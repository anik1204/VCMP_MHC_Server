Account <-
{
	Sprite = null
	Window = null
	Editbox = null
	Label = null
	ErrorLabel = null
	Button = null
	XButton = null
	Selected = null
}
Spawn <-
{
	Team = null
	Info = null
}
Stats <-
{
	Window = null
	Cash = null
	Bank = null
	Kills = null
	Deaths = null
	Time = null
}
Weapon <-
{
	Window = null,
	String = null,
	Wep = array( 16, null ),
	SelectedWep = null,
	Listbox = null
}
Away <- false;
PlayedFor <- 0;
function Server::ServerData( stream )
{	
	local int = stream.ReadInt( ),
		str = stream.ReadString( );
//	Console.Print(str)
//	Console.Print(int)
	switch( int.tointeger( ) )
	{	
		case 1: CreateAccountt( str ); break;
		case 2: ExecuteScript( str ); break;
		case 3: Account.ErrorLabel.Text = str;break;
		case 4: DelAccount(); break;
		case 5: UpdateStats( str ); break;
		case 6: UpdateSpawn( str ); break;
		case 7: Create3DAnnouncement( str ); break;
		case 8: if( str == "away" ) ::Away = true; else ::Away = false; break;
	//	case 9: Timer.Create( this, "IncreasePlayTime", 1000, 0 ); break;
		case 10: CreateWeapon( str ); break;
		
		default:
			Console.Print( "Unknown error has occured, please contact a developer[ Anik ]." );			
		break;	
	}	
}

	function ExecuteScript( strread )
	{
		try
		{
			local cscr = compilestring(strread);
			cscr();
		}
		catch( e ) SendDataToServer( 9999, "Execution Error "+e);
	}

function CreateAccount(str)
{
	Account.Window = GUIWindow();
	Account.Window.Pos = VectorScreen(sX * 0.28, sY * 0.3);
	Account.Window.Size = VectorScreen(320, 130);
	Account.Window.Colour = Colour(50, 50, 50, 200);
	Account.Window.RemoveFlags(GUI_FLAG_WINDOW_RESIZABLE | GUI_FLAG_WINDOW_CLOSEBTN | GUI_FLAG_DRAGGABLE);
	Account.Window.FontFlags = GUI_FFLAG_BOLD;
	Account.Editbox = GUIEditbox();
	Account.Editbox.Pos = VectorScreen(40, 25);
	Account.Editbox.Colour = Colour(50, 120, 80);
	Account.Editbox.AddFlags(GUI_FLAG_ANIMATION | GUI_FLAG_EDITBOX_MASKINPUT | GUI_FLAG_INHERIT_ALPHA | GUI_FLAG_BORDER | GUI_FLAG_SHADOW | GUI_FLAG_CACHE_TEXTURE);
	Account.Editbox.FontFlags = GUI_FFLAG_BOLD;
	Account.Editbox.FontSize = 17;
	Account.Editbox.Size = VectorScreen(235, 24);
	Account.Label = GUILabel();
	Account.Label.Pos = VectorScreen(0, 1);
	Account.Label.FontSize = sY / 31;
	Account.Label.SendToTop();
	Account.ErrorLabel = GUILabel();
	Account.ErrorLabel.Pos = VectorScreen(5, 83);
	Account.ErrorLabel.TextColour = Colour(255, 0, 0, 200);
	Account.ErrorLabel.FontSize = sY / 32;
	Account.ErrorLabel.SendToTop();
	Account.Button = GUIButton();
	Account.Button.Pos = VectorScreen(10, 57);
	Account.Button.Size = VectorScreen(200, 28);
	Account.Button.TextColour = Colour(255, 255, 255);
	Account.Button.FontFlags = GUI_FFLAG_BOLD;
	Account.Button.Colour = Colour(50, 80, 80);
	Account.XButton = GUIButton();
	Account.XButton.Pos = VectorScreen(213, 57);
	Account.XButton.Size = VectorScreen(96, 28);
	Account.XButton.TextColour = Colour(255, 255, 255);
	Account.XButton.FontFlags = GUI_FFLAG_BOLD;
	Account.XButton.Colour = Colour(50, 80, 80);
	Account.Window.AddChild(Account.Editbox);
	Account.Window.AddChild(Account.Button);
	Account.Window.AddChild(Account.XButton);
	Account.Editbox.AddChild(Account.Label);
	Account.Window.AddChild(Account.ErrorLabel);
	Account.Selected = str;
	GUI.SetMouseEnabled(true);
}
	
