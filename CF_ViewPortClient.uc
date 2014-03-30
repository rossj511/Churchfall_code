class CF_ViewPortClient extends GameViewPortClient;



var Texture2D BackgroundImages[2];
var Texture2D background;
var LinearColor BackgroundColor;


function DrawTransition(Canvas Canvas)
{
    local string MapName;
    local int Pos;

    switch(Outer.TransitionType)
    {
        case TT_Loading:
            MapName = Outer.TransitionDescription;
            /* Remove .udk from map */
            Pos = InStr(MapName,".");
            if (Pos != -1)
            {
                MapName = left(MapName, Pos);
            }
            DrawImageTransitionMessage(Canvas,MapName);
            break;
		case TT_Saving:
			DrawTransitionMessage(Canvas,MapName);
			break;
		case TT_Connecting:
			DrawTransitionMessage(Canvas,MapName);
			break;
		case TT_Precaching:
			DrawTransitionMessage(Canvas,MapName);
			break;
		case TT_Paused:
			DrawTransitionMessage(Canvas,MapName);
			break;
    }
}

function DrawImageTransitionMessage(Canvas Canvas,string Message)
{
	local int i;
	i = Rand(1);
    /* Draw the texture on screen */
    Canvas.SetPos(0,0);
	Background=BackgroundImages[i];
    Canvas.DrawTile(Background, Canvas.ClipX, Canvas.ClipY, 0, 0, Background.SizeX, Background.SizeY, BackgroundColor);  
}
DefaultProperties
{
    BackgroundColor=(R=1.0,G=1.0,B=1.0,A=1.0)
	BackgroundImages[0]=Texture2D'CFLoadingScreen.Textures.Image1'
    BackgroundImages[1]=Texture2D'CFLoadingScreen.Textures.Image2'