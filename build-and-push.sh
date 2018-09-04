#!/bin/bash
# POSIX

die() {
    printf '%s\n' "$1" >&2
    exit 1
}

show_help() {
    echo "Usage: build-and-push.sh ( --library=LIBRARY, -l LIBRARY | --all )

Please specify library name with \"--library python-3.7\"
Or, use --all to build and push them all" >&1
}

build_library() {
    dir="$1"
    img=$dir
    tag='latest'
    if [[ $dir =~ ^([a-z][a-z0-9\-]+):([a-z0-9]+)$ ]]; then
        img=${BASH_REMATCH[1]}
        tag=${BASH_REMATCH[2]}
    fi
    if [ -x $dir/docker-builder.sh ]; then
        iid=`bash "$dir/docker-builder.sh"` && \
        _tag=`docker image inspect $iid | jq -r '.[]["Config"]["Labels"]["image.tag"]'` && \
        [ "x$_tag" != "x" ] && \
        tag=$_tag
    fi
    #echo "docker build --tag \"${ORGANIZATION}/${img}:${tag}\" \"${dir}\"" >&2 && \
    docker build --tag "${ORGANIZATION}/${img}:${tag}" "${dir}" && \
    #echo "docker push \"${ORGANIZATION}/${img}:${tag}\"" >&2 && \
    docker push "'${ORGANIZATION}/${img}:${tag}'"
}

[ `command -v jq` != "" ] || die "please install \`jq\`"

target_library=
build_all=0

while :; do
    case $1 in
        -h|-\?|--help)
            show_help
            exit
            ;;
        -l|--library) # Takes an option argument; ensure it has been specified.
            if [ "$2" ]; then
                target_library=$2
                shift
            else
                die 'ERROR: "--library" requires a non-empty option argument.'
            fi
            ;;
        --library=?*)
            target_library=${1#*=}
            ;;
        --library=) # Handle the case of an empty --library=
            die 'ERROR: "--library" requires a non-empty option argument.'
            ;;
        -a|--all)
            build_all=$((build_all + 1)) # Each -a adds 1 to build_all.
            ;;
        --) # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *) # Default case: No more options, so break out of the loop.
            break
    esac
    shift
done

ORGANIZATION='xindong'
cd `dirname $0`/library

if [ $build_all -gt 0 ]; then
    images=`\ls`
    for dir in $images; do
        build_library $dir
    done
elif [ "x$target_library" != "x" ]; then
    build_library $target_library
else
    show_help && exit 0
fi
