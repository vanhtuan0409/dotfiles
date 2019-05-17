from ranger.api.commands import Command
from ranger.ext.next_available_filename import next_available_filename
import os
import re
from shutil import copyfile


class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        fzf = self.fm.execute_command("fzf +m", universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

class duplicate(Command):
    def _ask_new_name(self):
        from ranger import MACRO_DELIMITER, MACRO_DELIMITER_ESC

        tfile = self.fm.thisfile
        relpath = tfile.relative_path.replace(MACRO_DELIMITER, MACRO_DELIMITER_ESC)
        basename = tfile.basename.replace(MACRO_DELIMITER, MACRO_DELIMITER_ESC)
        if basename.find('.') <= 0 or os.path.isdir(relpath):
            self.fm.open_console('duplicate ' + relpath)
            return
        pos_ext = basename.rindex('.')
        pos = len(relpath) - len(basename) + pos_ext
        self.fm.open_console('duplicate ' + relpath, position=(10 + pos))

    def _duplicate(self, n):
        file_name = next_available_filename(n)
        copyfile(self.fm.thisfile.basename, file_name)

    def execute(self):
        name = self.rest(1)
        if name == "":
            self._ask_new_name()
            return
        else:
            self._duplicate(name)
            return
