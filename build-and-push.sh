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
    image=$1
    ver=latest
    if [[ $1 =~ ^([a-z][a-z0-9\-]+)-([0-9][\.0-9]+[0-9]+)$ ]]; then
        image=${BASH_REMATCH[1]}
        ver=${BASH_REMATCH[2]}
    fi
    echo "docker build --tag $ORGANIZATION/$image:$ver $1" >&2
    docker build --tag $ORGANIZATION/$image:$ver $1
    echo "docker push $ORGANIZATION/$image:$ver" >&2
    docker push $ORGANIZATION/$image:$ver
}

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
