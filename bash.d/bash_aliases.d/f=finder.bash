# f = find text
{ hash rg       2>&- && alias f='rg'; } ||
{ hash ag       2>&- && alias f='ag'; } ||
{ hash ack-grep 2>&- && alias f='ack-grep'; } ||
{ hash ack      2>&- && alias f='ack'; } ||
{ hash find     2>&- && alias f='find . | xargs grep '; }
