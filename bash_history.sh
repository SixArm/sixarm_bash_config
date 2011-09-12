#!/bin/bash

# huge history lists are very useful
export HISTSIZE=100000

# huge history files aren't a problem
export HISTFILESIZE=1000000

# skip duplicate lines in history
export HISTCONTROL=ignoredups

# bind up & down arrows to history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


