--Leaderboard system. WIP!
local leaderboard = {
	boards = {},
	affixes = {},
}

function leaderboard:init()
	return "Mechanic","Leaderboards for everything!"
end

function leaderboard:receive(name,user,mode,score)
	if not self.boards[name] then self.boards[name] = {} end
	if mode == "set" then
		self.boards[user] = score
	elseif mode == "get" then
		return self.boards[user]
	elseif mode == "add" then
		self.boards[user] = self.boards[user] + score
	end
end

function leaderboard:command(args,message)
	if self.boards[args[1]] then
		local list = {}
		
		
		
		list = nil
	else
		message:reply("**Leaderboards** That leaderboard doesn't exist! Try \"!leaderboard leaderboards\" for the list of leaderboards.")
	end
end


return leaderboard