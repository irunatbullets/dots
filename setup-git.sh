#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Configuring git…"

git config --global alias.stat status
git config --global alias.ci commit
git config --global alias.co checkout

git config --global alias.remove-deleted-branches \
'!f() { current=$(git symbolic-ref --short HEAD); git fetch --prune; git branch -vv | grep ": gone]" | awk "{print \$1}" | grep -v "^$current$" | grep -v "^main$" | xargs -r git branch -D; }; f'

git config --global user.name "irunatbullets"
git config --global user.email "murray@ik.me"

git config --global core.editor vim
git config --global advice.skippedCherryPicks false
git config --global fetch.prune true
git config --global init.defaultBranch main

echo "✅ Git configured"
