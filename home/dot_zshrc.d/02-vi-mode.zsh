bindkey -v
export KEYTIMEOUT=1

# Let starship's prompt (default vimcmd_symbol) reflect insert/normal mode,
# and switch the terminal cursor shape to match: bar in insert, block in normal.
zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne '\e[2 q'
  else
    echo -ne '\e[6 q'
  fi
  zle reset-prompt
}
zle -N zle-keymap-select

zle-line-init() {
  echo -ne '\e[6 q'
}
zle -N zle-line-init
