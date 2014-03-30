// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class CF_SeqAct_AdjustAudio extends SequenceAction;
var CF_Ambient  Audio;
var float duration;
var float VolumeLevel;

event Activated()
{
	Audio.adjustComponentVolume(duration,VolumeLevel);
}

defaultproperties
{
	ObjName="Change Audio Volume"
	ObjCategory="Churchfall Actions"
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Audio",PropertyName=Audio,MaxVars=1))
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Duration",PropertyName=duration,MaxVars=1))
	VariableLinks.Add((ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="New Volume Level",PropertyName=VolumeLevel,MaxVars=1))

}