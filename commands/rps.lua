local rps = {
	matches = {},
	requests = {},
}


local bot = false
function rps:init(b)
	bot = b
	return "Game","Play rock paper scissors with someone!"
end

function rps:update()
end

function rps:command(args,message)
	if args[1] == "challenge" then
		
	else
	end
end

function rps:message(message)
end

return rps