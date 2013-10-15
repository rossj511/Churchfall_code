class CF_Journal_Movie extends GFxMoviePlayer;
var bool bIsOpen;
var bool pause_item_text_bool;
var GFxObject journal_text;
//Starts the movie
function Init(optional LocalPlayer LocPlay)
{
        Start();
		SetTimingMode(TM_Real);
		bIsOpen = true;
		GetPC().SetPause(true);
		Advance(0);
		self.AddFocusIgnoreKey('Escape');
}
//Ends movie
function End()
{
	Close();
	GetPC().SetPause(false);
	self.ClearFocusIgnoreKeys();
	bIsOpen = false;
}
function CloseJournal()
{
	End();
}
function Entry1()
{	
	journal_text = self.GetVariableObject("_root.text");
	journal_text.SetText("24th August, 20--\n\n     My Dear Simeon,\n\n     Thank you for your letter asking about visiting the Sanctuary Church on retreat. I am extremely sorry to hear about the recent and tragic death of your wife, Elizabeth: there are few words that one can offer at a time like this, but may I offer my most sincere condolences for your loss, and my prayers for your comfort and support through these dark and troublous times.The Sanctuary Church is happy to welcome all people for stays of a few days up to a month. We are a small community: apart from myself and the three other ministers, there are no longer any permanent clerical staff in residence. A housekeeper comes in every day to prepare a lunch and evening meal for us and our guests and to keep the manse tidy, and apart from the cleaner who attends once a week there is a only a small group of volunteers, mostly from local parishes, who clean the church and tend the grounds. It is thus pleasant for us to receive visitors as much as we");
	//journal_text.SetText("hope our guests shall have a relaxing and reinvigorating retreat here at our small church.I do not know if you have any information about our Sanctuary Church, so I have enclosed one of our leaflets. It has driving instructions, a little about the local towns and a few words about the church itself.Once again, may I offer my deepest sympathy to you at this terrible time. I am glad we are able to offer you a place to begin to find a little of God’s peace in your heart and soul, and my colleagues and I look forward to meeting you.Yours in Christ,Malachi Townes");
}
function Entry1_2()
{	
	journal_text = self.GetVariableObject("_root.text");
	journal_text.SetText("hope our guests shall have a relaxing and reinvigorating retreat here at our small church.I do not know if you have any information about our Sanctuary Church, so I have enclosed one of our leaflets. It has driving instructions, a little about the local towns and a few words about the church itself.Once again, may I offer my deepest sympathy to you at this terrible time. I am glad we are able to offer you a place to begin to find a little of God’s peace in your heart and soul, and my colleagues and I look forward to meeting you.Yours in Christ,Malachi Townes");
}
DefaultProperties
{
	MovieInfo = SwfMovie'CFLetters.Journal';
    bEnableGammaCorrection=false
	bPauseGameWhileActive=true
	bIgnoreMouseInput=false
	bCaptureInput=false
	bIsOpen=false
}
