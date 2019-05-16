#!/bin/bash

##
# Bash loading details
#
# Since /etc/bashrc is typically included by ~/.bashrc,
# and read every time a shell starts up, we can use /etc/bashrc
# file to include aliases, functions, and completions.
#
# This is useful because bash aliases and functions do not
# behave like bash environment variables; the bash aliases
# and functions are not passed to other processes.
#
# ## Example
#
# To see an example of this, do this at a command prompt:
#
#     alias example='echo this is a test!'
#     cat > ~/example.bash << EOF
#     !/bin/bash
#     example
#     EOF
#     chmod u+x ~/example.bash
#     ~/.example.bash
#
# Executing the script will give you an error:
#
#     example: command not found
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
#
# TODO: consider including https://github.com/mrzool/bash-sensible
#
##


###########################################################################
# SixArm Unix functions
# 
# These are general-purpose functions that our teams use in scripts, 
# so we want to ensure that we load these functions first.
###########################################################################


##
# Output helpers
##

# out: print output message to stdout
out() { printf %s\\n "$*" ; }

# err: print error message to stderr
err() { >&2 printf %s\\n "$*" ; }

# die: print error message to stderr, then exit with error code 1
die() { >&2 printf %s\\n "$*" ; exit 1 ; }

# big: print a big banner to stdout, good for human readability
big() { printf \\n###\\n#\\n#\ %s\\n#\\n###\\n\\n "$*"; }

# log: print the current datestamp, the process id, and a message
log() { printf '%s %s %s\n' "$( now )" $$ "$*" ; }

# zid: generate a 32-bit secure random lowercase hex identifier
zid() { hexdump -n 16 -v -e '16/1 "%02x" "\n"' /dev/random ; }

##
# Time helpers
##

# now: get the current datetime using ISO standard format.
now() { date -u "+%Y-%m-%dT%H:%M:%S.%N+00:00" ; }

# sec: get the current time in Unix seconds.
sec() { date "+%s" ; }

##
# Number helpers
##

# int: convert a number string to an integer number string.
int() { awk '{ print int($1) }' ; }

# sum: print the sum of numbers
sum() { awk '{for(i=1; i<=NF; i++) sum+=$i; } END {print sum}' ; }

##
# Run helpers
##

# cmd: return true iff a command exists
cmd() { command -v "$1" >/dev/null 2>&1 ; }

# exe: run all the executable commands in a given directory and subdirectories
exe() { [ -d "$1" ] && find "$1" -type f \( -perm -u=x -o -perm -g=x -o -perm -o=x \) -exec test -x {} \; -exec {} \; ; }

##
# Array helpers
##

# array_i: get the array item at index `i`.
array_i() { [ $# == 3 ] && awk -F "$2" "{print \$$3}" <<< "$1" || awk "{print \$$2}" <<< "$1" ; }

# array_n: get the array number of fields a.k.a. length a.k.a. size.
array_n() { [ $# == 2 ] && awk -F "$2" "{print NF}"   <<< "$1" || awk "{print NF}" <<< "$1" ; }

##
# Assert helpers
##

# Assert an item is empty.
assert_empty() { [ -z "$1" ] || err $FUNCNAME "$@" ; }

# Assert an item is equal to another item.
assert_equal() { [ "$1" = "$2" ] || err $FUNCNAME "$@" ; }

# Assert an item matches a regular expression.
assert_match() { [[ "$2" =~ $1 ]] || err $FUNCNAME "$@" ; }

##
# Home helpers
##

log_home() { out "${LOG_HOME:=$HOME/.log}" ; }
data_home() { out "${XDG_DATA_HOME:=$HOME/.local/share}" ; }
cache_home() { out "${XDG_CACHE_HOME:=$HOME/.cache}" ; }
config_home() { out "${XDG_CONFIG_HOME:-$HOME/.config}" ; }
runtime_home() { out "${XDG_RUNTIME_HOME:=$HOME/.runtime}" ; }
temp_home() { out "$(mktemp -d -t "${1:-$(zid)}")"; }


###########################################################################
# Includes
#
# We source all the relevant files inside the bash.d directory,
# and choose the appropriate files for the platform.
###########################################################################


##
# Create a list of all the paths that we want to source.
##

top_paths="$(dirname "$BASH_SOURCE")/bash.d"
sub_paths="bash_aliases.d bash_functions.d bash_scripts.d"

if shopt -oq posix; then
  sub_paths="$sub_paths bash_completion.d"
fi

case "`uname`" in

    CYGWIN*)
      sub_paths="$sub_paths bash_on_cygwin.d"
    ;;

    Linux*)
      sub_paths="$sub_paths bash_on_linux.d"
    ;;

    Darwin*)
      sub_paths="$sub_paths bash_on_darwin.d"
    ;;

esac

##
# Source all the relevant files.
##

for top_path in $top_paths; do
  for sub_path in $sub_paths; do
    # Find the files to source, using a cross-platform POSIX way,
    # that will find files that are executable by the current user,
    # and will execute in a predicatble order i.e. in sort order.
    for file in $(find "$top_path/$sub_path" -type f \( -perm -u=x -o -perm -g=x -o -perm -o=x \) -exec test -x {} \; -print | sort); do
      source "$file"
    done
  done
done
