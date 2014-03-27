class CF_Malachi_AIController extends AIController;

var() vector TempDest;
var actor currentTarget;
var int targetCount;
var int finalDestinationCount;
var() bool startMoving;
var CF_Malachi_Pawn MalachiPawn;
function PostBeginPlay()
{
	super.PostBeginPlay();
	NavigationHandle = new(self) class'NavigationHandle';
	
}
event Possess(Pawn inPawn, bool bVehicleTransition)
{
	local CF_Malachi_Pawn TempPawn;
    super.Possess(inPawn, bVehicleTransition); 
    Pawn.SetMovementPhysics();
	TempPawn = CF_Malachi_Pawn(self.Pawn);
	if(TempPawn == none)
	{
		`Log("NO PAWN FOUND");
	}
	else
	{
			MalachiPawn = TempPawn;
	}
	targetCount = 0; 
	finalDestinationCount = 0;
	currentTarget = MalachiPawn.Targets[0];
} 
auto state Idle
{
	function checkForMove()
	{
		if(startMoving == true)
		{
			currentTarget = MalachiPawn.Targets[targetCount];
			GoToState('PathFind');	
		}
	}

Begin:
	//checkforMove();
	//goToState('PathFind');
	
}

state PathFind
{

	function bool FindNavMeshPath()
    {
        // Clear cache and constraints (ignore recycling for the moment)
		NavigationHandle.ClearConstraints(); 
        NavigationHandle.PathConstraintList = none;
        NavigationHandle.PathGoalList = none;
        // Create constraints
        class'NavMeshPath_Toward'.static.TowardGoal( NavigationHandle,currentTarget);
        class'NavMeshGoal_At'.static.AtActor( NavigationHandle, currentTarget,50);
		Worldinfo.Game.Broadcast(self, "The goal is:"@currentTarget);
		`log(NavigationHandle.FindPath());
        return NavigationHandle.FindPath();
    }
	Begin:
		if(currentTarget == none)
		{
			`log("NO TARGET FOUND");
			gotostate('Idle');

		}

		if(currentTarget == MalachiPawn.finalDestination[finalDestinationCount])
		{
			startMoving = false;
			finalDestinationCount++;
		
		}
		if( NavigationHandle.ActorReachable(currentTarget) )
		{
			FlushPersistentDebugLines();
			GetALocalPlayerController().ClientMessage("Found");
			MoveToward( currentTarget,currentTarget );
			if(MalachiPawn.ReachedDestination(currentTarget))
			{
				targetCount++;
				goToState('Idle');
			}
		 }
		else if( FindNavMeshPath() )
		{
			NavigationHandle.SetFinalDestination(currentTarget.Location);
			FlushPersistentDebugLines();
			NavigationHandle.DrawPathCache(,TRUE);
 
			// move to the first node on the path
			if( NavigationHandle.GetNextMoveLocation( TempDest, Pawn.GetCollisionRadius()) )
			{
				DrawDebugLine(Pawn.Location,TempDest,255,0,0,true);
				DrawDebugSphere(TempDest,16,20,255,0,0,true);
			
				MoveTo(TempDest, currentTarget );
			}

		}
		else
		{
			GotoState('Idle');
		}
		goto 'Begin';
}


DefaultProperties
{
	startMoving = false
	NavigationHandleClass=class'NavigationHandle'
}
