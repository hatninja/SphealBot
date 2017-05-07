--TO-DO: Change to hash table instead of array. I imagine it must take a ton of memory space the current way.
local bank = {
	nextsave = os.time()+60,
	changed = true
}

local accounts = {}

function bank:init() --Load from memory!
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
				if os.time() > accounts[message.author.id][2] then
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
										
										accounts[message.author.id][2] = os.time()+30
										
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
	accounts[id] = {tonumber(amount) or 100,0}
	self:awake()
end

function bank:getAccount(id)
	return accounts[id] and accounts[id][1]
end

function bank:givePoints(id, amount)
	if accounts[id] then
		self:awake()
		accounts[id][1] = accounts[id][1] + math.floor(math.abs(amount))
		return true
	end

end

function bank:takePoints(id, amount)
	if accounts[id] then
		self:awake()
		accounts[id][1] = accounts[id][1] - math.floor(math.abs(amount))
		return true
	end
end

function bank:save()
	local file = io.open("data/accounts", "w")
	for id,data in ipairs(accounts) do
		file:write(id..":"..data[1].."\n")
	end
	file:close()
	
	self:sleep()
	print("Bank saved!")
end

function bank:load()
	for line in io.lines("data/accounts") do
		local data = string.split(line,":")
		self:newAccount(data[1], data[2])
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