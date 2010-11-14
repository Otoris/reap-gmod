DB = {}

--Otoris--
--DB.Create() Checks to see if the server already has a created DB, 
-- if not it creates one. This is for reap_player_profiles DB and
-- reap_player_inventory DB
function DB.Create()
	-- Check reap_player_profiles if it exist
	if ( sql.TableExists( "reap_player_profiles" ) ) then
		Msg( "[REAP] reap_player_profiles Database Exisits!\n" )
	else 
	-- If reap_player_profiles doesn't exist, we should probably create it
		if ( !sql.TableExists( "reap_player_profiles" ) ) then
			query = "CREATE TABLE reap_player_profiles ( unique_id varchar(255), model str, hp int, armor int, currency varchar(255) )"
			result = sql.Query( query )
			if ( sql.TableExists( "reap_player_profiles" ) ) then
				Msg( "[REAP] reap_player_profiles Database Created\n" )
			else
				Msg( "[REAP] reap_player_profiles Database Failed to Create\n" )
				Msg( sql.LastError( result ) .. "\n" )
			end
		end
	end
	
	-- Check reap_player_inventory if it exist
	if ( sql.TableExists( "reap_player_inventory" ) ) then
		Msg( "[REAP] reap_player_inventory Database Exisits!\n" )
	else 
	-- If reap_player_inventory doesn't exist, we should probably create it
		if ( !sql.TableExists( "reap_player_inventory" ) ) then
			query = "CREATE TABLE reap_player_inventory ( unique_id varchar(255), inventory table )"
			result = sql.Query( query )
			if ( sql.TableExists( "reap_player_inventory" ) ) then
				Msg( "[REAP] reap_player_inventory Database Created\n" )
			else
				Msg( "[REAP] reap_player_inventory Database Failed to Create\n" )
				Msg( sql.LastError( result ) .. "\n" )
			end
		end
	end
end


--Otoris--
-- DB.SearchPlayerDB() Checks for a specific players table in the DB
function DB.SearchPlayerDB( ply )

	ply.unique_id = ply:SteamID() -- Uses the players steam id as unique_id
	
	result = sql.Query( "SELECT unique_id FROM reap_player_profiles WHERE unique_id = '"..ply.unique_id.."'" ) -- Checks for players unique steam id in the DB
	result = sql.Query( "SELECT unique_id FROM reap_player_inventory WHERE unique_id = '"..ply.unique_id.."'" ) -- Checks for players unique steam id in the DB
	if ( result && result2 ) then
		if DeveloperMode then
		Msg( "[REAP] Profile for ".. ply.unique_id .." Exists\n" )
		Msg( "[REAP] Inventory for ".. ply.unique_id .." Exists\n" )
		end
		ply.NewChar = "Failure" -- We mark the player with a failure so they can't create more than one table in our DB
		DB.LoadProfile( ply ) -- We will call this to retrieve info on the player since they exist in the DB!
	else
		if DeveloperMode then
		Msg( "[REAP] Profile ".. ply.unique_id .." Creating\n" )
		end
		ply.NewChar = nil -- We mark the player with nil so that the Character Creation menu will be able to setup the players desired choices for their new table.
		ply:SendLua( "PlayerCreateMenu()" ) --Open Character Creation menu on client
	end
	
end

--Otoris--
-- DB.GetPlayerSetup() catches desired player info set on the Character Create
--  menu and inserts it in the DB
function DB.GetPlayerSetup( ply, cmd, args )

	if ( NewChar == nil ) then --We check to see if this player already has a profile so he can't call this command unauthorized
		-- Sets some variables on the player so we can create them with DB.CreateNewProfile()
		ply.model = args[1]
		ply.armor = StartingArmor
		ply.hp = StartingHP
		ply.currency = StartingMoney
		ply.inventory = StartingInventory
		ply:SendLua( "CompleteCharCreation()" ) -- Send this function to the client to close their menu and continue
		NewChar = "Failure" -- Mark the player with failure so they can't do this twice
		DB.CreateNewProfile( unique_id, ply ) -- Create a new player :D
	else 
		RunConsoleCommand( "kick", ply:Name() ) -- if NewChar == anything else but nil we kick them for attempted exploiting
		Msg( "[REAP] Player Kicked for Hacking" )
	end
end
concommand.Add( "rp_newcharacter", DB.GetPlayerSetup )

--Otoris--
-- DB.CreateNewProfile inserts a new player into our sql databases based 
--  on info provided by DB.GetPlayerSetup
function DB.CreateNewProfile( unique_id, ply )
	-- Inserts info provided by DB.GetPlayerSetup into our DBs
	sql.Query( "INSERT INTO reap_player_profiles ( `unique_id`, `model`, `hp`, `armor`, `currency` )VALUES ( '".. ply.unique_id .."', '".. ply.model .."', '".. ply.hp .."', '".. ply.armor .."', '".. ply.currency .."' )" )
	sql.Query( "INSERT INTO reap_player_inventory ( `unique_id`, `inventory` )VALUES ( '".. ply.unique_id .."', '".. ply.inventory .."' )" )
	result = sql.Query( "SELECT unique_id FROM reap_player_profiles WHERE unique_id = '".. ply.unique_id .."'" )
	result2 = sql.Query( "SELECT unique_id FROM reap_player_inventory WHERE unique_id = '".. ply.unique_id .."'" )
	if ( result && result2 ) then -- If no errors and our query worked notify and load player info into the server.
		if DeveloperMode then
			Msg( "[REAP] Profile ID ".. ply.unique_id .." Created in reap_player_profiles & reap_player_inventory\n" )
		end
		DB.LoadPlayerProfile( ply ) -- We have created the new player profile so we'll go ahead and load this players info onto the server for use.
	else
		if DeveloperMode then
			Msg( "[REAP] Profile Failed to Create\n" )
			Msg( sql.LastError( result ) )
			Msg( sql.LastError( result2 ) )
		end
	end
	
end