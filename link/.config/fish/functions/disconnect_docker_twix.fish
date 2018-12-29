function disconnect_docker_twix
	pkill -f "2375"
set --erase DOCKER_HOST
end
