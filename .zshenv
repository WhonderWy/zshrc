#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

# https://blog.patshead.com/2011/04/improve-your-oh-my-zsh-startup-time-maybe.html
skip_global_compinit=1

# http://disq.us/p/f55b78
# setopt noglobalrcs

export SYSTEM=$(uname -s)

# You may need to manually set your language environment
export LANG=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8

export ARCHFLAGS="-arch x86_64"
export MAKEFLAGS="--jobs=$(nproc)"
export CC="/usr/bin/clang"
export CXX="/usr/bin/clang++"
# export CFLAGS="-O4"
export LDFLAGS="-fuse-ld=lld"

export CHROOT="$HOME/chroot"

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  # export EDITOR='nano'
  export EDITOR='nano'
else
  export EDITOR='code'
fi

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

source "$HOME/.cargo/env"
