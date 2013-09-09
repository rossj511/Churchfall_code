class CF_Crosshair extends GFxMoviePlayer;
/*
Crosshair movie class for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  
var bool bIsOpen;
//Plays movie
function Init(optional LocalPlayer LocPlay)
{
	Start();
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
	bIsOpen = true;
}
//end movie
function End(optional LocalPlayer LocPlay)
{
	bIsOpen = false;
	Close();
}

//simple check function
function bool open_check()
{
	return bIsOpen;
}
defaultproperties
{
	bDisplayWithHudOff=false
	MovieInfo=SwfMovie'CFHUD.CF_Crosshair'
	bEnableGammaCorrection = true;
	bIsOpen = false;
}

