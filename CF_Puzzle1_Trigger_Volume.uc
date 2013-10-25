class CF_Puzzle1_Trigger_Volume extends TriggerVolume
placeable;


 simulated  singular event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector Direction ) 
{

  local CF_Player_Controller CF_Controller;
  CF_Controller = CF_Player_Controller(self.GetALocalPlayerController());
  CF_Controller.bPuzzle1=true;
}
DefaultProperties
{
}