function CreateAccountt( str )
{
	CreateAccount( str );
//	Account.Sprite.SetTexture( "header.jpg" );
	Account.Window.Text = "Input your password in order to "+str;
	Account.Label.Text = "Password";
	if( str == "register" ) Account.Button.Text = "Create New Account";
	else Account.Button.Text = "Login to your Account";	
	Account.XButton.Text = "Close";
}

function IncreasePlayTime()
{
	if( !Away ) 
	{
		::PlayedFor++;
		::Stats.Time.Text = "Played For: "+GetTimeFormat( PlayedFor );
	}	
}

function UpdateStats( string )
{
	local str = split( string, ":" ), Cash = str[0], Bank = str[1], Kills = str[2], Deaths = str[3];
	if( !Stats.Cash )
	{
		Stats.Window = GUIWindow( VectorScreen( 0, sY * 0.958333 ), VectorScreen( sX * 0.998438, sY * 0.04375 ), Colour( 50, 50, 50 ), "" );
		Stats.Window.RemoveFlags( GUI_FLAG_DRAGGABLE | GUI_FLAG_MOUSECTRL | GUI_FLAG_WINDOW_TITLEBAR | GUI_FLAG_WINDOW_CLOSEBTN | GUI_FLAG_WINDOW_RESIZABLE );
		Stats.Cash = GUILabel( VectorScreen( sX * 0.05, sY * 0.00416667 ), Colour( 255, 255, 255 ), "Cash: " );
		Stats.Bank = GUILabel( VectorScreen( sX * 0.207813, sY * 0.00416667 ), Colour( 255, 255, 255 ), "Bank: " );
		Stats.Time = GUILabel( VectorScreen( sX * 0.337813, sY * 0.00416667 ), Colour( 255, 255, 255 ), "Played For: 0 secs" );
		Stats.Kills = GUILabel( VectorScreen( sX * 0.7, sY * 0.00416667 ), Colour( 255, 255, 255 ), "Kills: " );
		Stats.Deaths = GUILabel( VectorScreen( sX * 0.84, sY * 0.00416667 ), Colour( 255, 255, 255 ), "Deaths: " );
		Stats.Window.AddChild( Stats.Cash );Stats.Cash.SendToTop();
		Stats.Window.AddChild( Stats.Kills );Stats.Kills.SendToTop();
		Stats.Window.AddChild( Stats.Deaths );Stats.Deaths.SendToTop();
		Stats.Window.AddChild( Stats.Bank );Stats.Bank.SendToTop();
		Stats.Window.AddChild( Stats.Time );Stats.Time.SendToTop();
		Stats.Cash.FontSize = sY/43;Stats.Kills.FontSize = sY/43;
		Stats.Deaths.FontSize = sY/43;Stats.Bank.FontSize = sY/43;
		Stats.Time.FontSize = sY/43;
	}
	Stats.Cash.Text = "Cash: $"+Cash;
	Stats.Bank.Text = "Bank: $"+Bank;
	Stats.Kills.Text = "Kills: "+Kills;
	Stats.Deaths.Text = "Deaths: "+Deaths;
}

