local elmer = {
	translation = {
		{"double","dubbuh"},
		{"lla","ya"},
		{"very","vewy"},
		{"lol","wol"},
		{"the","da"},
		{"er","uh"},
		{"l","w"},
		{"r","w"}
	}
}

function elmer:init()
	return "Chat", "Have Elmer Fudd repeat what you say!"
end

function elmer:command(args,message)
	local msg = table.concat(args," ")
	for i,v in ipairs(self.translation) do
		msg = msg:gsub(v[1],v[2])
	end
	message:reply(msg)
end

return elmer