# BASH Aliases
alias kget="kubectl get"
alias kgetall="kubectl get all"
alias kexec="kubectl exec -it"
alias kdescribe="kubectl describe"
alias kedit="kubectl edit"

# Set up kube-ps1
if [[ -f /usr/local/add-ons/kube-ps1/kube-ps1.sh ]]
then
	source /usr/local/add-ons/kube-ps1/kube-ps1.sh
fi
if [[ -f /usr/local/add-ons/git-prompt.sh ]]
then
	source /usr/local/add-ons/git-prompt.sh
fi
PS1='[\u@\h \W ]\n$(__git_ps1) $(kube_ps1) \$ '
