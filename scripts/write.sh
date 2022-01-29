#!/bin/bash

#echo $1
touch meta.yml
while read line
do
  files=$line
  md5=$(md5sum $files | awk '{ print $1 }')
  echo $files' -> '$md5
  raw=$(echo $files | sed 's/binary//g' | sed 's#/#.#g' | cut -c2-)
  yq -i '.md5.'$raw' = "'$md5'"' meta.yml
done < $1
