local bit = require"bit"
local bot = ...
local poll = {
	category = "Chat",
	description = "Get results!",
	
	cost=30,
	bonus=3,
	polls = {
	},
}

--The epitome of brute force.
function isEmoji(t)
	local emojilist = [[©️®️‼️⁉️™️ℹ️↔️↕️↖️↗️↘️↙️↩️↪️⌚️⌛️⌨️⏏️⏩️⏪️⏫️⏬️⏭️⏮️⏯️⏰️⏱️⏲️⏳️⏸️⏹️⏺️Ⓜ️▪️▫️▶️◀️◻️◼️◽️◾️☀️☁️☂️☃️☄️☎️☑️☔️☕️☘️☝️☠️☢️☣️☦️☪️☮️☯️☸️☹️☺️♀️♂️♈️♉️♊️♋️♌️♍️♎️♏️♐️♑️♒️♓️♠️♣️♥️♦️♨️♻️♿️⚒️⚓️⚔️⚕️⚖️⚗️⚙️⚛️⚜️⚠️⚡️⚪️⚫️⚰️⚱️⚽️⚾️⛄️⛅️⛈️⛎️⛏️⛑️⛓️⛔️⛩️⛪️⛰️⛱️⛲️⛳️⛴️⛵️⛷️⛸️⛹️⛺️⛽️✂️✅️✈️✉️✊️✋️✌️✍️✏️✒️✔️✖️✝️✡️✨️✳️✴️❄️❇️❌️❎️❓️❔️❕️❗️❣️❤️➕️➖️➗️➡️➰️➿️⤴️⤵️⬅️⬆️⬇️⬛️⬜️⭐️⭕️〰️〽️㊗️㊙️🀄🃏🅰️🅱️🅾️🅿️🆎🆑🆒🆓🆔🆕🆖🆗🆘🆙🆚🈁🈂️🈚🈯🈲🈳🈴🈵🈶🈷️🈸🈹🈺🉐🉑🌀🌁🌂🌃🌄🌅🌆🌇🌈🌉🌊🌋🌌🌍🌎🌏🌐🌑🌒🌓🌔🌕🌖🌗🌘🌙🌚🌛🌜🌝🌞🌟🌠🌡️🌤️🌥️🌦️🌧️🌨️🌩️🌪️🌫️🌬️🌭🌮🌯🌰🌱🌲🌳🌴🌵🌶️🌷🌸🌹🌺🌻🌼🌽🌾🌿🍀🍁🍂🍃🍄🍅🍆🍇🍈🍉🍊🍋🍌🍍🍎🍏🍐🍑🍒🍓🍔🍕🍖🍗🍘🍙🍚🍛🍜🍝🍞🍟🍠🍡🍢🍣🍤🍥🍦🍧🍨🍩🍪🍫🍬🍭🍮🍯🍰🍱🍲🍳🍴🍵🍶🍷🍸🍹🍺🍻🍼🍽️🍾🍿🎀🎁🎂🎃🎄🎅🎆🎇🎈🎉🎊🎋🎌🎍🎎🎏🎐🎑🎒🎓🎖️🎗️🎙️🎚️🎛️🎞️🎟️🎠🎡🎢🎣🎤🎥🎦🎧🎨🎩🎪🎫🎬🎭🎮🎯🎰🎱🎲🎳🎴🎵🎶🎷🎸🎹🎺🎻🎼🎽🎾🎿🏀🏁🏂🏃🏄🏅🏆🏇🏈🏉🏊🏋️🏌️🏍️🏎️🏏🏐🏑🏒🏓🏔️🏕️🏖️🏗️🏘️🏙️🏚️🏛️🏜️🏝️🏞️🏟️🏠🏡🏢🏣🏤🏥🏦🏧🏨🏩🏪🏫🏬🏭🏮🏯🏰🏳️🏴🏵️🏷️🏸🏹🏺🏻🏼🏽🏾🏿🐀🐁🐂🐃🐄🐅🐆🐇🐈🐉🐊🐋🐌🐍🐎🐏🐐🐑🐒🐓🐔🐕🐖🐗🐘🐙🐚🐛🐜🐝🐞🐟🐠🐡🐢🐣🐤🐥🐦🐧🐨🐩🐪🐫🐬🐭🐮🐯🐰🐱🐲🐳🐴🐵🐶🐷🐸🐹🐺🐻🐼🐽🐾🐿️👀👁️👂👃👄👅👆👇👈👉👊👋👌👍👎👏👐👑👒👓👔👕👖👗👘👙👚👛👜👝👞👟👠👡👢👣👤👥👦👧👨👩👪👫👬👭👮👯👰👱👲👳👴👵👶👷👸👹👺👻👼👽👾👿💀💁💂💃💄💅💆💇💈💉💊💋💌💍💎💏💐💑💒💓💔💕💖💗💘💙💚💛💜💝💞💟💠💡💢💣💤💥💦💧💨💩💪💫💬💭💮💯💰💱💲💳💴💵💶💷💸💹💺💻💼💽💾💿📀📁📂📃📄📅📆📇📈📉📊📋📌📍📎📏📐📑📒📓📔📕📖📗📘📙📚📛📜📝📞📟📠📡📢📣📤📥📦📧📨📩📪📫📬📭📮📯📰📱📲📳📴📵📶📷📸📹📺📻📼📽️📿🔀🔁🔂🔃🔄🔅🔆🔇🔈🔉🔊🔋🔌🔍🔎🔏🔐🔑🔒🔓🔔🔕🔖🔗🔘🔙🔚🔛🔜🔝🔞🔟🔠🔡🔢🔣🔤🔥🔦🔧🔨🔩🔪🔫🔬🔭🔮🔯🔰🔱🔲🔳🔴🔵🔶🔷🔸🔹🔺🔻🔼🔽🕉️🕊️🕋🕌🕍🕎🕐🕑🕒🕓🕔🕕🕖🕗🕘🕙🕚🕛🕜🕝🕞🕟🕠🕡🕢🕣🕤🕥🕦🕧🕯️🕰️🕳️🕴️🕵️🕶️🕷️🕸️🕹️🕺🖇️🖊️🖋️🖌️🖍️🖐️🖕🖖🖤🖥️🖨️🖱️🖲️🖼️🗂️🗃️🗄️🗑️🗒️🗓️🗜️🗝️🗞️🗡️🗣️🗨️🗯️🗳️🗺️🗻🗼🗽🗾🗿😀😁😂😃😄😅😆😇😈😉😊😋😌😍😎😏😐😑😒😓😔😕😖😗😘😙😚😛😜😝😞😟😠😡😢😣😤😥😦😧😨😩😪😫😬😭😮😯😰😱😲😳😴😵😶😷😸😹😺😻😼😽😾😿🙀🙁🙂🙃🙄🙅🙆🙇🙈🙉🙊🙋🙌🙍🙎🙏🚀🚁🚂🚃🚄🚅🚆🚇🚈🚉🚊🚋🚌🚍🚎🚏🚐🚑🚒🚓🚔🚕🚖🚗🚘🚙🚚🚛🚜🚝🚞🚟🚠🚡🚢🚣🚤🚥🚦🚧🚨🚩🚪🚫🚬🚭🚮🚯🚰🚱🚲🚳🚴🚵🚶🚷🚸🚹🚺🚻🚼🚽🚾🚿🛀🛁🛂🛃🛄🛅🛋️🛌🛍️🛎️🛏️🛐🛑🛒🛠️🛡️🛢️🛣️🛤️🛥️🛩️🛫🛬🛰️🛳️🛴🛵🛶🛷🛸🤐🤑🤒🤓🤔🤕🤖🤗🤘🤙🤚🤛🤜🤝🤞🤟🤠🤡🤢🤣🤤🤥🤦🤧🤨🤩🤪🤫🤬🤭🤮🤯🤰🤱🤲🤳🤴🤵🤶🤷🤸🤹🤺🤼🤽🤾🥀🥁🥂🥃🥄🥅🥇🥈🥉🥊🥋🥌🥐🥑🥒🥓🥔🥕🥖🥗🥘🥙🥚🥛🥜🥝🥞🥟🥠🥡🥢🥣🥤🥥🥦🥧🥨🥩🥪🥫🦀🦁🦂🦃🦄🦅🦆🦇🦈🦉🦊🦋🦌🦍🦎🦏🦐🦑🦒🦓🦔🦕🦖🦗🧀🧐🧑🧒🧓🧔🧕🧖🧗🧘🧙🧚🧛🧜🧝🧞🧟🧠🧡🧢🧣🧤🧥🧦]]
	return emojilist:find(t)
