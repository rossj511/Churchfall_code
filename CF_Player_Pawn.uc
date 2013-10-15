class CF_Player_Pawn extends Pawn;

/*
Player Pawn class for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  

var bool has_test_item;
var bool bIs_Highlightable_Actor;
var bool game_start;
var bool change_crosshair;
var bool test_puzzle_trigger_bool, test_puzzle_trigger2_bool,test_puzzle_completed;
var CF_Crosshair crosshair_movie;
var GFxObject crosshair_frame;
var CF_Journal_Sound_Test journal_test;
var SoundCue test;

//Starts a timer to check if the puzzle is completed and opens the crosshair movie
simulated function PostBeginPlay()
{
	local string url;
	local CF_save_info save_info;
	local vector vec;
	super.PostBeginPlay();
	Super.PostBeginPlay();
	SetTimer(0.5,true,'puzzle_check');
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

function journal_start()
{
	if(journal_test == None)
	{
		journal_test = new class'CF_Journal_Sound_Test';
	}

	journal_test.Init();
	PlaySound(test);

}
//Checks to see if the test puzzle is completed by checking the two test puzzle trigger actors
function puzzle_check()
{
	local CF_puzzle_trigger_test test_puzzle_trigger;
	local CF_puzzle_trigger_test2 test_puzzle_trigger2;

	ForEach AllActors(class'CF_puzzle_trigger_test',test_puzzle_trigger)
	{
		if(test_puzzle_trigger.puzzle_solved == true)
		{
			test_puzzle_trigger_bool = true;
		}
	}
	ForEach AllActors(class'CF_puzzle_trigger_test2',test_puzzle_trigger2)
	{
		if(test_puzzle_trigger2.puzzle_solved == true)
		{
			test_puzzle_trigger2_bool = true;
		}
	}
	if(test_puzzle_trigger_bool == true && test_puzzle_trigger2_bool == true)
	{
		ForEach AllActors(class'CF_puzzle_trigger_test',test_puzzle_trigger)
		{
			test_puzzle_trigger.remove_rotate = true;
		}
		ForEach AllActors(class'CF_puzzle_trigger_test2',test_puzzle_trigger2)
		{
			test_puzzle_trigger2.remove_rotate = true;
		}
		test_puzzle_completed=true;
		GetALocalPlayerController().ClientMessage("Puzzle Solved");
		ClearTimer('puzzle_check');
	}
}
//Updates once per 24 frames
event Tick(float DeltaTime)
{
	local CF_Player_Controller CF_Controller;
    super.Tick(DeltaTime);
	CF_Controller= CF_Player_Controller(self.Controller);

		if(change_crosshair == true&&CF_Controller.close_crosshair==false)
		{
			crosshair_frame.GotoAndStopI(2);
		}
		else if(change_crosshair == false&&CF_Controller.close_crosshair==false)
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
	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bSynthesizeSHLight=true
		bIsCharacterLightEnvironment=true
		bUseBooleanEnvironmentShadowing=false
	End Object
	Components.Add(MyLightEnvironment)

	bPostRenderifNotVisible = true
	bIs_Highlightable_Actor = false
	game_start = false
	change_crosshair = false
	test_puzzle_trigger_bool=false
	test_puzzle_trigger2_bool=false
	test_puzzle_completed=false
	has_test_item=false
	test = SoundCue'A_Ambient_Loops.Fire.Fire_TorchAmbient_01_Cue'
}
