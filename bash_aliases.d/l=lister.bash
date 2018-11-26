# l = lister of files
{ hash exa  2>&- && alias l='exa' & alias ll='exa --long --bytes --extended --group  --time-style long-iso --git'; } ||
{ hash ls 2>&- && alias l='ls' & alias ll='ls -1A'; }
