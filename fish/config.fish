if status is-interactive
    # Commands to run in interactive sessions can go here
    cd $HOME    
    alias ls="exa"
    alias ll="exa --long"
    alias z="zoxide"

    zoxide init fish | source
    starship init fish | source
end
