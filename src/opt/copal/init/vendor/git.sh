#!/bin/bash
cd $_defaults_/git
sudo apt install -y git-core
git config --global user.name "$DEV_USER"
git config --global user.email "$DEV_USER@$NODE_IP"
#initialize repositories
readarray -t repos < repos.list
for repo in ${repos[@]}; do
  cd $repo
  if [[ $BOOTSTRAP == 1 ]]; then
    git init && git add -A && git commit -m "default" && git branch stage
  else
    rm -rf $(ls -A $repo) && git clone ssh://$DEV_USER@$(copal peer -r)$repo/.git ./
  fi
  cp $_defaults_/git/post-receive .git/hooks
  chmod +x .git/hooks/post-receive
done
unset repo && unset repos
