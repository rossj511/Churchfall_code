class CF_Item_Pop_Up_Test extends GFxMoviePlayer;
var GFxObject text;
var bool bIsOpen;
//Starts movie
function Init(optional LocalPlayer LocPlay)
{
	Start();
	bIsOpen=true;
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
	text = self.GetVariableObject("_root.item_text");
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
	MovieInfo=SwfMovie'CFItems.CF_Item_Test'
	bCaptureInput=true;
	bIsOpen=false
}