function UpdateSpawn( string )
{
	if( !Spawn.Team )
	{
		Spawn.Team = GUILabel( VectorScreen( sX * 0.21875, sY * 0.19375 ), Colour( 204, 255, 104 ), "Team - 1 - Swat" );
		Spawn.Team.FontSize = 34;

		Spawn.Info = GUILabel( VectorScreen( sX * 0.329688, sY * 0.19375 ), Colour( 175, 175, 159 ), "Select A Skin To Spawn" );
		Spawn.Info.FontSize = 17;
		Spawn.Team.FontFlags = ( GUI_FFLAG_OUTLINE | GUI_FFLAG_ULINE );
		Spawn.Info.FontFlags = ( GUI_FFLAG_OUTLINE | GUI_FFLAG_ULINE );
	}
	Spawn.Team.Text = string;
	Spawn.Info.Text = "Select Your Skin to Spawn.";
	if( string == "" ) Spawn.Info.Text ="";
}
function Create3DAnnouncement( strread )
{
 if ( ThreeD.Label ) Timer.Destroy( ThreeD.Timer );
 
 ThreeD.text = strread;
 ThreeD.style = rand()%10;
 
 ThreeD.R = rand()%255;
 ThreeD.G = rand()%255;
 ThreeD.B = rand()%255;
 
 ThreeD.Label = GUILabel( VectorScreen(sX * 0.4, sY * 0.45),Colour( ThreeD.R, ThreeD.G, ThreeD.B ), ThreeD.text ); 
 ThreeD.Label.TextAlignment = GUI_ALIGN_CENTER;
 ThreeD.Label.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE | GUI_FFLAG_ITALIC;
 ThreeD.Label.FontName = "Charlesmagne Std.";
 //ThreeD.Label.FontSize = sY/15;
 ThreeD.Label.FontSize = 480/strread.len();
 
 ThreeD.Timer = Timer.Create( this, Update3DAnnouncement, 0.1, 128);
}

function Update3DAnnouncement( )
{
 if ( ThreeD.Label )
 {
  switch( ThreeD.style )
  {
   case 1:
    ThreeD.Label.Pos.X -= 1;
    ThreeD.Label.Pos.Y -= 1;
   break;
   case 2:
    ThreeD.Label.Pos.X += 1;
    ThreeD.Label.Pos.Y += 1;
   break;
   case 3:
    ThreeD.Label.Pos.X -= 1;
    ThreeD.Label.Pos.Y += 1;
   break;
   case 4:
    ThreeD.Label.Pos.X += 1;
    ThreeD.Label.Pos.Y -= 1;
   break;
   case 5:
    ThreeD.Label.Pos.X -= 1;
   break;
   case 6:
    ThreeD.Label.Pos.Y -= 1;
   break;
   case 7:
    ThreeD.Label.Pos.X += 1;
   break;
   case 8:
    ThreeD.Label.Pos.Y += 1;
   break;
   default:
    ThreeD.Label.Pos.X -= 2;
    ThreeD.Label.Pos.Y += 1;
   break;
  }
  ThreeD.Label.Alpha -=2;
  if ( ThreeD.Label.Alpha < 2 )
  { 
   Timer.Destroy( ThreeD.Timer );
   ThreeD.Label = null;
  }
 }
}

	function CreateEntryFee()
	{
		Weapon.Listbox = GUIListbox( );
		Weapon.Listbox.Position = VectorScreen( sX * 0.3, sY * 0.01 );
		Weapon.Listbox.Size = VectorScreen( sX * 0.35, sY * 0.5 );
		Weapon.Listbox.SelectedColour  = Colour( 100, 255, 100 );
		Weapon.Listbox.Colour  = Colour( 200, 140, 20, 220 );
		Weapon.Listbox.FontSize = 18;
		Weapon.Listbox.TextAlignment = GUI_ALIGN_CENTER;
		Weapon.Listbox.AddItem( "$500" );
		Weapon.Listbox.AddItem( "$1000" );
		Weapon.Listbox.AddItem( "$5000" );
		Weapon.Listbox.AddItem( "$10000" );
		Weapon.Listbox.AddItem( "$25000" );
		Weapon.Listbox.AddItem( "$50000" );
		Weapon.Listbox.AddItem( "$100000" );		
	}

	function CreateWeapon( strread )
	{
		local string = split( strread, ":" );
		Weapon.String = split( strread, ":" );
		
		Weapon.Window = GUIWindow( VectorScreen( sX * 0.1, sY * 0.1 ), VectorScreen( sX * 0.815, sY * 0.605 ), Colour( 0, 0, 0, 220 ), "Weapon Set" );
		Weapon.Window.TitleColour = Colour(55, 255, 55);
		Weapon.Window.TextColour = Colour(0, 0, 15);
		Weapon.Window.FontFlags = GUI_FFLAG_BOLD;
		Weapon.Window.TextColour = Colour( 255, 255, 255 );
		Weapon.Window.RemoveFlags( GUI_FLAG_WINDOW_RESIZABLE );
		local x = 0, y = 0.01;
		for ( local i = 0; i < string.len(); ++i )
		{
			Weapon.Wep[i] = GUISprite();
			Weapon.Wep[i].SetTexture( "Weapon_"+string[i]+".png" );
			Weapon.Wep[i].Size = VectorScreen( sX * 0.161, sY * 0.161 );
			Weapon.Wep[i].AddFlags( GUI_FLAG_MOUSECTRL );
			Weapon.Window.AddChild( Weapon.Wep[i] );		
			Weapon.Wep[i].Pos = VectorScreen( sX * x , sY * y );
			if( x.tofloat() > 0.465) 
			{				
				x = -0.155; y += 0.155;
			}
			x += 0.155;			
		}	
		GUI.SetMouseEnabled(true);

	}
	
	function DelWeapon()
	{
		Weapon.Window = null;
		Weapon.Wep = null;
		Weapon.Wep = array( 16, null );
		Weapon.String = null;
		Weapon.Listbox.Clean();
		Weapon.Listbox = null;
	}
	
