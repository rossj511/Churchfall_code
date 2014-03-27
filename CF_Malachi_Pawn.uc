class CF_Malachi_Pawn extends UDKPawn
placeable;

var() array<Actor> Targets;
var() array<Actor> finalDestination;
var() int finalDestinationIndex;
var() Actor targetAA;
event PostBeginPlay()
{
    super.PostBeginPlay();
}

DefaultProperties
{
		// Create a light environment for the pawn
	Begin Object Class=DynamicLightEnvironmentComponent Name=PawnLightEnvironment
		bSynthesizeSHLight=true
		bIsCharacterLightEnvironment=true
		bUseBooleanEnvironmentShadowing=false
	End Object
	Components.Add(PawnLightEnvironment)
	bPostRenderifNotVisible = True
	bCanJump=false
    InventoryManagerClass=class'Churchfall.CF_Inventory_Manager'
	BaseEyeHeight=150
    MaxStepHeight=60
   begin object name=CollisionCylinder
        CollisionHeight=90.0
        CollisionRadius=34.0
	End Object
	Components.Add(CollisionCylinder)
	 Begin Object Class=SkeletalMeshComponent Name=MalachiPawnSkeletalMesh
        SkeletalMesh=SkeletalMesh'frmalachitemp.Meshes.Priest_L2'
       // AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
       // AnimTreeTemplate=AnimTree'SandboxContent.Animations.AT_CH_Human'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    End Object
 
    Mesh=MalachiPawnSkeletalMesh
    Components.Add(MalachiPawnSkeletalMesh)
    ControllerClass=class'Churchfall.CF_AICTEST'
 
   
 
    GroundSpeed=200.0 //Making the bot slower than the player
}
