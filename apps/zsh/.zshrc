# https://michaeluloth.com/neovim-switch-configs/
vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

alias vz='NVIM_APPNAME=nvim-lazyvim nvim' # LazyVim
alias vc='NVIM_APPNAME=nvim-nvchad nvim' # NvChad
alias vk='NVIM_APPNAME=nvim-kickstart nvim' # Kickstart
alias va='NVIM_APPNAME=nvim-astronvim nvim' # AstroVim
alias vl='NVIM_APPNAME=nvim-lunarvim nvim' # LunarVim
alias v='va' # default Neovim config

mkdir -p ~/diary
alias d='v ~/diary/diary.norg'

alias resource='source ~/.zshrc'

plugins=(git tmux python poetry poetry-env rust ssh-agent vi-mode z)

#VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
#VI_MODE_SET_CURSOR=true

#MODE_INDICATOR="%F{white}|%f"
#INSERT_MODE_INDICATOR="%F{yellow}-%f"

zstyle :omz:plugins:ssh-agent agent-forwarding yes

ZSH_TMUX_AUTOSTART=true
source $ZSH/oh-my-zsh.sh
#PROMPT="$PROMPT\$(vi_mode_prompt_info)"
#RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"

# Make short hostname only if its not an IP address
__tm_get_hostname(){
    local HOST="$(echo $* | rev | cut -d ' ' -f 1 | rev)"
    if echo $HOST | grep -P "^([0-9]+\.){3}[0-9]+" -q; then
        echo $HOST
    else
        echo $HOST| cut -d . -f 1
    fi
}

__tm_get_current_window(){
    tmux list-windows| awk -F : '/\(active\)$/{print $1}'
}

# Rename window according to __tm_get_hostname and then restore it after the command
__tm_command() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=| cut -d : -f 1)" = "tmux" ]; then
        __tm_window=$(__tm_get_current_window)
        # Use current window to change back the setting. If not it will be applied to the active window
        trap "tmux set-window-option -t $__tm_window automatic-rename on 1>/dev/null" RETURN
        tmux rename-window "$(__tm_get_hostname $*)"
    fi
    command "$@"
}

ssh() {
    __tm_command ssh "$@"
}

ec2ssh() {
    __tm_command ec2ssh "$@"
}
