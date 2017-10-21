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
			local user = bot.client:getUser(args[2]:sub(3,-2))
			
			self.requests[message.user] = {
				rounds = tonumber(args[3]) or 3,
				vs = user,
				channel = message.channel
			}
			user:send(message.user.username.." challenges you to Rock Paper Scissors!\nDo you accept?")
			message:reply("<@"..message.user.id.."> challenged <@"..user.id.."> to Rock Paper Scissors!")
			
		end
	else
		
	end
end

function rps:message(message)
	if not message.member then
		if string.lower(message.content:sub(1,1)) == "y" then
			for k,v in pairs(self.requests) do
				if v.vs == message.user then
					v.channel:send("<@"..(v.vs.id).."> accepted! Match starting...")
					self.matches[k] = v
					self.requests[k] = nil
					break
				end
			end
			
		elseif string.lower(message.content:sub(1,1)) == "n" then
			for k,v in pairs(self.requests) do
				if v.vs == message.user then
					v.channel:send("<@"..(v.vs.id).."> declined!")
					self.requests[k] = nil
					break
				end
			end
			
		end
		
		if string.lower(message.content:sub(1,1)) == "r" then self:submit(messge.user,"r")
		elseif string.lower(message.content:sub(1,1)) == "p" then self:submit(messge.user,"p")
		elseif string.lower(message.content:sub(1,1)) == "s" then self:submit(messge.user,"s")
		end
		
	end
end

function rps:wait(k)
	local match = self.matches[k]
	match.choicec = false
	match.choiced = false
	match.round = (match.round or 0)+1

	local msg = "Round "..match.round.."!\nEnter your choice! (R)ock/(P)aper/(S)cissors)"
	k:send(msg)
	match.vs:send(msg)
end

function rps:submit(user,hand)
	local match = self:userinmatch(message.user)
	if match then
		if match.vs == message.user then
			match.choiced = hand
		else
			match.choicec = hand
		end
		user:send("Setting to "..self:geticon(hand))
		
		if match.choiced and match.choicec then
			local winner
		end
	end
end

function rps:userinmatch(user)
	for k,v in pairs(self.matches) do
		if k == user or v.vs == user then return v end
	end
end
function rps:userinrequest(user)
	for k,v in pairs(self.requests) do
		if k == user or v.vs == user then return v end
	end
end

function rps:geticon(hand)
	if hand == "r" then return "rock"
	elseif hand == "p" then return "paper"
	elseif hand == "s" then return "scissors"
	end
end

return rps