if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source
  if command -q nvim
    set -gx EDITOR nvim
  end
  fish_vi_key_bindings
end
