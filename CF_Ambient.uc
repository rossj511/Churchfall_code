class CF_Ambient extends AmbientSound
	placeable
	ClassGroup(CF_Actors);

function fadeInSound(float duration, float volumeLevel)
{
	self.AudioComponent.FadeIn(duration,volumeLevel);
}
function fadeOutSound(float duration, float volumeLevel)
{
	self.AudioComponent.FadeOut(duration,volumeLevel);
}

function adjustComponentVolume(float timeToBeAtNewVolume, float volumeLevel)
{
	self.AudioComponent.AdjustVolume(timeToBeAtNewVolume,volumeLevel);

}
DefaultProperties
{
	bAutoPlay = false
}
