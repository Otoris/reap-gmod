AddCSLuaFile( "shared.lua" )
ENT.Type = "brush"
AccessorFunc( ENT, "m_iNumber", 		"Number" )

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()	
end

/*---------------------------------------------------------
   Name: StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )

	if ( self:PassesTriggerFilters( entity ) ) then
	print( "Touched!" )
	--if ( entity:IsValid() and entity:IsPlayer() ) then
		entity:PrintMessage( HUD_PRINTCENTER, "How bout them triggers?" )
	print( "SET" )
		entity.safe = true
		print( entity.safe )
	end

end

/*---------------------------------------------------------
   Name: EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
	
		if ( self:PassesTriggerFilters( entity ) ) then
		print( "Not Touched!" )
		entity:PrintMessage( HUD_PRINTCENTER, "How bout them triggers?" )
		print( "SET" )
		entity.safe = false
		print( entity.safe )
		end
end

/*---------------------------------------------------------
   Name: KeyValue
---------------------------------------------------------*/
function ENT:KeyValue( key, value )
	if ( key == "farmnumber" ) then
		self:SetNumber( tonumber(value) )
	end
end

/*---------------------------------------------------------
   Name: PassesTriggerFilters
---------------------------------------------------------*/
function ENT:PassesTriggerFilters( entity )
	return entity:GetClass() == "player"
end

