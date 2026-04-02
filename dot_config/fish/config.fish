if status is-interactive
    # Commands to run in interactive sessions can go here

    set -g fish_greeting

    fish_vi_key_bindings

    if command -q starship
        starship init fish | source
    end

    if command -q zoxide
        zoxide init --cmd cd fish | source
    end

    if command -q fzf
        fzf --fish | source
    end
end

# [INFO] macos
if test (uname) = Darwin
    if type -q brew
        fish_add_path -m (brew --prefix)/bin
    end
end

# [INFO] global variables

if command -q nvim
    set -gx EDITOR nvim
end

# [INFO] alias

if command -q nvim
    function nv --wraps nvim
        command nvim $argv
    end
end

if command -q lsd
    function ls --wraps lsd
        command lsd $argv
    end

    function la --wraps "lsd -Al"
        command lsd -Al $argv
    end

    function ltr --wraps "lsd --tree"
        command lsd --tree $argv
    end
end

if command -q lazygit
    function lg --wraps lazygit
        command lazygit $argv
    end
end

if command -q zellij
    function zj --wraps zellij
        command zellij $argv
    end
end

