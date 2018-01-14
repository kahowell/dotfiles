# ~/.bashrc
for file in ~/.bashrc.d/*; do
  if [ -x "$file" ]; then
    . $file
  fi
done

EDITOR=/usr/bin/vim
PATH="~/.local/bin:~/bin:$PATH"
