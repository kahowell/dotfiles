if [ -f /home/linuxbrew/.linuxbrew/etc/profile.d/bash-preexec.sh ]; then
  source /home/linuxbrew/.linuxbrew/etc/profile.d/bash-preexec.sh
  eval "$(atuin init bash --disable-up-arrow)"
fi
