/*

	MHC | ManHunt City Server
	By Anik

*/

/* ============== Constants Start ============== */
const Creator 		= "Anik";
const Credits		= "";
const ServerIP 		= "51.255.193.118:8200";
const Forum			= "Coming Soon";

const ICOL_WHITE    = "\x000300";
const ICOL_BLACK    = "\x000301";
const ICOL_BLUE     = "\x000302";
const ICOL_GREEN    = "\x000303";
const ICOL_RED      = "\x000304";
const ICOL_BROWN    = "\x000305";
const ICOL_PURPLE   = "\x000306";
const ICOL_ORANGE   = "\x000307";
const ICOL_YELLOW   = "\x000308";
const ICOL_LGREEN   = "\x000309";
const ICOL_CYAN     = "\x000310";
const ICOL_LCYAN    = "\x000311";
const ICOL_LBLUE    = "\x000312";
const ICOL_PINK     = "\x000313";
const ICOL_GREY     = "\x000314";
const ICOL_LGREY    = "\x000315";
const ICOL          = "\x0003";
const ICOL_BOLD     = "\x0002";
const ICOL_ULINE    = "\x0031";

const RED 			= "[#FF0000]";
const SKY 			= "[#77FFCB]";
const SKYD 			= "[#00FF7C]";
const PINK 			= "[#FF1493]";
const LPINK 		= "[#FF00C0]";
const LPURPLE		= "[#C400FF]";
const LGREEEN		= "[#00FFBC]";
const LCUSTOM 		= "[#00FCFF]";
const ORANGE 		= "[#FF8C00]";
const YELLOW 		= "[#FFD700]";
const PURPLE 		= "[#9400D3]";
const LGREEN 		= "[#32CD32]";
const GREEN			= "[#008000]";
const DGREEN		= "[#006400]";
const BLUE			= "[#0000FF]";
const DBLUE 		= "[#00008B]";
const LBLUE 		= "[#1A6EFF]";
const BROWN 		= "[#8B4513]";
const WHITE			= "[#FFFFFF]";
const BLACK 		= "[#000000]";
const GREY			= "[#BDBDBD]";
const MSG 			= "[#AFFF00]";

const PROTECTION_TIME = 5;

/* ============== Constants End ============== */

/* ============== Class ============== */

class PlayerInfo
{
	/* Booleans */
	
	Registered	=	false;
	LoggedIn	=	false;
	Nogoto		=	"off";
	AutoLogin	=	false;
	Away 		=	false;
	
	/* NULL */
	
	Password 	=	null;
	UID 		=	null;
	IP		 	=	null;
	LastPos	 	=	Vector( 0, 0, 0 );
	
	/* Integers */
	
	Level	=	0;
	Kills	=	0;
	Deaths	=	0;
	Cash	=	0;
	Bank	=	0;
	LogTime	=	0;
	LastJoin =	0;
	AFKfor	 =	0;
	SProtection	= 0;
	KillingSpree =	0;
	
}

class Pickups
{
	Model = null;
	Interior = 0;
	Name = null;
	Label = null;
	Cost = null;
	Owner = "None";
	Shared = "None";
	Locked = 0
}

Event <-
{
	Type	=	null
	Wep		=	null
	EntryFee=	0
	Started	=	false
	Players	=	[ ]
	TotalFee	=	0
	StartingIn	=	0
}

