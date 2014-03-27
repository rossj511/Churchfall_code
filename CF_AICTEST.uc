class CF_AICTEST extends UDKBot;
var Vector tempDest;
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
	
} 
function bool FindNavMeshPath(optional Actor Target, optional Vector TargetDest)
{
	if (Target == none && TargetDest == Vect(0,0,0))
	{
		return false;
	}
     
	// Clear cache and constraints (ignore recycling for the moment)
    NavigationHandle.PathConstraintList = none;
    NavigationHandle.PathGoalList = none;

    // Create constraints
	if (Target != none)
	{
		class'NavMeshPath_Toward'.static.TowardGoal(NavigationHandle, Target);
		class'NavMeshGoal_At'.static.AtActor(NavigationHandle, Target, 32);
	}
	else
	{
		class'NavMeshPath_Toward'.static.TowardPoint( NavigationHandle, TargetDest ); 
		class'NavMeshGoal_At'.static.AtLocation( NavigationHandle, TargetDest, 50, );
	}

    // Find path
    return NavigationHandle.FindPath();
}
/**
 * This will try several methods to reach DestTarget:
 * Returns 1 if target is directly reachable. 
 * Returns 2 if path can be found using navmesh. 
 * Returns 3 if path can be found using pathnodes. 
 * Returns 0 if no path to the target can be found. 
 */
simulated function int CanFindPath(optional Actor DestTarget, optional Vector DestPoint)
{
	if(DestTarget != none)
	{
		// Check if the target is directly reachable
		if (NavigationHandle.ActorReachable(DestTarget) || ActorReachable(DestTarget))
		{
			return 1;
		}
		// Failing that, check if a path can be found using navmesh
		else if(FindNavMeshPath(DestTarget))
		{
			return 2;
		}
		// Failing that, check if a path can be found using pathnodes
		else if (FindPathToward(DestTarget) != none)
		{
			return 3;
		}
	}
	else if (DestPoint != Vect(0,0,0))
	{
		if (NavigationHandle.PointReachable(DestPoint) || PointReachable(DestPoint) )
		{
			return 1;
		}
		else if (FindNavMeshPath(,DestPoint) )
		{
			return 2;
		}
		else if (FindPathTo(DestPoint) != none)
		{
			return 3;
		}
	}
	// If it didn't find a route, return a fail code
	return 0;
}

/**
 * Returns a Vector which indicates where the bot's next move should be, using whichever method it can to reach the supplied destination Actor or Vector.
 * If both are supplied, will prioritise the Actor over the Vector
 */
simulated function Vector GetNextMove(optional Actor DestActor, optional Vector DestVector)
{
	if (DestActor != none)
	{
		switch(CanFindPath(DestActor))
		{
			// If the enemy is directly reachable then run straight for them
		case 1:
			return DestActor.Location;
		case 2:
			// If not, but I can find a path with navmesh then use that
			NavigationHandle.SetFinalDestination(DestActor.Location);
			if (NavigationHandle.GetNextMoveLocation(TempDest, Pawn.GetCollisionRadius()))
			{
				return TempDest;
			}
			break;
		case 3:
			// If not, but I can find a path using pathnodes then use that instead
			return FindPathToward(DestActor).Location;
			break;
		Default:
			return Vect(0,0,0);
		}
	}
	else if (DestVector != Vect(0,0,0))
	{
		switch(CanFindPath(,DestVector))
		{
			// If the enemy is directly reachable then run straight for them
		case 1:
			return DestVector;
		case 2:
			// If not, but I can find a path with navmesh then use that
			NavigationHandle.SetFinalDestination(DestVector);
			if (NavigationHandle.GetNextMoveLocation(TempDest, Pawn.GetCollisionRadius()))
			{
				return TempDest;
			}
			break;
		case 3:
			// If not, but I can find a path using pathnodes then use that instead
			return FindPathTo(DestVector).Location;
			break;
		Default:
			return Vect(0,0,0);
		}
	}
	return Vect(0,0,0);
}

auto state idle
{
Begin:
	`log("IDLE");
	MoveTo(GetNextMove(MalachiPawn.targetAA));
	`log(MalachiPawn.targetAA);
	`log(GetNextMove(MalachiPawn.targetAA));
	`log(CanFindPath(MalachiPawn.targetAA));
}





DefaultProperties
{

}
