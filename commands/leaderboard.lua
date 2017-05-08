--Leaderboard system. WIP!
--TO-DO:
--Affixes
--Opposite sorting (Lowest first.)
--Oh yeah, making it work.
local leaderboard = {
	boards = {},
	data = {},
}

function leaderboard:init()
end

function leaderboard:receive(name,user,mode,score)
	if not self.boards[name] then self.boards[name] = {} end
	if mode == "setup" then
		self.data = {}
	elseif mode == "set" then
		self.boards[name][user] = score
	elseif mode == "get" then
		return self.boards[name][user]
	elseif mode == "add" then
		if self.boards[name][user] then
			self.boards[name][user] = self.boards[name][user] + score
		end
	end
end

function leaderboard:command(args,message)
	if self.boards[args[1]] then
		local leaderboard = self.boards[args[1]]
		local list = {}
		for k,v in pairs(leaderboard) do
			table.insert(list,k)
		end
		table.sort(list,function(a,b) return leaderboard[a] > leaderboard[b] end)
		
		local msg = "```\n"..args[1]
		
		list = nil
	else
		message:reply("**Leaderboards** That leaderboard doesn't exist! Try \"!leaderboard leaderboards\" for the list of leaderboards.")
	end
end


return leaderboard