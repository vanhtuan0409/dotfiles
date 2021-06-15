# K8s abbr
abbr -a k kubectl
abbr -a keti 'kubectl exec -ti'

abbr -a kgp 'kubectl get pods'
abbr -a kgpwide 'kubectl get pods -o wide'
abbr -a kdp 'kubectl describe pods'
abbr -a kdelp 'kubectl delete pods'

abbr -a kgs 'kubectl get svc'
abbr -a kgswide 'kubectl get svc -o wide'
abbr -a kds 'kubectl describe svc'
abbr -a kdels 'kubectl delete svc'

abbr -a kgd 'kubectl get deployment'
abbr -a kgdwide 'kubectl get deployment -o wide'
abbr -a kdd 'kubectl describe deployment'
abbr -a kdeld 'kubectl delete deployment'

abbr -a kgns 'kubectl get namespaces'
abbr -a kcn 'kubectl config set-context (kubectl config current-context) --namespace'

abbr -a kgcm 'kubectl get configmaps'
abbr -a kdcm 'kubectl describe configmap'

abbr -a kgsec 'kubectl get secret'
abbr -a kdsec 'kubectl describe secret'

abbr -a kl 'kubectl logs'
abbr -a kgno 'kubectl get nodes'
abbr -a kdno 'kubectl describe node'
