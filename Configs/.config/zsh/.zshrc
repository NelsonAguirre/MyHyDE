# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added a config file for you to customize HyDE before loading zshrc
# Edit $ZDOTDIR/.user.zsh to customize HyDE before loading zshrc

#  Plugins 
# oh-my-zsh plugins are loaded  in $ZDOTDIR/.user.zsh file, see the file for more information

#  Aliases 
# Override aliases here in '$ZDOTDIR/.zshrc' (already set in .zshenv)

# # Helpful aliases
# alias c='clear'                                                        # clear terminal
# alias l='eza -lh --icons=auto'                                         # long list
# alias ls='eza -1 --icons=auto'                                         # short list
# alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
# alias ld='eza -lhD --icons=auto'                                       # long list dirs
# alias lt='eza --icons=auto --tree'                                     # list folder as tree
# alias un='$aurhelper -Rns'                                             # uninstall package
# alias up='$aurhelper -Syu'                                             # update system/package/aur
# alias pl='$aurhelper -Qs'                                              # list installed package
# alias pa='$aurhelper -Ss'                                              # list available package
# alias pc='$aurhelper -Sc'                                              # remove unused cache
# alias po='$aurhelper -Qtdq | $aurhelper -Rns -'                        # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
# alias vc='code'                                                        # gui code editor
# alias fastfetch='fastfetch --logo-type kitty'

# # Directory navigation shortcuts
# alias ..='cd ..'
# alias ...='cd ../..'
# alias .3='cd ../../..'
# alias .4='cd ../../../..'
# alias .5='cd ../../../../..'

# # Always mkdir a path (this doesn't inhibit functionality to make a single dir)
# alias mkdir='mkdir -p'

#  This is your file 
# Add your configurations here
EDITOR=nvim

# unset -f command_not_found_handler # Uncomment to prevent searching for commands not found in package manager

# General alias
alias ls="lsd"
alias lsn="/bin/ls"
alias cat="bat --style=plain"
alias catn="/bin/cat"
alias vim="nvim"
alias icat="kitty +kitten icat"
alias matrix="unimatrix -s 95"
alias open="xdg-open"

eval $(thefuck --alias)

wsearch() {
    # Reemplaza los espacios por '+' para que la URL sea válida
    local query=$(echo "$*" | tr ' ' '+')
    w3m "https://duckduckgo.com/html/?q=$query"
}
  
# Variables

export PASSWORD_STORE_ENABLE_EXTENSIONS=true


# opencode
export PATH=/home/nelson/.opencode/bin:$(go env GOPATH)/bin:$PATH

export PKMPATH="/home/nelson/MyZettelkasten"
alias inbox="ls '$PKMPATH/01-Inbox'"

# Ignorar el signal SIGSEGV del proceso hijo (ERROR opencode+plugin mio)
opencode() { command opencode "$@" 2>/dev/null || true; }
