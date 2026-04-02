# Description

The follow up of setup of my dev env.

# Prepare

To begin with, make sure the network is ready.

## macos

### cli toolkit

```sh
xcode-select --install
```

### homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### packages

```sh
brew install --cask ghostty
brew install fish
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
fish
brew install chezmoi
chezmoi init https://github.com/miRceLzeS/dotfiles.git
chezmoi apply
brew install fzf fd ripgrep neovim zellij zoxide starship lsd lazygit
```

### languages

```sh
# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# restart shell

# lsp
rustup component add rust-analyzer
```

```sh
# go
# install via official installer

fish_add (go env GOPATH)/bin
# lsp
go install golang.org/x/tools/gopls@latest

# debugger
go install github.com/go-delve/delve/cmd/dlv@latest
```

```sh
# lua

# lsp
brew install lua-language-server
```

### neovim

```sh
# nvim-treesitter
cargo install --locked tree-sitter-cli
```

## archlinux

- TODO
