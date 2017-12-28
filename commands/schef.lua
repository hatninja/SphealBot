local schef = {
	category = "Chat",
	description = "De speekken lookee sveedish-a cheff! Bork Bork Bork!",
		
	translation = {
		{"the","de"},
		{"is","ez"},
		{"to","der"},
		{"all","ow"},
		{"in","oon"},
		{"one","oon"},
		{"two","too"},
		{"three","trree"},
		{"microwave","microowaveeevoovee"},
		{"pancake","flap jack"},
		{"flap jack","flappen jacken"},
		{"flip","flip-flop"},
		{"for","fyr"},
		
		{"c","k"},
		{"f","v","f"},
--		{"y","e"},
		{"w(%S)","v%1"},
		{"(%S)w(%s)","%1wzen%2"},
		{"e","ee"},
		{"ea","ee"},
		{"ae","oo"},
		{"o","oo"},
		{"u","oo"},
		{"ou","uoo"},
		{"ua","ooe"},
		{"ph","ff"},
--		{"k(%S)","kk%1"},
--		{"(%S)?t","%1tt"},
		{"(%s)a(%s)","%1eh%2"},
		{"(%s)a","%1e"},
		{"(%s)o","%1u"},
		{"(%S)s(%s)","%1ss%2"},
		{"(%S)?f(%s)","%1ff%2"},
		{"(%S)le(%s)","%1el%2"},
		{"(%S)re(%s)","%1er%2"},
		{"(%S)?d","%1d%-a"},
		
		
		
		{"a","â"},
		{"ee","ëë","êê"},
		{"e","ë","ê"},
		{"i","î","ï"},
		{"oo","øø","öö"},
		{"o","ø","ö"},
		{"u","ü"},
	}
}

function schef:command(args,message)
	local msg = table.concat(args," ").." børk, børk, børk!"
	for i,v in ipairs(self.translation) do
		msg = msg:gsub(v[1],v[math.random(2,#v)])
	end
	message:reply(msg)
end

return schef