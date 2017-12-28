local bot = ...
local status = {
	category = "Info",
	description = "The current status of this bot.",
}

function status:command(args,message)
	message:reply(string.format("I have been running for `%1d` days and `%.2f` hours. Memory usage is `%dKB` or `%dMB`",
	math.floor((os.time()-bot.starttime)/60/60/24), ((os.time()-bot.starttime)/60/60)%24, math.floor(gcinfo()*100)/100, math.floor((gcinfo()/1024)*100)/100))
end

return status