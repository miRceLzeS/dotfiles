# general packages
brew install fzf fd ripgrep neovim tmux tmuxp zoxide starship lsd tree-sitter-cli tealdeer

# rust
if command -q curl
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup component add rust-analyzer
end

# lua
brew install lua-language-server
