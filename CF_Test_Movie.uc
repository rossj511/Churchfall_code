class CF_Test_Movie extends GFxMoviePlayer;

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
	MovieInfo=SwfMovie'CFHUD.CF_Test_Movie'
	bEnableGammaCorrection = true;
	bIsOpen = false;
}

