local bot = ...
local fc = {
	category = "Chat",
	description = "Store your friend codes!",
	
	users = {
	},
	
	consoles = {
		["3DS"] = {
			pattern = "%d%d%d%d%-%d%d%d%d%-%d%d%d%d"
		},
		["NNID"] = {
			pattern = "^[0-9a-zA-Z_]+$"
		},
		["SW"] = {
			pattern = "%d%d%d%d%-%d%d%d%d%-%d%d%d%d"
		},
	},
}

function fc:init()
	self:load()
end

function fc:command(args,message)
	if #message.content < 4 then
		message:reply("```\nFriend Code:\nGet friend code - !FC [username/mention]\nSet your friend code - !FC [console] [code/name]\nValid consoles: 3DS, NNID, SW```")
		return
	end
	local isconsole = false
	for k,console in pairs(self.consoles) do
		if string.lower(args[1]) == string.lower(k) then
			local user = self.users[message.author.id]
			local nargs = {unpack(args)}; table.remove(nargs,1)
			local code = table.concat(nargs," ")
			
			if #nargs == 0 or not code:find(console.pattern) then --Delete the code
				if user then user[k] = nil end
				message:reply(string.format("**FC:** Pattern was not found, clearing %s...",k))
				return
			end

			isconsole=true
			if not user then user={}; self.users[message.author.id]=user end
			
			user[k]=code
			message:reply(string.format("**FC:** %s code set for %s!",k,message.author.name))
			message:delete()
			self:save()
			
			break
		end
	end
	if args[1] == "status" and not args[2] then
		local msg = "```\nFriend Code:\n"
		local counts = {}
		for _,v in pairs(self.users) do
			for k,_ in pairs(v) do
				counts[k] = (counts[k] or 0) + 1
			end
		end
		for k,v in pairs(counts) do
			msg=msg..k..": "..tostring(v).." people\n"
		end
		message:reply(msg.."```")
	elseif not isconsole then--Get a users friend code!
		local searchstring = string.lower(table.concat(args," "))
		
		local founduser = false
		for k,user in pairs(message.guild.members) do
			if string.lower(user.name):find(searchstring) or searchstring:find(user.id) then
				founduser = user
			end
		end
		if founduser then
			if not self.users[founduser.id] then message:reply("**FC:** "..founduser.name.." does not have friend codes!");return end
			local entry = self.users[founduser.id]
			local msg = string.format("```\n%s\n",founduser.name)
			for k,v in pairs(entry) do
				msg=msg..k..": "..v.."\n"
			end
			message:reply(msg.."```")
		else
			message:reply("**FC:** The user could not be found in the database.")
		end
	end
end


function fc:load()
	local file = io.open(bot.path.."data/friendcodes", "r")
	if file then
		local data = file:read("*a")
		file:close()
		self.users = bot.LON.decode(data)
	end
end

function fc:save()
	local file = io.open(bot.path.."data/friendcodes", "w")
	file:write(bot.LON.encode(self.users))
	file:close()
end

return fc