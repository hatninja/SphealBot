local rps = {
	category = "Game",
	description = "*WIP* Play rock paper scissors with someone!",
	
	matches = {},
	requests = {},
}

local bot = ...

function rps:update()
end

function rps:command(args,message)
	if args[1] == "challenge" then
		if args[2] and args[2]:sub(1,2) == "<@" and args[2]:sub(-1,-1) == ">" then
			local id = args[2]:sub(3,-2)
			requests[message.user.id] = {rounds = tonumber(args[3]) or 3}
		end
	else
		
	end
end

function rps:message(message)
end

return rps