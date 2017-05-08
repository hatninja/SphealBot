local bit = {}

function bit:command(args,message)
	message:reply(math.random(1,2) == 1 and "Yes." or "No.")
end

return bit