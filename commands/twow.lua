local bot = ...
local twow = {
	category = "Game",
	description = "Ten Words of Wisdom (Look it up!)",
	
	channel=false,
	
	prompts={
		
	},
}

function twow:init()
	self:load()
end

function twow:command(args,message)
	if message.member then
		if args[1] == "here" then
			if message.member then
				for role in message.member.roles do
					if role.name == "Bot Manager" then
						self.channel = message.channel
						self:save()
						message:reply("**Daily Lottery** is now set up in "..self.channel.mentionString.."!")
						break
					end
				end
			end
		end
	else --Private channel!
		if args[1] == "join" then
			
		end
	end
end

function twow:save()
	local file = io.open(bot.path.."data/twowlocation", "w")
	file:write(self.channel.id)
	file:close()
end

function twow:load()
	local file = io.open(bot.path.."data/twowlocation", "r")
	if file then
		self.channel = bot.client:getChannel(file:read())
		file:close()
	end
end

return twow