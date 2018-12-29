# Defined in /var/folders/0y/pcc55wz96nv3t7kr_s4n8n5w0000gn/T//fish.fnzqmE/connect_docker_twix.fish @ line 2
function connect_docker_twix
	ssh -fNL 2375:localhost:2376 -T napcae@twix
export DOCKER_HOST=tcp://127.0.0.1:2375
end
