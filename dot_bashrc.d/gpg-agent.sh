# per https://www.gnupg.org/documentation/manuals/gnupg/Agent-Examples.html#Agent-Examples
export GPG_TTY=$(tty)
gpg-connect-agent /bye
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
