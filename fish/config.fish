# starship init
starship init fish | source
if status is-interactive
    # Commands to run in interactive sessions can go here
end

#check local config
if test -f ~/.fishrc
    source ~/.fishrc
end
