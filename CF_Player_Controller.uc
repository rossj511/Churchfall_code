class CF_Player_Controller extends PlayerController;

/*
Player Controller class for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  

var CF_Test_Movie test_movie;
var bool open_crosshair;
var bool close_crosshair;
var CF_Journal_Movie journal_movie;
var bool pausable;
exec function Flashlight()
{
	`log("Flashlight");
}

exec function Journal()
{
	`log("journal");
	if(CF_HUD(self.myHUD).use_journal== true)
	{
	if(journal_movie == none)
	{
		journal_movie = new class'CF_Journal_Movie';
	}
	if(journal_movie.bIsOpen==false)
	{
		
		journal_movie.Init();
		pausable=false;
	}
	else if(journal_movie.bIsOpen==true)
	{
		journal_movie.End();
		pausable=true;
		journal_movie = new class'CF_Journal_Movie';
	}
	}
}
//What the controller starts with
event Possess(Pawn inPawn, bool bVehicleTransition)
{
	local CF_options_save_info options;
    local PostProcessChain Chain;
    local PostProcessEffect Effect;
    local int index;
	//local CF_Player_Pawn CF_Pawn;
	//local actor Player_location_actor;
	
	super.Possess(inPawn, bVehicleTransition);

	//Player_location_actor = GetALocalPlayerController().Pawn;
	//CF_Pawn  = CF-Player_Pawn(Player_Location_Actor);
	options = class'CF_options_save_info'.static.load_options();

		if(options == none)
		{
			options = new class'CF_options_save_info';
		}

	ConsoleCommand("setSensitivity"@options.CursorSensitivity);
	index = options.AAIndex;
	`log(options.AAIndex);
	Chain = WorldInfo.WorldPostProcessChain;
	`log(Chain);
		if (Chain != None)
		{
			foreach Chain.Effects(Effect)
			{
				if (UberPostProcessEffect(Effect) != None)
				{
					switch(index)
					{
						case 0:
							
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_Off;
							ConsoleCommand("PostProcessAAType 0");
							break;
						case 1:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA1;
							ConsoleCommand("PostProcessAAType 1");
						   
							break;
						case 2:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA2;
							ConsoleCommand("PostProcessAAType 2");
						  
							break;
						case 3:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA3;
							ConsoleCommand("PostProcessAAType 3");
						
							break;
						case 4:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA4;
							ConsoleCommand("PostProcessAAType 4");
						   
							break;
						case 5:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA5;
							ConsoleCommand("PostProcessAAType 5");
						 //`log( UberPostProcessEffect(Effect).PostProcessAAType);
						
							break;
					}
             
				}
			}
		}

}
function Spawn_Block()
{
    local CF_Spawnable_Mesh_Test mesh;
    local Vector mesh_location;

    // position 100 units infront of pawn
    mesh_location = Pawn.Location + Vector(Pawn.Rotation) * 100.0;

    // spawn a dynamic static mesh actor
    mesh = Spawn( class'CF_Spawnable_Mesh_Test', , , mesh_location );

    if ( mesh == None ) return;

    // use generic cube mesh, half size
    //A.StaticMeshComponent.SetStaticMesh( StaticMesh'EngineMeshes.Cube' );
     mesh.SetDrawScale( 0.5 );

    // drop to floor
    mesh.SetPhysics( PHYS_None );
    // set it to self-destruct after 3 seconds
    mesh.SetTimer( 3.0, false, 'Destroy_Mesh' );
}
//Gets the triggers that the player uses
//Top part is an override of PlayerController class GetTriggerUseList function
function GetTriggerUseList(float interactDistanceToCheck, float crosshairDist, float minDot, bool bUsuableOnly, out array<trigger> out_useList)
{
    local int Idx;
    local vector cameraLoc;
    local rotator cameraRot;
    local trigger checkTrigger;
    local SeqEvent_Used UseSeq;
 
    if (Pawn != None)
    {
        GetPlayerViewPoint(cameraLoc, cameraRot); 
        // search of nearby actors that have use events 
        foreach Pawn.CollidingActors(class'trigger',checkTrigger,interactDistanceToCheck) 
        { 
        for (Idx = 0; Idx < checkTrigger.GeneratedEvents.Length; Idx++)
			{
				UseSeq = SeqEvent_Used(checkTrigger.GeneratedEvents[Idx]);

				if( ( UseSeq != None )
					// if bUsuableOnly is true then we must get true back from CheckActivate (which tests various validity checks on the player and on the trigger's trigger count and retrigger conditions etc)
					&& ( !bUsuableOnly || ( checkTrigger.GeneratedEvents[Idx].CheckActivate(checkTrigger,Pawn,true)) )
					// check to see if we are looking at the object
					&& ( Normal(checkTrigger.Location-cameraLoc) dot vector(cameraRot) >= minDot )

					
					&& ( ( ( UseSeq.bAimToInteract && IsAimingAt( checkTrigger, 0.98f ) && ( VSize(Pawn.Location - checkTrigger.Location) <= UseSeq.InteractDistance ) ) )
					      // if we should NOT aim to interact then we need to be close to the trigger
			  || ( !UseSeq.bAimToInteract && ( VSize(Pawn.Location - checkTrigger.Location) <= UseSeq.InteractDistance ) )  // this should be UseSeq.InteractDistance
						  )
				   )
				{
					out_useList[out_useList.Length] = checkTrigger;

					// don't bother searching for more events
					Idx = checkTrigger.GeneratedEvents.Length;
				}
			}
          
 
            //add custom triggers to list of useable triggers
            if (CF_interactable_trigger_test2(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_rotatable_trigger_test(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_puzzle_trigger_test(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_puzzle_trigger_test2(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_Inventory_Test_Trigger(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_placeable_trigger_test(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_placeable_trigger_test_location(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_Pop_Up_Text_Trigger_Test(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
		}
    }
}
function Log_Call()
{
	`log("Called");
}


function Open_Test_Movie(CF_SeqAct_Flash_Movie_Test movie)
{
	close_crosshair=true;
	if(test_movie == none)
	{
		test_movie = new class'CF_Test_Movie';
	}
	test_movie.Init();
	SetTimer(2,false,'Close_Test_Movie');
	SetTimer(5,false,'Open_CH_Movie');
	
}
function Close_Test_Movie()
{
	test_movie.End();
}
function Open_CH_Movie()
{
	open_crosshair=true;
	close_crosshair=false;
}
DefaultProperties
{
	InputClass=class'Churchfall.CF_Player_Input'
	open_crosshair=false
	close_crosshair=false
	pausable=true;
}
