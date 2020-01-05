powerline-daemon -q
set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
powerline-setup

set -U fish_user_paths $fish_user_paths $HOME/.node_modules/bin
set -Ux npm_config_prefix ~/.node_modules
