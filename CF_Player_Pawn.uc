class CF_Player_Pawn extends UTPawn;

/*
Player Pawn class for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  


var bool game_start;
var CF_Crosshair crosshair_movie;
var GFxObject crosshair_frame;
//var SpotLightComponent LightAttachment;

//Starts a timer to check if the puzzle is completed and opens the crosshair movie
simulated function PostBeginPlay()
{
	local string url;
	local CF_save_info save_info;
	local vector vec;
	super.PostBeginPlay();


	//SetTimer(0.5,true,'puzzle_check');
	if(game_start == false)
	{
		crosshair_movie_start();
		//journal_start();
		game_start = true;
	}
	url = WorldInfo.GetLocalURL();
	`log(url);

	//checks for load game
	if(Instr(url,"?lf_load",,true)!=-1)
	{
		save_info = class'CF_save_info'.static.load_options();

		if(save_info == none)
		{
			save_info = new class'CF_save_info';
		}
		vec.x = save_info.loc_x;
		vec.y = save_info.loc_y;
		vec.z = save_info.loc_z;
		`log(vec.z@vec.y@vec.z);
		SetLocation(vec);
	}
}
//Starts the crosshair movie
function crosshair_movie_start()
{
	if(crosshair_movie == None)
	{
		crosshair_movie = new class'CF_Crosshair';
	}

	crosshair_movie.Init();
	crosshair_frame = crosshair_movie.GetVariableObject("_root");
}


//Updates once per 24 frames
event Tick(float DeltaTime)
{
	local CF_Player_Controller CF_Controller;
	local int i;
	super.Tick(DeltaTime);
	CF_Controller= CF_Player_Controller(self.Controller);
	if(CF_Controller.candles.Length!=0)
	{
		for(i=0;i < CF_Controller.candles.Length;i++)
		{
			if(CF_Controller.candles[i].dead==true)
			{
				CF_Controller.removeCandle(true);
				CF_Controller.candles.Remove(i,1);
			}
		}
	}   
		if(CF_Controller.close_crosshair==false)
		{
			crosshair_frame.GotoAndStopI(1);
		}
		if(CF_Controller.open_crosshair==true)
		{
			CF_Controller.open_crosshair=false;
		}
	    if(CF_Controller.close_crosshair==true)
		{
			crosshair_frame.GotoAndStopI(3);
		}
		
		
}
DefaultProperties
{
	// Create a light environment for the pawn
	Begin Object Class=DynamicLightEnvironmentComponent Name=PawnLightEnvironment
		bSynthesizeSHLight=true
		bIsCharacterLightEnvironment=true
		bUseBooleanEnvironmentShadowing=false
	End Object
	Components.Add(PawnLightEnvironment)
	bPostRenderifNotVisible = true
	game_start = false
	bCanJump=false
    InventoryManagerClass=class'Churchfall.CF_Inventory_Manager'
}
