#!/bin/bash

cd `dirname $0`/library

echo -n 'steps:' > ../cloudbuild.yaml

images=`\ls`
for dir in $images; do
  if [[ $dir =~ ^([a-z][a-z0-9\-]+)-([0-9][\.0-9]+[0-9]+)$ ]]; then
    image=${BASH_REMATCH[1]}
    ver=${BASH_REMATCH[2]}
  else
    ver=latest
  fi
  echo -n "
- name: 'gcr.io/cloud-builders/docker'
  args: [ 'build', '-t', 'gcr.io/\$PROJECT_ID/$image:$ver', 'library/$dir' ]" >> ../cloudbuild.yaml
done
