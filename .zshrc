export ZSH="$HOME/.bin/oh-my-zsh"
ZSH_THEME="catppuccin"
# Auto-update oh my zsh
zstyle ':omz:update' mode auto
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"


# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/secrets.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias clang=clang-20
alias uvr="uv run"
alias py="uv run python"

# Function to lazy load slow running init scripts.
lazy_load() {
    local init=$argv[-1]
    local -a cmds=($argv[1,-2])
    local cmd
    for cmd ($cmds) {
        eval "$cmd() {
            local c
            for c ($cmds) {
                unfunction \$c
            }
            eval ${(q)init}
            $cmd \"\$@\"
        }"
    }
}

# Rust init.
export CARGO_HOME="$HOME/.bin/cargo"
export RUSTUP_HOME="$HOME/.bin/rustup"
export PATH="$CARGO_HOME/bin:$PATH"
# Rust esp init.
export LIBCLANG_PATH=$(echo $RUSTUP_HOME/toolchains/esp/xtensa-esp32-elf-clang/*/esp-clang/lib(N[-1]))
export PATH=$(echo $RUSTUP_HOME/toolchains/esp/xtensa-esp-elf/*/xtensa-esp-elf/bin(N[-1])):"$PATH"

# Python init.
init_cmd=$(cat << EOF
$("$HOME/.bin/miniforge3/bin/conda" shell.zsh  hook 2> /dev/null)
$("$HOME/.bin/miniforge3/bin/mamba" shell hook --shell zsh --root-prefix "$HOME/.bin/miniforge3" 2> /dev/null)
EOF
)
lazy_load python ipython jupyter "eval $init_cmd"
unset init_cmd

# Javascript init.
export NVM_DIR="$HOME/.bin/nvm"
export PATH=$(echo $NVM_DIR/versions/node/*/bin(N[-1])):"$PATH"
lazy_load nvm "source $NVM_DIR/nvm.sh; source $NVM_DIR/bash_completion"

# Vim init.
alias vim=nvim
export EDITOR='nvim'
export PATH="$HOME/.bin/nvim/bin:$PATH"
