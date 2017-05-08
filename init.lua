local prefix = "!"
local path = debug.getinfo(1, "S").source:sub(2,-9)

local discordia = require('discordia')
local client = discordia.Client()

local timer = require('timer')
local sleep = timer.sleep
math.randomseed(os.time())
math.random() math.random()

local commands = {}
function send(to, ...) --Allows the commands to send data to eachother. 'Specially useful for bank features.
	if commands[to] and commands[to].receive then
		return commands[to]:receive(...)
	end
end
local help = {}
--Container for common functions and variables we want to use.
local bot = {discordia=discordia,client=client,path=path,send=send,prefix=prefix} 

client:on('ready', function()
	--Initialize
	os.execute("mkdir "..path.."data")
	
	for file in io.popen("ls "..path.."commands/"):lines() do
		local command=require(path.."commands/"..file)--Some
		commands[file:sub(1,-5)] = command
	end
	for k,command in pairs(commands) do
		if command.init then
			--Initialize command
			local category, description = command:init(bot)
			--Entry for the help menu.
			if not help[category] then help[category] = {} end
			table.insert(help[category],prefix..k.." - "..description)
		end
	end
	
	print("Initialized "..table.count(commands).." commands.")
	print("Now running!")
	
	--Update
	while true do
    	sleep(1000)
		for k,v in pairs(commands) do
			if v.update then v:update(client) end
		end
	end
end)

client:on('messageCreate', function(message)
	if message.content:sub(1,#prefix) == prefix then --Commands
		local start, fin = message.content:find(" ")
		local name = message.content:sub(2,(start or 0)-1)
		if name ~= "help" then
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
		else --Special help command that is handled directly!
			local msg = "**Command List:**\n```\n"
			for k,v in pairs(help) do
				msg=msg..k..":\n"
				for i=1,#v do
					msg=msg..v[i].."\n"
				end
			end
			message:reply(msg.."```")
		end
	elseif message.user ~= client.user then --Plain message
		for k,v in pairs(commands) do
			if v.message then
				local suc,err = pcall(v:message(message))
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