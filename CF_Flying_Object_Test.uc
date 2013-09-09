class CF_Flying_Object_Test extends Pawn
    placeable;


//initialize variables
var() array<Pathnode> Waypoints;

DefaultProperties
{
 Begin Object Name=CollisionCylinder
       CollisionHeight =0.000000
       CollisionRadius=20.00000
 End Object
 CylinderComponent=CollisionCylinder
 Begin Object class=StaticMeshComponent Name=MyMeshy
    StaticMesh=StaticMesh'EngineMeshes.Cube'
 End Object
  CollisionComponent=MyMeshy
  Components.Add(MyMeshy)
   ControllerClass=class'Churchfall.CF_Flying_Object_Test_Controller'
   bCollideActors=true
   bBlockActors=true
   bJumpCapable=true
   bCollideWorld=true
   bCanJump=true
   bNoDelete = false
   bStatic = false
   bPostRenderIfNotVisible=true
   bHidden=true
   GroundSpeed=300.0
}