class CF_particle_trigger_test extends Trigger;
/*
Test  Particle Emmiting Trigger class for Churchfall(working title)
DangerZone Games: James Ross (jross.rpi@gmail.com)
Date : 09/08/2013
All code (c)2013 DangerZone Games inc. all rights reserved
*/ 
var ParticleSystem flame;
var ParticleSystemComponent flame_emitter;
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
	super.Touch(Other, OtherComp, HitLocation, HitNormal);

	if (Pawn(Other) != none)
	{
		flame_emitter = WorldInfo.MyEmitterPool.SpawnEmitter(flame, self.location);
	}
}
//Untouch event 
event UnTouch(Actor Other)
{

	super.UnTouch(Other);

	if (Pawn(Other) != none)
	{
		flame_emitter.DeactivateSystem();
	}
}
DefaultProperties
{
	 Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
	
    Begin Object Name=CollisionCylinder
       CollisionHeight =40.000000
       CollisionRadius=20.00000
    End Object
    CylinderComponent=CollisionCylinder
	    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'CFParticles.Mesh.Barrel'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	bBlockActors=true
    bCollideActors=true
    bHidden=false
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=true
	flame = ParticleSystem'CFParticles.Particles.fire_effect'
}
