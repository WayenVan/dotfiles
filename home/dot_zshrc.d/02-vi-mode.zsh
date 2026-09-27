bindkey -v
export KEYTIMEOUT=1

# Allow deleting text that was present before entering vi insert mode.
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^?' backward-delete-char

# Switch the terminal cursor shape to match the active vi keymap without
# rebuilding the prompt. `zle reset-prompt` reruns Starship on every mode
# change and makes commands such as C feel noticeably delayed.
zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne '\e[2 q'
  else
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
  echo -ne '\e[6 q'
}
zle -N zle-line-init
