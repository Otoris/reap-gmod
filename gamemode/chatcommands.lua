chatcommands = {}

function GM:PlayerSay( ply, txt, teamonly, isalive ) 
	local Strings = string.Explode(" ", txt)
	for k,v in pairs(chatcommands) do
		if Strings[1] == k then
			table.remove(Strings,1)
			v(ply,Strings)
			--ply:ChatPrint("ChatCommand: "..k)
			return ""
		end
	end
	for k,v in pairs(chatcommands) do
		--if string.len(Strings[1]) < 3 then return txt end
		if string.find(k,Strings[1]) != nil then
			print("Typed Word")
			print(Strings[1])
			print("ChatCommand")
			print(k)
			local start,endpos,word = string.find(k,Strings[1])
			print("Start")
			print(start)
			print("ENDPOS")
			print(endpos)
			print("Total match")
			print(endpos-start)
			if endpos - (start-1) > 2 then
				ply:ChatPrint("Woops did you mean "..k.." ?")
				return ""
			end
		end
	end
	return txt
end

function AddChatCommand( ChatCommand, FunctionName )
	if ChatCommand == nil or FunctionName == nil then return end
	for k,v in pairs(chatcommands) do
		if ChatCommand == k then
			return
		end
	end
	chatcommands[ChatCommand] = FunctionName
	
end
