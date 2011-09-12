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
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '


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

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

for file in /etc/bash_setuprompt /etc/bash_sudo_hint /etc/bash_command_not_found ~/.bash_aliases; do
  if [ -f $file ]; then
    . $file
  fi
done

# Don't use ^D to exit
set -o ignoreeof

# turn on vi editing command line
#set -o vi

# turn on minor directory spellchecking for `cd`
shopt -s cdspell


##############################################################
#                      History
##############################################################

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# huge hist files aren't a problem
export HISTFILESIZE=1000000

# and huge history lists are very useful
export HISTSIZE=100000

# nearly nothing I work on will fit in the default of 64m, so embiggen this
export MAVEN_OPTS=-Xmx512m


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


