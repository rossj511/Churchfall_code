class CF_Flying_Object_Test_Controller extends AIController;

//initialize variables
var int CloseEnough;
var int _PathNode;
var Actor Target;
var float Path_Count;


//possesion event to give ai properties
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
    pathfind();
    SetTimer(4,true,'pathfind');
}
//checks what pathnode in the list to set before pathfinding
simulated function PathFind()
{
					    
        if (_PathNode >= CF_Flying_Object_Test(Pawn).Waypoints.Length)
		{
			_PathNode = 0;
		}
        else
        {
           _PathNode=_PathNode++;
        }

        GoToState('Pathfinding');
}

//State that does the pathfinding
//It is set to chase the player if they get within a certain distance of the monster
state Pathfinding 
{
Begin:
	

    if(CF_Flying_Object_Test(Pawn).Waypoints[_PathNode] != None)
    {
		Path_Count = 0;
		MoveToward(CF_Flying_Object_Test(Pawn).Waypoints[_PathNode], CF_Flying_Object_Test(Pawn).Waypoints[_PathNode], 128);
    }  
	else
	{
		Sleep(1);
	}

    Sleep(0);
}

DefaultProperties
{
    CloseEnough = 200
    Path_Count = 0;
    bPreciseDestination = True
}