#!/usr/bin/env bash

rm -rfv build
mkdir -pv build/content
cp -v content/*.md build/content
mkdir -pv build/content/news
for language in $(grep '^\[languages\..*\]$' config.toml | cut -d '.' -f2 | cut -d ']' -f1)
do
    cp -v "content/rsoc.md" "build/content/rsoc.$language.md"
    cp -v "content/talks.md" "build/content/talks.$language.md"
    for file in content/news/*.md
    do
        cp -v "$file" "build/${file%.md}.$language.md"
    done
done
hugo -c build/content -d build/public --cleanDestinationDir "$@"