function onScriptLoad( )
{
	/* ============== Arrays ============== */
	stats <- array( GetMaxPlayers(), null );
	i_Height <- array( GetMaxPlayers(), null );
	SpawnwepPlayer <- array( GetMaxPlayers(), null );
	pickups <- array( 1000, null );	
	
	/* ============== Tables ============ */
	wepPickups <- {};
	
	/* ============== Variables ============ */
	
	BASE16_TABLE <- "0123456789ABCDEF";
	
	/* ============== Database ============== */
	
	db <- mysql_connect( "192.168.42.237", "MHC", "UidnRepeXjTDBqQS", "MHC" );
	if( db ) print( "Succesfully connected to database" );
	
	/* ============== Creating Tables in Database ============== */
	//mysql_query( db, "CREATE TABLE IF NOT EXISTS mhc_accounts( ID INTEGER, Name TEXT, NameLower TEXT, IP VARCHAR( 255 ), UID VARCHAR( 255 ), Password VARCHAR( 255 ), Level INTEGER, Kills INTEGER, Deaths INTEGER, Cash INTEGER, Bank INTEGER, AutoLogin BOOL DEFAULT true, LoggedIn BOOL DEFAULT false, DateRegistered VARCHAR( 255 ), LastJoin INTEGER, nogoto VARCHAR( 4 ) DEFAULT 'off', PASS VARCHAR( 255 ) )");
	mysql_query( db, "CREATE TABLE IF NOT EXISTS spawnwep( Nick TEXT, Weps TEXT)");
	mysql_query( db, "CREATE TABLE IF NOT EXISTS invalidnicks( Name TEXT )");
	mysql_query( db, "CREATE TABLE IF NOT EXISTS clans( Name TEXT, Tag TEXT, Car INTEGER, Kills INTEGER, Deaths INTEGER, Cash INTEGER )" );
	mysql_query( db, "CREATE TABLE IF NOT EXISTS clan_members( Tag TEXT, Members VARCHAR( 255 ) )");
	mysql_query( db, "CREATE TABLE IF NOT EXISTS clan_leaders( Tag TEXT, Leaders VARCHAR( 255 ) )");
	
	/* ============== Loading Files ============== */
	
	dofile( "scripts/Functions.nut", true );
	dofile( "scripts/clientside.nut", true );
	dofile( "scripts/Commands.nut", true );
	dofile( "scripts/MHC_Echo.nut", true );
	dofile( "scripts/Automsg.nut", true );
	print( "Succesfully Loaded all Files." );
	
	/* ============== Execute Functions ============ */
	
	LoadClass(); // Loading Classes
	LoadBot(); // Connecting bots to irc 
	LoadPickups(); // Loading Pickups
	LoadVehicles(); // Loading Vehicles
	AutoMsg(); // Sending the first message
	NewTimer( "AutoMsg", 45000, 0 );
	print( "Succesfully Executed all Functions.." );
}

function onScriptUnload( )
{
	if( GetPlayers() > 0 )
	{
		for( local i = 0; i < GetMaxPlayers(); ++i )
		{
			local player = FindPlayer(i);
			if(	player )
			{
				onPlayerPart( player, 111 );
			}
		}
	}
	mysql_close( db );
}


function onClientScriptData( player )
{
		local StreamReadInt = Stream.ReadInt( ),
			  StreamReadString = Stream.ReadString( );
			  
		switch( StreamReadInt )
		{
			case 1:
			
				local text = mysql_escape_string( db, StreamReadString );
				if ( text != player.Name )
				{
					SendDataToClient(player, 4, null );
					RegisterP( player, text );
					SendDataToClient( player, 2, "::PlayedFor = "+stats[ player.ID ].LogTime );
				}
				else SendDataToClient(player, 3, "You cannot use your name as your password!" );
			
			break;
			
			case 2:
			
				local text = mysql_escape_string( db, StreamReadString );
				if ( !text || text == "" ) SendDataToClient(player, 3, "Wrong Password." );
				else if ( SHA256(text) != stats[ player.ID ].Password ) SendDataToClient(player, 3, "Wrong password." );
				else
				{
					SendDataToClient( player, 4, null );					
					LoginP( player );
					SendDataToClient( player, 2, "::PlayedFor = "+stats[ player.ID ].LogTime );
				}
			
			break;
			
			case 3: //Event
				SendDataToClient( player, 2, "DelWeapon()" );
				if( Event.Type == null )
				{
					if( GetPlayers() > 0 )
					{
						local data = split( StreamReadString, ":" ), cash = data[1].slice(1, data[1].len() );
						if( GetCash( player ) >= cash.tointeger() || GetBank( player ) >= cash.tointeger() )
						{
							 StartEvent( player, data[ 0 ].tointeger(), cash.tointeger() );
							 Event.StartingIn = 0;
						}
						else ErrorMessage( "You don't have $"+cash+" in your pocket / bank.", player );
					}
					else ErrorMessage( "Need at least 3 players to start the event. Invite your friends to start an event.", player );
				}	
				else ErrorMessage( "There is already a "+Event.Type+" event going on. Use /joinevent to join the event", player );
			break;
			
			case 9999: print( StreamReadString );
			MessagePlayer( StreamReadString+"!", player ); break;
			case 99999: SendDataToClient(player, 2, StreamReadString );break;
		
			case 1234:
				local text = StreamReadString;
				UpdateStats( player, stats[ player.ID ].Cash+":"+stats[ player.ID ].Bank+":"+stats[ player.ID ].Kills+":"+stats[ player.ID ].Deaths );
			default: break;
		
		}

}


