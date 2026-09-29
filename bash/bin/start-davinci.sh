#!/usr/bin/env bash
# Launch Resolve on Niri and work around xwayland-satellite's hidden dialogs.
exec python - "$@" <<'PY'
import ctypes as C
import os
from pathlib import Path
import subprocess
import sys
import time

RESOLVE = '/opt/resolve/bin/resolve'
env = os.environ.copy()
env.update(QT_QPA_PLATFORM='xcb', GDK_BACKEND='x11')
env.pop('QT_QPA_PLATFORMTHEME', None)
state = Path.home() / '.local/state/davinci-launcher'
state.mkdir(parents=True, exist_ok=True)

def resolve_pids():
    found = []
    for entry in Path('/proc').iterdir():
        if not entry.name.isdigit():
            continue
        try:
            if entry.stat().st_uid == os.getuid() and os.readlink(entry / 'exe') == RESOLVE:
                found.append(int(entry.name))
        except (OSError, PermissionError):
            pass
    return found

def main():
    if not Path(RESOLVE).is_file():
        raise RuntimeError(f'Resolve was not found at {RESOLVE}')
    if not env.get('DISPLAY'):
        raise RuntimeError('No X11 DISPLAY is set. Run this from a terminal in your Niri session.')

    x = C.CDLL('libX11.so.6')
    ptr, win = C.c_void_p, C.c_ulong
    signatures = {
        'XOpenDisplay': ([C.c_char_p], ptr),
        'XDefaultRootWindow': ([ptr], win),
        'XQueryTree': ([ptr, win, C.POINTER(win), C.POINTER(win),
                        C.POINTER(C.POINTER(win)), C.POINTER(C.c_uint)], C.c_int),
        'XFetchName': ([ptr, win, C.POINTER(ptr)], C.c_int),
        'XInternAtom': ([ptr, C.c_char_p, C.c_int], win),
        'XDeleteProperty': ([ptr, win, win], C.c_int),
        'XChangeProperty': ([ptr, win, win, win, C.c_int, C.c_int, ptr, C.c_int], C.c_int),
        'XUnmapWindow': ([ptr, win], C.c_int),
        'XMapRaised': ([ptr, win], C.c_int),
        'XSync': ([ptr, C.c_int], C.c_int),
        'XFree': ([ptr], C.c_int),
        'XCloseDisplay': ([ptr], C.c_int),
    }
    for name, (args, result) in signatures.items():
        fn = getattr(x, name)
        fn.argtypes, fn.restype = args, result
    # A window may disappear between enumeration and inspection (BadWindow).
    error_handler = C.CFUNCTYPE(C.c_int, ptr, ptr)(lambda *_: 0)
    x.XSetErrorHandler.argtypes = [type(error_handler)]
    x.XSetErrorHandler(error_handler)
    display = x.XOpenDisplay(env['DISPLAY'].encode())
    if not display:
        raise RuntimeError(f"Cannot connect to X11 display {env['DISPLAY']}")

    existing = resolve_pids()
    child = None
    if existing:
        print('Resolve is already running; checking its hidden startup windows.', flush=True)
    else:
        with (state / 'startup.log').open('w') as log:
            child = subprocess.Popen([RESOLVE, *sys.argv[1:]], env=env,
                                     stdout=log, stderr=subprocess.STDOUT,
                                     start_new_session=True)
        print(f'Starting Resolve. Log: {state / "startup.log"}', flush=True)

    root = x.XDefaultRootWindow(display)
    transient = x.XInternAtom(display, b'WM_TRANSIENT_FOR', 0)
    window_type = x.XInternAtom(display, b'_NET_WM_WINDOW_TYPE', 0)
    normal = win(x.XInternAtom(display, b'_NET_WM_WINDOW_TYPE_NORMAL', 0))
    atom = x.XInternAtom(display, b'ATOM', 0)
    fixed = set()
    first_seen = {}
    try:
        while True:
            if child is not None:
                status = child.poll()
                if status is not None:
                    if status:
                        print(f'Resolve exited with status {status}; see {state / "startup.log"}.')
                    break
            elif not resolve_pids():
                break
            parent, root_return = win(), win()
            children = C.POINTER(win)()
            count = C.c_uint()
            x.XQueryTree(display, root, C.byref(root_return), C.byref(parent),
                         C.byref(children), C.byref(count))
            windows = list(children[:count.value]) if children else []
            if children:
                x.XFree(children)
            for window in windows:
                if window in fixed:
                    continue
                name = ptr()
                x.XFetchName(display, window, C.byref(name))
                title = C.string_at(name).decode(errors='replace') if name else ''
                if name:
                    x.XFree(name)
                if title not in ('Project Manager', 'Message'):
                    continue
                props = subprocess.run(['xprop', '-id', hex(window), 'WM_CLASS', 'WM_STATE'],
                                       env=env, capture_output=True, text=True).stdout
                if '"resolve", "resolve"' not in props or 'window state: Normal' not in props:
                    continue
                # Let the splash screen and temporary parent finish disappearing.
                since = first_seen.setdefault(window, time.monotonic())
                if time.monotonic() - since < 3:
                    continue
                x.XUnmapWindow(display, window)
                x.XSync(display, 0)
                x.XDeleteProperty(display, window, transient)
                x.XChangeProperty(display, window, window_type, atom, 32, 0,
                                  C.cast(C.byref(normal), ptr), 1)
                x.XSync(display, 0)
                x.XMapRaised(display, window)
                x.XSync(display, 0)
                fixed.add(window)
                print(f'Applied window workaround: {title}', flush=True)
            time.sleep(1)
    finally:
        x.XCloseDisplay(display)

try:
    main()
except KeyboardInterrupt:
    print('\nWindow helper stopped; Resolve is left running.')
except (OSError, RuntimeError) as error:
    print(f'Cannot start Resolve: {error}', file=sys.stderr)
    sys.exit(1)
PY
