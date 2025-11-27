set -gx KUBECONFIG "$HOME/.kube/config"
for cfg in $HOME/.kube/config.d/**/*.yaml
  set -gx KUBECONFIG "$KUBECONFIG:$cfg"
end
