## One Letter Shortcuts

# e = edit using emacs || vi
hash emacs 2>&- && alias e='emacs -nw --color=no' || alias e='vi'

# f = find fast
hash ack-grep 2>&- && alias f='ack-grep' || hash ack 2>&- && alias f='ack' || alias f='find . | xargs grep '

# m = most || more
hash most 2>&- && alias m='most' || alias m='more'

