## my zshrc based on grml and powerline

alias -g colorcopy="| sed 's/'\$(echo -e \"\\033\")'/'\$(echo -e \"\\033\\033\")'/g' | tee /dev/tty | xsel -bi"

[ -f $HOME/.bashrc ] && source $HOME/.bashrc
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
export SHELL=/bin/zsh

#powerline
POWERLINE_BINDINGS=/usr/share/powerline/bindings/
powerline-daemon -q  # run powerline daemon
[ -f $POWERLINE_BINDINGS/zsh/powerline.zsh ] &&source $POWERLINE_BINDINGS/zsh/powerline.zsh

[ -f $HOME/.config/zsh/zshinit.zsh ] &&source $HOME/.config/zsh/zshinit.zsh

# key bindings fixes for urxvt
# bindkey "^[[7~" beginning-of-line
# bindkey "^[[8~" end-of-line
# bindkey "^[[5~" beginning-of-history
# bindkey "^[[6~" end-of-history
# bindkey "^[[3~" delete-char
# bindkey "^[[2~" quoted-insert

# bindkey "^[[A" history-substring-search-up
# bindkey "^[[B" history-substring-search-down

# bindkey "^[p" up-line-or-search
# bindkey "^[n" down-line-or-search

# bindkey "^[OA" history-substring-search-up
# bindkey "^[OB" history-substring-search-down



# completion for Syu
# compdef -e "words[1]=(pacman -Su);service=pacman;((CURRENT+=1));_pacman" Syu Ge Gc Gw
# compdef -e "words[1]=(pikaur -G);service=cower;((CURRENT+=1));_pikaur" Ga
# compdef -e "words[1]=(pikaur -Ssa);service=cower;((CURRENT+=1));_pikaur" Ssa

# add a command line to the shells history without executing it
commit-to-history () {
        print -s ${(z)BUFFER}
        zle send-break
}
zle -N commit-to-history
# bindkey -M viins "^x^h" commit-to-history
# bindkey -M emacs "^x^h" commit-to-history


# zsh_stats from oh-my-zsh https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/functions.zsh
function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}



# change systemd-boot default entry to reboot to windows
# alias reboot-windows="sudo efivar -w -n 4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderEntryDefault -f =(echo -n 'windows\0' | iconv -f utf-8 -t utf-16le)"

# Automatically change the directory in bash after closing ranger
#
# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.

function ranger-cd {
    tempfile="$(mktemp)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}
