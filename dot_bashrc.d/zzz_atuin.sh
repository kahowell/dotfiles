if [ -f $HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh ]; then
  source $HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh
  eval "$($HOMEBREW_PREFIX/bin/atuin init bash --disable-up-arrow)"
fi
