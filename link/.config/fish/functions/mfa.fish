# Defined in /var/folders/0y/pcc55wz96nv3t7kr_s4n8n5w0000gn/T//fish.ez2Zl1/mfa.fish @ line 2
function mfa
	ykman oath code $argv | tail -c 7 | pbcopy
end
