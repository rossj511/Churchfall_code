class CF_Malachi_Pawn extends UDKPawn
placeable
	ClassGroup(CF_Actors);
var skeletalmeshcomponent MalachiAnim;
function SetAnimation()
{
	if (self.Mesh!=none)
    {          
		MalachiAnim=self.Mesh;
    }
}
event PostBeginPlay()
{
	SetAnimation();
    super.PostBeginPlay();	
	self.MalachiAnim.PlayAnim('MalachiPrayerIdle');
}
DefaultProperties
{
	Begin Object class=AnimNodeSequence Name=spawnsequence
	End Object
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
        SkeletalMesh=SkeletalMesh'PenIsland69TeeHee.MalachiModel'
       AnimSets(0)=AnimSet'PenIsland69TeeHee.MalachiPrayerIdle'
		AnimSets(1)=AnimSet'PenIsland69TeeHee.MalachiStandingToPrayer'
		AnimSets(2)=AnimSet'PenIsland69TeeHee.MalachiStartWalk'
		AnimSets(3)=AnimSet'PenIsland69TeeHee.MalachiWalkLoop'
		AnimSets(4)=AnimSet'PenIsland69TeeHee.MalachiEndWalk'
		Animations=spawnsequence
       //AnimTreeTemplate=AnimTree'PenIsland69TeeHee.MalachiAnimTree'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    End Object
	//Animations=spawnsequence
	//MalachiAnim=MalachiPawnSkeletalMesh
    Mesh=MalachiPawnSkeletalMesh
    Components.Add(MalachiPawnSkeletalMesh)
    ControllerClass=class'Churchfall.CF_MalachiAI'
    GroundSpeed=200.0 
}
