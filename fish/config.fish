# if status is-interactive
    # Commands to run in interactive sessions can go here
    # cd $HOME    
 
    # Changing "ls" to "eza"
    alias ls='eza --color=always --group-directories-first'
    alias la='eza -a --color=always --group-directories-first'
    alias ll='eza -l --color=always --group-directories-first'
    alias lla='eza -la --color=always --group-directories-first'
    alias lt='eza -aT --color=always --group-directories-first'
    alias l.='eza -a | egrep "^\."'

    # Colorize grep output (good for log files)
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'

    alias ..='cd ..'

    # git
    alias addup='git add -u'
    alias addall='git add .'
    alias branch='git branch'
    alias checkout='git checkout'
    alias clone='git clone'
    alias commit='git commit -m'
    alias fetch='git fetch'
    alias pull='git pull origin'
    alias push='git push origin'
    alias tag='git tag'
    alias newtag='git tag -a'
    alias gs='git status'
    alias glog='git log --graph --decorate --oneline'

    alias cp='cp -i'
    alias df='df -h'

    # programs
    alias z='zoxide'
    alias vim='nvim'


    alias perfview="wine ~/.local/bin/PerfView.exe"


function desk
  export DESKTOP_SESSION=ubuntu
  export GDMSESSION=ubuntu 
  export GNOME_SHELL_SESSION_MODE=ubuntu 
  export GTK_IM_MODULE=ibus 
  export GTK_MODULES=gail:atk-bridge 
  export IM_CONFIG_CHECK_ENV=1 
  export IM_CONFIG_PHASE=1 
  export QT_ACCESSIBILITY=1 
  export QT_IM_MODULE=ibus 
  export XDG_CURRENT_DESKTOP=ubuntu:GNOME 
  export XDG_DATA_DIRS=/usr/share/ubuntu:$XDG_DATA_DIRS 
  export XDG_SESSION_TYPE=wayland 
  export XMODIFIERS=@im=ibus 
  export MUTTER_DEBUG_DUMMY_MODE_SPECS=1920x1080 
  gnome-session
end

# Launch through nested labwc so GUI overlay windows stack correctly on niri.
function quicksim_labwc --argument-names product mode
  set -l repo_root "$PWD"
  while not test -f "$repo_root/linux/run_sim_labwc.sh"
    if test "$repo_root" = /
      echo "Could not find linux/run_sim_labwc.sh above the current directory." >&2
      return 1
    end
    set repo_root (path dirname "$repo_root")
  end

  command bash "$repo_root/linux/run_sim_labwc.sh" "$product" "$mode" $argv[3..-1]
end

function quicksim_lapsim
  quicksim_labwc LapSim $argv
end

function quicksim_lap4
  quicksim_labwc Lap4 $argv
end


# Start quickSim functions
function qslap
  quicksim_lapsim "release" $argv
end

function qslapd
  quicksim_lapsim "debug" $argv
end

function qslapu
  quicksim_lapsim "unopt" $argv
end

function qslap4
  quicksim_lap4 "release" $argv
end

function qslap4d
  quicksim_lap4 "debug" $argv
end

function qslap4u
  quicksim_lap4 "unopt" $argv
end

# Build quickSim functions
function blap4
  bcli "-plinux-release" "-tquickSimLap4"
end

function blap4d
  bcli "-plinux-debug" "-tquickSimLap4"
end

function blap4u
  bcli "-plinux-unopt" "-tquickSimLap4"
end


function blap
  bcli "-plinux-release" "-tquickSimLapsim"
end

function blapd
  bcli "-plinux-debug" "-tquickSimLapsim"
end

function blapu
  bcli "-plinux-unopt" "-tquickSimLapsim"
end


# Build then start quickSim functions
function bqslap4
  blap4 && qslap4 $argv
end

function bqslap4d
  blap4d && qslap4d $argv
end

