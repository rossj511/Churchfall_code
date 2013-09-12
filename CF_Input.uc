class CF_Input extends PlayerInput within CF_Player_Controller;
var bool bInputAllowed;
event PlayerInput(float DeltaTime)
{

        super.PlayerInput(DeltaTime);
	    if(bInputAllowed)
	    {
		`log("Input");
	    }
}
DefaultProperties
{
	bInputAllowed = true
}
