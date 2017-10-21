local bot = ...
local status = {
	category = "Info",
	description = "The current status of this bot.",
}

function status:command(args,message)
	message:reply(string.format("I have been running for `%.2f` hours. Memory usage is `%dKB`", (os.time()-bot.starttime)/60/60, math.floor(gcinfo()*100)/100))
end

return status