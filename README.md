# SixArm.com → Bash shell → <br> /etc/bash* files for system setup

This repo has bash shell files, aliases, completions, functions, scripts, etc.


## Install

To install for your user account:

```shell
git clone https://github.com/SixArm/sixarm_bash_etc_files.git
cd sixarm_bash_etc_files
... look through the files and copy anything you like to your own .bashrc ...
```

To install for all user accounts and potentially overwrite system bash files:

```shell
git clone https://github.com/SixArm/sixarm_bash_etc_files.git
sudo cp -R sixarm_bash_etc_files/bash* /etc
```


## Contents

We create these files and directories in <code>/etc</code>:

    bashrc
    bash_aliases
    bash_aliases.d/
    bash_completions
    bash_completions.d/
    bash_functions
    bash_functions.d/
    bash_scripts
    bash_scripts.d/


## Platforms

Platform-specific code goes in platform-specific files:
    
    bash_on_cygwin
    bash_on_cygwin.d/
    bash_on_darwin
    bash_on_darwin.d/
    bash_on_linux
    bash_on_linux.d/


## Locations

The main bashrc script will source all the above, if they exist:

    /etc/bash_scripts 
    /etc/bash_scripts.d/*
    ~/.bash_scripts
    ~/.bash_scripts.d/*

And so on for the other areas.
