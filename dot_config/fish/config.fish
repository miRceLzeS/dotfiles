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

if command -q fzf
  set -Ux FZF_DEFAULT_OPTS "
      --color=fg:#908caa,bg:#191724,hl:#ebbcba
      --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
      --color=border:#403d52,header:#31748f,gutter:#191724
      --color=spinner:#f6c177,info:#9ccfd8
      --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
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

