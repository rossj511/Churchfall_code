// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class CF_SeqAct_Test extends SequenceAction;

event Activated()
{

local CF_Player_Controller CF_Controller;
CF_Controller = CF_Player_Controller(GetWorldInfo().GetALocalPlayerController());
CF_Controller.Log_Call();
}

defaultproperties
{
	ObjName="CF_Cinematic"
	ObjCategory="Churchfall Actions"
}
