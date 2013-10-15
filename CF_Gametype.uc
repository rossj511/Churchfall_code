class CF_Gametype extends FrameworkGame;
/*
Gametype class for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  
//Initial call
event PostLogin( PlayerController CF_PC )
{ 
	local string url;
 	local actor Player_Location_Actor;
    local CF_Player_Pawn CF_pawn;
	local CF_save_info save_info;
	local vector vec;
	super.PostLogin( CF_PC );

	Player_Location_Actor = GetALocalPlayerController().Pawn;
	CF_pawn = CF_Player_Pawn(Player_Location_Actor);
	url = WorldInfo.GetLocalURL();
	`log(url);
		//check for load game
		if(Instr(url,"?load",,true)!=-1)
		{
			save_info = class'CF_save_info'.static.load_options();

			if(save_info == none)
			{
				save_info = new class'CF_save_info';
			}
			vec.x = save_info.loc_x;
			vec.y = save_info.loc_y;
			vec.z = save_info.loc_z;
			CF_Pawn.SetLocation(vec);
		}
}
//After play begins
event PostBeginPlay()
{
	super.PostBeginPlay();
}
//Beginning of game
simulated function StartMatch()
{
	super.StartMatch(); 
}
//Gaeinfo
static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return Default.class;
}

DefaultProperties
{
	PlayerControllerClass=class'Churchfall.CF_Player_Controller'
	DefaultPawnClass=class'Churchfall.CF_Player_Pawn'
    HUDType=class'Churchfall.CF_HUD'
    bDelayedStart=false
}
