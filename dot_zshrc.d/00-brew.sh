# Set PATH, MANPATH, etc., for Homebrew.
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew && $PATH != *".linuxbrew"* ]]; then
    OLDPATH=$PATH
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # NOTE: unlike "idiomatic brew" I prefer system binaries when possible
    export PATH=$OLDPATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin
fi
