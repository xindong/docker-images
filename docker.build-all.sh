#!/bin/bash

ORGANIZATION='xindong'

cd `dirname $0`/library
images=`\ls`
for dir in $images; do
  if [[ $dir =~ ^([a-z][a-z0-9\-]+)-([0-9][\.0-9]+[0-9]+)$ ]]; then
    image=${BASH_REMATCH[1]}
    ver=${BASH_REMATCH[2]}
  else
    ver=latest
  fi
  docker build -t $ORGANIZATION/$image:$ver $dir
done
