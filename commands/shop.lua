local bot = ...

local shop = {
	category = "System",
	description = "Points Shop - Personalize with your points!",
	
	roles = {[0]={"",0},
	}, 
}

function shop:init()
	self:loadroles()
end

function shop:command(args,message)
	if message.member then
		if args[1] == "list" then
			if args[2] == "role" then
				local msg = "**Points Shop**\n```\nColored Roles (role):\n"
				for i,data in pairs(self.roles) do
					msg = msg .. i .. ": ".. (data[1] and data[1].name or "Removal").. " - " .. (data[2]).."P\n"
				end
				message:reply(msg.."```")
			end
			
		elseif args[1] == "buy" then
			if not args[2] then message:reply("**Points Shop** Please specify an item category.");return end
			if not args[3] then message:reply("**Points Shop** Please enter the id of the item you want.");return end
			
			if args[2] == "role" then
				local item = self.roles[tonumber(args[3])]
				if item then
					local balance = bot.send("bank","balance",message.author.id)
					if not balance then message:reply("**Points Shop** You don't have an account!");return end
					if balance <= item[2] then message:reply("**Points Shop** You don't have enough points!");return end
					
					for i,item in pairs(self.roles) do --Remove pre-existing roles.
						if i ~= 0 then
							if message.member:hasRole(item[1]) then
								message.member:removeRole(item[1])
							end
						end
					end
					
					if item[1] ~= "" then --Give role!
						if message.member:hasRole(item[1]) then message:reply("**Points Shop** <@"..message.author.id.."> You already have that role!");return end
						
						message.member:addRole(item[1])
					end
					
					if message.member:hasRole(item[1]) then
						bot.send("bank","take",message.author.id,item[2])
						message:reply("**Points Shop** <@"..message.author.id.."> applied "..(item[1] and item[1].name or "Removal").." for `"..item[2].."P`!")
					end
				else
					message:reply("**Points Shop** Invalid item!")
				end
			else
				message:reply("**Points Shop** Invalid item category!")
			end
		--Mod commands
		elseif args[1] == "addrole" then
			if message.member then
				for role in message.member.roles do
					if role.name == "Bot Manager" then
						
						local name = table.concat({args[2],args[3]}," ")
						for role in message.guild.roles do
							if role.name == name then
								self:addRoleItem(role,20)
								message:reply("**Points Shop** Added "..role.name.."!")
								break
							end
						end
						self:saveroles()
						
					end
				end
			end
		elseif args[1] == "removerole" then
			if message.member then
				for role in message.member.roles do
					if role.name == "Bot Manager" then
						
						for i=2,#args do
							local id = tonumber(args[i])
							if self.roles[id] then
								self.roles[id] = nil
							end
						end
						self:saveroles()
						
					end
				end
			end
		else
			message:reply("**Points Shop**\n```\n!shop list [store] - Shows all availible items in that store.\n!shop buy [store] [id] - Buy a specific item!\n\nStores:\nrole - Colored roles!\n```")
		end
	end
end

function shop:addRoleItem(role,cost)
	self.roles[#self.roles+1] = {role,tonumber(cost)}
end

function shop:checkRoles(server) --Deletes any roles that no longer exist.
	for id,item in pairs(self.roles) do
		local found = false
		for role in server:roles() do
			if id == role.id then
				found = true
				break
			end
		end
		if not found then
			shop:deleteRole(id)
		end
	end
end

function shop:saveroles()
	local file = io.open(bot.path.."data/shoproles", "w")
	for id,data in pairs(self.roles) do
		if id ~= 0 and data and #data > 1 then
			file:write((data[1].id)..":"..tostring(data[2]).."\n")
		end
	end
	file:close()

	print("Updated role items!")
end

function shop:loadroles()
	local file = io.open(bot.path.."data/shoproles", "r")
	if file then
		for line in file:lines() do
			local data = string.split(line,":")
			if #data > 1 then
				self:addRoleItem(bot.client:getRole(data[1]),tonumber(data[2]))
			end
		end
		file:close()
	end
end

return shop