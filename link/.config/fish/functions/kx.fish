# Defined in - @ line 1
function kx --description 'alias kx=kubectl config use-context (kubectl config get-contexts -oname | fzf)'
	kubectl config use-context (kubectl config get-contexts -oname | fzf) $argv;
end
