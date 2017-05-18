--Random test program i did.
local chance = {
	category = "Chat",
	description = "Accurately tells you a chance",
}

function chance:command(args,message)
	message:reply(math.random(0, 100).."%")
end

return chance