# Defined in /var/folders/0y/pcc55wz96nv3t7kr_s4n8n5w0000gn/T//fish.hCiBMD/mp3d.fish @ line 2
function mp3d
	if contains youtube $argv; 
		youtube-dl -f bestaudio[ext=m4a] --embed-thumbnail --add-metadata "$argv"
	else
		youtube-dl --embed-thumbnail --add-metadata "$argv"
	end
end
