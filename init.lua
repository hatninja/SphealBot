local prefix = "!"
local path = debug.getinfo(1, "S").source:sub(2,-9)

local discordia = require('discordia')
local client = discordia.Client()

local timer = require('timer')
math.randomseed(os.time())
math.random() math.random()

local commands = {}
send = function(to, ...) --Allows the commands to send data to eachother. 'Specially useful for bank and storage features.
	if commands[to] and commands[to].receive then
		return commands[to]:receive(...)
	end
end

client:on('ready', function()
	--Initialize
	for file in io.popen("ls "..path.."commands/"):lines() do
		local command=require(path.."commands/"..file)--Some
		if command.init then command:init(path,discordia,client,send) end
		commands[file:sub(1,-5)] = command
	end
	
	print("Initialized "..table.count(commands).." commands.")
	print("Now running!")
	
	--Update
	while true do
    	timer.sleep(1000)
		for k,v in pairs(commands) do
			if v.update then v:update(client) end
		end
	end
end)

client:on('messageCreate', function(message)
	if message.content:sub(1,#prefix) == prefix then --Commands
		local start, fin = message.content:find(" ")
		local command = commands[message.content:sub(2,(start or 0)-1)]
		if command then
			if command.command then
				local args = (fin or fin ~= #message.content) and string.split(message.content:sub((fin or 0)+1,-1)," ")
				command:command(args,message,client)
			end
		else
			print("Invalid command: \""..message.content:sub(2,(start or 0)-1).."\"")
		end
	elseif message.user ~= client.user then --Plain message
		for k,v in pairs(commands) do
			if v.message then
				if not v:message(message,client) then
					--Help Menu
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