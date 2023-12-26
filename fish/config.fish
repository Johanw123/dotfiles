# if status is-interactive
    # Commands to run in interactive sessions can go here
    cd $HOME    
 
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


    zoxide init fish | source
    starship init fish | source
# end

switch (uname)
  case Darwin
    export MGFXC_WINE_PATH=/Users/johan/.winemonogame
  case Linux
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  case '*'
end
