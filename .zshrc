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
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export SCRIPTS=${HOME}/scripts
export ZSHCONFIG=${ZDOTDIR:-$HOME}/.zsh-config

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

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
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
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
  # git-extras
  # gitfast
  gitignore
  wd
  python
  rust
  # ubuntu
  zsh-completions
  # zsh-syntax-highlighting
  evalcache
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

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
# export ARCHFLAGS="-arch x86_64"
# export MAKEFLAGS="--jobs=$(nproc)"
# export CC="/usr/bin/clang"
# export CXX="/usr/bin/clang++"
# export LDFLAGS="-fuse-ld=lld"

# SSH
# Do not export SSH_AUTH_SOCK as SSH-AGENT is supposedly automatically started nowadays
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# export SSH_AUTH_SOCK="C:\Temp\cyglockfile"
# [ -n ${WSL_AUTH_SOCK} ] && export SSH_AUTH_SOCK=${WSL_AUTH_SOCK}
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# WSL
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# ss -a | grep -q $SSH_AUTH_SOCK
# if [ $? -ne 0   ]; then
#     rm -f $SSH_AUTH_SOCK
#     ( setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"/mnt/c/WSL_SSH/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
# fi
# function ssa() {
#   if [[ -z ${SSH_AGENT_PID} ]]; then
#     eval $(ssh-agent -t 20000)
#     ssh-add
#   fi
# }

# function unssa() {
#   if [[ -n ${SSH_AGENT_PID} ]]; then
#     ssh-agent -k
#     unset SSH_AGENT_PID
#   fi
# }

# SSH_ENV="$HOME/.ssh/agent-environment"

# function start_agent {
#     echo "Initialising new SSH agent..."
#     /usr/bin/ssh-agent | sed 's/^echo/#echo/' >"$SSH_ENV"
#     echo succeeded
#     chmod 600 "$SSH_ENV"
#     . "$SSH_ENV" >/dev/null
#     /usr/bin/ssh-add; 
# }

# # Source SSH settings, if applicable

# if [ -f "$SSH_ENV" ]; then
#     . "$SSH_ENV" >/dev/null
#     #ps $SSH_AGENT_PID doesn't work under Cygwin
#     ps -ef | grep $SSH_AGENT_PID | grep ssh-agent$ >/dev/null || {
#         start_agent
#     } 
# else
#     start_agent 
# fi 

# gpg
# eval $(gpg-agent --daemon)
# GPG-AGENT stuff
# GET_TTY=$(tty)
# export $GET_TTY
# $HOME/.gnupg/gpg-agent-start.sh
# setopt HIST_IGNORE_SPACE
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
alias ve="python3 -m venv --upgrade-deps ./venv"
alias va="source ./venv/bin/activate"
alias cpv="rsync -ah --info=progress2"
alias tcn="mv --force -t ~/.local/share/Trash"
alias foliate="com.github.johnfactotum.Foliate &" # Assumes foliate is installed via snap store or similar
alias cwd="echo 'Correct way to print current working directory is PWD.' && pwd"
alias open="xdg-open"
alias unzipJp="unzip -O shift-jis $1"
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


####################
## USER FUNCTIONS ##
####################
function hakuneko() {
  local currentDir=$(pwd)
  cd "$HOME/git/hakuneko" || return 1
  git fetch --all || return 1
  git rebase origin/master || return 1
  git push --force || return 1

  # npm run build

  npm run start &

  cd $currentDir
}

function haruneko() {
  local currentDir=$(pwd)
  cd "$HOME/git/haruneko" || return 1
  # git fetch --all || return 1
  # git rebase origin/master || return 1
  # git push --force || return 1
  git pull || return 1

  local useDev=false
  local useNW=false
  for arg in "$@"
  do
    if [[ "$arg" == "--useDev" ]]; then
      useDev=true
    elif [[ "$arg" == "--useNW" ]]; then
      useNW=true
    fi
  done

  local buildOption="prod"
  local port=5000

  if [ "$useDev" = true ]; then
    buildOption="dev"
    port=3000
  fi

  local vite='node "$HOME/git/haruneko/node_modules/vite/bin/vite.js"'
  local electron='node "$HOME/git/haruneko/app/electron/build/main.js"'

  # Start the first Node.js application in a new zsh window
  cd "$HOME/git/haruneko/web" || return
  # npm run build
  # zsh -c "$vite preview --port=$port --strictPort"
  zsh -c "npm run serve:$buildOption" &

  local app="electron"
  if [ "$useNW" = true ]; then
    app="nw"
  fi
  # Start the second Node.js application in another new zsh window
  cd "$HOME/git/haruneko/app/$app" || return
  # npm run build
  # zsh -c "$electron ./build --origin=http://localhost:$port"
  zsh -c "npm run launch:$buildOption" &
  # npm run build

  # npm run start &

  cd $currentDir
}


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

# Convert EPUB to PDF
function convert_epub_to_pdf() {
    local file="$1"
    local ebook_convert_path="ebook-convert"
    local base_name=$(basename "$file" .epub)
    local pdf_file="${base_name}.pdf"

    if [ ! -f "$pdf_file" ]; then
        echo "Converting '$file' to PDF..."
        "$ebook_convert_path" "$file" "$pdf_file"
    else
        echo "PDF already exists. Extracting from $pdf_file"
    fi
}

