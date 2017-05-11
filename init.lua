local prefix = "!"
local path = debug.getinfo(1, "S").source:sub(2,-9)

local discordia = require('discordia')
local client = discordia.Client()

local timer = require('timer')
local sleep = timer.sleep

local format = string.format --TO-DO: Use this for fasts

math.randomseed(os.time())
math.random() math.random()

local modified = {} --Last modified times for each command, this allows us to dynamically update commands without stopping the bot!
local commands = {} --The table used to access each command object.

local bot = { --Container for common functions and variables we want to use.
	discordia=discordia, client=client, path=path, prefix=prefix,
	send=function(to, ...) --Allows the commands to send data to eachother. 'Specially useful for bank features.
		if commands[to] and commands[to].receive then
			return commands[to]:receive(...)
		end
	end,
	starttime=os.time()
}

client:on('ready', function()
	--[[Initialization]]
	os.execute(format("mkdir %sdata",path))
	
	local ls = io.popen(format("ls %scommands/",path))
	for file in ls:lines() do
		local suc, data = pcall(loadfile(path.."commands/"..file),bot)
		if suc then
			if data.init then data:init() end
			commands[file:sub(1,-5)] = data
		else
			print(data)
		end
	end
	ls:close()
	
	print("Initialized "..table.count(commands).." commands.")
	
	client:setGameName(prefix.."help")
	print("Now running!")
	
	--[[Updating]]
	while true do
    	sleep(1000)
		for k,v in pairs(commands) do
			if v.update then
				local suc,err = pcall(v.update,v)
				if not suc and err then
					print(k.." update: "..err)
				end
			end
		end
	end
end)

client:on('messageCreate', function(message)
	if message.content:sub(1,#prefix) == prefix then --Commands
		local start, fin = message.content:find(" ")
		local name = message.content:sub(2,(start or 0)-1)
		if name == "help" then --TO-DO: Add category support.
			local msg = "**Command List:**\n```\n"
			for name,command in pairs(commands) do
				if command.description then
					msg=msg..prefix..name.." - "..command.description.."\n"
				end
			end
			message:reply(msg.."```")
		elseif name == "reset" then
			if message.member then
				for role in message.member.roles do
					if role.name == "Bot Manager" then
						local name = message.content:sub((fin or 0)+1,-1)
						if commands[name] then
							commands[name] = nil
							local suc, data = pcall(loadfile(path.."commands/"..name..".lua"),bot)
							if suc then
								if data.init then data:init() end
								commands[name] = data
								message:reply(format("Resetted %s!",name))
							else
								message:reply(data)
							end
						end
						break
					end
				end
			end
		else
			local command = commands[name]
			if command then
				if command.command then
					local args = (fin or fin ~= #message.content) and string.split(message.content:sub((fin or 0)+1,-1)," ")
					local suc,err = pcall(command.command,command,args,message)
					if err then
						message:reply(err)
					end
				end
			else
				print("Invalid command: \""..message.content:sub(2,(start or 0)-1).."\"")
			end
		end
	elseif message.user ~= client.user then --Plain message
		for k,v in pairs(commands) do
			if v.message then
				local suc,err = pcall(v.message,v,message)
				if err then
					message:reply(err)
				end
			end
		end
	end
end)

local file = io.open(path.."token.txt","r")
if file then
	client:run(file:read())
	file:close()
else
	print("Please place your token in a token.txt at the project root.")
end