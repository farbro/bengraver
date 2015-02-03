#!/usr/bin/env python
#
# Original code from nophead: https://github.com/nophead/Mendel90
# Tweaked by farbo for general use

import os
import sys
import shutil
import subprocess

def render(stl_dir):
    render_dir = stl_dir + os.sep + "render"

    if os.path.isdir(render_dir):
        shutil.rmtree(render_dir)   #clear out any dross
    os.makedirs(render_dir)
    #
    # List of individual part files
    #
    stls = [i[:-4] for i in os.listdir(stl_dir) if i[-4:] == ".stl"]
#
    for i in stls:
        command = 'blender -b  utils' + os.sep + 'render.blend -P utils' + os.sep + 'viz.py -- ' + \
            stl_dir + os.sep + i + '.stl ' + render_dir + os.sep + i + '.png'
        print(command)
        subprocess.check_output(command.split())

if __name__ == '__main__':
    if len(sys.argv) > 1:
        render(sys.argv[1])
    else:
        print "usage: render [path/to/stls]"
        sys.exit(1)
