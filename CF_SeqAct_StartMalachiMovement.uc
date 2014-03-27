class CF_SeqAct_StartMalachiMovement extends SequenceAction;
var CF_Malachi_Pawn MalachiPawn;
event Activated()
{
	Local CF_Malachi_AIController MalachiController;
	MalachiController = CF_Malachi_AIController(MalachiPawn.Controller);
	MalachiController.startMoving = true;
}

defaultproperties
{
	ObjName="Start Malachi Movement"
	ObjCategory="Churchfall Actions"
	VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Malachi",PropertyName=MalachiPawn)
}
