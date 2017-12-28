--[[
TO-DO:

!status other people.
Hero removal.
Hero renaming.


--[=[
Inventory Items:

Armor (Suits) - Passive effects like abilties, also affects hero's typing.
Moves (Techniques) - Like pokemon moves, they vary in power, typing and effects.
Items - Like pokemon items, they can be used once or provide a passive effect throughout.
]=]

]]

local function randomset(N,S,L) --Returns a random set of (N) numbers that always add to the sum of (S), optionally each number can be capped by (L)
	local n = {}
	for i=1,N-1 do n[i]=math.random(0,S) end
	
	table.insert(n,0)
	table.insert(n,S)
	table.sort(n)
	
	local d = {}
	for i=1,N do d[i]=(n[i+1]-n[i]) end
	
	if L then --If there is a limit on how big each number can be.
		local o = 0
		for i=1,N do --Check which number is above the limit and add it to the counter.
			if d[i] > L then
				o=o+(d[i]-L)
				d[i] = L
			end
		end
		while o > 0 do --Then randomly distribute to each number, this can balance it all out.
			local r = math.random(1,N)
			if d[r] < L then
				d[r]=d[r]+1
				o=o-1
			end
		end
	end
	
	return unpack(d)
end

local bot = ...
local rpg = {
	category = "Game",
	description = "",
	
	names = {}, --Global name table, checks for names of heroes.
	players = {},

}


function rpg:init()
end

function rpg:update()
end

function rpg:command(args,message)
	--Hero management
	if args[1] == "new" then
		if not self:getPlayer(message.author.id) then self:newPlayer(message.author.id) end
		local player = self:getPlayer(message.author.id)
		if #player.heroes < player.herolimit then
			local namet = {unpack(args)}; table.remove(namet,1)
			local name = table.concat(namet," ")
			
			if not name or name == "" then message:reply("**RPG** - No name given.") return end
			if not name:find("[a-zA-Z]") then message:reply("**RPG** - Letters are required in a name.") return end
			
			local hero = rpg:newHero(name)
			if not hero then message:reply(string.format("**RPG** - Name \"%s\" is already taken.",name)) return end
			
			table.insert(player.heroes, hero)
			message:reply(string.format("**RPG** - New hero \"%s\" created!",name))
		else
			message:reply("**RPG** - You have reached your hero limit!")
		end
	end
	if args[1] == "status" then
		local user = message.author
		do
			local namet = {unpack(args)}; table.remove(namet,1)
			local name = table.concat(namet," ")
			if message.guild then
				for k,v in pairs(message.guild.members) do
					if string.lower(name) == string.lower(v.name) then
						user = v
					end
				end
			end
		end
		for k,v in pairs(message.mentionedUsers) do user = v end
		
		local msg = "```"
		msg=msg..string.format("Player: %s\n",user.name)
		msg=msg.."----------------\n"
		local player = self:getPlayer(user.id)
		if player then
			for i,v in ipairs(player.heroes) do
				msg=msg..string.format("%d. %s - Level: %d\n",i,self.names[v.name],v.level)
			end
			if #player.heroes == 0 then msg=msg.."No Heroes!" end
		else
			msg=msg.."Not a player!"
		end
		message:reply(msg.."```")
	end
	
end

function rpg:getPlayer(id) return self.players[id] end
function rpg:newPlayer(id)
	self.players[id] = {
		herolimit = 1,
		heroes = {
		},
		inventory = {
		},
	}
end

function rpg:newHero(name)
	self.names[#self.names+1] = name
	return {
		name = #self.names,
		exp = 0,
		level = 1,
		ivs = {randomset(6,120,32)},
		renames = {
		},
		loadout = {
			armor = {0,0}, --First slot determines first type and ability. Second only determines second type.
			moves = {0,0,0,0}, --Moves can only be used if they are matching the armor types. However, any move in last slot can always be used.
			item = 0,
		},
	}
end

return rpg