function bqslap4u
  blap4u && qslap4u $argv
end

function bqslap
  blap && qslap $argv
end

function bqslapd
  blapd && qslapd $argv
end

function bqslapu
  blapu && qslapu $argv
end


function bcli
  set -l current_dir $PWD
  set -l build_status 1
  set -l found "0"
  while true
    if test -d ./products
      if test -d ./Runtime
          set found "1"
          break
      end
    end

     if [ "$PWD" = "/" ]
      echo "Reached sytem root without finding susrepo1 root"
      break
    end

    cd ..
  end

  if [ $found = "1" ]
    set -l build_cli_path $PWD/cmake/BuildCLI
    if test -e $build_cli_path 
      cd $PWD/cmake
      command $build_cli_path -s $argv
      set build_status $status
    else
      echo "Could not find filepath: $build_cli_path"
    end
  end

  cd $current_dir
  return $build_status
end

    # alias wine64='whisky'
    # alias wine='whisky'

  #   switch (uname)
  #     case Darwin
  #       export MGFXC_WINE_PATH=/Users/johanwangsell/.winemonogame
  # #eval "$(/opt/homebrew/bin/brew shellenv)"
  # #eval "(/opt/homebrew/bin/brew shellenv)"
  #       /opt/homebrew/bin/brew shellenv | source
  #     case Linux
  #       eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  #     case '*'
  #   end


# ~/.config/fish/config.fish
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

  if test -d /home/linuxbrew/.linuxbrew # Linux
    set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
    export MGFXC_WINE_PATH=/home/johan/.winemonogame
    # export MGFXC_WINE_PATH=/home/johan/.wine
  else if test -d /opt/homebrew # MacOS
    set -gx HOMEBREW_PREFIX "/opt/homebrew"
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"

    export MGFXC_WINE_PATH=/Users/johanwangsell/.winemonogame
    export PATH="/usr/local/share/dotnet/x64:$PATH"
    # export PATH="$HOME/.dotnet/tools:$PATH"
  end
  fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin";
  ! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
  ! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;
    
    set TERM "xterm-256color"
    set fish_greeting

# Functions needed for !! and !$
    function __history_previous_command
      switch (commandline -t)
      case "!"
        commandline -t $history[1]; commandline -f repaint
      case "*"
        commandline -i !
      end
    end

    function __history_previous_command_arguments
      switch (commandline -t)
      case "!"
        commandline -t ""
        commandline -f history-token-search-backward
      case "*"
        commandline -i '$'
      end
    end

# The bindings for !! and !$
    if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
      bind -Minsert ! __history_previous_command
      bind -Minsert '$' __history_previous_command_arguments
    else
      bind ! __history_previous_command
      bind '$' __history_previous_command_arguments
    end
# end

# eval (/opt/homebrew/bin/brew shellenv)

# /home/linuxbrew/.linuxbrew/bin/brew

zoxide init fish | source
starship init fish | source

set PATH $HOME/.local/bin/ $PATH
set PATH $HOME/dotfiles/bash/bin/ $PATH
set PATH $HOME/squashfs-root/usr/bin/ $PATH
set PATH $HOME/.dotnet/tools/ $PATH

set PATH $HOME/my_msvc/opt/msvc/bin/x64 $PATH
set PATH $HOME/bin $PATH

set PATH $HOME/.local/share/nvim/mason/bin/ $PATH

set OLLAMA_API_BASE "http://localhost:11434"
set -x SurgicalScienceDevMode "1"
set -x SDL_VIDEODRIVER "wayland,x11"

set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/src/tensorrt/lib/"

set -x LAPSUITE_UI_PROJECT_PATH "/home/johanw/Dev/workspaces/LapMentorGUI/"
set -x LAPSUITE_GODOT_BIN "/bin/godot"

set -e DOTNET_ROOT
set -e DOTNET_MULTILEVEL_LOOKUP

pyenv init - fish | source
