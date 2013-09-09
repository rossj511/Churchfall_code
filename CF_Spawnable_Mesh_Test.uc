class CF_Spawnable_Mesh_Test extends DynamicSMActor_Spawnable;
function Destroy_Mesh()
{
	self.Destroy();
}
DefaultProperties
{
	Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'EngineMeshes.Cube'
    End Object
	CollisionComponent=MyMesh 
    Components.Add(MyMesh)
}
