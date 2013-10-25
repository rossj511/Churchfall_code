class CF_Puzzle1_Object_2 extends Trigger
ClassGroup(CF_Actors);

var bool IsInInteractionRange;
//Touch Event
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
	local CF_Player_Controller CF_Controller;
	super.Touch(Other, OtherComp, HitLocation, HitNormal);
	CF_Controller = CF_Player_Controller(self.GetALocalPlayerController());

	if (Pawn(Other) != none && CF_Controller.bPuzzle1==true)
	{
		IsInInteractionRange = true;
	}
}
//Untouch event
event UnTouch(Actor Other)
{
	local CF_Player_Controller CF_Controller;
	super.UnTouch(Other);
	CF_Controller = CF_Player_Controller(self.GetALocalPlayerController());
	
	if (Pawn(Other) != none&& CF_Controller.bPuzzle1==true)
	{
		IsInInteractionRange = false;
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
		CF_Controller.Puzz1has_second_item = true;
		self.Destroy();
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
	Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'CFParticles.Mesh.Barrel'
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
