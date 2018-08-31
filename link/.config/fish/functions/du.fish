# Defined in - @ line 0
function du --description 'alias du=ncdu --color dark -rr -x --exclude .git --exclude node_modules'
	ncdu --color dark -rr -x --exclude .git --exclude node_modules $argv;
end
