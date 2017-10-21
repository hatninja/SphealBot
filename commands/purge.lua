local purge = {}

function purge:command(args,message)
	if message.member then
		for k,role in pairs(message.member.roles) do
			if role.name == "Bot Manager" then
				message.channel:bulkDelete((tonumber(args[1]) or 2))
			end
		end
	end
end

return purge