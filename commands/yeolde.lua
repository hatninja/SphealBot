local yeolde = {
	category = "Chat",
	description = "Speak in Ye Olde English! (Probably not accurate.)",
		
	translation = {
		--Sentences
		{"hello","good day"},
		{"hi(%s)","good day%1"},
		{"goodbye","fare thee well"},
		{"(%s)bye","%1farewell"},
		{"seeya","farewell"},
		{"thanks","many thanks"},
		{"thank you","many thanks to you"},
		{"(%s)lol(%s)","%1lollery%2"},
		{"(%s)rofl","%1rofling"},
		{"(%s)haha","%1chuckle"},
		{"(%s)i think","%1methinks"},
		
		--Make things longer :P
		{"count","tally"},
		{"affect","sway"},
		{"after","posterior to"},
		
		{"again","once more"},
		{"(%s)ages","%1summers"},
		{"(%s)ago","%1before"},
		
		{"(%s)sky","%1ether"},
		{"(%s)gust","%1flurry"},
		
		{"anything","any one thing"},
		{"an assault","hostilities"},
		{"an attack","hostilities"},
		
		--Compounds
		{"i'm","i am"},
		{"it's","it is"},
		{"i'll","i will"},
		{"isn't","is not"},
		{"you're","you are"},
		{"don't","do not"},
		{"won't","will not"},
		{"can't","can not"},
		{"cannot", "can not"},
		{"shouldn't","should not"},
		{"wouldn't","would not"},
		{"couldn't","could not"},
		{"should've","should have"},
		{"would've","would have"},
		{"could've","could have"},

		{"it is(%s)","'tis%1"},
		{"it was(%s)","'twas%1"},
		
		{"(%s)soon","%1anon"},
		{"later","anon"},
		{"before","'ere"},
		{"tolerate","abide"},
		{"withstand","abide"},
		{"await","abide"},
		
		--Misc.
		{"would", "wouldst"},
		{"could", "couldst"},
		{"should", "shouldst"},

		{"(%s)you are","%1thou art"},
		{"(%s)you","%1thee"},
		{"(%s)your","%1thy"},
		{"(%s)yours","%1thine"},
		{"(%s)my","%1mine"},
		
		{"there","thither"},
		{"where","whither"},
		{"here","hither"},

		{"over there","yonder"},
		{"from where","whence"},
		
		{"(%s)are","%1art"},
		{"(%s)often","%1oft"},
		{"(%s)do","%1doeth"},
		{"does","doth"},
		{"has","hath"},
		{"was","wast"},
		{"why","wherefore"},
		{"will(%s)","wilt%1"},
		
		{"the(%s)","ye%1"},
		{"(%S)ld(%s)","%1lde%2"},
		
		{"(%s)yes","%1aye"},
		{"(%s)no","%1nay"},
		{"(%s)ok","%1okay"},
		
		{"(%s)in","%1within"},
		
		{"(%s)yay","%1huzzah"},
		
		{"(%s)let","%1allow"},
		{"(%s)ask","%1pray"},
		{"(%s)pray thee","%1prithee"},
		
		{"(%s)may","%1shall"},
		{"maybe","perchance"},
		{"perhaps","perchance"},
		{"possibly","perchance"},
		
		{"(%s)try","attempt"},
		{"attempt","assay"},
		{"attempted","assayed"},
		
		{"help","assist"},
		{"slowly","soft"},
		
		{"write","pen"},
		{"fight","brawl"},
		{"enemy","adversary"},
		{"sadness","woe"},
		{"(%s)joy","%1glee"},
		{"grief","woe"},
		{"nothing","naught"},
		{"beautiful","fair"},
		
		{"(%s)lesson","%1lore"},
		
		{"3 times","thrice"},
		{"three times","thrice"},
		
		{"(%s)kill","%1slay"},
		{"(%s)killed","%1slain"},
		{"(%s)die","%1perish"},
		{"(%s)died","%1perished"},
		
		{"born","begotten"},

		--Contractions
		{"(%s)never","%1ne'er"},
		{"(%s)ever","%1e'er"},
		{"(%s)even","%1e'en"},
		{"(%s)over","%1o'er"},
		{"shall not","shan't"},
		{"will not","shan't"},
		
		--Things
		{"(%s)map","%1chart"},
		{"(%s)book","%1scroll"},
		{"calculator","abacus"},
		{"(%s)house","%1abode"},
		{"(%s)airplane","%1manned bird"},
		{"(%s)car","%1carriage"},
		{"(%s)bot","%1robot"},
		{"robot","automaton"},
		
		{"storm","tempest"},
		{"weak","feeble"},
		
		{"boyfriend","male partner"},
		{"girlfriend","female partner"},
		{"(%s)friend","%1cousin"},
		{"girl","lass"},
		{"boy","lad"},
		{"man","sirrah"},
		{"woman","mistress"},
		{"comedian","jester"},
		
		--Time
		{"morning","morrow"},
		{"tomorrow","to morrow"},
		
		{"le(%s)","el%1"},
		{"re(%s)","er%1"},
		
		{"d(%s)","de%1"},
		{"ea","e"},
	}
}

function yeolde:command(args,message)
	local msg = " "..table.concat(args," ").." "
	for i,v in ipairs(self.translation) do
		msg = msg:gsub(string.lower(v[1]),string.lower(v[2]))
	end
	message:reply(msg:sub(2,-2))
end

return yeolde