// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class ToggleMalachisDoor extends SequenceAction;
var CF_DoorActor MalachisDoor;
event Activated()
{
	MalachisDoor.toggleDoor();
}


defaultproperties
{
	ObjName="ToggleMalachisDoor"
	ObjCategory="Churchfall Actions"
	bCallHandler=false
	VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Malachi's Door",PropertyName=MalachisDoor)
}
