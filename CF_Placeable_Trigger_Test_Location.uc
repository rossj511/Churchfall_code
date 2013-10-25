class CF_Placeable_Trigger_Test_Location extends Trigger;
var bool can_be_placed;
var bool IsInInteractionRange;
var StaticMeshComponent trigger_mesh;
var() const editconst DynamicLightEnvironmentComponent LightEnvironment;

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
 //   CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	//CF_Pawn.bIs_Highlightable_Actor = false;
	//CF_Pawn.change_crosshair = false;
	if (Pawn(Other) != none)
	{
		PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
		IsInInteractionRange = false;
	}
}
//Adds hud functionality by checking to see if player is looking at object or other nearby puzzle triggers
//Also changes object material according to current object rotation
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
	local CF_Player_Pawn CF_Pawn;
	local CF_Player_Controller CF_Controller;
	local actor Player_Location_Actor;
	local float dot_product;
	local vector player_rotation;
	local vector camera_location;
	local rotator camera_rotation;
	super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);

	Player_Location_Actor = GetALocalPlayerController().Pawn;
    CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	CF_Controller = CF_Player_Controller(CF_Pawn.Controller);
	player_rotation = Vector(CF_Pawn.Rotation);
	dot_product =player_rotation dot (Player_location_actor.Location - self.Location);
	CF_Controller.GetPlayerViewPoint(camera_location,camera_rotation);

	if(dot_product < 0 && CF_Controller.IsAimingAt( self, 0.98f )&&can_be_placed==true)
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
//Rotates object 11.25 degrees when looking at it and pressing the use key
function bool UsedBy(Pawn User)
{
	local bool used;
	local CF_Player_Pawn CF_Pawn;
	local CF_Player_Controller CF_Controller;
	local actor Player_Location_Actor;
	local float dot_product;
	local vector player_rotation;
	local vector camera_location;
	local rotator camera_rotation;
	local CF_Placeable_Trigger_Test test;
	used = super.UsedBy(User);

	Player_Location_Actor = GetALocalPlayerController().Pawn;
    CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	CF_Controller = CF_Player_Controller(CF_Pawn.Controller);
	player_rotation = Vector(CF_Pawn.Rotation);
	dot_product =player_rotation dot (Player_location_actor.Location - self.Location);
	CF_Controller.GetPlayerViewPoint(camera_location,camera_rotation);

	if (IsInInteractionRange && dot_product < 0 && CF_Controller.IsAimingAt( self, 0.98f )&&can_be_placed==true)
	{
		self.trigger_mesh.SetStaticMesh(StaticMesh'CFPuzzleTest.brick01a');
		ForEach AllActors(class'CF_Placeable_Trigger_Test', test)
		{
			test.Destroy();
		}
		can_be_placed=false;
		return true;
	}
	return used;
}
DefaultProperties
{
	can_be_placed=false
	Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
	
    Begin Object Name=CollisionCylinder
       CollisionHeight =40.000000
       CollisionRadius=20.00000
    End Object
    CylinderComponent=CollisionCylinder
	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bSynthesizeSHLight=true
		bIsCharacterLightEnvironment=true
		bUseBooleanEnvironmentShadowing=false
		bEnabled=true
	End Object
	Components.Add(MyLightEnvironment)
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_SHORT'
    End Object
	trigger_mesh=MyMesh
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
