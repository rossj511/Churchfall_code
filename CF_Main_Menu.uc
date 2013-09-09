class CF_Main_Menu extends GFxMoviePlayer;
/*
Main Menu movie for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  
var CF_Player_input CF_Input;
//Starts movie
function Init(optional LocalPlayer LocPlay)
{
	Start();
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
	CF_Input = CF_Player_Input(GetPC().PlayerInput);
}
//Starts game
function Play_game()
{
	ConsoleCommand("open test");
}
//Quits game
function Quit_game()
{
	ConsoleCommand("quit");
}
DefaultProperties
{
	bDisplayWithHudOff=true
	MovieInfo=SwfMovie'CFMenu.CF_FP_Main_Menu'
	bCaptureInput=true;
}
