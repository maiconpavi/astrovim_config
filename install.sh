
GO_VERSION="1.21.0"

ishell() {
  sudo apt install build-essential libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev -y
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  env NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  -s -- -y
  source "$HOME/.cargo/env"
  cargo install --locked --features clipboard broot
  bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)
  sudo apt install zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  curl -sS https://starship.rs/install.sh | sh
}

invim() {
  sudo apt-get install tmux -y
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  sudo chmod u+x nvim.appimage
  sudo mv nvim.appimage /usr/local/bin/nvim
  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
}

invimdep() {
  brew install hadolint
  sudo apt-get install aptitude python3.11 python3-pip -y
  sudo apt-get install python3 wget -y
  sudo npm install -g typescript-language-server typescript graphql-language-service-cli eslint sql-formatter dockerfile-language-server-nodejs @microsoft/compose-language-service

  # Go
  rm -rf /usr/local/go 2> /dev/null
  wget https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz
  rm -f go$GO_VERSION.linux-amd64.tar.gz

  # Venv, fd, tmux
  sudo apt-get install -y python3.11-venv fd-find 
  ln -s $(which fdfind) ~/.local/bin/fd || true

  # rust
  
  cargo install ripgrep bottom


  # lazygit
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm -f lazygit.tar.gz lazygit


  # fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
  ~/.fzf/install --all

  # python
  pip3 install -U isort black virtualenv pyright ruff ruff_lsp debugpy cfn-lint yamllint clang-format
}

