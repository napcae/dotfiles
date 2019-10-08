# Defined in /var/folders/j_/8cpj3cg1575_6lkj8tqpwzlc0000gn/T//fish.77Y4oW/mp3d.fish @ line 2
function mp3d
	if string match -q "*youtube*" $argv; 
        echo "Downloading from youtube"
		youtube-dl -f bestaudio[ext=m4a] --embed-thumbnail --add-metadata "$argv"
	else
        echo "Downloading non-youtube"
		youtube-dl --embed-thumbnail --add-metadata "$argv"
	end
end
