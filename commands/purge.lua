local purge = {}

function purge:command(args,message)
	if message.member then
		for role in message.member.roles do
			if role.name == "Bot Manager" then
				for v in message.channel:bulkDelete((tonumber(args[1]) or 2)) do
				end
				break
			end
		end
	end
end

return purge