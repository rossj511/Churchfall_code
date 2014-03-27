class CF_screw1 extends Trigger
placeable
ClassGroup(CF_Actors);
var bool IsInInteractionRange;


simulated function PostBeginPlay()
{
	super.PostBeginPlay();
}
event Tick(float DeltaTime)
{
	super.Tick(DeltaTime);
}
//Touch Event
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
	super.Touch(Other, OtherComp, HitLocation, HitNormal);

	if (Pawn(Other) != none)
	{
		IsInInteractionRange = true;
	}
}
//Untouch event removes crosshair highlighting
event UnTouch(Actor Other)
{
	super.UnTouch(Other);
	if (Pawn(Other) != none)
	{
		IsInInteractionRange = false;
	}
}
//Adds hud functionality by checking to see if player is looking at object or other nearby puzzle triggers
//Also changes object material according to current object rotation
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
	super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
}
//Rotates object 11.25 degrees when looking at it and pressing the use key
function bool UsedBy(Pawn User)
{
	local WorldInfo CFGameInfo; //this will represent the gameinfo class
	local CF_Gametype CFGameType; //this represents the desired gametype
	CFGameInfo = class'WorldInfo'.static.GetWorldInfo();
	CFGameType = CF_Gametype(CFGameInfo.Game);
	CFGameType.bHasScrew1 = true;
	return true;
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
       StaticMesh=StaticMesh'toolsandcontainers.Meshes.BookGreenOpenUp'
	   LightEnvironment=MyLightEnvironment
	   Translation=(X=0.000000,Y=0.000000,Z=0.000000)
	   Rotation=(Pitch=0,Roll=0,Yaw=0)
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
