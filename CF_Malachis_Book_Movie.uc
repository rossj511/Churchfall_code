class CF_Malachis_Book_Movie extends GFxMoviePlayer;
var bool bIsOpen;
var bool triggerEvent;
//Starts the movie
function Init(optional LocalPlayer LocPlay)
{
        Start();
		SetTimingMode(TM_Real);
		bIsOpen = true;
		GetPC().SetPause(true);
		Advance(0);
		self.AddFocusIgnoreKey('Escape');
}
//Ends movie
function End()
{
	local CF_Player_Controller CF_Controller;
	Close();
	GetPC().SetPause(false);
	self.ClearFocusIgnoreKeys();
	bIsOpen = false;
	CF_Controller = CF_Player_Controller(GetPC());
	if(triggerEvent==true)
	{
		CF_Controller.TriggerEventClass(class'CF_SeqEvent_CloseMalachisDoor',CF_Controller);
		triggerEvent=false;

	}
}
function CloseJournal()
{
	End();
}
DefaultProperties
{
	MovieInfo =SwfMovie'CFItems.CF_Book_Hint';
    bEnableGammaCorrection=false
	bPauseGameWhileActive=true
	bIgnoreMouseInput=false
	bCaptureInput=false
	bIsOpen=false
	triggerEvent=false
}
