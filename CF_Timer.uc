class CF_Timer extends Actor
placeable;
var float rate;
event PostBeginPlay()
{
	`log("Timer is Here");
	SetTimer(rate);
}

function Timer()
{
	//Stuff to do 
}

DefaultProperties
{
	bBlockActors=false
    bCollideActors=false
    bHidden=true
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=false
	rate = 3.0
}
