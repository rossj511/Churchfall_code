class CF_DialogClass extends Object;
struct DArray
{
	var array<string> dialogArray;
	var string name;
};
var DArray MalachiIntro;
var array<DArray> TotalDialogs;
var array<string> empty;
function fillArray()
{
	fillMalachiIntro();	
	TotalDialogs.InsertItem(0,MalachiIntro);
}

function fillMalachiIntro()
{
	local string prompt1;
	local string prompt2;
	local int i;
	local string prompts[2];
	MalachiIntro.name = "MalachiIntro";
	prompt1 = "blah";
	prompts[0] = prompt1;
	prompt2 = "stuff";
	prompts[1] = prompt2;

	for(i = 0; i < 2; i++)
	{
		MalachiIntro.dialogArray.InsertItem(i,prompts[i]);
	}

}
function array<string> getDialogArray(string arrayName)
{
	local int i;
	for(i = 0; i < TotalDialogs.length; i++)
	{
		if(arrayName == TotalDialogs[i].name)
		{
			return TotalDialogs[i].dialogArray;
		}
	}
	return empty;
}
DefaultProperties
{
	

}
