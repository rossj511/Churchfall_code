class CF_HUD extends HUD;
/*
HUD class for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  


var CF_Pause_Menu PauseMenu;
var bool rendered_test_item_text;
var bool can_pause;
var bool use_journal;
//Rebinds escape to show the pause menu
exec function ShowMenu()
{
	// if using GFx HUD, use GFx pause menu
	local CF_Player_Controller CF_Controller;
	CF_Controller = CF_Player_Controller(GetALocalPlayerController());
	can_pause = CF_Controller.pausable;
	TogglePauseMenu(can_pause);
}

// Displays the pause menu defined in CF_PauseMenu
function int TogglePauseMenu(bool flag)
{
	if(can_pause == true)
	{
	if (PauseMenu.bIsOpen == true )
	{
		PauseMenu.AddFocusIgnoreKey('E');
		PlayerOwner.SetPause(False);
		PauseMenu.End();
		use_journal=true;
		PauseMenu.bIsOpen = false;
		PauseMenu = new class'CF_Pause_Menu';
		return 1;
	}
	else
	{
		PauseMenu.Start();
		use_journal=false;
		PlayerOwner.SetPause(True);
		PauseMenu.AddFocusIgnoreKey('E');
		return 0;
	}
	}
	return 0;

}

//Function that allows for drawing to hud and playing of other hud related movies
function PostRender()
{
	//local CF_Player_Pawn CF_Pawn;
	//local CF_Player_Controller CF_Controller;
	//local actor Player_Location_Actor;
	super.PostRender();

	//Player_Location_Actor = GetALocalPlayerController().Pawn;
    //CF_Pawn = CF_Player_Pawn(Player_Location_Actor);
	//CF_Controller = CF_Player_Controller(CF_Pawn.Controller);

	if(PauseMenu == none)
	{
		PauseMenu = new class'CF_Pause_Menu';
	}

}


DefaultProperties
{
	bShowOverlays=true
	rendered_test_item_text=false
	can_pause=true
	use_journal=true
}