end

function poll:command(args,message)
	if args[1] == "endthepollsplz" then
		if message.member then
			for k,role in pairs(message.member.roles) do
				if role.name == "Bot Manager" then
					for i,po in pairs(self.polls) do
						po.length = 0
					end
					return
				end
			end
		end
	end
	if #args > 1 then
		local balance = bot.send("bank","balance",message.author.id)
		if not balance then message:reply("**POLL** - You don't have a bank account! Points are required to make polls.");return end
		if balance < self.cost then message:reply("**POLL** - You don't have enough!");return end
		
		local po = {
			channel = message.channel,
			user = message.author,
			starttime = os.time(),
			length = 60*60, --An hour by default.
			voters = {},
			entries = {},
		}
		
		local emoji
		local text = ""
		for i,arg in ipairs(args) do
			--Think of emoji as delimiters.
			local s,e = arg:find(":%S+:")
			if s and e or isEmoji(arg) then
				if not emoji then
					po.title = tostring(text)
				else
					table.insert(po.entries,{emoji,text})
				end
				emoji = arg
				if s and e then
					local name = emoji:sub(s+1,e-1)
					local moji = message.guild.emojis:find(function(e) return name == e.name end)
					if moji then emoji = moji end
				end
				text = ""
			else
				if i == 1 and tonumber(arg) then
					if tonumber(arg) < 0 then
						po.length = math.huge
					else
						po.length = tonumber(arg)*60
					end
				else
					text = text ..(#text==0 and""or" ")..arg
				end
			end
		end
		if emoji then table.insert(po.entries,{emoji,text}) end
		
		if #po.entries == 0 then message:reply("**POLL** - You need to provide at least one entry!");return end
		
		local desc = ""
		for i,entry in pairs(po.entries) do desc=desc..""..tostring(type(entry[1])=="string"and entry[1] or entry[1].mentionString).." "..tostring(entry[2]).."\n" end
		desc=desc.."\nTo vote, add your reaction below."
		
		po.message = message:reply({
			content=po.user.name.." created a new poll!",
			embed={
				title=("POLL: "..po.title):sub(1,256),
				description=desc:sub(1,2000),
				color=math.floor(math.random(0,0xFFFFFF))
			}
		})
		for i,entry in ipairs(po.entries) do po.message:addReaction(entry[1]) end
		
		table.insert(self.polls,po)
		bot.send("bank","take",message.author.id,self.cost)
		
		message:delete()
	else
		message:reply(string.format("```\nPoll:\n!poll (minutes) (title message) [emoji] (entry 1) [emoji] (entry 2) ...\n. A poll cost %dP to make. Entrants get a %dP bonus.\n. (minutes) is optional. -1 is indefinite.\n. If the poll has only one entry, you will get a message with the list of entrants.```",self.cost,self.bonus))
	end
end

function poll:reactionAdd(reaction,userid)
	for i,po in ipairs(self.polls) do
		if reaction.message == po.message then
			local poemoji = false
			local moji
			for i,entry in ipairs(po.entries) do
				if reaction.emojiName == entry[1] or reaction.emojiId == (type(entry[1])~="string"and entry[1].id) then
					poemoji = i
					break
				end
			end
			if not poemoji or po.voters[userid] then
				po.message:removeReaction(reaction,userid)
				return
			end
			
			local balance = bot.send("bank","balance",userid)
			if balance then bot.send("bank","give",userid,self.bonus) end
			
			po.voters[userid] = poemoji
		end
	end
end

function poll:reactionRemove(reaction,userid)
	for i,po in ipairs(self.polls) do
		if reaction.message == po.message then
			local balance = bot.send("bank","balance",userid)
			if balance then bot.send("bank","take",userid,self.bonus) end
			
			po.voters[userid] = nil
		end
	end
end

function poll:update()
	for i=#self.polls,1,-1 do  local po = self.polls[i]
		if not po.message then table.remove(self.polls,i) end
		if os.time() > po.starttime+po.length then
			if #po.entries == 1 then
				local msg = "**POLL** - Your list was completed!\n"
				for k,reaction in pairs(po.message.reactions) do
					msg = msg..tostring(reaction.count-1).." people have entered.\n"
					msg = msg.."```\n"
					for k,user in pairs(reaction:getUsers()) do
						if user.fullname ~= bot.client.user.fullname then
							if #msg > 2000-5 then po.user:reply(msg.."```");msg = "```\n" end
							msg = msg..user.name.."\n"
						end
					end
					msg = msg.."```"
				end
				po.user:send(msg)
			else
				local msg = string.format("**POLL** - %s's poll \"%s\" has completed!\n",po.user.name,po.title)
				local count = 0
				local counts = {}
				for id,vote in pairs(po.voters) do
					counts[vote] = (counts[vote] or 0) + 1
					count = count + 1
				end
				msg = msg.."```\nResults:\n"
				for i,entry in ipairs(po.entries) do
					msg = msg..(counts[i] and counts[i] or "0").." - "..entry[2].."\n"
				end
				msg = msg.."In total, "..count.." people have voted!```"
				po.channel:send(msg)
			end
			
			table.remove(self.polls,i)
		end
	end
end

return poll