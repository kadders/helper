# BASH Aliases
alias test-token="AWS_PROFILE=test aws-iam-authenticator -i test-kubernetes1 token | jq '.status.token'"
alias dev-token="AWS_PROFILE=dev aws-iam-authenticator -i dev-kubernetes1 token | jq '.status.token'"
alias stage-token="AWS_PROFILE=dev aws-iam-authenticator -i stage-kubernetes1 token | jq '.status.token'"
alias prod-token="AWS_PROFILE=prod aws-iam-authenticator -i prod-kubernetes1 token | jq '.status.token'"
alias ktest="kubectl config use-context test-kubernetes1"
alias kdev="kubectl config use-context dev-kubernetes1"
alias kstage="kubectl config use-context stage-kubernetes1"
alias kprod="kubectl config use-context prod-kubernetes1"
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