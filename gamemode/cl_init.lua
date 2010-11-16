include("shared.lua")

function GM:Initialize( ) 

end

function PlayerCreateMenu()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 50,50 )
	DermaPanel:SetSize( 400, 600 )
	DermaPanel:SetTitle( "Reap Model Selector" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local icon = vgui.Create( "DModelPanel", DermaPanel )
	icon:SetModel( "models/player/Group01/male_01.mdl" )
	icon:SetPos(-50,55)
	icon:SetSize( 500, 500 )
	icon:SetCamPos( Vector( 100, 0, 110 ) )
	icon:SetLookAt( Vector( 0, 0, 0 ) )
	
	local DermaListView = vgui.Create("DListView")
	DermaListView:SetParent(DermaPanel)
	DermaListView:SetPos(50, 350)
	DermaListView:SetSize(300, 200)
	DermaListView:SetMultiSelect(false)
	DermaListView:AddColumn("Model") -- Add column
	

	for k,v in pairs(MaleModels) do
		DermaListView:AddLine("models/player/Group01/male_0"..MaleModels[k]) -- Add lines
	end
	
	for k,v in pairs(MaleModels) do
		DermaListView:AddLine("models/player/Group03/male_0"..MaleModels[k]) -- Add lines
	end
	
	for k,v in pairs(FemaleModels) do
		DermaListView:AddLine("models/player/Group01/female_0"..FemaleModels[k]) -- Add lines
	end
	
	for k,v in pairs(FemaleModels) do
		DermaListView:AddLine("models/player/Group03/female_0"..FemaleModels[k]) -- Add lines
	end
	
	DermaListView.OnClickLine = function(parent, line, isselected) //We override the function with our own
		icon:SetModel(line:GetValue(1)..".mdl")
	end


end