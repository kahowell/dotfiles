# ~/.bashrc
for file in ~/.bashrc.d/*; do
  if [ -x "$file" ]; then
    . $file
  fi
done

EDITOR=/usr/bin/vim
PATH="~/bin:$PATH:~/.local/bin"
