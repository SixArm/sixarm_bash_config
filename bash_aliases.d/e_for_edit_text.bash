# e = edit using emacs or vi
$(hash emacs 2>&- && alias e='emacs -nw --color=no’) || 
$(hash vi 2>&- && alias e='vi’) ||
$(hash pico 2>&- && alias e='pico’) ||
$(hash nano 2>&- && alias e='nano’)
