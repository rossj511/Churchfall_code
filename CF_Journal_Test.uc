class CF_Journal_Test extends GFxMoviePlayer;

var GFxObject text;
var GFxObject scroll;
var bool bIsOpen;
//Starts movie
function Init(optional LocalPlayer LocPlay)
{
	Start();
	bIsOpen=true;
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
	text = self.GetVariableObject("_root.text_test");
	text.SetText("Blahhhhhhhhhhhhhhhh\nhhhhhhhhhhhhhhhhhhhhh\nddddddddddddddddddddddddddddd\nddddddddddddddddddddd\nrrrrrrrrrrrrrrrrrrrrr\ndfdefefrefefefefefefe\nf\nf\nders\npreffe\n");
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
DefaultProperties
{
	bDisplayWithHudOff=true
	MovieInfo=SwfMovie'CFItems.CF_Scroll_Test'
	bCaptureInput=true;
	bIsOpen=false
}


