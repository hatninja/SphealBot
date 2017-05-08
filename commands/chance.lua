--Random test program i did.
local chance = {}

function chance:init()
	return "Chat","Tells you chances."
end

function chance:command(args,message)
	message:reply(math.random(0, 100).."%")
end

return chance