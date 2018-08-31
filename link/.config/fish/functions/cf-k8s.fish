# Defined in - @ line 0
function cf-k8s --description 'alias cf-k8s=env KUBECONFIG=~/.kube/cf-authinfo.yaml:/.kube/cf-staging.yaml kubectl'
	env KUBECONFIG=~/.kube/cf-authinfo.yaml:/.kube/cf-staging.yaml kubectl $argv;
end
