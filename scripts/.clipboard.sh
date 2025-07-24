#!/bin/bash

options=$(cat ~/.config/config/.clipboard | grep -v '^#')
selection=$(echo "$options" | fzf)

# exit if selection is empty
[[ -z "$selection" ]] && exit

IS_WSL=$(uname -a | grep -iq "microsoft" && echo "true")

if [[ -n "$IS_WSL" ]]; then
    echo -n "$selection" | clip.exe
else
    echo -n "$selection" | xclip -selection clipboard
    echo -n "$selection" | xclip -selection primary
fi

