set -o vi
bind 'set keyseq-timeout 10'

# Cursor shape follows mode: bar in insert, block in normal (native readline
# feature -- updates live on mode switch, unlike PROMPT_COMMAND-based tricks).
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string "\1\e[6 q\2"'
bind 'set vi-cmd-mode-string "\1\e[2 q\2"'
