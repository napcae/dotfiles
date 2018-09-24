function mfa
	ykman oath code $argv | tail -c 6 | pbcopy
end
