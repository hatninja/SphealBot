local rps = {
	category = "Game",
	description = "*WIP* Play rock paper scissors with someone!",
	
	matches = {},
	requests = {},
}


local bot = false
function rps:init(b)
	bot = b
end

function rps:update()
end

function rps:command(args,message)
	if args[1] == "challenge" then
		if args[2] and args[2]:sub(1,2) == "<@" and args[2]:sub(-1,-1) == ">" then
			local id = args[2]:sub(3,-2)
			
		end
	else
		
	end
end

function rps:message(message)
end

return rps