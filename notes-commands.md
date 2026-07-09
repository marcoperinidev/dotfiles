# Setup rapido

## SSH GitHub
ssh-keygen -t ed25519 -C "tuo@email" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com
cat ~/.ssh/id_ed25519.pub

## Cambiare remote da HTTPS a SSH
git remote -v
git remote set-url origin git@github.com:OWNER/REPO.git
git remote -v
git push
git pull

## Bitwarden CLI
bw login
export BW_SESSION="$(bw unlock --raw)"
bw list items
bw list items --search github
bw list items --search ssh
bw get item "secret-key.txt"
bw get item "secret-key.txt" | jq -r '.notes'

## Filtrare / formattare Bitwarden con jq
bw list items | jq '.[] | {name, id, folderId, type}'
bw list items --search github | jq '.[] | {name, id, username: .login.username}'
bw list items | jq 'map({name, id, folderId, type})'

## Chezmoi
chezmoi cd
chezmoi diff
chezmoi init <repo>
chezmoi apply

## VM / bootstrap
./install-bw.sh
