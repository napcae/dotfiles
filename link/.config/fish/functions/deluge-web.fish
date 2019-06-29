# Defined in /var/folders/0y/pcc55wz96nv3t7kr_s4n8n5w0000gn/T//fish.zoIhD2/deluge-web.fish @ line 2
function deluge-web
	ssh -fNL 8112:localhost:8112 -T napcae@twix && chrome --args --profile-directory="Profile 1" http://localhost:8112
end
