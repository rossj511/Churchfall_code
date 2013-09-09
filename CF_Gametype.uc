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
	super.PostLogin(CF_PC);
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
