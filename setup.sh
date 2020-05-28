#!/run/current-system/sw/bin/bash
#
# Setup my environment
#

read -r -p "Where are your secret dotfiles? (ssh://user@domain:port/username/repo.git) " secret_dotfiles_repo
read -r -p "What is your GitHub personal access token? " gh_personal_access_token
read -r -p "What is your \`git.xaviermaso.com\` personal access token? " gxm_personal_access_token

mkdir -p "${HOME}/Workspace/tools"

# Create and deploy ssh key
ssh-keygen -t ed25519 -o -a 100
date="$(date +'%md%dd%Y')"
pubkey="$(cut -d' ' -f1,2 < "${HOME}"/.ssh/id_ed25519.pub)"
post_data=$(printf '{"title": "%s", "key": "%s"}' "w-$date" "$pubkey")

curl -u "Pamplemousse:$gh_personal_access_token" -X POST --data "$post_data" https://api.github.com/user/keys
curl -H "Authorization: token $gxm_personal_access_token" -X POST --data "$post_data" https://git.xaviermaso.com/user/keys

# Pull down my dotfiles
git clone https://github.com/andsens/homeshick.git "${HOME}/.homesick/repos/homeshick"
source "${HOME}/.homesick/repos/homeshick/homeshick.sh"
homeshick clone git@github.com:Pamplemousse/dotfiles.git
homeshick clone "$secret_dotfiles_repo"

# Install Oh-My-Zsh
ln -s "$(nix-store --query --requisites /run/current-system | grep oh-my-zsh | sort | uniq)/share/oh-my-zsh" "${HOME}/.oh-my-zsh"

# Setup NeoVim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c ":PlugInstall" -c "q|q"

curl -Ssk --create-dirs -o "${HOME}/.vim/spell/fr.utf-8.spl" \
  https://ftp.vim.org/vim/runtime/spell/fr.utf-8.spl

# Setup less
lesskey ~/.lessrc

# Install TPM (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins

# Pull down tools
git clone https://github.com/rukshn/pomodoro.git "${HOME}/Workspace/tools/pomodoro"

curl -Sso "${HOME}/Workspace/tools/record-gif.sh" \
  https://raw.githubusercontent.com/edouard-lopez/record-gif.sh/master/record-gif.sh
chmod +x "${HOME}/Workspace/tools/record-gif.sh"

# Restart to apply configuration
systemctl restart usbguard
