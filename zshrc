ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
ZSH_THEME="agnoster"
ZSH_CUSTOM="/Users/sapkar/Documents/zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"
source ~/.bash_profile
export PATH=/Users/sapkar/.toolbox/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/sapkar/.toolbox/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
plugins=(iterm2 python history git git-extras zsh-autosuggestions zsh-syntax-highlighting)
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
