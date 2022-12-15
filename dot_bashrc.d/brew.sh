# Set PATH, MANPATH, etc., for Homebrew.
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

COMPLETIONS="
argocd
brew
chezmoi-completion.bash
helm
k3d
k9s
kind
kube-linter
kubectl
minikube
oc
starship
stern
yq
"
for file in $COMPLETIONS; do
  if [ -f /home/linuxbrew/.linuxbrew/etc/bash_completion.d/$file ]; then
    source /home/linuxbrew/.linuxbrew/etc/bash_completion.d/$file
  fi
done
