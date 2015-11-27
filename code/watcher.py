# TODO
# * check if files are actually build

# File Watcher and Build System

# $ pip install watchdog
# http://pythonhosted.org/watchdog/api.html#module-watchdog.observers
# http://pythonhosted.org/watchdog/api.html#watchdog.events.FileSystemEventHandler
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

import os
from glob import glob


LOG = logging.getLogger(__name__)


class Builder(object):

    def __init__(self, assets_dir, output_dir, logger=print):
        self.assets_dir = assets_dir
        self.output_dir = output_dir
        self.logger = logger

    def compile_sass(self, *args, **kwargs):
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

        error = 0

        for sass_file_path in glob(self.assets_dir+'*.*'):
            filename = sass_file_path.split(self.assets_dir)[-1].split('.')[0]
            css_path = self.output_dir + filename + '.css'

            sass_args = {
                'source': '{}'.format(sass_file_path),
                'output': '{}'.format(css_path),
            }
            subprocess.call('''
                sassc -m {source} {output} -s compressed
                '''.format(**sass_args),
                shell=True,
                preexec_fn=os.setsid,
                stdout=subprocess.PIPE
            )

            if glob(css_path):
                self.logger('Built \'{}\''.format(css_path))
            else:
                self.logger('Error when building \'{}\''.format(css_path))
                error = 1

        if not error:
            self.logger('Completed Build')
        else:
            self.logger('[ERROR!] Build Incomplete')

    def start(self):
        from watchdog.observers import Observer
        from watchdog.events import FileSystemEventHandler

        handler = FileSystemEventHandler()
        handler.on_modified = self.compile_sass

        watch = Observer()
        watch.schedule(handler, self.assets_dir, recursive=True)
        watch.start()
        self.logger('Watching \'{}\' for changes'.format(self.assets_dir))

def activate():
    builder = Builder('static/assets/', 'static/css/')
    builder.start()
    builder.compile_sass()


if __name__ == '__main__':
    builder = Builder('static/assets/', 'static/css/')
    builder.start()
    builder.compile_sass()
