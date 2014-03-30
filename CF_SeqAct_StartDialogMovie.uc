// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class CF_SeqAct_StartDialogMovie extends SequenceAction;
var string DialogArray;
event Activated()
{
	local CF_DialogMovie DMovie;
	DMovie = new class'Churchfall.CF_DialogMovie';
	DMovie.Init();
	DMovie.setDialog(DialogArray);
	
}

defaultproperties
{
	ObjName="Start Dialog Movie"
	ObjCategory="Churchfall Actions"
	VariableLinks.Add((ExpectedType=class'SeqVar_String',LinkDesc="DialogArray",PropertyName=DialogArray))
}
