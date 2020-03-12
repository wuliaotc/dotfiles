#plugins
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

#theme
[ -f $HOME/.config/zsh/theme/powerlevel10k/powerlevel10k.zsh-theme ] &&source $HOME/.config/zsh/theme/powerlevel10k/powerlevel10k.zsh-theme
[ -f $HOME/.config/zsh/theme/.p10k.zsh ] &&source $HOME/.config/zsh/theme/.p10k.zsh
