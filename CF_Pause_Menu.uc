class CF_Pause_Menu extends GFxMoviePlayer;
/*
Pause Menu movie for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/  
var bool bIsOpen;
var GFxObject RootMC;
var GFxobject candle_text, candle_inventory_1,candle_inventory_2,candle_inventory_3,candle_inventory_4,candle_inventory_5,candle_inventory_6;
var Cf_save_info save_info;

//Starts the movie
function bool Start(optional bool StartPaused = false)
{
		local CF_Player_Controller CF_Controller;
		local int i;
		local array<GFxObject> candle_array;
        super.Start();
		CF_Controller = CF_Player_Controller(GetPC());
		SetTimingMode(TM_Real);
		bIsOpen = true;
		Advance(0);
		i=candle_array.Length;
		RootMC = GetVariableObject("_root");
		candle_text = GetVariableObject("_root.can");
		candle_inventory_1= GetVariableObject("_root.can2");
		candle_array.AddItem(candle_inventory_1);
		candle_inventory_2= GetVariableObject("_root.can3");
		candle_array.AddItem(candle_inventory_2);
		candle_inventory_3= GetVariableObject("_root.can4");
		candle_array.AddItem(candle_inventory_3);
		candle_inventory_4= GetVariableObject("_root.can5");
		candle_array.AddItem(candle_inventory_4);
		candle_inventory_5= GetVariableObject("_root.can6");
		candle_array.AddItem(candle_inventory_5);
		candle_inventory_6= GetVariableObject("_root.can7");
		candle_array.AddItem(candle_inventory_6);
		candle_text.SetText("You have"@string(CF_Controller.candles.Length)@"candles.\n");
		for(i=0; i < CF_Controller.candles.Length;i++)
		{
			candle_array[i].SetText("Candle"@string(i+1)@"has"@string(int(CF_Controller.candles[i].Life))@"seconds remaing.\n");
		
		}
		return true;
}
//Ends movie
function End()
{
	Close();
	bIsOpen = false;
}
function open_main_menu()
{
	ConsoleCommand("open test_menu");
}
function Finished()
{
		local CF_Player_Controller CF_Controller;
		local int i;
		local array<GFxObject> candle_array;
		CF_Controller = CF_Player_Controller(GetPC());
		i=candle_array.Length;
		candle_text = GetVariableObject("_root.can");
		candle_inventory_1= GetVariableObject("_root.can2");
		candle_array.AddItem(candle_inventory_1);
		candle_inventory_2= GetVariableObject("_root.can3");
		candle_array.AddItem(candle_inventory_2);
		candle_inventory_3= GetVariableObject("_root.can4");
		candle_array.AddItem(candle_inventory_3);
		candle_inventory_4= GetVariableObject("_root.can5");
		candle_array.AddItem(candle_inventory_4);
		candle_inventory_5= GetVariableObject("_root.can6");
		candle_array.AddItem(candle_inventory_5);
		candle_inventory_6= GetVariableObject("_root.can7");
		candle_array.AddItem(candle_inventory_6);
		candle_text.SetText("You have"@string(CF_Controller.candles.Length)@"candles.\n");
		for(i=0; i < CF_Controller.candles.Length;i++)
		{
			candle_array[i].SetText("Candle"@string(i+1)@"has"@string(int(CF_Controller.candles[i].Life))@" seconds remaing.\n");
		
		}
		
}
function save_game_info()
{
	local actor Player_Location_Actor;
    local CF_Player_Pawn CF_Pawn;
	Player_Location_Actor = GetPC().Pawn;
    CF_pawn = Cf_Player_Pawn(Player_Location_Actor);
	save_info = class'CF_save_info'.static.load_options();
	candle_text.SetText("You have candles.");
	if(save_info == none)
	{
		save_info = new class'CF_save_info';
	}
	save_info.loc_x = CF_Pawn.location.X;
	save_info.loc_y = CF_Pawn.location.Y;
	save_info.loc_z = CF_Pawn.location.Z;
	save_info.map_name = GetPC().WorldInfo.GetMapName();
	save_info.save_game();
}
DefaultProperties
{
			
    MovieInfo = SwfMovie'CFPause.CF_Pause';
    bEnableGammaCorrection=false
	bPauseGameWhileActive=true
	bIgnoreMouseInput=false
	bCaptureInput=false
	bIsOpen=false
}
