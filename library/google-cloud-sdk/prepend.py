from urllib import request
import tarfile
import os


def image_tag():
    return 'latest'


def build_args():
    args = {'CLOUD_SDK_VERSION': None}
    pwd = os.path.dirname(__file__)
    trf = pwd + os.path.sep + 'google-cloud-sdk.tar.gz'
    url = 'https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz'
    request.urlretrieve(url, trf)
    with tarfile.open(trf, 'r:gz') as tar:
        with tar.extractfile('google-cloud-sdk/VERSION') as fd:
            args['CLOUD_SDK_VERSION'] = fd.read().decode("utf-8").strip()
            print(args['CLOUD_SDK_VERSION'])
    os.remove(trf)
    return args
