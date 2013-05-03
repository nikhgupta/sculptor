Sculptor :: Scripts
===================

This repository contains various/miscellenous scripts that I use for my
development work, or just for leisure purposes.

I have been creating such scripts from quite a long time, but have not yet,
figured out a neat, reusable way to preserver them, and have them available
globally on my machine.

`Sculptor` simply helps me in doing exactly this. All scripts have been created
using `thor` gem. `Sculptor` installs itself as a global thor task, which in
turn calls upon tasks from the specified directories, thus, resulting in the
following:

  - Scripts can be easily categorized in different folders, according to their
  purpose/work.
  - Any new script created inside these folders will automatically be
  accessible globally.
  - I can version my scripts, when I place them inside this repository :)

Usage
-----

First, open the file: `~/.sculptor/data.yml` and add the following code to it:

    ---
    path: /path/to/local/sculptor/repository
    task_dirs:
      - /absolute/path/to/a/task/folder
      - may/be/relative/path/to/a/task/folder
      - and/so/on

`task_dirs` is an array of relative or absolute paths to the folders
containing our thor task files.

Now, you simply need to install the `sculptor.thor` task in thor.

    thor install sculptor.thor
    
Voila! Now, all your thor tasks will appear with a simple `thor -T` anywhere
on your machine!
