class CF_Lantern extends UDKWeapon;
/*
First person arms for Landfall
Contains animations that are called based on bools in player pawn and player controller
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//Initialize variables
var bool check;
var bool play_idle;
//var AnimSequence OnSpawn;
//var AnimNodePlayCustomAnim Idle;
var SpotLightComponent LightAttachment;
var SkeletalMeshComponent LanternComponent;
// Sets animation node slots so they can be called in unrealscript
function SetAnimation()
{
	if (self.Mesh!=none)
    {          
		LanternComponent=SkeletalMeshComponent(self.Mesh);
    }
}
simulated function PostBeginPlay()
{
	SetAnimation();
	super.PostBeginPlay();
}
function CreateLight(float intensity,float radius,CF_Player_Pawn CF_Pawn)
{
	LightAttachment = new(self) class 'SpotLightComponent';
	LightAttachment.SetLightProperties(intensity);
	LightAttachment.Radius= radius;
	LightAttachment.InnerConeAngle= 20;
	LightAttachment.OuterConeAngle= 50;
	LightAttachment.CastDynamicShadows = false;
	LightAttachment.ShadowFilterQuality = SFQ_High;
	LightAttachment.ShadowProjectionTechnique = ShadowProjTech_BPCF_High;
	LightAttachment.SetEnabled( true );
	//self.AttachComponent(LightAttachment);
	//CF_Pawn.AttachComponent(LightAttachment);
	LanternComponent.AttachComponentToSocket(LightAttachment,'MuzzleFlashSocket');
}
function DisableLight()
{
	LightAttachment.SetEnabled(false);
}
event Tick(float DeltaTime)
{

	super.Tick(DeltaTime);
}
//Sets the arms in a position in front of player to look like arms
//checks the player controller attack and block bools to know whether to play an animation
simulated event SetPosition(UDKPawn Holder)
{
    local vector FinalLocation;
    local vector X,Y,Z;
    Holder.GetAxes(Holder.Controller.Rotation,X,Y,Z);
    FinalLocation= Holder.GetPawnViewLocation(); //this is in world space.
    FinalLocation= FinalLocation- Y * 12 - Z * 32; // Rough position adjustment
   // SetHidden(False);
    SetLocation(FinalLocation);
    SetBase(Holder);
    SetRotation(Holder.Controller.Rotation);
}

DefaultProperties
{
	Begin Object class=AnimNodeSequence Name=spawnsequence
	End Object
    Begin Object class=SkeletalMeshComponent Name=MySkeletalMeshComponent
    SkeletalMesh=SkeletalMesh'WP_LinkGun.Mesh.SK_WP_Linkgun_1P'
	AnimSets(0)=AnimSet'WP_LinkGun.Anims.K_WP_LinkGun_1P_Base'
	Animations=spawnsequence
    Translation=(Z=0.0)
	HiddenGame=FALSE
    HiddenEditor=FALSE
    End Object
    Mesh=MySkeletalMeshComponent
  
    Components.Add(MySkeletalMeshComponent)
	bPostRenderifNotVisible = true
	play_idle = false
}
