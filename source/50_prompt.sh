#Hostcolors

lion='\[\e[0;36m\]'         #macbook air, cyan
corny='\[\e[0;32m\]'        #pi, green
bounty='\[\e[0;35m\]'       #macbook, purple
duplo='\[\e[0;33m\]'        #ams1 digital ocean server, yellow
butterfinger='\[\e[1;37m\]' #butterfinger, white
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
butterfinger)
    hostncolor=$butterfinger
    ;;
wonderbar)
    hostncolor=$wonderbar
    ;;
kitkat)
    hostncolor=$kitkat
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

##http://www.bergspot.com/blog/2012/02/how-to-fix-warning-setlocale-lc_ctype-cannot-change-locale-utf-8/
##manual locale set
export LANG="de_DE.UTF-8"
export LC_CTYPE="de_DE.UTF-8"
export LC_ALL="de_DE.UTF-8"
