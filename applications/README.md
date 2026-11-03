# System Update

Run `system-update` from Fish, or `~/dotfiles/bash/bin/system-update --window`
to open a dedicated Alacritty window. `--dry-run` previews the commands.

The updater runs `paru -Syu` or `yay -Syu` (falling back to `sudo pacman -Syu`),
then `flatpak update` if installed. Normal review/password/confirmation prompts
remain enabled. A failed Arch/AUR upgrade stops the sequence. The window stays
open with the result. This covers OS/AUR packages and Flatpaks, not language
package managers or manually downloaded applications.

## Activate the app launcher entry

Run locally:

```sh
mkdir -p ~/.local/share/applications
cp ~/dotfiles/applications/system-update.desktop ~/.local/share/applications/
```

Search for **System Update** in the Dux/DankMaterialShell launcher. This standard
desktop entry also works with other application launchers.

## Keyboard shortcut

The tracked Niri configuration binds **Super+Alt+U**. If your live configuration
is a separate copy, add the following inside its existing `binds` block in
`~/.config/niri/config.kdl`:

```kdl
Mod+Alt+U hotkey-overlay-title="Update system packages" { spawn-sh "exec \"$HOME/dotfiles/bash/bin/system-update\" --window"; }
```

Niri reloads configuration changes automatically. The existing Waybar update
button also uses this updater when the tracked Waybar script is deployed.

## Arch-logo bar button

Run `~/dotfiles/bash/bin/install-update-button` from your normal terminal.
This installs the local `ArchUpdate` Dux/DMS plugin, enables it, and inserts its
blue Arch-logo button at the start of the right section on each enabled bar.
Click it to open the updater; hover to see its description.

Setup briefly stops and restarts DMS, preserves other bar settings, and saves
backups under `~/.config/dms/backup-arch-update-*`. Re-running it does not add a
duplicate button. The bundled logo comes from Arch's installed
`/usr/share/pixmaps/archlinux-logo.svg`.
