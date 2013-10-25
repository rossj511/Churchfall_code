class CF_interactable_trigger_test extends Trigger;
/*
Test  Interactable Trigger class for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  
var bool IsInInteractionRange;
//Touch Event
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
	super.Touch(Other, OtherComp, HitLocation, HitNormal);

	if (Pawn(Other) != none)
	{
		PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
		IsInInteractionRange = true;
	}
}
//Untouch event removes crosshair highlighting
event UnTouch(Actor Other)
{
	//local CF_Player_Pawn CF_Pawn;
	//local actor Player_Location_Actor;
	super.UnTouch(Other);

	//Player_Location_Actor = GetALocalPlayerController().Pawn;
    //CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	//CF_Pawn.bIs_Highlightable_Actor = false;
	//CF_Pawn.change_crosshair = false;

	if (Pawn(Other) != none)
	{
		PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
		IsInInteractionRange = false;
	}
}
//Adds hud functionality by checking to see if player is looking at object or other nearby puzzle triggers
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
	local CF_Player_Pawn CF_Pawn;
	local float dot_product;
	local actor Player_Location_Actor;
	local vector player_rotation;
	super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);

	Player_Location_Actor = GetALocalPlayerController().Pawn;
    CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	player_rotation = Vector(CF_Pawn.Rotation);
	dot_product =player_rotation dot (Player_location_actor.Location - self.Location);

	if(dot_product < 0)
	{
		//CF_Pawn.bIs_Highlightable_Actor = true;
		//CF_Pawn.change_crosshair = true;
	}
	else
	{
		//CF_Pawn.bIs_Highlightable_Actor = false;
		//CF_Pawn.change_crosshair = false;
	}
}

DefaultProperties
{
	  Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
	
    Begin Object Name=CollisionCylinder
       CollisionHeight =40.000000
       CollisionRadius=20.00000
    End Object
    CylinderComponent=CollisionCylinder
	
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'HU_Deco3.SM.Mesh.S_HU_Deco_SM_GasTanks01'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	bBlockActors=true
    bCollideActors=true
    bHidden=false
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=true
	IsInInteractionRange=false
}
