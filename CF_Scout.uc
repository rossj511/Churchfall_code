class CF_Scout extends Scout;

DefaultProperties
{
	PathSizes.Empty
 /** Clears out any paths that may previously have been
 there. We will be using the size of our pawn as a
 template for how tall and wide our paths should 
 be */
 PathSizes.Add((Desc=Human,Radius=180,Height=330)) 
 NavMeshGen_EntityHalfHeight=165
/** Subtract this from our MaxPolyHeight to get the final 
 height for our NavMesh bounds */
 NavMeshGen_StartingHeightOffset=140
/** This number needs to be larger than the size of your 
 default pawn */ 
 NavMeshGen_MaxPolyHeight=350
}
