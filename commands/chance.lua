local chance = {}

function chance:command(args,message)
	message:reply(math.random(0, 100).."%")
end

return chance