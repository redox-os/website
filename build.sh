#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m\n"

hugo && echo || exit 1

export GIT_WORK_TREE="$(pwd)/public"
export GIT_DIR="$GIT_WORK_TREE/.git"

URL="$(git config remote.origin.url)"

if [ ! -z "$GH_TOKEN" ];
then
  URL="$(echo "$URL" | sed "s,https://,https://$GH_TOKEN@,")"
fi

git add -A && \
  git commit -m "${1:-"Update $(env LANG=en_US date)"}" && \
  git push -fq "$URL" master
