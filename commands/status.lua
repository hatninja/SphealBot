local status = {
	category = "Info",
	description="The current status of this bot.",
}

local bot = false
function status:init(self,b)
	bot = b
end

function status:command(self,args,message)
	message:reply(string.format("I have been running for `%.2f` hours. Memory usage is `%dKB`", (os.time()-bot.starttime)/60/60, math.floor(gcinfo()*100)/100))
end
return status