function onPlayerJoin( player )
{
	i_Height[player.ID] = 500;
	local country = geoip_country_name_by_addr( player.IP ), country_code = geoip_country_code_by_addr( player.IP )
	if( player.IP == "127.0.0.1" ) country = "Localhost", country_code = "Lh";
	
	Message( WHITE+"( "+MSG+"JOIN"+WHITE+" ) " +  player.Name + " is connecting from [ "+MSG+"" + country + ", " + country_code + ""+WHITE+" ]" );
	EchoMessage( ICOL_BLACK+"( "+ICOL_GREEN+"JOIN"+ICOL_BLACK+" ) " +  player.Name + " is connecting from [ "+ICOL_RED+"" + country + ", " + country_code + ""+ICOL_BLACK+" ]" );
	InvalidNick( player );
	stats[ player.ID ] = PlayerInfo( );
	AccInfo( player );
	LoadSpawnwep(player);		
}

function onPlayerPart( player, reason )
{	
	local Text = "Unknown / Crashed";
	switch ( reason )
	{
		case PARTREASON_DISCONNECTED:
			Text = "Quit";
		break;
		case PARTREASON_TIMEOUT:
			Text = "Timeout";
		break;
	    case PARTREASON_KICKED:
			Text = "Kicked";
		break;
		case PARTREASON_KICKEDBANNED:
			Text = "Banned"
		break;
		case PARTREASON_BANNED:
			Text = "Banned";
		break;
		case 111:
			Text = "Shutting down server";
		break;
	}
	if( Text == "Kicked" ) return 0;
	Message( WHITE+"( "+RED+"PART"+WHITE+" ) " +  player.Name + " has left the server ( " + Text + " )" );
	EchoMessage( ICOL_BLACK+"( "+ICOL_RED+"PART"+ICOL_BLACK+" ) " +  player.Name + " has left the server ( " + Text + " )" );
	if( stats[ player.ID ].LoggedIn ) SaveStats( player );
	if (SpawnwepPlayer[ player.ID ] != null) 
	{
		if(!CheckTableSpawnwep( player )) mysql_query( db, "REPLACE INTO Spawnwep( Nick, Weps ) VALUES ( '" + player.Name + "','"+ SpawnwepPlayer[ player.ID ] + "' ) ");
		else mysql_query( db, "UPDATE Spawnwep SET Weps='"+ SpawnwepPlayer[ player.ID ] +"' WHERE Nick='" + player.Name + "'" );
		SpawnwepPlayer[ player.ID ] = null;
	}
	if( Event.Type )
	{
		EventWinner( player );
	}
}	


