# File Watcher and Build System

# $ pip install watchdog
# http://pythonhosted.org/watchdog/api.html#module-watchdog.observers
# http://pythonhosted.org/watchdog/api.html#watchdog.events.FileSystemEventHandler
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

import os
from glob import glob


class Builder(object):

    def __init__(self, assets_dir, output_dir):
        self.assets_dir = assets_dir
        self.output_dir = output_dir

    def sass(self, *args, **kwargs):
        # $ sudo apt-get install python-dev
        # $ pip install libsass
        # https://github.com/dahlia/libsass-python
        #
        # Why are we writing our own watcher instead of the builtin libsass
        # watcher?
        # a) the libsass command line API is more stable than the python API
        # b) at time of writing, if you call libsass via subprocess with the
        #    watcher, it wont close when its parent python process closes.
        #    which leads to dozens of `sassc --watch` processes open forever

        for sass_file_path in glob(self.assets_dir+'*.*'):
            filename = sass_file_path.split(self.assets_dir)[-1].split('.')[0]
            css_path = self.output_dir + filename + '.css'

            print('Building {}'.format(css_path))

            sass_args = {
                'source': '{}'.format(sass_path),
                'output': '{}'.format(css_path),
            }
            subprocess.call('''
                sassc -m {source} {output} -s compressed
                '''.format(**sass_args),
                shell=True,
                preexec_fn=os.setsid,
                stdout=subprocess.PIPE
            )
        print('Completed Build')


def watcher(callback, path):
    # create the event handler
    handler = FileSystemEventHandler()

    # define the path and event callback
    path = os.path.dirname(__file__)+'/'+path
    handler.on_modified = callback

    # start watching that path
    watch = Observer()
    watch.schedule(handler, path, recursive=True)
    watch.start()
    print('Watching {} for changes'.format(path))


if __name__ == '__main__':

    assets_dir = 'static/assets/'
    output_dir = 'static/css/'

    # set configs for the builder class
    builder = Builder(assets_dir, output_dir)
    # give the watcher the relevant build function and watch path
    watcher(builder.sass, assets_dir)
