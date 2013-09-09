class CF_Menu_Gametype extends SimpleGame;
/*
Gametype class for the menu of Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  
var CF_Main_Menu main_menu;


//Initial call of game
event PostLogin(PlayerController NewPlayer)
{
	super.PostLogin( NewPlayer );
}
//Once the game begins the menu is opened
simulated function StartMatch()
{
	super.StartMatch();
	main_menu = new class'CF_Main_Menu';
	main_menu.Init();
	
}
//game info
static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return Default.class;
}

defaultproperties
{
   PlayerControllerClass=class'Churchfall.CF_Menu_Player_Controller'
   DefaultPawnClass=class'Churchfall.CF_Pawn_Menu'
   bDelayedStart=false
}