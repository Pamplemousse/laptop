#!/run/current-system/sw/bin/bash
#
# Setup my environment
#

mkdir "${HOME}/Workspace"


# Pull down my dotfiles
git clone git://github.com/andsens/homeshick.git "${HOME}/.homesick/repos/homeshick"
source "${HOME}/.homesick/repos/homeshick/homeshick.sh"
homeshick clone git@github.com:Pamplemousse/dotfiles.git

# Install Oh-My-Zsh
nix-env -iA nixos.oh-my-zsh
ln -s "$(nix-env -q --out-path oh-my-zsh | cut -d' ' -f3)/share/oh-my-zsh" "${HOME}/.oh-my-zsh"

# Install Vundle (vim plugin manager)
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c ":PluginInstall" -c "q|q"

# Install TPM (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# Pull down tools
mkdir "${HOME}/Workspace/tools"

git clone https://github.com/rukshn/pomodoro.git "${HOME}/Workspace/tools/pomodoro"

curl -Ss https://raw.githubusercontent.com/edouard-lopez/record-gif.sh/master/record-gif.sh --output "${HOME}/Workspace/tools/record-gif.sh"
chmod +x "${HOME}/Workspace/tools/record-gif.sh"
