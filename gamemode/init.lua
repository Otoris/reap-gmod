
require("mysqloo")

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )
include( 'chatcommands.lua' )
include( 'daytime.lua' )
include( 'database.lua' )


function GM:Initialize( )--Called when the gamemode loads and starts. 

end

function GM:PlayerInitialSpawn( ply )--Is called when the player first spawns into the world. 

end

function GM:PlayerSpawn( ply )--Called whenever a player respawns. 

end

function InsertInv()

end

