# SixArm.com » Bash shell » <br> /etc/bash* files for system setup

We create these files and directories in <code>/etc</code>:

    bashrc
    bashrc_on_darwin
    bashrc_on_cygwin
    bashrc_on_linux
    bash_aliases
    bash_aliases.d/
    bash_completions
    bash_completions.d/
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

    /etc/bash_functions
    /etc/bash_functions.d/*
    ~/.bash_functions
    ~/.bash_functions.d/*

    /etc/bash_completions
    /etc/bash_completions.d/*
    ~/.bash_completions
    ~/.bash_completions.d/*
    
Platform-specific code goes in platform-specific files:

    
    /etc/bashrc_on_cygwin # For Cygwin Windows Unix 
    /etc/bashrc_on_darwin # For Mac OSX Darwin
    /etc/bashrc_on_linux  # For Linux, Ubuntu, Debian, etc.
    

    
        
    
