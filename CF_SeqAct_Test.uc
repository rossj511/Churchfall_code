// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class CF_SeqAct_Test extends SequenceAction;

event Activated()
{

	local CF_Player_Controller CF_Controller;
	local CF_Player_Pawn CF_Pawn;
	CF_Controller = CF_Player_Controller(GetWorldInfo().GetALocalPlayerController());
	CF_Pawn = CF_Player_Pawn(CF_Controller.Pawn);
	CF_Controller.IgnoreMoveInput(true);
	CF_Controller.IgnoreLookInput(true);
	CF_Pawn.crosshair_movie.End();
	
}

defaultproperties
{
	ObjName="CF_Cinematic_Freeze"
	ObjCategory="Churchfall Actions"
}
