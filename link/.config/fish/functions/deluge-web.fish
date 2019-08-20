# Defined in /var/folders/j_/8cpj3cg1575_6lkj8tqpwzlc0000gn/T//fish.pWGAPG/deluge-web.fish @ line 2
function deluge-web
	ssh -fNL 8112:localhost:8112 -T milka && chrome --args --profile-directory="Profile 1" http://localhost:8112
end
