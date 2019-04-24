# p = pager for printing text to the screen
{ hash bat  2>&- && alias p='bat'; } ||
{ hash most 2>&- && alias p='most'; } || 
{ hash less 2>&- && alias p='less'; } || 
{ hash more 2>&- && alias p='more'; } ||
{ hash cat 2>&- && alias p='cat'; }
