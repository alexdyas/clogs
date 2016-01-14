# clogs
Coloured Logs

Small filter to colour space separated log file fields to make them easier to read

Example usage :

`$ cat access.log | clogs.pl`

- Supports double quoted strings
- Colours cycle through ANSI 31 to 37
- Written to be as portable as possible, only requirement is Perl
