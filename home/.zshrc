alias ls='ls --color=auto'

# PATHs
export MANPATH="/usr/local/man:$MANPATH"
export PATH=$HOME/.local/bin:$PATH

# oh-my-zsh
export ZSH="/home/lava/.oh-my-zsh"
ZSH_THEME="bira"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
export UPDATE_ZSH_DAYS=7
plugins=(command-not-found dotnet gitfast gulp nvm timer yarn zsh-autosuggestions)
ZSH_AUTOSUGGEST_STRATEGY=(completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# DISABLE_MAGIC_FUNCTIONS=true
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder
source $ZSH/oh-my-zsh.sh

# Wine
export WINEPREFIX=/home/lava/.wine
export WINEARCH=win64

# Other environment variables
export FREETYPE_PROPERTIES="truetype:interpreter-version=35"
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4096m"

# History
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

# Pacman rehash hook
autoload -Uz add-zsh-hook
zshcache_time="$(date +%s%N)"
rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
add-zsh-hook -Uz precmd rehash_precmd

# Fuck
eval $(thefuck --alias)

# Autostart X
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi