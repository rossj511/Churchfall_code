class CF_Journal_Sound_Test extends GFxMoviePlayer;
var bool bIsOpen;
//Starts movie
function Init(optional LocalPlayer LocPlay)
{
	Start();
	bIsOpen=true;
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
}

function Back_To_Game()
{
	self.End();
}
function End()
{
	bIsOpen = false;
	Close();
}
function Quit_game()
{
	self.End();
	`log("Called");
}
DefaultProperties
{
	bDisplayWithHudOff=true
	MovieInfo=SwfMovie'CFItems.CF_Journal_Sound'
	bCaptureInput=true;
	bIsOpen=false
	
}



