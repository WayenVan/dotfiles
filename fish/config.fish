# starship init
starship init fish | source

alias -s ll "ls -lah"

#check local config
if test -f ~/.fishrc
  source ~/.fishrc
end
