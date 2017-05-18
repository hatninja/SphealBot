--Daily lottery function!
local lotteryratio = 1/3
local lottery = {
	category = "System",
	description = "The daily lottery, share your coins!",
	
	channel = false,
	
	entrants = {},
	jackpot = 0,
	date = math.floor(os.time()/60/60/24)
}

local bot = ...
function lottery:init()
	self:reset()
	self:load()
end

function lottery:update()
	if self.date ~= math.floor(os.time()/60/60/24) then --It's a new day!
		self:reset() --Give the prize to the winner and start again.
		self.date = math.floor(os.time()/60/60/24)
	end
end

function lottery:command(args,message)
	if message.channel == self.channel then
		if args[1] == "enter" then
			if not args[2] or tonumber(args[2]) and tonumber(args[2]) >= 10 then
				local amount = (tonumber(args[2]) or 10)
				if not self.entrants[message.author] then 
					local balance = bot.send("bank","balance",message.author.id)
					if balance then
						if balance >= (tonumber(args[2]) or 10) then
							bot.send("bank","take",message.author.id,amount)
							self.entrants[message.author] = table.count(self.entrants)+1
							self.jackpot = self.jackpot + amount
							
							message:reply("**Daily Lottery:** <@"..message.author.id.."> entered with `"..amount.."P`\nThe jackpot is now `"..math.floor(self.jackpot).."P`")
							message:delete()
						else
							message:reply("**Daily Lottery:** <@"..message.author.id.."> You don't have enough points!")
							message:delete()
						end
					else
						message:reply("**Daily Lottery:** <@"..message.author.id.."> You need a bank account!")
						message:delete()
					end
				else
					message:reply("**Daily Lottery:** <@"..message.author.id.."> You've already entered!")
					message:delete()
				end
			else
				message:reply("**Daily Lottery:** <@"..message.author.id.."> Invalid number! The minimum is 10P")
				message:delete()
			end
		elseif args[1] == "status" then
			message:reply(string.format("**Daily Lottery** Win ratio: %d/%d\nThe jackpot total is `%dP`\nMinutes Left: %.1f", math.ceil(table.count(self.entrants) * lotteryratio), table.count(self.entrants), math.floor(self.jackpot), ((math.floor(os.time()/60/60/24)+1)*24*60)-os.time()/60))
		elseif args[1] == "reset" then
			if message.member then
				for role in message.member.roles do
					if role.name == "Bot Manager" then
						self:reset()
						break
					end
				end
			end
		else
			message:reply("**Daily Lottery** enter daily lotterys using `!lottery enter (optional amount)`!\nYou can check the status using `!lottery status`")
		end
	end
		
	--Mod commands
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
end

function lottery:reset()
	local randomtable = {}
	for i=1,table.count(self.entrants) do randomtable[i] = i end
	
	local winners = math.ceil(#randomtable * lotteryratio)
	local picks = 0
	while picks < winners do
		local random = math.random(1,#randomtable)
		for user,count in pairs(self.entrants) do
			if randomtable[random] == count then
				bot.send("bank","give",user.id,self.jackpot/winners)
				self.channel:sendMessage("**Daily Lottery:** <@"..user.id.."> won the Jackpot! `+"..math.floor(self.jackpot/winners).."P`")
			end
		end
		table.remove(randomtable,random)
		picks = picks + 1
	end
	
	
	if self.channel then
		self.channel:sendMessage("**Daily Lottery:** A new daily lottery is now running, feel free to enter!")
	end
	
	self.entrants = {}
	self.jackpot = 0
end

function lottery:save()
	local file = io.open(bot.path.."data/lotterylocation", "w") --For some reason, this crashes!
	file:write(self.channel.id)
	file:close()
end

function lottery:load()
	local file = io.open(bot.path.."data/lotterylocation", "r")
	if file then
		self.channel = bot.client:getChannel(file:read())
		file:close()
	end
end

return lottery