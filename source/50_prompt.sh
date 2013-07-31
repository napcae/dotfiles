#Hostcolors

lion='\[\e[0;36m\]'         #macbook air, cyan
corny='\[\e[0;32m\]'        #pi, green
bounty='\[\e[0;35m\]'       #macbook, purple
duplo='\[\e[0;33m\]'        #ams1 digital ocean server, yellow
default='\[\e[1;31m\]'      #orange 

wonderbar='\[\e[0;37m\]'    #iphone  
kitkat='\[\e[0;37m\]'       #kindle
#list of possible future hostnames
hostn=`hostname -s`

case $hostn in
lion)
    hostncolor=$lion
    ;;
corny)
    hostncolor=$corny
    ;;
bounty)
    hostncolor=$bounty
    ;;
duplo)
    hostncolor=$duplo
    ;;
*) 
    hostncolor=$default
    echo "color not defined"
esac
#debugging
#echo $hostn
#echo $hostncolor


#PS1 'hostmachine:~ username$ '
if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
    PS1="\[\e[1;31m\]\h\[\e[0;38m\]:\[\e[0;32m\]\w \[\e[0;36m\]\u\[\e[0;37m\]\$ \[\033[0m\]"
else # normal
    PS1="$hostncolor\h\[\e[0;38m\]:\[\e[0;32m\]\w \[\e[0;36m\]\u\[\e[0;37m\]\$ \[\033[0m\]"
fi

