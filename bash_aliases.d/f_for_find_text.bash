# f = find text using ag or ack-grep or ack or grep.
hash ack-grep 2>&- && alias f='ag' || 
hash ack-grep 2>&- && alias f='ack-grep' || 
hash ack 2>&- && alias f='ack' || 
alias f='find . | xargs grep '
