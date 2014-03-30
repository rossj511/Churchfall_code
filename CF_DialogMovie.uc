class CF_DialogMovie extends GFxMoviePlayer;

var bool bIsOpen;
var GFxObject RootMC;
var GFxObject Dialog_Text;
var array<string> Dialog;
var int indexCount;

function bool Start(optional bool StartPaused = false)
{
        super.Start();
		SetTimingMode(TM_Real);
		bIsOpen = true;
		Advance(0);
		RootMC = GetVariableObject("_root");
		Dialog_Text = GetVariableObject("_root.DialogT");
		return true;
}
function setDialog(string DialogArray)
{
		
		getArray(DialogArray);
		getText();
}
function End()
{
	Close();
	bIsOpen = false;
}
function getArray(string dialogArray)
{
	local CF_DialogClass dClass;
	local WorldInfo CFGameInfo; //this will represent the gameinfo class
	local CF_Gametype CFGameType; //this represents the desired gametype
	CFGameInfo = class'WorldInfo'.static.GetWorldInfo();
	CFGameType = CF_Gametype(CFGameInfo.Game);
	dClass = CFGameType.dClass;
	Dialog = dClass.getDialogArray(dialogArray);
}
function getText()
{
	local string Text;
	if(indexCount == Dialog.Length)
	{
		End();
	}
	Text = Dialog[indexCount];
	indexCount++;
	DisplayText(Text);

}
function DisplayText(string Text)
{
	`log(text);
	Dialog_Text.SetText(Text);
}

DefaultProperties
{
	MovieInfo = SwfMovie'CFDialog.CF_Dialog'
	bEnableGammaCorrection=false
	bPauseGameWhileActive=true
	bIgnoreMouseInput=false
	bCaptureInput=false
	bIsOpen=false
	indexCount=0
}

