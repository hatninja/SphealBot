local elmer = {
	category = "Chat",
	description = "Have Elmer Fudd repeat what you say!",
		
	translation = {
		{"double","dubbuh"},
		{"ll","w"},
		{"lol","wo{$!}"},
		{"the","da"},
		{"er","uh"},
		{"l","w"},
		{"r","w"},
		{"{$!}","l"}
	}
}

function elmer:command(args,message)
	local msg = table.concat(args," ")
	for i,v in ipairs(self.translation) do
		msg = msg:gsub(v[1],v[2])
	end
	message:reply(msg)
end

return elmer