# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

for file in ~/.bashrc.d/*; do
  if [ -x "$file" ]; then
    . $file
  fi
done

EDITOR=/usr/bin/vim
PATH="~/.local/bin:~/bin:$PATH"