# Extract images from PDF
function extract_images_from_pdf() {
    local pdf_file="$1"
    local pdf_images_path="pdfimages"
    local base_name=$(basename "$pdf_file" .pdf)

    if [ -f "$pdf_file" ]; then
        echo "Extracting images from '$pdf_file'..."
        mkdir -p "tmp"
        "$pdf_images_path" -j -png -p -print-filenames "$pdf_file" "./tmp/"
        mv "./tmp/" "$base_name"
    else
        echo "Failed to convert EPUB to PDF: $pdf_file"
    fi
}

# Prepend parent directory name to files
function prepend_parent_directory_name_to_files() {
    local output_dir="$1"
    if [ -z "$output_dir" ]; then
        output_dir=$(pwd)
    fi
    
    if [ -d "$output_dir" ]; then
        find "$output_dir" -type f | while read -r file; do
            local parent_folder=$(basename "$(dirname "$file")")
            local new_name="${parent_folder}$(basename "$file")"
    local new_path="$(dirname "$file")/$new_name"

            echo "New path/name is $new_path"
            # Uncomment the following line to actually rename the files
            # mv "$file" "$new_path"
        done
    else
        echo "Failed to process files in directory: $output_dir"
    fi
}

# Extract EPUB images
function extract_epub_images() {
    local epub_files=("$@")
    local ebook_convert_path="ebook-convert"
    local pdf_images_path="pdfimages"

    if ! command -v "$ebook_convert_path" &> /dev/null; then
        echo "ebook-convert is not in the system PATH. Please ensure Calibre is installed and the path is set."
        return
    fi

    if ! command -v "$pdf_images_path" &> /dev/null; then
        echo "pdfimages is not in the system PATH. Please ensure Poppler Utils is installed and the path is set."
        return
    fi

    # If no EPUB files are passed, find all EPUB files in the current directory
    if [ ${#epub_files[@]} -eq 0 ]; then
        epub_files=($(find . -type f -iname "*.epub"))
    fi

    echo "Found ${#epub_files[@]} EPUB files."

    for file in "${epub_files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "File not found: $file"
            continue
        fi

        local base_name=$(basename "$file" .epub)
        local pdf_file="${base_name}.pdf"
        local output_dir="$(pwd)/$base_name"

        convert_epub_to_pdf "$file"
        extract_images_from_pdf "$pdf_file"
        prepend_parent_directory_name_to_files "$output_dir"
    done
}

# Render resume (markdown to PDF and then convert to PNG)
function render_resume() {
    local resume_md="work/résumé.md"
    local resume_pdf="work/résumé.pdf"
    local resume_png="work/résumé.png"
    local pandoc_path="pandoc"
    local texlive_path="xelatex.exe"
    local magick_path="magick"

    echo "Rendering Markdown to PDF..."
    "$pandoc_path" --from=markdown "$resume_md" --pdf-engine="$texlive_path" --to=pdf -o "$resume_pdf"
    echo "Completed."

    echo "Rendering PDF to PNG..."
    "$magick_path" -density 300 "$resume_pdf" -quality 100 -alpha remove "$resume_png"
    echo "Completed."
}

# Example of how to use the functions
# Uncomment the function calls below to use them

# convert_epub_to_pdf "your_epub_file.epub"
# extract_images_from_pdf "your_pdf_file.pdf"
# prepend_parent_directory_name_to_files "/path/to/your/output/directory"
# extract_epub_images "file1.epub" "file2.epub"
# render_resume


function rebuild_python_packages() {
  # Find all directories in /usr/lib/ that contain "python" in their name, without recursion
  directories=($(find /usr/lib/ -maxdepth 1 -type d -name "python*" | sort))

  # Get the latest directory by sorting them in reverse order and picking the first
  latest_dir="${directories[-1]}"

  # Loop through all directories except the latest one
  for dir in "${directories[@]}"; do
    # Skip the latest directory
    if [[ "$dir" == "$latest_dir" ]]; then
      continue
    fi

    # Run pacman and paru commands for each directory
    pacman -Qoq "$dir" | paru -S --rebuild -
  done
}

function clean_paru_packages() {
  sudo paccache -rk1
  paru -Sc
}

function list_aur_packages() {
  paru -Qm
}

revert_gcc() {
  # Set the default linker to 'lld'
  local linker="lld"
  
  # Check if the first argument is a linker (ld, lld, or mold)
  if [[ "$1" == "ld" || "$1" == "lld" || "$1" == "mold" ]]; then
      linker="$1"
      shift  # Remove the linker argument from the list of arguments
  fi

  # Define custom flags
  local custom_cc="gcc"
  local custom_cxx="g++"
  
  # Set the linker flag
  local linker_flag="-fuse-ld=$linker"

  # Run the specified command with the custom flags and selected linker
  CC="$custom_cc" CXX="$custom_cxx" LDFLAGS="$linker_flag" "$@"
}

try_build() {
    local command_status

    # Run the command with the default environment
    "$@"
    command_status=$?

    if [ $command_status -ne 0 ]; then
        echo "Initial build failed. Retrying with fallback environment: CC=gcc, CXX=g++, LD=ld..."
        CC=gcc CXX=g++ LD=ld LDFLAGS="-fuse-ld=ld" "$@"
        command_status=$?

        if [ $command_status -ne 0 ]; then
            echo "Fallback build also failed." >&2
        else
            echo "Fallback build succeeded."
        fi
    else
        echo "Build succeeded."
    fi

    return $status
}




[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx

# _evalcache direnv hook zsh
eval "$(direnv hook zsh)"

# source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

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

# eval $(thefuck --alias)
function fuck() {
eval $(thefuck --alias)
  unset -f fuck
  fuck "$@"
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
