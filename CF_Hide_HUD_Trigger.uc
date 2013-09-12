class CF_Hide_HUD_Trigger extends Trigger;
var bool IsInInteractionRange;
var() const editconst DynamicLightEnvironmentComponent LightEnvironment;
var() int timer;
var bool touch_1;
//Touch Event
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
	local CF_Player_Pawn CF_Pawn;
	local actor Player_Location_Actor;
	super.Touch(Other, OtherComp, HitLocation, HitNormal);
	Player_Location_Actor = GetALocalPlayerController().Pawn;
    CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	if (Pawn(Other) != none && touch_1 == true)
	{
		CF_Pawn.crosshair_movie.End();
		SetTimer(timer,false,'Show_HUD');
		IsInInteractionRange = true;
		touch_1=false;
	}
}
function Show_HUD()
{
	local CF_Player_Pawn CF_Pawn;
	local actor Player_Location_Actor;
	Player_Location_Actor = GetALocalPlayerController().Pawn;
    CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	CF_Pawn.crosshair_movie.Init();
}
//Untouch event removes crosshair highlighting
event UnTouch(Actor Other)
{
	super.UnTouch(Other);

	if (Pawn(Other) != none)
	{
		IsInInteractionRange = false;
		//self.Destroy();
	}
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
       StaticMesh=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_SHORT'
	   LightEnvironment=MyLightEnvironment
    End Object
    CollisionComponent=MyMesh
    Components.Add(MyMesh)
	bBlockActors=true
    bCollideActors=true
    bHidden=true
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=false
	IsInInteractionRange=false
	touch_1=true
}