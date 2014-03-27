class CF_Darkness_PuzzleActor extends Trigger
placeable;

var CF_GameType CFGame;
var bool bCandleAdded;
simulated function PostBeginPlay()
{
	local WorldInfo CFGameInfo; //this will represent the gameinfo class
	local CF_Gametype CFGameType; //this represents the desired gametype
	super.PostBeginPlay();
	CFGameInfo = class'WorldInfo'.static.GetWorldInfo();
	CFGameType = CF_Gametype(CFGameInfo.Game);
	CFGame = CFGameType;
}

//Touch Event
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
	super.Touch(Other, OtherComp, HitLocation, HitNormal);
	if(CF_Candle(Other)!=none)
	{
		candleAdded(CF_Candle(Other));

	}

}
function candleAdded(CF_Candle Candle)
{
	if(bCandleAdded==false)
	{
		self.GetALocalPlayerController().ClientMessage("Candle Added");
		CFGame.solvedPuzzleActors.InsertItem(0,self);
		bCandleAdded = true;
		Candle.isLockedToObject = true;
		if(CFGame.solvedPuzzleActors.Length == 3)
		{
			CFGame.bSolvedDarknessPuzzle = true;
			CFGame.GetALocalPlayerController().TriggerEventClass(class 'CF_SeqEvent_FinishedDarknessPuzzle',CFGame.GetALocalPlayerController());
			//Trigger next event in kismet or code
			self.GetALocalPlayerController().ClientMessage("Puzzle Solved");

		}
	}
}
//Untouch event removes crosshair highlighting
event UnTouch(Actor Other)
{
	super.UnTouch(Other);
}
function bool UsedBy(Pawn User)
{

	return true;
}
DefaultProperties
{
   Begin Object Class=CylinderComponent Name=CylinderComp
        CollisionRadius=32
        CollisionHeight=48
        CollideActors=true        
        BlockActors=false
    End Object
    
    Components.Add( CylinderComp )
    CollisionComponent=CylinderComp

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
   // CollisionComponent=MyMesh
    Components.Add(MyMesh)
	bBlockActors=true
    bCollideActors=true
    bHidden=false
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=true
	bCandleAdded=false;
}
