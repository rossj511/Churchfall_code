// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class CF_Seq_Act_CF_Cinematic_Unfreeze extends SequenceAction;

event Activated()
{
	local CF_Player_Controller CF_Controller;
	local CF_Player_Pawn CF_Pawn;
	CF_Controller = CF_Player_Controller(GetWorldInfo().GetALocalPlayerController());
	CF_Pawn = CF_Player_Pawn(CF_Controller.Pawn);
	CF_Controller.IgnoreMoveInput(false);
	CF_Controller.IgnoreLookInput(false);
	CF_Pawn.crosshair_movie_start();

}

defaultproperties
{
	ObjName="CF_Cinematic_Unfreeze"
	ObjCategory="Churchfall Actions"
}
