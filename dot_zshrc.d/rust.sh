if [ -f $HOME/.cargo/env ]; then
  . "$HOME/.cargo/env"
fi
export PATH=$PATH:$HOME/.cargo/bin
