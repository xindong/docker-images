from urllib import request
import json

REVEALJS_GITREPO = 'hakimel/reveal.js'


def image_tag():
    url = "https://api.github.com/repos/{0}/releases/latest".format(
        REVEALJS_GITREPO)
    with request.urlopen(url) as f:
        data = json.loads(f.read())
    return data['tag_name']


def build_args():
    args = {'REVEALJS_GITREPO': REVEALJS_GITREPO,
            'REVEALJS_VERSION': image_tag()}
    return args
