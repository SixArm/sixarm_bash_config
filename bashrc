# System-wide bashrc file for interactive bash(1) shells.
# Use this file to set up aliases, functions, and completions.
#
# To enable these items for login shells as well, 
# we can source this file in /etc/profile.
#
# ## What we load
#
# This bashrc script will source all these locations: 
#    
#    /etc/bash_scripts
#    /etc/bash_scripts.d/*
#    ~/.bash_scripts
#    ~/.bash_scripts.d/*
#    
#    /etc/bash_aliases
#    /etc/bash_aliases.d/*
#    ~/.bash_aliases
#    ~/.bash_aliases.d/*
#    
#    /etc/bash_functions
#    /etc/bash_functions.d/*
#    ~/.bash_functions
#    ~/.bash_functions.d/*
#
#    /etc/bash_completion
#    /etc/bash_completion.d/*
#    ~/.bash_completion
#    ~/.bash_completion.d/*
#
# ## Load details
#
# Since /etc/bashrc is typically included by ~/.bashrc,
# and read every time a shell starts up, we can use 
# the /etc/bashrc file to include aliases, functions, and completions. 
#
# This is useful because bash aliases and functions do not 
# behave like bash environment variables; the bash aliases 
# and functions are not passed to other processes. 
#
# ## Example
#
# To see an example of this, do this at a command prompt:
#
#     alias testecho='echo this is a test!'
#     cat > ~/test_script.bash << EOF
#     !/bin/bash
#     testecho
#     EOF
#     chmod u+x ~/test_script.bash
#     ~/.test_script.bash
#
# Executing the script will give you an error: 
# 
#     testecho: command not found
#
# The error happens because aliases and functions are not passed 
# to sub-processes. So, since ~/.bashrc is included with every 
# shell (and typically includes /etc/bashrc), people use this 
# file to set up aliases and functions so all of their shells have
# the same customizations.
#
# ## Difference between /etc/profile and /etc/bashrc 
#
# /etc/profile and /etc/bashrc are similar, 
# but traditionally have different purposes.
#
# /etc/profile is automatically loaded 
# only if the shell is a login shell.
#
# /etc/bashrc is not automatically loaded.
#
# To load /etc/bashrc, for example in 
# your ~/.bashrc file:
#
#    if [ -f /etc/bashrc ] ; then
#      . /etc/bashrc
#    fi
#
# Because of the difference in load behavior, 
# /etc/profile and /etc/bashr become specialized. 
#
# /etc/profile contains system/global environment variables 
# and startup programs. Since environment variables are 
# persistent (each process started by a shell inherits them)
# we only need to read them once. Similarly, once a startup 
# program is launched, there is no need to start it again.
# 
# One last bit to note. Both /etc/profile and /etc/bashrc contain
# settings that can be overwritten by users. If you are a sysadmin, 
# thatposes a problem if you want to impose a global change on all 
# users. Of these two files, the only one that lets you make such a
# change is /etc/profile. The reason for that is, a user can remove
# the "if [ -f /etc/bashrc ]" line from ~/.bashrc, and any changes
# to /etc/bashrc will be ignored. /etc/profile is guaranteed to be
# included at least once when the user initialy logs in, and that
# leaves it as the only viable way to include system-wide changes.
#
# ## Difference between /etc/bashrc and /etc/bash.bashrc
#
# The /etc/bash.bashrc file is only on Debian based Operating Systems.
# You will not find it on a Red Hat system nor most others (Arch etc).
#
# Therefore we prefer putting bash aliases and functions
# in /etc/bashrc, and sourcing it from /etc/bash.bashrc
#
# Credit for the comments above:
# http://www.linuxquestions.org/questions/linux-general-1/etc-profile-v-s-etc-bashrc-273992/

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# set a plain prompt
PS1='$ '

# set a prefix for bash script debugging output that shows
# the script name, line number and function name.
PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# Don't use ^D to exit
set -o ignoreeof

# turn on vi editing command line
#set -o vi

# turn on minor directory spellchecking for `cd`
shopt -s cdspell


##############################################################
#                      Includes
##############################################################

x=bash_scripts
for f in /etc/$x /etc/$x.d/* ~/.$x ~/.$x.d/*; do [ -r $f ] && source $f; done

x=bash_aliases
for f in /etc/$x /etc/$x.d/* ~/.$x ~/.$x.d/*; do [ -r $f ] && source $f; done

x=bash_functions
for f in /etc/$x /etc/$x.d/* ~/.$x ~/.$x.d/*; do [ -r $f ] && source $f; done

x=bash_completion
# we only need completion when we're in an interactive shell
if shopt -oq posix
then
  for f in /etc/$x /etc/$x.d/* ~/.$x ~/.$x.d/*; do [ -r $f] && source $f; done
fi


##############################################################
#             Environment specific settings
##############################################################

environment=$(uname -o)

case "`uname`" in

    CYGWIN*)
      # Cygwin specific stuff goes here
        PATH="$JAVA_HOME/bin:$PATH:./:/usr/share:/cygdrive/c/dev/Windows Resource Kits:/cygdrive/c/Program Files/Debugging Tools for Windows (x86):/cygdrive/c/dev/MySQL Server 5.0/bin/"
    ;;
    
    Linux*)
      # Linux specific stuff goes here
        export JDK_HOME=~/apps/jdks/jdk
        export JAVA_HOME=$JDK_HOME
        
        # this seems to make IntelliJ IDEA crash on startup so it's commented out: 
        # export AWT_TOOLKIT="MToolkit"

        export PATH="$JAVA_HOME/bin:$PATH:/home/tkirk/bin"
        export CLASSPATH=/home/tkirk/apps/tomcat/common/lib/jsp-api.jar:/home/tkirk/apps/tomcat/common/lib/servlet-api.jar
    ;;
esac

