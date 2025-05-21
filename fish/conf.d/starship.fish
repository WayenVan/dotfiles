# starship init
function starship_post_config_func --on-event fish_postconfig
    # 这里放置你的函数代码
    starship init fish | source
    echo "loaded starship"
    functions --erase starship_post_config_func
end
