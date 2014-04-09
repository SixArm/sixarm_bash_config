## One Letter Shortcuts

# f = find fast
hash ack-grep 2>&- && alias f='ack-grep' || hash ack 2>&- && alias f='ack' || alias f='find . | xargs grep '

# m = most || more
hash most 2>&- && alias m='most' || alias m='more'

