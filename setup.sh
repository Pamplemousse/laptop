#!/run/current-system/sw/bin/bash
#
# Setup my environment
#

mkdir -p "${HOME}/Workspace/tools"

# Pull down my dotfiles
git clone https://github.com/andsens/homeshick.git "${HOME}/.homesick/repos/homeshick"
source "${HOME}/.homesick/repos/homeshick/homeshick.sh"
homeshick clone git@github.com:Pamplemousse/dotfiles.git

# Install Oh-My-Zsh
nix-env -iA nixos.oh-my-zsh
ln -s "$(nix-env -q --out-path oh-my-zsh | cut -d' ' -f3)/share/oh-my-zsh" "${HOME}/.oh-my-zsh"

# Setup Vim
git clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"
vim -c ":PluginInstall" -c "q|q"

curl -Ssok "${HOME}/.vim/spell/fr.utf-8.spl" \
  https://ftp.vim.org/vim/runtime/spell/fr.utf-8.spl

# Install TPM (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins

# Pull down tools
git clone https://github.com/rukshn/pomodoro.git "${HOME}/Workspace/tools/pomodoro"

curl -Sso "${HOME}/Workspace/tools/record-gif.sh" \
  https://raw.githubusercontent.com/edouard-lopez/record-gif.sh/master/record-gif.sh
chmod +x "${HOME}/Workspace/tools/record-gif.sh"
