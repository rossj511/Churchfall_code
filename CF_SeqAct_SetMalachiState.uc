// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class CF_SeqAct_SetMalachiState extends SequenceCondition;
var CF_Malachi_Pawn CF_Malachi;
var string StateName;
var actor target;
event Activated()
{
	local CF_MalachiAI AI;
	AI = CF_MalachiAI(CF_Malachi.Controller);
	AI.GotoState(name(StateName));
	AI.Target= target;
	if(target==none)
	{
		OutputLinks[0].bHasImpulse = true;
	}
}

defaultproperties
{
	
	ObjName="Set Malachi State"
	ObjCategory="Churchfall Conditions"
	OutputLinks(0) = (LinkDesc="Finished")
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Malachi",PropertyName=CF_Malachi,MaxVars=1))
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_String',LinkDesc="State",PropertyName=StateName,MaxVars=1))
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Target",PropertyName=Target,MaxVars=1))

}
