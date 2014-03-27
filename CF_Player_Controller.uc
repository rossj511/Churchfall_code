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
var CF_Timer timer;
var CF_Lantern lantern;
var bool lantern_is_being_used;
var array<CF_Candle_Attributes> candles; 
var int num_candles;
var int burn_number;
var bool bPuzzle1, Puzz1has_first_item, Puzz1has_second_item;

/* Controller needs inventory of candle objects
 * new exec to place candle 
 * exec to check if can place candle
 * 
 * 
 */
exec function int LanternToggle()
{
	local CF_Player_Pawn CF_Pawn;
	local WorldInfo CFGameInfo; //this will represent the gameinfo class
	local CF_Gametype CFGameType; //this represents the desired gametype
	CFGameInfo = class'WorldInfo'.static.GetWorldInfo();
	CFGameType = CF_Gametype(CFGameInfo.Game);
	CF_Pawn =CF_Player_Pawn(self.Pawn);
	if(CFGameType.bHasLantern == true)
	{
		if(lantern == none && lantern_is_being_used == false)
		{
			lantern = Spawn(class'CF_Lantern');
			CF_Pawn.InvManager.addInventory(lantern);
			CF_Pawn.InvManager.bMustHoldWeapon = true;
			CF_Pawn.InvManager.SetCurrentWeapon(lantern);
				if(lantern!=none)
				{
					lantern.GiveTo(CF_Pawn);
				}
			lantern.CreateLight(0.0,500.0,CF_Pawn);
			lantern.SetHidden(false);
			lantern.LanternComponent.PlayAnim('WeaponEquip');
			lantern_is_being_used = true;
			lantern.LightAttachment.SetEnabled(false);
			return 1;
		}
		else if(lantern!=none && lantern_is_being_used == false)
		{
			lantern.SetHidden(false);
			lantern.LanternComponent.PlayAnim('WeaponEquip');
			lantern_is_being_used = true;
			lantern.LightAttachment.SetEnabled(true);
			return 1;
		}
		else if(lantern!=none && lantern_is_being_used == true)
		{
			lantern.LanternComponent.PlayAnim('WeaponPutDown');
			lantern_is_being_used = false;
			lantern.DisableLight();
			return 1;
		}
	}
}

exec function int addCandle()
{
	/*local int i;
	for(i=0;i<candles.Length;i++)
	{
		`log(candles[i].Life);
	}*/
	if(candles.Length == 0 || num_candles== 0)
	{
		return 0;
	}
	`log(candles[num_candles-1].is_burning);
	if(lantern!=none && lantern_is_being_used == true && num_candles > 0)
	{
		if(lantern.LightAttachment.Brightness <= 0.0)
		{
			if(candles[num_candles-1].is_burning == false)
			{
			lantern.LightAttachment.SetEnabled(true);
			lantern.LightAttachment.SetLightProperties(lantern.LightAttachment.Brightness+candles[num_candles-1].Brightness);
			burn_number = num_candles-1;
			//SetTimer(1,true,'BurnCandle');
			candles[num_candles-1].Burn();
			candles[num_candles-1].is_burning = true;
			num_candles--;
			}
			return 1;
		}
		else if(lantern.LightAttachment.Brightness <= 3)
		{

			if(candles[num_candles-1].is_burning == false)
			{
			lantern.LightAttachment.SetLightProperties(lantern.LightAttachment.Brightness+candles[num_candles-1].Brightness);
			burn_number = num_candles-1;
			//SetTimer(1,true,'BurnCandle');
			`log("Hit");
			candles[num_candles-1].Burn();
			candles[num_candles-1].is_burning = true;
			num_candles--;
			`log(num_candles);
			}

			return 1;
		}
		else
			return 0;
	}
	else
		return 0;
}

exec function int removeCandle(optional bool fromPawn)
{
	
	if(candles.Length == 0 || num_candles == candles.Length)
	{
		return 0;
	}

	if(lantern!=none && lantern_is_being_used == true)
	{
		if(lantern.LightAttachment.Brightness <= 0.1)
		{
			lantern.LightAttachment.SetLightProperties(lantern.LightAttachment.Brightness-candles[burn_number].Brightness);
			if(lantern.LightAttachment.Brightness <= 0.0)
			{
				lantern.DisableLight();
			}
			if(fromPawn==false)
			{
			candles[num_candles].is_burning=false;
			candles[num_candles].ClearTimer('Burning');
			num_candles++;
			}
			return 1;
		}
		else if(lantern.LightAttachment.Brightness > 0.1)
		{
			lantern.LightAttachment.SetLightProperties(lantern.LightAttachment.Brightness-candles[burn_number].Brightness);
			if(fromPawn==false)
			{
			candles[num_candles].is_burning=false;
			candles[num_candles].ClearTimer('Burning');
			num_candles++;
			}
			return 1;
		}
		else
			return 0;
	}
	else 
		return 0;
}
/*exec function Journal()
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
}*/
exec function spawnCandle()
{
local Actor Collider;
local CF_Candle spawn_candle;
local vector loc;

loc = self.Pawn.Location + Vector(self.Pawn.Rotation)*150;

	if(num_candles > 0)
	{
		foreach CollidingActors(class'Actor',Collider,40,loc)
		{
			break;
		}
		if(Collider==none)
		{
			spawn_candle = Spawn(class'CF_Candle',,,loc);
			spawn_candle.life=candles[num_candles-1].Life;
			spawn_candle.brightness=candles[num_candles-1].Brightness;
			spawn_candle.bPostRenderIfNotVisible=true;
		}
		else
		{
			`log("Collision cant spawn");
			//also play movie
		}
		if(spawn_candle!=none)
		{
			candles.Remove(num_candles-1,1);
			num_candles--;
		}
	}
}


//What the controller starts with
event Possess(Pawn inPawn, bool bVehicleTransition)
{
	local CF_options_save_info options;
    local PostProcessChain Chain;
    local PostProcessEffect Effect;
	local CF_Candle_Attributes start_candle;
	local CF_Candle_Attributes start_candle1;
    local int index;
	//local CF_Player_Pawn CF_Pawn;
	//local actor Player_location_actor;
	
	super.Possess(inPawn, bVehicleTransition);

	//Player_location_actor = GetALocalPlayerController().Pawn;
	//CF_Pawn  = CF-Player_Pawn(Player_Location_Actor);
	options = class'CF_options_save_info'.static.load_options();
	start_candle = Spawn(class'CF_Candle_Attributes');
	start_candle1 = Spawn(class'CF_Candle_Attributes');
		if(options == none)
		{
			options = new class'CF_options_save_info';
		}

	ConsoleCommand("setSensitivity"@options.CursorSensitivity);
	index = options.AAIndex;
	Chain = WorldInfo.WorldPostProcessChain;
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
		candles.AddItem(start_candle);
		candles.AddItem(start_candle1);
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
			if (CF_Candle(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_MalachisBook(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_screw1(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (CF_screw2(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
		}
    }
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
	lantern_is_being_used=false;
	num_candles=2
	bPuzzle1=false
	Puzz1has_first_item=false
	Puzz1has_second_item=false
}