function onPlayerRequestClass(player, classID, team, skin)
{
	if( i_Height[ player.ID ] != 500 ) return 0;
		switch (skin)
		{
			case 2:
				{
					SendDataToClient( player, 7, "Team - 1 - Swat" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 3:
				{

					SendDataToClient( player, 7, "Team - 1 - FBI" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 4:
				{
					SendDataToClient( player, 7, "Team - 1 - Army" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 102:
				{

					SendDataToClient( player, 7, "Team - 2 - Undercover #1" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 103:
				{

					SendDataToClient( player, 7, "Team - 2 - Undercover #2" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 104:
				{

					SendDataToClient( player, 7, "Team - 2 - Undercover #3" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 117:
				{

					SendDataToClient( player, 7, "Team - 3 - Girl #1" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 143:
				{
					SendDataToClient( player, 7, "Team - 3 - Girl #2" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 157:
				{
					SendDataToClient( player, 7, "Team - 3 - Girl #3" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 180:
				{
					SendDataToClient( player, 7, "Team - 4 - Vercetty #1" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 147:
				{
					SendDataToClient( player, 7, "Team - 4 - Vercetty #2" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 146:
				{
					SendDataToClient( player, 7, "Team - 4 - Vercetty #3" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 93:
				{
					SendDataToClient( player, 7, "Team - 5 - Bike #1" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 94:
				{
					SendDataToClient( player, 7, "Team - 5 - Bike #2" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 51:
				{
					SendDataToClient( player, 7, "Team - 5 - Bike #3" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 140:
				{
					SendDataToClient( player, 7, "Team - 6 - Cool #1" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 46:
				{
					SendDataToClient( player, 7, "Team - 6 - Cool #2" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 158:
				{
					SendDataToClient( player, 7, "Team - 7 - Citizen #1" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 5:
				{
					SendDataToClient( player, 7, "Team - 7 - Citizen #2" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 6:
				{
					SendDataToClient( player, 7, "Team - 7 - Citizen #3" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 61:
				{
					SendDataToClient( player, 7, "Team - 7 - Citizen #4" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 62:
				{
					SendDataToClient( player, 7, "Team - 8 - Citizen #1" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 76:
				{
					SendDataToClient( player, 7, "Team - 8 - Citizen #2" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
			case 77:
				{
					SendDataToClient( player, 7, "Team - 8 - Citizen #3" );
					player.SetAnim(155);
					PlaySound(player.UniqueWorld, 335, player.Pos);
				}
				break;
		}
	player.Angle = 1;
	return 1;
}

function onPlayerChat( player, text )
{
	local newtext = text.tolower();
	local firstchar = GetFirstChar( text );
	if( firstchar != null )
	{
		if( NeedsQuestionMark( newtext ) == 1 )
		{
			local len = text.len();
			local stext = newtext.slice( 1, len );
			local formattedtext = player.Name + "" + WHITE + ": " + firstchar.toupper() + stext + "";
			ClientMessageToAll( formattedtext+"", player.Colour.r, player.Colour.g ,player.Colour.b );
			EchoMessage (  ICOL_BOLD+ICOL_BROWN+player.Name + "" + ICOL_BLACK + ": " + firstchar.toupper() + stext + "" );
			return 0;
		}
		else if( NeedsQuestionMark( newtext ) == 2 )
		{
			local len = text.len();
			local stext = newtext.slice( 1, len );
			local formattedtext = ""+ player.Name + "" + WHITE + ": " + firstchar.toupper() + stext + "?";
			ClientMessageToAll( formattedtext+"", player.Colour.r, player.Colour.g ,player.Colour.b );
			EchoMessage (  ICOL_BOLD+ICOL_BROWN+player.Name + "" + ICOL_BLACK + ": " + firstchar.toupper() + stext + "?" );
			return 0;
		}
		else if( NeedsQuestionMark( newtext ) == 3 )
		{
			local len = text.len();
			local stext = newtext.slice( 1, len );
			local formattedtext = player.Name + "" + WHITE + ": " + firstchar.toupper() + stext;
			ClientMessageToAll( formattedtext+"", player.Colour.r, player.Colour.g ,player.Colour.b );
			EchoMessage (  ICOL_BOLD+ICOL_BROWN+player.Name + "" + ICOL_BLACK + ": " + firstchar.toupper() + stext );
			return 0;
		}
	}
	else return 1;
}

function onPlayerAwayChange( player, newStatus )
{
	stats[ player.ID ].Away = newStatus;
	if( newStatus == true ) SendDataToClient( player, 8, "away" );
	else SendDataToClient( player, 8, "back" );
}

function onPlayerTeamKill( killer, player, reason, bodypart )
{
	ClientMessageToAll( "( "+RED+"Team Kill"+WHITE+" ) " + killer.Name + " has killed " + player.Name + " ( " + MSG+GetWeaponName( reason )+WHITE + " ) ( " + MSG+GetBodypartName( bodypart )+WHITE + " )", 255, 255, 255)
	EchoMessage( "( "+ICOL_RED+"Team Kill"+ICOL_BLACK+" ) " + ICOL_BOLD+killer.Name + " has killed " +ICOL_BOLD+ player.Name + " ( "+ICOL_RED+"" + GetWeaponName( reason ) + ""+ICOL_BLACK+" ) ( "+ICOL_RED+"" + GetBodypartName( bodypart ) + ""+ICOL_BLACK+" )" );
	local death = stats[ player.ID ].Deaths+1, kills = stats[ killer.ID ].Kills+1;
	SetDeaths( player, death );
	SetKills( killer, kills );
	EndKillingSpree(player,killer);
	stats[ killer.ID ].KillingSpree = 0;
	if( stats[ killer.ID ].Cash >= 300 ) SetCash( killer, stats[ killer.ID ].Cash - 300 );
	else if( stats[ killer.ID ].Bank >= 300 ) SetBank( killer, stats[ killer.ID ].Bank - 300 );
	if( Event.Type )
	{
		EventWinner( player );
	}
	SendDataToClient( player, 8, "away" );
}

function onPlayerKill( killer, player, reason, bodypart )
{
	ClientMessageToAll( "( "+RED+"Kill"+WHITE+" ) " + killer.Name + " has killed " + player.Name + " ( " + MSG+GetWeaponName( reason )+WHITE + " ) ( " + MSG+GetBodypartName( bodypart )+WHITE + " )", 255, 255, 255)
	EchoMessage( "( "+ICOL_RED+"Kill"+ICOL_BLACK+" ) " + ICOL_BOLD+killer.Name + " has killed " +ICOL_BOLD+ player.Name + " ( "+ICOL_RED+"" + GetWeaponName( reason ) + ""+ICOL_BLACK+" ) ( "+ICOL_RED+"" + GetBodypartName( bodypart ) + ""+ICOL_BLACK+" )" )
	local death = stats[ player.ID ].Deaths+1, kills = stats[ killer.ID ].Kills+1;
	SetDeaths( player, death );
	SetKills( killer, kills );
	IncPlayerSpree(killer, 1);
	StartKillingSpree(killer);
	EndKillingSpree(player,killer);
	if (GetPlayerSpree(player) >= 1) DecPlayerSpree(player,GetPlayerSpree(player));
	CreatePlayerWeaponPickups( player );
	SetCash( killer, stats[ killer.ID ].Cash + 300 );
	AnimatedAnnounce( killer, "Reward for killing: $300" );
	if( stats[ player.ID ].Cash >= 250 ) SetCash( killer, stats[ killer.ID ].Cash - 250 );
	else if( stats[ player.ID ].Bank >= 250 ) SetBank( killer, stats[ killer.ID ].Bank - 250 );
	AnimatedAnnounce( player, "Lost for dying: $250" );
	if( bodypart == 6 )
	{
		AnimatedAnnounce( killer, "Reward for killing: $300 + $500 bonus for Headshot!" );
		SetCash( killer, stats[ killer.ID ].Cash + 500 );
	}
	if( Event.Type )
	{
		EventWinner( player );
	}
	local tag = FindPlayersClan( player );
	if( tag != "none" ) 
	{
		if( ClanRegistered( tag ) ) SetClanDeaths( tag, GetClanDeaths( tag )+1 );
	}
	local tagg = FindPlayersClan( killer );
	if( tagg != "none" ) 
	{
		if( ClanRegistered( tagg ) ) SetClanKills( tagg, GetClanKills( tagg )+1 );
	}
	SendDataToClient( player, 8, "away" );
}

function onPlayerDeath( player , reason )
{
	Message("[#FFFFFF]( [#FF0000]Death[#FFFFFF] ) "+player.Name+" has been found dead in "+GetDistrictName( player.Pos.x, player.Pos.y )+"!");
	local death = stats[ player.ID ].Deaths+1;
	SetDeaths( player, death );
	EndKillingSpree(player,255);
    if (GetPlayerSpree(player) >= 1) DecPlayerSpree(player,GetPlayerSpree(player));
	if( stats[ player.ID ].Cash >= 150 ) SetCash( player, stats[ player.ID ].Cash - 150 );
	else if( stats[ player.ID ].Bank >= 150 ) SetBank( player, stats[ player.ID ].Bank - 150 );
	AnimatedAnnounce( player, "Lost for dying: $150" );
	if( Event.Type )
	{
		EventWinner( player );
	}
	local tag = FindPlayersClan( player );
	if( tag != "none" ) 
	{
		if( ClanRegistered( ClanAlias(tag) ) ) SetClanDeaths( ClanAlias(tag), GetClanDeaths( ClanAlias(tag) )+1 );
	}
	SendDataToClient( player, 8, "away" );
}

function onPlayerRequestSpawn( player )
{
	if( !stats[ player.ID ].Registered ) ErrorMessage( "You need to register first!", player );
	else if( !stats[ player.ID ].LoggedIn ) ErrorMessage( "You need to login first!", player );
	else if( i_Height[player.ID] == 500 ) GTAVSpawn ( player , player.Pos );
	return 0;
}

function onPlayerSpawn( player )
{
	player.World = 1;
	EMessage( player.Name + " has spawned at "+ICOL_BOLD+ GetDistrictName( player.Pos.x, player.Pos.y ) );
	EMessagePlayer( "Anti-Spawnkill is on for 5 seconds.", player );
	stats[ player.ID ].SProtection = (time() + PROTECTION_TIME);
	// SendDataToClient( player, 7, "" );
	GiveSpawnwep(player);
	player.RestoreCamera();
	SendDataToClient( player, 8, "back" );
}

function onPlayerEnterVehicle( player, vehicle, door )
{
	local q = mysql_query( db, "SELECT * FROM vehicles WHERE rowid = '" + player.Vehicle.ID + "'" ), data = mysql_fetch_assoc( q );
	local qq = mysql_query( db, "SELECT * FROM vehiclecost WHERE Name = '" + GetVehicleNameFromModel( vehicle.Model ) + "'" ), dataa = mysql_fetch_assoc( qq );
	
	if( data[ "Owner" ] == "MHC Staff" ) MessagePlayer( WHITE+"( " + YELLOW + "MHC Service " + WHITE + ") You have entered in "+MSG+GetVehicleNameFromModel( player.Vehicle.Model ), player );
	else if ( data[ "Owner" ] == player.Name ) MessagePlayer( WHITE+"( " + YELLOW + "Vehicle " + WHITE + ") You have entered in your "+MSG+GetVehicleNameFromModel( player.Vehicle.Model ), player );
	else if( data[ "Owner" ] == "None" ) MessagePlayer( WHITE+"( " + YELLOW + "Vehicle " + WHITE + ") You have entered in "+MSG+GetVehicleNameFromModel( player.Vehicle.Model )+WHITE+"; Price: "+MSG+dataa["Cost"]+WHITE+"; Forsale: "+MSG+"YES", player );
	else MessagePlayer( WHITE+"( " + YELLOW + "Vehicle " + WHITE + ") You have entered in "+MSG+data["Owner"]+WHITE+"'s "+MSG+GetVehicleNameFromModel( player.Vehicle.Model )+WHITE+"; Shared With: "+MSG+data["Shared"]+"", player );
	
	mysql_free_result( q );
	mysql_free_result( qq );
}

function onPlayerExitVehicle( player, vehicle, )
{
	local vehname = GetVehicleNameFromModel( vehicle.Model );
    ClientMessage ( "You've exited the " + vehname + ".", player,255,255,255);
}	 

function onPlayerHealthChange(player, OldHP, NewHP)
{
	if ( stats[ player.ID ].SProtection > time() )
	{
		player.Health = OldHP;
	}
}

function onPickupPickedUp( player, pickup )
{
		//PlaySound( player.UniqueWorld , 50000 , player.Pos );
		if ( stats[ player.ID ].Registered == true )
		{		
			if ( stats[ player.ID ].LoggedIn == true )
			{				
				switch( pickup.Model )
				{
					case 406:
					
						 local
							Name 		= 	pickups[pickup.ID].Label,
							Owner		=	pickups[pickup.ID].Owner,
							Shared		=	pickups[pickup.ID].Shared,
							Label		=	pickups[pickup.ID].Label,
							Cost		=	pickups[pickup.ID].Cost;
						
						if ( Label != "None" ) Name = Label;
						else Name = pickups[pickup.ID].Name;
						ClientMessage( "- " + Name + " -", player, 51, 171, 255 );
						if ( Owner != "None" ) ClientMessage( "House ID: " + pickup.ID + " - Owner:[ " + Owner + " ] - Shared:[ " + Shared + " ].", player, 51, 171, 255 );
						else ClientMessage( "ID: " + pickup.ID + " - Cost: $" + Cost + ".", player, 51, 171, 255 );
					
					break;
					
					default: break;
				}
			}
		}
}		

function onPickupClaimPicked( player, pickup )
{
 if ( player.Health > 0 && wepPickups.rawin( pickup.ID ) )
 {
  PlaySound( player.UniqueWorld, 78, player.Pos );

  wepPickups.rawdelete( pickup.ID );
  pickup.Remove();

  return 1;
 }

 return 1;
}

function onTimeChange( lasthour, lastmin, newhour, newmin )
{
	if( GetPlayers() > 0 )
	{
		if( Event.Type && !Event.Started )
		{
			Event.StartingIn++;
			if( Event.StartingIn > 59 )
			{
				if( Event.Players.len() > 2 )
				{
					foreach( val in Event.Players )
					{
						FindPlayer(val).CanAttack = true;
						ClientMessageToAll( "( "+RED+"Event"+WHITE+" ) The event has started, the last survived player will get the total fee of event $"+Event.TotalFee+" as a reward.", 255, 255, 255);				
						EchoMessage( "( "+ICOL_RED+"Event"+ICOL_BLACK+" ) The event has started, the last survived player will get the total fee of event $"+Event.TotalFee+" as a reward." );
						Event.Started = true;
					}
				}
				else
				{
					ClientMessageToAll( "( "+RED+"Event"+WHITE+" ) The event has been stopped due to lack of players.", 255, 255, 255);				
					EchoMessage( "( "+ICOL_RED+"Event"+ICOL_BLACK+" ) The event has been stopped due to lack of players." );					
					foreach( val in Event.Players )
					{
						local plr = FindPlayer( val );
						SetCash( plr, stats[ plr.ID ].Cash + Event.EntryFee );
						plr.World = 1;
						plr.CanAttack = true;
						plr.Pos = stats[ plr.ID ].LastPos;
						Event.Type = null;
						Event.Wep = null;
						Event.Started = false;
						Event.EntryFee = 0;
						Event.TotalFee = 0;
						Event.Players = [ ];
						Event.StartingIn = 0;
					}						
				}
			}
		}
		for( local i = 0; i < GetMaxPlayers(); ++i )
		{
			local player = FindPlayer(i);
			if(	player )
			{
				stats[ player.ID ].AFKfor++
				if( stats[ player.ID ].AFKfor > 120 ) 
				{					
					if( !stats[i].Away )
					{
						EMessage( player.Name+" has been set auto away. Reason : No activity since 2 minutes" );
						stats[i].Away = true;
						SendDataToClient( player, 8, "away" );
					}
				}	
				if( player.IsSpawned )
				{
					if( !stats[i].Away )
					{
						if( stats[ i ].LoggedIn )
						{
							stats[ i ].LogTime++;
						}	
					}
				}
			}
		}
	}
}