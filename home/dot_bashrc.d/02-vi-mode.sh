set -o vi
bind 'set keyseq-timeout 10'

# Let Readline change the cursor shape with the active vi mode. Unlike Zsh's
# `zle reset-prompt`, this uses Readline's native redisplay mechanism and does
# not rerun the shell prompt command.
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string "\1\e[6 q\2"'
bind 'set vi-cmd-mode-string "\1\e[2 q\2"'