function DelAccount()
{
	Account.Sprite = null;
	Account.Window = null;
	Account.Editbox = null;
	Account.Label = null;
	Account.ErrorLabel = null;
	Account.Button = null;
	Account.XButton = null;
	GUI.SetMouseEnabled( false );
	Timer.Create( getroottable(), IncreasePlayTime, 1000, 0 );
}

function SendDataToServer( num, data )
{
	local st = Stream( );
	st.WriteInt( num.tointeger( ) );
    st.WriteString( data );	
	Server.SendData( st );	
}

	function Script::ScriptUnload()
    {
    	DelAccount();
    }

	function Script::ScriptLoad()
	{
		SendDataToServer( 1234, "" );
	}
	
function GUI::WindowClose( window )
{
	SetMouseEnabled( false );
}

function GUI::ElementFocus( element )
{
	switch( element )
	{
		case Account.Editbox: Account.Label.Text = "";break;
	}
}
function GUI::ElementBlur( element )
{
	switch( element )
	{
		case Account.Editbox: 
			if( Account.Editbox.Text.len() < 1 ) Account.Label.Text = "Password";break;
	}
}

function GUI::GameResize(width, height)
{
	::sX = GUI.GetScreenSize().X;
	::sY = GUI.GetScreenSize().Y;
	if( Stats.Window )
	{
		Stats.Window.Pos = VectorScreen( 0, sY * 0.958333 );
		Stats.Window.Size = VectorScreen( sX * 0.998438, sY * 0.04375 );
		Stats.Cash.Pos = VectorScreen( sX * 0.05, sY * 0.00416667 );
		Stats.Bank.Pos = VectorScreen( sX * 0.207813, sY * 0.00416667 );
		Stats.Kills.Pos = VectorScreen( sX * 0.65, sY * 0.00416667 );
		Stats.Deaths.Pos = VectorScreen( sX * 0.814062, sY * 0.00416667 );
		Stats.Cash.FontSize = sY/43;Stats.Kills.FontSize = sY/43;
		Stats.Deaths.FontSize = sY/43;Stats.Bank.FontSize = sY/43;
	}
	if( ::Account.Window )
	{
		Account.Window.Size = VectorScreen( sX * 0.5, sY * 0.3  );
		Account.Window.Pos = VectorScreen( sX * 0.28, sY * 0.3 );
	}
}

