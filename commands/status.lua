local bot = false
return {
	init = function(self,b)
		bot = b
	end,
	command = function(self,args,message)
		message:reply(string.format("I have been running for `%.2f` hours. Memory usage is `%dKB`", (os.time()-bot.starttime)/60/60, math.floor(gcinfo()*100)/100))
	end,
}