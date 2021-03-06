class CF_Pop_Up_Text_Trigger_Test extends Trigger;

var bool IsInInteractionRange;
var() const editconst DynamicLightEnvironmentComponent LightEnvironment;
var StaticMeshComponent trigger_mesh;
var CF_Item_Pop_Up_Test item_movie;
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

	if(dot_product < 0 && CF_Controller.IsAimingAt( self, 0.98f ))
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
	used = super.UsedBy(User);

	Player_Location_Actor = GetALocalPlayerController().Pawn;
    CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	CF_Controller = CF_Player_Controller(CF_Pawn.Controller);
	player_rotation = Vector(CF_Pawn.Rotation);
	dot_product =player_rotation dot (Player_location_actor.Location - self.Location);
	CF_Controller.GetPlayerViewPoint(camera_location,camera_rotation);

	if (IsInInteractionRange && dot_product < 0 && CF_Controller.IsAimingAt( self, 0.98f ))
	{
		self.Destroy();
		if(item_movie == NONE)
		{
			item_movie = new class'CF_Item_Pop_Up_Test';
		}
		item_movie.Init();
		item_movie.text.SetText("This item does things");
		//CF_Pawn.bIs_Highlightable_Actor = false;
		//CF_Pawn.change_crosshair = false;
		return true;
	}
	return used;
}
DefaultProperties
{
	  Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
	
    Begin Object Name=CollisionCylinder
       CollisionHeight=10.000000
       CollisionRadius=30.00000
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
       StaticMesh=StaticMesh'CFPuzzleTest.brick01a'
	   LightEnvironment=MyLightEnvironment
	   Translation=(X=0.000000,Y=0.000000,Z=0.000000)
	   Rotation=(Pitch=10240,Roll=0,Yaw=0)
    End Object
    CollisionComponent=MyMesh
    Components.Add(MyMesh)
	trigger_mesh=MyMesh
	bBlockActors=true
    bCollideActors=true
    bHidden=false
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=true
	IsInInteractionRange=false
}