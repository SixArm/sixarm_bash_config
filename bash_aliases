## One Letter Shortcuts

# d = directory jump
[ -d /d ] && alias d="cd /d/; cd "

# e = edit using emacs || vi
hash emacs 2>&- && alias e='emacs -nw' || alias e='vi'

# f = find fast
hash ack-grep 2>&- && alias f='ack-grep' || hash ack 2>&- && alias f='ack' || alias f='find . | xargs grep '

# g = git
alias g='git'

# l = list files
alias l='ls -1AF'

# m = most || more
hash most 2>&- && alias m='most' || alias m='more'

## Administration

# rs = rsync with settings for typical mirroring; no partials because we may not have security.
alias rs='rsync --archive --compress --progress --update --verbose'

## Applications

# firefox
[ -e /opt/firefox/firefox ] && alias firefox='/opt/firefox/firefox'

# Ruby On Rails Restart - Phusion Passenger in the app's top directory
alias rrr='touch tmp/restart.txt'

