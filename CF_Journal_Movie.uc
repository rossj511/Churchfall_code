class CF_Journal_Movie extends GFxMoviePlayer;
var bool bIsOpen;
var bool pause_item_text_bool;
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
	Close();
	GetPC().SetPause(false);
	self.ClearFocusIgnoreKeys();
	bIsOpen = false;
}
function CloseJournal()
{
	`log("Close");
	End();
}
function Entry1()
{	
	`log("Play Sound");
}
function JournalOpen()
{
	`log("Stop all sounds");
}
DefaultProperties
{
	MovieInfo = SwfMovie'CFLetters.Journal';
    bEnableGammaCorrection=false
	bPauseGameWhileActive=true
	bIgnoreMouseInput=false
	bCaptureInput=false
	bIsOpen=false
}
