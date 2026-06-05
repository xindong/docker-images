#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "$0")" && pwd)"
library_dir="${repo_root}/library"
cloudbuild_file="${repo_root}/cloudbuild.yaml"

image_name() {
    local context_dir="$1"
    local dir_name

    dir_name="$(basename "${context_dir}")"
    if [[ "${context_dir}" == */* ]]; then
        printf '%s:%s' "${context_dir%/*}" "${dir_name}"
    elif [[ "${dir_name}" =~ ^([a-z][a-z0-9-]+)@(.+)$ ]]; then
        printf '%s:%s' "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
    else
        printf '%s:latest' "${dir_name}"
    fi
}

shopt -s globstar nullglob

known_contexts=(
    alpine-base
    anaconda3
    anaconda3-combo
    anaconda3-cuda
    git-bfg
    google-cloud-sdk
    google-cloud-sdk-combo
    machine-learning/cpu
    machine-learning/gpu
    python@2.7
    python@3.5
    python@3.6
    python@3.7
    python@3.14
    rclone-task
    reveal.js
    ruby@2.5
    ruby@4.0
)

emitted_contexts=" "

emit_context() {
    local context_dir="$1"
    local image

    [[ -f "${library_dir}/${context_dir}/Dockerfile" ]] || return 0
    [[ "${emitted_contexts}" == *" ${context_dir} "* ]] && return 0

    image="$(image_name "${context_dir}")"
    emitted_contexts="${emitted_contexts}${context_dir} "
    printf -- "- name: 'gcr.io/cloud-builders/docker'\n"
    printf "  args: ['build', '--build-arg', 'BASE_REGISTRY=gcr.io/\$PROJECT_ID', '-t', 'gcr.io/\$PROJECT_ID/%s', 'library/%s']\n" "${image}" "${context_dir}"
    printf "  timeout: 600s\n"
    printf -- "- name: 'gcr.io/cloud-builders/docker'\n"
    printf "  args: ['push', 'gcr.io/\$PROJECT_ID/%s']\n" "${image}"
}

{
    printf 'steps:\n'
    for context_dir in "${known_contexts[@]}"; do
        emit_context "${context_dir}"
    done

    for dockerfile in "${library_dir}"/**/Dockerfile; do
        image_dir="$(dirname "${dockerfile}")"
        context_dir="${image_dir#"${library_dir}/"}"
        emit_context "${context_dir}"
    done
} > "${cloudbuild_file}"
