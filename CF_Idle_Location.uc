class CF_Idle_Location extends PathNode
	placeable
	ClassGroup(CF_Actors);

DefaultProperties
{
		begin Object Class=SpriteComponent Name=CFSprite
	Sprite=Texture2D'EditorResources.PathTarget'
	HiddenGame=true
  end Object
  Components.Add(CFSprite
	Begin Object Name=CollisionCylinder
       CollisionHeight=20.000000
       CollisionRadius=20.00000
    End Object
	bBlockActors=true
    bCollideActors=true
    bHidden=false
    bNoDelete = false
    bStatic = false
}
