#!/bin/zsh

URL="https://raw.githubusercontent.com/w3c/xml-entities/refs/heads/gh-pages/unicode.xml"

IFS=$'\n'
for k in $(curl $URL | xq -j | jq -jr '.unicode.charlist.character[] | select(has("latex")) | .latex, " ", .["@id"], "\n"' | grep -E '^\\' | tr -d '\' | perl -pe 's/ / \\/g')
do
  echo -e "$k" | perl -pe 's/\-[0-9]{5}$//;s/^/\\/g'
done | sort > latex_symbols.txt
