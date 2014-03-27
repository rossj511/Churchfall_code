// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class CF_SeqAct_GiveLantern extends SequenceAction;

event Activated()
{
	local WorldInfo CFGameInfo; //this will represent the gameinfo class
	local CF_Gametype CFGameType; //this represents the desired gametype
	CFGameInfo = class'WorldInfo'.static.GetWorldInfo();
	CFGameType = CF_Gametype(CFGameInfo.Game);
	CFGameType.bHasLantern = true;
}

defaultproperties
{
	ObjName="GiveLantern"
	ObjCategory="Churchfall Actions"
}
