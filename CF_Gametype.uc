class CF_Gametype extends FrameworkGame;
/*
Gametype class for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  
var bool bHasLantern;
var bool bHasMKey;
var bool bHasScrew1;
var bool bHasScrew2;
var array<CF_Darkness_PuzzleActor> solvedPuzzleActors;
var bool bSolvedDarknessPuzzle;
var int malachiIndexCount;
var CF_DialogClass dClass;
//Initial call
event PostLogin( PlayerController CF_PC )
{ 
	local string url;
 	local actor Player_Location_Actor;
    local CF_Player_Pawn CF_pawn;
	local CF_save_info save_info;
	local vector vec;
	local name sName;
	super.PostLogin( CF_PC );
	sName=class'Engine'.static.GetSubtitleFont().Name;
	`log(sName);
	dClass = new class 'Churchfall.CF_DialogClass';
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
			bHasLantern = save_info.bHasLantern;
			bHasMKey = save_info.bHasMKey;
			bHasScrew1= save_info.bHasScrew1;
			bHasScrew2 = save_info.bHasScrew2;
			solvedPuzzleActors = save_info.solvedPuzzleActors;
			bSolvedDarknessPuzzle = save_info.bSolvedDarknessPuzzle;
			malachiIndexCount = save_info.malachiIndexCount;

		}
	self.GetALocalPlayerController().ConsoleCommand("Scale Set DynamicShadows true");
	self.GetALocalPlayerController().ConsoleCommand("Scale Set DynamicLights true");
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
	bHasLantern = false
	bHasMKey = false
	bHasScrew1=false
	bHasScrew2=false
	bSolvedDarknessPuzzle = false
	malachiIndexCount=0;
}