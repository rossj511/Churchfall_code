class CF_DoorActor extends Actor
placeable;


//initialize variables
var() int RotatingSpeed;
var() int SpeedFade;
var() string RotationAxis;
// 0 = closed, 1 = opening, 2 = opened, 3 = closing
var int status;
var bool IsInInteractionRange;
var bool playing;
//When used, the door will either open or close depending on status.
event Tick( float DeltaTime ) 
{
    super.Tick(DeltaTime);

		if(status == 1 )
		{
			RotateOnAxis(RotationAxis,1,DeltaTime);

		}
		if(status == 2)
		{
			RotateOnAxis(RotationAxis,-1,DeltaTime);
		}
	
}
function RotateOnAxis(string axis,int dir,float DeltaTime)
{
	local Rotator final_rot;
	final_rot = Rotation;
	RotatingSpeed = FMax(RotatingSpeed - SpeedFade* DeltaTime,0);
	if(axis == "Yaw")
	{
			final_rot.Yaw = final_rot.Yaw + RotatingSpeed*DeltaTime*dir;
	}
	else if(axis == "Pitch")
	{
			final_rot.Pitch = final_rot.Pitch + RotatingSpeed*DeltaTime*dir;
	}
	SetRotation(final_rot);

}
function bool toggleDoor()
{

		if(playing == true)
		{
			return false;
		}
		
		if (status!=1&&status!=3)
		{
			status = 1;
			playing = true;	
			SetTimer(5.5,false,'door_stop');
      
			return true;
		}
		if (status==3)
		{
			status = 2;
			playing = true;
			SetTimer(5.5,false,'door_stop');

			return true;
		}

    return false;
} 

function door_stop()
{

	if(status == 2)
	{
		status = 0;
	}

	if(status == 1)
	{
		status = 3;
	}
	playing = false;

}

defaultproperties
{	
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'CFParticles.Mesh.Barrel'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    RotatingSpeed = 6000
    SpeedFade = 1
	
	bHidden = false
    bBlockActors=true
    bCollideActors=true
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=true
	
    status = 0
	playing = false
   
}
