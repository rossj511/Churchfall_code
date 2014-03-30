class CF_MalachiAI extends AIController;
/* High Logic:
 * If touching actor is of type, idle, talk move, etc...go to that state
 * SeqAct can force state change. for example during opening scene player will trigeer malachi interaction
 * 
 * 
 * 
 * 
 */
var Vector TempDest;
var Vector FinalDest;
var CF_Malachi_Pawn MalachiPawn;
var Actor Target;
//var name TargetType;

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
	}}auto state Idle
{
	Begin:
		//MalachiPawn.MalachiAnim.PlayAnim('MalachiStandingToPrayer');
}state PathFind
{
 // If we see a player or pawn, ignore it
ignores SeePlayer;
 function bool FindNavMeshPath()
 {
 // Clear cache and constraints 
	NavigationHandle.PathConstraintList = none;
	NavigationHandle.PathGoalList = none;
	NavigationHandle.bDebugConstraintsAndGoalEvals = true;
 
 /** this makes sure the bot wont wander into an area 
 where it will get stuck */
	class'NavMeshPath_EnforceTwoWayEdges'.static.EnforceTwoWayEdges(NavigationHandle);
 /** Tells the bot to set a random goal. 
 There are 2 optional
 variables you can pass, a float or int representing 
 the range 
 to search, and an int representing how many polys 
 away he can 
 move to */ 
	class'NavMeshPath_Toward'.static.TowardGoal(NavigationHandle,Target);
 
 class'NavMeshGoal_At'.static.AtActor(NavigationHandle,Target,32);
 
	// Find path
	return NavigationHandle.FindPath();
 } 
/* event EndState(Name NextStateName)
{
	MalachiPawn.MalachiAnim.PlayAnim('MalachiEndWalk');
}*/
 Begin:
	if(FindNavMeshPath())
	{
		NavigationHandle.SetFinalDestination(Target.Location);
 // The random point is any area within the NavMesh
		FinalDest = NavigationHandle.FinalDestination.Position;
		`log(FinalDest);
 // Draw the line to our pawn
		DrawDebugLine(Pawn.Location, FinalDest,255,0,0,true);
	 /** Draw a red sphere to illustrate the next location 
	 the bot
	will stop at */ 
		 DrawDebugSphere(FinalDest,16,20,255,0,0,true);
  // While our bot hasn't reached the random point yet... 
			while(!pawn.ReachedPoint(FinalDest, none))
			{
	/** If the bot realizes it can't reach this point 
	directly...*/
 
			if(!NavigationHandle.PointReachable(FinalDest))
			{
	// Get out of here and pick another point
			 break;
			}
	 // Otherwise...
		else
		{
	// Move to the random point
		MalachiPawn.MalachiAnim.PlayAnim('MalachiStartWalk');
		MalachiPawn.MalachiAnim.PlayAnim('MalachiWalkLoop');
		MoveTo(FinalDest);
		MalachiPawn.MalachiAnim.PlayAnim('MalachiEndWalk');
		}
	// Rest for (X) seconds before picking a new point
	 Sleep(0.1);
	}
 // Start from the beginning again
     Target=none;
	GoToState('Idle');
 }
}
state Talking
{

Begin:
	//MalachiPawn.MalachiAnim.PlayAnim('MalachiPrayerIdle');
}
state Praying
{

Begin:
	MalachiPawn.MalachiAnim.PlayAnim('MalachiPrayerIdle');
}
DefaultProperties
{
	Target = none
}