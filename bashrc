# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

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
for f in /etc/$x /etc/$x.d/* ~/.$x ~/.$x.d; do [ -r $f ] && source $f; done

x=bash_aliases
for f in /etc/$x /etc/$x.d/* ~/.$x ~/.$x.d; do [ -r $f ] && source $f; done

# enable bash completion in interactive shells
if shopt -oq posix
then
  x=bash_completion
  for f in /etc/$x /etc/$x.d/* ~/.$x ~/.$x.d; do [ -r $f] && source $f; done
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

