// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class CF_SeqAct_RotateMalachiTowardsPlayer extends SequenceAction;
var CF_Player_Pawn CF_Pawn;
var CF_Malachi_Pawn CF_Malachi;;
event Activated()
{
	local CF_RotatorClass RotationClass;
	RotationClass = new class'CF_RotatorClass';
	RotationClass.RotatorSlerp(CF_Malachi.Rotation,CF_Pawn.Rotation,1.0);
}

defaultproperties
{
	ObjName="Rotate Malachi Towards Player"
	ObjCategory="Churchfall Actions"
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Player",PropertyName=CF_Pawn,MaxVars=1))
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Malachi",PropertyName=CF_Malachi,MaxVars=1))
}
