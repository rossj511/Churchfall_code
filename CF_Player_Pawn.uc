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


//Starts a timer to check if the puzzle is completed and opens the crosshair movie
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(0.5,true,'puzzle_check');
	if(game_start == false)
	{
		crosshair_movie_start();
		game_start = true;
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

    super.Tick(DeltaTime);

		if(change_crosshair == true)
		{
			crosshair_frame.GotoAndStopI(2);
		}
		else if(change_crosshair == false)
		{
			crosshair_frame.GotoAndStopI(1);
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
}
