#!/bin/bash

rm -rfv build
mkdir -pv build/content
cp -v content/*.md build/content
mkdir -pv build/content/news
for language in $(grep '^\[languages\..*\]$' config.toml | cut -d '.' -f2 | cut -d ']' -f1)
do
    for file in content/news/*.md
    do
        cp -v "$file" "build/${file%.md}.$language.md"
    done
done
hugo -c build/content -d build/public --cleanDestinationDir $*
