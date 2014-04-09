# SixArm.com » Bash » <br> /etc/bash* files for system setup

We create these files and directories in <code>/etc</code>:

    bashrc
    bash_aliases
    bash_aliases.d/
    bash_completion
    bash_completion.d/
    bash_functions
    bash_functions.d/
    bash_scripts
    bash_scripts.d/

The main bashrc script will source all these locations if they exist, in order:

    /etc/bash_scripts 
    /etc/bash_scripts.d/*
    ~/.bash_scripts
    ~/.bash_scripts.d/*

    /etc/bash_aliases
    /etc/bash_aliases.d/*
    ~/.bash_aliases
    ~/.bash_aliases.d/*

    /etc/bash_fucntions
    /etc/bash_fucntions.d/*
    ~/.bash_fucntions
    ~/.bash_fucntions.d/*

    /etc/bash_completion
    /etc/bash_completion.d/*
    ~/.bash_completion
    ~/.bash_completion.d/*
