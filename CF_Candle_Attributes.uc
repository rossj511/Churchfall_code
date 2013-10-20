class CF_Candle_Attributes extends Actor;

var float Life;
var float Brightness;
var bool is_burning;
var bool dead;

function Burn()
{
	SetTimer(1,true,'Burning');
}
function Burning()
{
	if(self.Life > 0)
	{
		self.Life-=1;
	}
	else
	{
		self.dead=true;
		//self.Destroy();
	}

}
DefaultProperties
{
	Life = 10.0;
	Brightness = 0.1
	is_burning = false;
	dead=false;
}
