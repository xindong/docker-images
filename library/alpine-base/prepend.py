from urllib import request
import json


def image_tag():
    return 'latest'


def build_args():
    args = {'ALPINE_GLIBC_GITREPO': 'sgerrand/alpine-pkg-glibc',
            'ALPINE_GLIBC_VERSION': None}
    url = "https://api.github.com/repos/{0}/releases/latest".format(
        args['ALPINE_GLIBC_GITREPO'])
    with request.urlopen(url) as f:
        data = json.loads(f.read())
        args['ALPINE_GLIBC_VERSION'] = data['tag_name']
    return args
