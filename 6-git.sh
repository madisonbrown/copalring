#!/bin/bash
sudo apt install -y git-core
git config --global user.name "$DEV_USER"
git config --global user.email "$DEV_USER@$NODE_IP"
#initialize repositories
config=$indir/config/git && peer=/etc/copal/rnd-peer.sh
readarray -t repos < $config/repos.list
for repo in ${repos[@]}; do
  cd $repo
  if [[ $BOOTSTRAP == 1 ]]; then
    git init && git add -A && git commit -m "default" && git branch stage
  else
    rm -rf $(ls -A $repo) && git clone ssh://$DEV_USER@$(bash $peer)$repo/.git ./
  fi
  cp $config/post-receive .git/hooks
  chmod +x .git/hooks/post-receive
done
unset config && unset peer && unset repo
