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

function elmer:command(args,message)
	local msg = table.concat(args," ")
	for i,v in ipairs(self.translation) do
		msg = msg:gsub(v[1],v[2])
	end
end

return elmer