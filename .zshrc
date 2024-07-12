#!/usr/bin/env zsh
# Enable this to time plugin loading times
zmodload zsh/zprof
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export SCRIPTS=${HOME}/scripts
export ZSHCONFIG=${ZDOTDIR:-$HOME}/.zsh-config

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  aliases
  battery
  colored-man-pages
  colorize
  copypath
  copyfile
  cp
  encode64
  git
  git-extras
  gitfast
  gitignore
  wd
  python
  rust
  ubuntu
  zsh-autosuggestions
  zsh-completions
  # zsh-syntax-highlighting
  evalcache
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Because BASH on Ubuntu on Windows

# To fix "nice" problems
unsetopt BG_NICE

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_AU.UTF-8
export LANGUAGE=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  # export EDITOR='nano'
  export EDITOR='code'
else
  export EDITOR='code'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"
export CC="/usr/bin/clang"
export CXX="/usr/bin/clang++"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# export SSH_AUTH_SOCK="C:\Temp\cyglockfile"
# [ -n ${WSL_AUTH_SOCK} ] && export SSH_AUTH_SOCK=${WSL_AUTH_SOCK}

# WSL
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
ss -a | grep -q $SSH_AUTH_SOCK
if [ $? -ne 0   ]; then
    rm -f $SSH_AUTH_SOCK
    ( setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"/mnt/c/WSL_SSH/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
fi

# gpg
# eval $(gpg-agent --daemon)
# GPG-AGENT stuff
# GET_TTY=$(tty)
# export $GET_TTY
# $HOME/.gnupg/gpg-agent-start.sh
export HISTIGNORE="ls"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias diffogram="git --no-pager diff --no-index --histogram"
# My aliases
alias wkupdate="sudo apt-fast update && sudo apt-fast upgrade -y && sudo apt autoremove -y"
alias newmake="make clean && make"
alias sourcerc="source ~/.zshrc"
alias pip3="python3 -m pip"
alias pipuserinstall="python3 -m pip install --user --upgrade $1"
alias untar="tar xvf $1"
alias tarit="tar cvf $1 $2"
alias lt="ls --human-readable --size -1 -S --classify"
alias gh="history | grep"
alias lastmodified="ls -t -1"
alias countfiles="find . -type f | wc -l"
alias ve="python3 -m venv ./venv"
alias va="source ./venv/bin/activate"
alias cpv="rsync -ah --info=progress2"
alias tcn="mv --force -t ~/.local/share/Trash"
alias foliate="com.github.johnfactotum.Foliate &" # Assumes foliate is installed via snap store or similar
alias cwd="echo 'Correct way to print current working directory is PWD.' && pwd"
alias open="xdg-open"
# WSL
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    alias here="explorer.exe ."
else
    alias here="xdg-open ."
fi
# UNSW CSE stuff
alias csesh="ssh CSE"
alias cp2cse="scp zID@login.cse.unsw.edu.au:~/scp ."

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


if [[ ":$PATH:" != *"$HOME/.local/bin"* ]]; then
  PATH="$HOME/.local/bin:$PATH"
fi

####################
## USER FUNCTIONS ##
####################

function ssa() {
  if [[ -z ${SSH_AGENT_PID} ]]; then
    eval $(ssh-agent -t 20000)
    ssh-add
  fi
}

function unssa() {
  if [[ -n ${SSH_AGENT_PID} ]]; then
    ssh-agent -k
    unset SSH_AGENT_PID
  fi
}

function start_agent() {
  echo "Initialising new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo Succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}

if [[ $(uname -a) =~ "arch" ]]; then
  function aur_update() {
    local yay-path="~/.cache/yay"
    for arg in "$@"; do
      cd "${yay_path}${arg}"
      makepkg -i
    done
  }
fi

function awsupdate() {
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install --bin-dir $(which aws) --install-dir $(ls -al $(which aws) | grep -P "(?<=-> )(.*)(?=\/v2\/current\/bin\/aws)" -o) --update
  rm -rf awscliv2.zip aws
}

function transfer() {
  if [ $# -eq 0 ]; then
    echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
    return 1;
  fi
  tmpfile=$( mktemp -t transferXXX );
  if tty -s; then
    basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
  else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
  fi;
  cat $tmpfile; rm -f $tmpfile;
}


# Example usage:
# add_torrent_rule "AnimeName" "MustContain" "MustNotContain" 1
add_torrent_rule() {
    local japanese_name="$1"
    local must_contain="$2"
    local must_not_contain="${3:-}"
    local season_number="${4:-1}"

    local rule_path="$HOME/.config/qBittorrent/rss/download_rules.json"

    if [ -z "$must_not_contain" ]; then
        must_not_contain=""
    fi
    if [ -z "$season_number" ]; then
        season_number=1
    fi

    local existing=$(cat "$rule_path")
    local obj=$(jq -n \
        --arg mustContain "$must_contain 1080p" \
        --arg mustNotContain "$must_not_contain" \
        --arg savePath "G:/$japanese_name/S$season_number" \
        '{
            addPaused: null,
            affectedFeeds: [
                "https://subsplease.org/rss",
                "https://nyaa.si/?page=rss&u=subsplease",
                "https://subsplease.org/rss/?t&r=1080"
            ],
            assignedCategory: "",
            enabled: true,
            episodeFilter: "",
            ignoreDays: 0,
            lastMatch: "",
            mustContain: $mustContain,
            mustNotContain: $mustNotContain,
            previouslyMatchedEpisodes: [],
            priority: 0,
            savePath: $savePath,
            smartFilter: false,
            torrentContentLayout: "null",
            torrentParams: {
                category: "",
                download_limit: -1,
                download_path: "",
                inactive_seeding_time_limit: -2,
                operating_mode: "AutoManaged",
                ratio_limit: -2,
                save_path: $savePath,
                seeding_time_limit: -2,
                skip_checking: false,
                tags: [],
                upload_limit: -1,
                use_auto_tmm: false
            },
            useRegex: false
        }')

    existing=$(echo "$existing" | jq --argjson obj "$obj" '. + {("subsplease " + $obj.savePath): $obj}')
    echo "$existing" | jq . > "$rule_path"
}


# Example usage:
# lsDate "/path/to/directory"
lsDate() {
    local args=("$@")
    if [ ${#args[@]} -eq 0 ]; then
        args=(".")
    fi
    for arg in "${args[@]}"; do
        find "$arg" -type d -exec stat -c "%n %w" {} + | sort -k2
    done
}


# Example usage:
# extract_subtitles
extract_subtitles() {
    for file in *.mkv; do
        echo "$file"
        /path/to/mkvinfo "$file" -r file.txt

        # Extract the track number using awk and grep
        track=$(grep -A 2 'Track type: subtitles' file.txt | awk -F ')' '/Track number:/ {print $1}')

        name="${file%.*}"
        /path/to/mkvextract tracks "$file" "${track}:${name}.track${track}.ass"
    done
}



# Example usage:
# new_anime_folder "AnimeName" 1 "SeasonSubtitle"
new_anime_folder() {
    local anime_name="$1"
    local season_number="${2:-1}"
    local season_subtitle="$3"

    if [ -n "$anime_name" ]; then
        local path="G:/$anime_name"

        if [ ! -d "$path" ]; then
            mkdir -p "$path"
        fi

        path="$path/S$season_number"

        if [ -n "$season_subtitle" ]; then
            path="$path - $season_subtitle"
        fi

        if [ ! -d "$path" ]; then
            mkdir -p "$path"
        fi

        open "$path"

        if [ -d "$path" ]; then
            cp "G:/temp/playnext.cmd" "$path/playnext.cmd"
            [ -f "$path/playnext.cmd" ]
        fi
    fi
}



[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

_evalcache direnv hook zsh
source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

autoload -Uz compinit

case $SYSTEM in
  Darwin)
    if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
      compinit;
    else
      compinit -C;
    fi
    ;;
  Linux)
    if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
      compinit;
    else
      compinit -C;
    fi;
    # not yet match GNU & BSD stat
  ;;
esac

eval $(thefuck --alias)
