-- taken from: https://stackoverflow.com/questions/41942289/display-contents-of-tables-in-lua
-- useful for debugging
function toStr (tbl, indent)
    if not indent then indent = 0 end
	local toprint = string.rep(" ", indent) .. "{\n"
	indent = indent + 2 
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if (type(k) == "number") then
			toprint = toprint .. "[" .. k .. "] = "
		elseif (type(k) == "string") then
			toprint = toprint	.. k ..	" = "	 
		end
		if (type(v) == "number") then
			toprint = toprint .. v .. ", \n"
		elseif (type(v) == "string") then
			toprint = toprint .. "\"" .. v .. "\", \n"
		elseif (type(v) == "table") then
			toprint = toprint .. toStr(v, indent + 2) .. ", \n"
		else
			toprint = toprint .. "\"" .. tostring(v) .. "\", \n"
		end
	end
	toprint = toprint .. string.rep(" ", indent-2) .. "}"
	return toprint
end
