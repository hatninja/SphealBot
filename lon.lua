local LON = {}

function LON.encode(t)
	local s = "{"
	local prev = 0 --For testing sequence breaks. Such as in arrays with like this {1,2,3,nil,nil,4,5}
	for i,v in ipairs(t) do
		if type(v) ~= "function" and type(v) ~= "userdata" then
			local data = tostring(v)
			if type(v) == "table" then data = LON.encode(v) end
			if type(v) == "string" then data = '[['..data..']]' end
			
			if i-1 == prev then
				s=s..data..","
				prev = i
			else
				s=s.."["..i.."]="..data..","
			end
		end
	end
	for k,v in pairs(t) do
		if type(k) == "string" and type(v) ~= "function" and type(v) ~= "userdata" then
			local data = tostring(v)
			if type(v) == "table" then data = LON.encode(v) end
			if type(v) == "string" then data = '[['..data..']]' end
			
			local key = k
			if k:find("[^0-9a-zA-Z_]") or tonumber(k:sub(1,1)) then key = "[\""..key.."\"]" end
			
			s=s..key.."="..data..","
		end
	end
	s=s:gsub(",}","}")
	return s.."}"
end

function LON.decode(s)
	return loadstring("return "..(s or ""))()
end

return LON