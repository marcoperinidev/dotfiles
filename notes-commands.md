# Setup rapido

## Install necessari
- sudo apt update && sudo apt upgrade -y
- sudo apt install git wget curl vim
- sudo snap install chezmoi --classic
- wget https://github.com/twpayne/chezmoi/releases/download/v2.71.0/chezmoi_2.71.0_linux_amd64.deb && sudo apt install ./chezmoi_2.71.0_linux_amd64.deb

## Install BW
./install-bw.sh

## una volta installato e sbloccato BW
- bw login
- export BW_SESSION="$(bw unlock --raw)"
- mkdir -p ~/.config/chezmoi
- bw get item "chezmoi-key" | jq -r '.notes' > ~/.config/chezmoi/key.txt
- chemod 600 ~/.config/chezmoi/key.txt
- chezmoi init --aply https://github.com/marcoperinidev/dotfiles

## SSH GitHub
ssh-keygen -t ed25519 -C "tuo@email" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com


## Cambiare remote da HTTPS a SSH
git remote -v
git remote set-url origin git@github.com:marcoperinidev/dotfiles.git
git remote set-url --push origin git@github.com:marcoperinidev/dotfiles.git
git remote -v


## comandi utili BW
- bw list items
- bw get item "secret-key.txt" | jq -r '.notes'
- bw list items | jq '.[] | {name, id, folderId, type}'
- bw list items --search github | jq '.[] | {name, id, username: .login.username}'
- bw list items | jq 'map({name, id, folderId, type})'
- bw list items --search google | jq -r '.[] | select(.login.username == "$USERNAME") | {name, login}'

## Chezmoi
chezmoi cd
chezmoi diff
chezmoi init <repo-remota>
chezmoi apply

