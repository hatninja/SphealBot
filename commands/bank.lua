--[[Bank - Implements a currency system and API functions.

]]
local bank = {
	nextsave = os.time()+60,
	changed = true,
	
	accounts = {}
}

local bot = false
function bank:init(b) --Load from memory!
	bot = b
	
	self:load()
end

function bank:update()
	if self.changed and os.time() > self.nextsave then
		self:save()
	end
end

function bank:receive(mode,user,amount) --API functions
	if mode == "give" then
		return self:givePoints(user,amount)
	elseif mode == "take" then
		return self:takePoints(user,amount)
	elseif mode == "balance" then
		return self:getAccount(user)
	end
end

function bank:command(args,message)
	if args[1] ~= "help" then
		if args[1] == "register" then
			if self:getAccount(message.author.id) then
				message.channel:sendMessage("<@"..message.author.id.."> You already have an account!")
			else
				self:newAccount(message.author.id,100)
				message.channel:sendMessage("<@"..message.author.id.."> New account created! You have been given a starting boost of 100P!")
			end
		elseif args[1] == "balance" then
			if self:getAccount(message.author.id) then
				message.channel:sendMessage("`"..message.author.username.." has "..self:getAccount(message.author.id).."P`")
			else
				message.channel:sendMessage("<@"..message.author.id.."> You don't have an account. Please register using \"!bank register\"!")
			end
		elseif args[1] == "transfer" then
			if self:getAccount(message.author.id) then
				if os.time() > self.accounts[message.author.id][2] then
					if args[2] and args[2]:sub(1,2) == "<@" and args[2]:sub(-1,-1) == ">" then
						local id = args[2]:sub(3,-2)
						if args[2]:sub(1,3) == "<@!" then
							id = args[2]:sub(4,-2)
						end
						if self:getAccount(id) then
							if id ~= message.author.id then
								if args[3] and tonumber(args[3]) and tonumber(args[3]) > 0 then
									local amount = tonumber(args[3])
									if self:getAccount(message.author.id)-amount >= 0 then
									
										self:takePoints(message.author.id, amount)
										self:givePoints(id, amount)
										
										self.accounts[message.author.id][2] = os.time()+30
										
										message.channel:sendMessage(message.author.username.." transferred "..amount.."P!")
									else
										message.channel:sendMessage("<@"..message.author.id.."> You do not have enough points!")
									end
								else
									message.channel:sendMessage("<@"..message.author.id.."> Please put in your amount!")
								end
							end
						else
							message.channel:sendMessage("<@"..message.author.id.."> That user does not have an account!")
						end
					else
						message.channel:sendMessage("<@"..message.author.id.."> Please specify a receipient!")
					end
				else
					message.channel:sendMessage("<@"..message.author.id.."> Please wait a bit before you transfer again.")
				end
			else
				message.channel:sendMessage("<@"..message.author.id.."> You don't have an account. Please register using \"_bank register\"!")
			end
		end
	else
		message.channel:sendMessage("```!bank register - Makes a new bank account.\n!bank balance - Check your balance.\n!bank transfer [@receipient] [amount] - Transfer your points to another user.```")
	end
end

function bank:newAccount(id,amount)
	self.accounts[id] = {tonumber(amount) or 100,0}
	self:awake()
end

function bank:getAccount(id)
	return self.accounts[id] and self.accounts[id][1]
end

function bank:givePoints(id, amount)
	if self.accounts[id] then
		self:awake()
		self.accounts[id][1] = self.accounts[id][1] + math.floor(math.abs(amount))
		return true
	end

end

function bank:takePoints(id, amount)
	if self.accounts[id] then
		self:awake()
		self.accounts[id][1] = self.accounts[id][1] - math.floor(math.abs(amount))
		return true
	end
end

function bank:save()
	local file = io.open(bot.path.."data/accounts", "w")
	for id,data in pairs(self.accounts) do
		file:write(id..":"..data[1].."\n")
	end
	file:close()
	
	self:sleep()
	print("Bank saved!")
end

function bank:load()
	local file = io.open(bot.path.."data/accounts", "r")
	if file then
		for line in file:lines() do
			local data = string.split(line,":")
			self:newAccount(data[1], data[2])
		end
		file:close()
	end
end

function bank:awake()
	bank.nextsave = os.time()+60
	bank.changed = true
end

function bank:sleep()
	bank.changed = false
end

return bank