#!/usr/bin/env sh

if [ "$1" != "serve" ] && [ ! -d "node_modules" ]; then
    echo "Installing node_modules"
    npm install --frozen-lockfile
fi

rm -rfv build
mkdir -pv build/content
cp -v content/*.md build/content
mkdir -pv build/content/news
grep '^\[languages\..*\]$' config.toml | \
  cut -d '.' -f2 | cut -d ']' -f1 | \
  while IFS= read -r language
do
    cp -v "content/rsoc.md" "build/content/rsoc.$language.md"
    cp -v "content/talks.md" "build/content/talks.$language.md"
    cp -v "content/rsoc-project-suggestions.md" "build/content/rsoc-project-suggestions.$language.md"
    cp -v "content/rsoc-proposal-how-to.md" "build/content/rsoc-proposal-how-to.$language.md"
    for file in content/news/*.md
    do
        filename=$(basename "$file" .md)
        cp -v "$file" "build/content/news/${filename}.$language.md"
    done
done
hugo -c build/content -d build/public --cleanDestinationDir "$@"
