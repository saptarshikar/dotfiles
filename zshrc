ZSH=~/.oh-my-zsh
ZSH_THEME="agnoster"
ZSH_CUSTOM="/Users/saptarshikar/.oh-my-zsh/custom"
ZSH_THEME="powerlevel10k/powerlevel10k"
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
POWERLEVEL9K_MODE="awesome-patched"
source $ZSH/oh-my-zsh.sh
export PATH=:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/sbin:/Users/saptarshikar/Library/Python/3.7/bin
alias y="yarn"
alias ls="ls -alh"
alias c="code ."
alias dotf="cd /Users/saptarshikar/Documents/code/dotfiles"
plugins=(iterm2 python history git git-extras zsh-autosuggestions zsh-syntax-highlighting)
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fortune|cowsay -f tux

