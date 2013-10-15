class CF_save_info extends Object;

/*
Object file that holds player progress data
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

var int loc_x,loc_y,loc_z;
var string map_name;


function bool save_game()
{
	if(class'Engine'.static.BasicSaveObject(self, "C:/Churchfall/GameInfo.dat",false,0))
	{
		return true;
	}
	else
	{
		return false;
	}
}
static function CF_save_info load_options()
{
	local CF_save_info save_info;
	
	save_info = new class'CF_save_info';
	if(!class'Engine'.static.BasicLoadObject(save_info, "C:/Churchfall/GameInfo.dat",false,0))
	{
		return none;
	}
	else
	{
		return save_info;
	}

}
defaultproperties
{
	loc_x = 0;
	loc_y = 0;
	loc_z = 0;
	map_name = "test"
}
