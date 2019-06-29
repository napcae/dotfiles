function chrome
	if count $argv > /dev/null
     /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $argv;
   else
     open /Applications/Google\ Chrome.app 
   end
end
