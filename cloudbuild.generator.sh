#!/bin/bash

build_library() {
    dir="$1"
    img=$dir
    tag='latest'
    if [[ $dir =~ ^([a-z][a-z0-9\-]+):([a-z0-9]+)$ ]]; then
        img=${BASH_REMATCH[1]}
        tag=${BASH_REMATCH[2]}
    fi
    echo -n "
- name: 'gcr.io/cloud-builders/docker'
    args: [ 'build', '-t', 'gcr.io/\$PROJECT_ID/$img:$tag', 'library/$dir' ]
    timeout: 600s
- name: 'gcr.io/cloud-builders/docker'
    args: [ 'push', 'gcr.io/\$PROJECT_ID/$img:$tag']" >> ../cloudbuild.yaml
}

cd `dirname $0`/library
echo -n 'steps:' > ../cloudbuild.yaml
images=`\ls`
for dir in $images; do
    build_library "$dir"
done
