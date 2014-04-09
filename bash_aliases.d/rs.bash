# rs: rsync with settings for typical mirroring.
#
# We do not use the --partial flag because sometimes 
# we will not have partial-write capability due to
# directory permissions.
#
alias rs='rsync --archive --compress --progress --verbose'

