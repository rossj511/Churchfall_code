class CF_Candle extends Trigger
ClassGroup(CF_Actors);

var bool IsInInteractionRange;
var() const editconst DynamicLightEnvironmentComponent LightEnvironment;
var() bool is_lit;
var StaticMeshComponent trigger_mesh;
var PointLightComponent point_light;
var float life;
var() float brightness;
var float flicker_light;
var bool isLockedToObject;
var SoundCue candle;
simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	point_light = new(self) class 'PointLightComponent';
	if(is_lit == true)
	{
		point_light.SetLightProperties(self.brightness);
		point_light.Radius=200.0;
		self.AttachComponent(point_light);
	}
}
event Tick(float DeltaTime)
{
	local float random;
	local float FPS;
	Super.Tick(DeltaTime);
	FPS = 1/DeltaTime;
	if(FPS > 10 && FPS <=20)
	{
		if(point_light!=none && FPS/1.2<=flicker_light&&self.brightness>0)
		{
			random= RandRange(self.brightness-0.03,self.brightness+0.03);
			point_light.SetLightProperties(random);
			flicker_light=0;
		}
		else
			flicker_light+=1.0;
	}
	if(FPS > 20 && FPS <= 30&&self.brightness>0)
	{
		if(point_light!=none && FPS/1.5<=flicker_light)
		{
			random = RandRange(self.brightness-0.03,self.brightness+0.03);
			point_light.SetLightProperties(random);
			flicker_light=0;
		}
		else
			flicker_light+=1.0;
	}
	if(FPS > 30 && FPS <= 40&&self.brightness>0)
	{
		if(point_light!=none && FPS/2<=flicker_light)
		{
			random= RandRange(self.brightness-0.03,self.brightness+0.03);
			point_light.SetLightProperties(random);
			flicker_light=0;
		}
		else
			flicker_light+=1.0;
	}
	if(FPS > 50 && FPS <= 60&&self.brightness>0)
	{
		if(point_light!=none && FPS/2.3<=flicker_light)
		{
			random= RandRange(self.brightness-0.03,self.brightness+0.03);
			point_light.SetLightProperties(random);
			flicker_light=0;
		}
		else
			flicker_light+=1.0;
	}
	if(FPS < 60 && FPS <= 70&&self.brightness>0)
	{
		if(point_light!=none && FPS/3<=flicker_light)
		{
			random= RandRange(self.brightness-0.03,self.brightness+0.03);
			point_light.SetLightProperties(random);
			flicker_light=0;
		}
		else
			flicker_light+=1.0;
	}
}
//Touch Event
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
	super.Touch(Other, OtherComp, HitLocation, HitNormal);

	if (Pawn(Other) != none)
	{
		PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
		IsInInteractionRange = true;
	}
	if(Other.Tag == 'StaticMeshActor')
	{
		self.WorldInfo.Game.Broadcast(self,"Hit");
		self.PlaySound(candle);
	
	}
}
//Untouch event removes crosshair highlighting
event UnTouch(Actor Other)
{
	super.UnTouch(Other);
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

	super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
}
//Rotates object 11.25 degrees when looking at it and pressing the use key
function bool UsedBy(Pawn User)
{
	local bool used;
	local CF_Player_Pawn CF_Pawn;
	local CF_Player_Controller CF_Controller;
	local CF_Candle_Attributes new_candle;
	local actor Player_Location_Actor;
	local float dot_product;
	local vector player_rotation;
	local vector camera_location;
	local rotator camera_rotation;
	used = super.UsedBy(User);
	if(isLockedToObject == true)
	{
		return true;
	}
	Player_Location_Actor = GetALocalPlayerController().Pawn;
    CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	CF_Controller = CF_Player_Controller(CF_Pawn.Controller);
	player_rotation = Vector(CF_Pawn.Rotation);
	dot_product =player_rotation dot (Player_location_actor.Location - self.Location);
	CF_Controller.GetPlayerViewPoint(camera_location,camera_rotation);
	new_candle = Spawn(class'CF_Candle_Attributes');
	if (IsInInteractionRange && dot_product < 0 && CF_Controller.IsAimingAt( self, 0.98f ))
	{
		//increment # of candles
		if(CF_Controller.candles.Length < 6)
		{
			new_candle.Life=self.life;
			new_candle.Brightness=0.5;
			new_candle.is_burning=false;
			CF_Controller.candles.InsertItem(Cf_COntroller.num_candles,new_candle);
			CF_Controller.candles[Cf_Controller.num_candles].is_burning=false;
			CF_Controller.num_candles++;
			`log(CF_Controller.num_candles);
			self.Destroy();
		}
		else
		{
			new_candle.Destroy();
		}
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
       CollisionHeight=20.000000
       CollisionRadius=60.00000
    End Object


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
	   Rotation=(Pitch=0,Roll=0,Yaw=0)
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
	life=10.0
	brightness=0.5
	flicker_light=0
	is_lit = true
	isLockedToObject=false
	candle = Soundcue'CFAudio.SC_Candle'
}