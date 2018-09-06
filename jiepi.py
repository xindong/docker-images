#!/usr/local/bin/python3

import importlib
import os
import re
import sys
import subprocess
from argparse import ArgumentParser
from pathlib import Path


parser = ArgumentParser(description='build / push Docker image')

# parser.add_argument('--quiet', '-q', help='Quiet mode', action='store_const',
#                    const=True, default=False)
parser.add_argument('--verbose', '-v', action='count',
                    help='Verbose mode', default=0)

sub2parsers = parser.add_subparsers(
    dest='command',
    title='subcommands',
    required=True,
    description='valid subcommands',
    help='sub-command help')

parser_build = sub2parsers.add_parser('build', help='build docker')
parser_build.add_argument('dest', nargs='?', metavar='<Dockerfile directory>')
parser_build.add_argument('-o', '--orgnizations', action='append',
                          help='orgnizations list')

parser_push = sub2parsers.add_parser('push', help='push docker')
parser_push.add_argument('name', nargs=1, metavar='<image name>')


def build(dest, orgns=None):
    pwd = os.path.dirname(os.path.realpath(__file__))
    os.chdir(pwd)
    path = Path('.') / 'library' / dest
    if not path.is_dir():
        raise RuntimeError("{0} not exists".format([dest]))
    docker = {'basename': os.path.basename(dest),
              'tag': 'latest',
              'args': {}}
    matches = re.search('^(.+)@(.+)$', docker['basename'])
    if matches:
        docker['basename'] = matches.group(1)
        docker['tag'] = matches.group(2)
    prep = path / 'prepend.py'
    if prep.is_file():
        spec = importlib.util.spec_from_file_location('prepend', prep)
        baal = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(baal)
        # sys.modules['prepend'] = baal
        docker['args'] = baal.build_args()
        docker['tag'] = baal.image_tag()
    cmd = ['docker', 'build']
    if orgns is None:
        orgns = []
    for orgn in orgns:
        cmd.extend(['-t',
                    orgn + '/' + docker['basename'] + ':' + docker['tag']])
    if args['verbose']:
        print(docker['args'])
    for key, val in docker['args'].items():
        cmd.extend(['--build-arg', "{0}={1}".format(key, val)])
    cmd.extend(['--label', "image.tag={0}".format(docker['tag'])])
    # iidfile = path / 'image.iid'
    # os.remove(iidfile)
    # cmd.extend(['--iidfile', iidfile, dest])
    cmd.append(str(path))
    cmd = ' '.join(cmd)
    if args['verbose']:
        print("Running docker build command: [{0}]".format(str(cmd)))
    subprocess.run(cmd, check=True, shell=True)
    # with open(iidfile, 'r') as fd:
    #    return fd.read().strip()


def push(name):
    subprocess.call(['docker', 'push', name])


if __name__ == "__main__":
    args = vars(parser.parse_args(sys.argv[1:]))
    if args['verbose']:
        print("ArgumentParser: " + str(args))
    if args['command'] == 'build':
        build(args['dest'], args['orgnizations'])
    elif args['command'] == 'push':
        push(args['name'])
