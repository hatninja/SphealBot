local prefix = "!"
local path = debug.getinfo(1, "S").source:sub(2,-9)

local discordia = require('discordia')
local client = discordia.Client()

local timer = require('timer')
local sleep = timer.sleep

local format = string.format --TO-DO: Use this for fasts

math.randomseed(os.time())
math.random() math.random()

local status = false
local modified = {} --Last modified times for each command, this allows us to dynamically update commands without stopping the bot!
local help = {} --Stores information for the help menu
local commands = {} --The table used to access each command object.

local bot = { --Container for common functions and variables we want to use.
	discordia=discordia, client=client, path=path, prefix=prefix, status=status,
	send=function(to, ...) --Allows the commands to send data to eachother. 'Specially useful for bank features.
		if commands[to] and commands[to].receive then
			return commands[to]:receive(...)
		end
	end,
	starttime=os.time()
}

function check(loadall)
	local ls = io.popen("ls "..path.."commands/")
	if ls then
		for file in ls:lines() do
			local stat = io.popen("stat -c %Y "..path.."commands/"..file) --"stat -f %m" for mac.
			if stat then
				local date = stat:read()
				if loadall or modified[file] ~= date then
					modified[file] = date
					stat:close()
					
					local suc, data = pcall(require,path.."commands/"..file)
					if suc then
						if data.init then data:init(bot) end
						commands[file:sub(1,-5)] = data
						print((loadall and "Loaded " or "Updated ")..file)
					else
						print(data)
					end
				end
			end
		end
	end
	ls:close()
end

client:on('ready', function()
	--[[Initialization]]
	os.execute(format("mkdir "..path.."data"))
	
	check(true) --Load all the commands.
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
		check()
	end
end)

client:on('messageCreate', function(message)
	if message.content:sub(1,#prefix) == prefix then --Commands
		local start, fin = message.content:find(" ")
		local name = message.content:sub(2,(start or 0)-1)
		if name ~= "help" then
			if name ~= "here" then
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
			else
				if message.member then
					for role in message.member.roles do
						if role.name == "Bot Manager" then
							status = message.channel
							break
						end
					end
				end
			end
		else
			local msg = "**Command List:**\n```\n"
			for k,v in pairs(help) do
				msg=msg..k..":\n"
				for i=1,#v do
					if #msg + #v[i] > 1995 then
						message:reply(msg.."\n```")
						msg = "```\n"
					end
					msg=msg..v[i].."\n"
				end
			end
			message:reply(msg.."```")
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