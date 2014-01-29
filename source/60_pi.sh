[[ "$(cat /proc/version 2> /dev/null)" =~ arm ]] || return 1

#Raspberry Pi specific stuff
NODE_JS_HOME=$HOME/node-v0.10.2-linux-arm-pi 
PATH=$PATH:$NODE_JS_HOME/bin 