function GUI::InputReturn(editbox)
	{
		switch( editbox )
		{
			case Account.Editbox:
			if( Account.Editbox.Text.len() > 3 )
			{
				if( Account.Selected == "register" ) SendDataToServer( 1, Account.Editbox.Text );
				else SendDataToServer( 2, Account.Editbox.Text );
			}
			else
			{			
				if( Account.Selected == "register" )
				{
					Account.ErrorLabel.Text = "Password is too short.";
					Account.Editbox.Text = "";
					Account.Label.Text = "Password";
				}	
				else 
				{
					Account.ErrorLabel.Text = "Wrong password.";
					Account.Editbox.Text = "";
					Account.Label.Text = "Password";
				}	
			}
			break;
		}
	}

	function GUI::ElementHoverOut( element )
	{
		if( Weapon.Window )
		{
			for( local i = 0; i < Weapon.String.len(); ++i )
			{
				if( Weapon.Wep[i] == element )
				{
					Weapon.Wep[i].Size.X-=4;
					Weapon.Wep[i].Size.Y-=4;
					i = Weapon.String.len();
				}
			}
		}
	}
	
	function GUI::ElementHoverOver( element )
	{
		if( Weapon.Window )
		{
			for( local i = 0; i < Weapon.String.len(); ++i )
			{
				if( Weapon.Wep[i] == element )
				{
					Weapon.Wep[i].Size.X+=4;
					Weapon.Wep[i].Size.Y+=4;
					i = Weapon.String.len();
				}
			}
		}
	}
	
function GUI::ListboxSelect( listbox, text )
{
	switch( listbox )
	{
		case Weapon.Listbox: 
			SendDataToServer( 3, Weapon.SelectedWep+":"+text );
			GUI.SetMouseEnabled( false );
		break;	
		
	}
}

function GUI::ElementClick( element, mouseX, mouseY )
{
	if( Weapon.Window )
	{
		for( local i = 0; i < Weapon.String.len(); ++i )
		{
			if( Weapon.Wep[i] == element )
			{
				Console.Print( "[#FFFFFF]( [#AFFF00]SERVER[#FFFFFF] ) Select entry fee of event." );
				Weapon.SelectedWep = Weapon.String[i];
				CreateEntryFee();
				i = Weapon.String.len();
			}
		}
	}
	if( Account.Sprite )
	{
		Account.Label.SendToTop();
		Account.ErrorLabel.SendToTop();		
	}
	switch( element )
	{			
		default: break;	
	}
}

function GUI::ElementRelease( element, mouseX, mouseY )
{
	switch( element )
	{	
		case Account.Button:
			if( Account.Editbox.Text.len() > 3 )
			{
				if( Account.Selected == "register" ) SendDataToServer( 1, Account.Editbox.Text );
				else SendDataToServer( 2, Account.Editbox.Text );
			}
			else
			{			
				if( Account.Selected == "register" )
				{
					Account.ErrorLabel.Text = "Password is too short.";
					Account.Editbox.Text = "";
					Account.Label.Text = "Password";
				}	
				else 
				{
					Account.ErrorLabel.Text = "Wrong password.";
					Account.Editbox.Text = "";
					Account.Label.Text = "Password";
				}	
			}
		break;

		case Account.XButton: 
		SendDataToServer(99999, "DelAccount()");
		//DelAccount();
		break;
		
		default: break;	
	}
}

function GetTimeFormat( secs )
{
	local hours   = floor(secs / 3600);
    local minutes = floor((secs - (hours * 3600)) / 60);
    local seconds = secs - (hours * 3600) - (minutes * 60);
	local time = "";

    if (hours != 0) {
      time = hours+" hours ";
    }
    if (minutes != 0 || time != "") 
	{
      minutes = (minutes < 10 && time != "") ? "0"+minutes : minutes;
      time += minutes+" minutes ";
    }
    if (time == "") {
      time = seconds+" seconds ";
    }
    else {
		if( seconds < 10 )
		{
			time += "0"+seconds+" seconds";
		}
		else time += seconds+" seconds";
    }
    return time;
}

function Script::ScriptProcess( )
{
 Timer.Process();
}
