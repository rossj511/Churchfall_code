class CF_Spawn_Any_Mesh_Trigger extends Trigger;

var() const editconst DynamicLightEnvironmentComponent LightEnvironment;
var() StaticMeshComponent Mesh;
var StaticMeshComponent trigger_mesh;
var bool spawned;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
	super.Touch(Other, OtherComp, HitLocation, HitNormal);

	if (Pawn(Other) != none && spawned == false)
	{
		self.SetHidden(false);
		trigger_mesh.SetStaticMesh(Mesh.StaticMesh);
		spawned = true;
	}
}

DefaultProperties
{
	Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
	
    Begin Object Name=CollisionCylinder
       CollisionHeight=10.000000
       CollisionRadius=50.00000
    End Object
    CylinderComponent=CollisionCylinder

	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bSynthesizeSHLight=true
		bIsCharacterLightEnvironment=true
		bUseBooleanEnvironmentShadowing=false
		bEnabled=true
	End Object
	Components.Add(MyLightEnvironment)
	Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'EngineMeshes.Cube'
	   LightEnvironment=MyLightEnvironment
	   Translation=(X=0.000000,Y=0.000000,Z=0.000000)
	   Rotation=(Pitch=10240,Roll=0,Yaw=0)
    End Object
    CollisionComponent=MyMesh
    Components.Add(MyMesh)
	trigger_mesh = MyMesh
	bBlockActors=true
    bCollideActors=true
    bHidden=true
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=true
	spawned = false
}
