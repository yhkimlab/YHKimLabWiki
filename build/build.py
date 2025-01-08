import shutil
from distutils.dir_util import copy_tree
import subprocess
import os

def build_and_copy(folder):
    os.chdir(folder)
    subprocess.run("mkdocs build", shell=True)
    copy_tree("site", f"../start_page/site/{folder}")
    os.chdir('..')

if __name__=='__main__':
    os.chdir('start_page')
    subprocess.run("mkdocs build", shell=True)
    os.chdir('..')

    folders = ['graduate', 'undergrad', 'starting']
    for folder in folders:
        build_and_copy(folder)

    copy_tree("start_page/site/", "../site")