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
alias vim='va' # default Neovim config

mkdir -p ~/diary
alias d='v ~/diary/diary.norg'

alias resource='source ~/.zshrc'

if [ -n "$SSH_CONNECTION" ]; then
  plugins=(git python poetry poetry-env rust ssh-agent vi-mode z)
else
  plugins=(git tmux python poetry poetry-env rust ssh-agent vi-mode z)
fi

#VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
#VI_MODE_SET_CURSOR=true

#MODE_INDICATOR="%F{white}|%f"
#INSERT_MODE_INDICATOR="%F{yellow}-%f"

zstyle :omz:plugins:ssh-agent agent-forwarding yes

ZSH_TMUX_AUTOSTART=true
source $ZSH/oh-my-zsh.sh
#PROMPT="$PROMPT\$(vi_mode_prompt_info)"
#RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"
alias lg='lazygit'
alias ld='lazydocker'

# sets config location for lazy git
export XDG_CONFIG_HOME="$HOME/.config
