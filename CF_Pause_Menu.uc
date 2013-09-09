class CF_Pause_Menu extends GFxMoviePlayer;
/*
Pause Menu movie for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  
var bool bIsOpen;
var bool pause_item_text_bool;
var GFxObject pause_item_text;
//Starts the movie
function bool Start(optional bool StartPaused = false)
{
        super.Start();
		SetTimingMode(TM_Real);
		bIsOpen = true;
		Advance(0);
		return true;
}
//Ends movie
function End()
{
	bIsOpen = false;
	Close();
}
function inv_menu_open()
{
	local CF_Player_Pawn CF_Pawn;
	local actor Player_Location_Actor;

	Player_Location_Actor = GetPC().Pawn;
    CF_Pawn = CF_Player_Pawn(Player_Location_Actor);

	pause_item_text = self.GetVariableObject("_root.inv_text");
	if(pause_item_text_bool == true && CF_Pawn.has_test_item == true)
	{
		pause_item_text.SetText("[x] Test item");
	}
}
DefaultProperties
{
			
    MovieInfo = SwfMovie'CFPause.CF_FP_Pause';
    bEnableGammaCorrection=false
	bPauseGameWhileActive=true
	bIgnoreMouseInput=false
	bCaptureInput=false
	bIsOpen=false
	pause_item_text_bool=false
}
