class CF_RotatorClass extends Object;


function Rotator RotatorSlerp(Rotator a, Rotator b, float f)
{
	return QuatToRotator(QuatSlerp(QuatFromRotator(a), QuatFromRotator(b), f));
}

DefaultProperties
{


}
