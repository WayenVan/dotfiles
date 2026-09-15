if command -v mise >/dev/null 2>&1; then
  ZSH_AUTOSUGGESTIONS_DIR=$(mise where zsh-autosuggest 2>/dev/null)
  [[ -f $ZSH_AUTOSUGGESTIONS_DIR/zsh-autosuggestions.zsh ]] && source $ZSH_AUTOSUGGESTIONS_DIR/zsh-autosuggestions.zsh
fi
