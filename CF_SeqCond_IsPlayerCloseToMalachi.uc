class CF_SeqCond_IsPlayerCloseToMalachi extends SequenceCondition;

var CF_Player_Pawn CF_Pawn;
var CF_Malachi_Pawn CF_Malachi;
var float Distance;

event Activated()
{
	    local float dot_product;
		local vector player_rotation;
		local float temp_distance;
		player_rotation = Vector(CF_Pawn.Rotation);
	    dot_product = player_rotation dot (CF_Pawn.Location - CF_Malachi.Location);
	    temp_distance = VSize(CF_Pawn.Location - CF_Malachi.Location);
		if(dot_product < 0 && temp_distance <= Distance)
		{
			OutputLinks[0].bHasImpulse = true;

		}
		else
		{
			OutputLinks[1].bHasImpulse = true;
		}



}

defaultproperties
{
	
	ObjName="Is Player Close Enough and Facing Malachi"
	ObjCategory="Churchfall Conditions"
	OutputLinks(0) = (LinkDesc="Yes")
	OutputLinks(1) = (LinkDesc="No")
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Player",PropertyName=CF_Pawn,MaxVars=1))
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Malachi",PropertyName=CF_Malachi,MaxVars=1))
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Distance",PropertyName=Distance,MaxVars=1))
}
