include("shared.lua")

function GM:Initialize( ) 

end

function PlayerCreateMenu()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 50,50 )
	DermaPanel:SetSize( 500, 700 )
	DermaPanel:SetTitle( "Testing Derma Stuff" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaListView = vgui.Create("DListView")
	DermaListView:SetParent(DermaPanel)
	DermaListView:SetPos(25, 50)
	DermaListView:SetSize(300, 400)
	DermaListView:SetMultiSelect(false)
	DermaListView:AddColumn("Model") -- Add column

	for k,v in pairs(player.GetAll()) do
		DermaListView:AddLine(v:Nick()) -- Add lines
	end
	
	 
	local icon = vgui.Create( "DModelPanel", DermaPanel )
	icon:SetModel( LocalPlayer():GetModel() )
	 
	icon:SetSize( 100, 100 )
	icon:SetCamPos( Vector( 50, 50, 120 ) )
	icon:SetLookAt( Vector( 0, 0, 0 ) )

end