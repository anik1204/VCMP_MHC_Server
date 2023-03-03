function LoadVehicles()
{
	local start = clock();
	local q4 = mysql_query(db, "SELECT Model, Position, Angle, Col1, Col2, Parked, rowid FROM vehicles"), splitPos, x, y, z, splitPark, px, py, pz, ax, ay, az
	local q5;
	local i = 0;
	while (q5 = mysql_fetch_row(q4))
	{
		//mysql_query( db, "UPDATE vehicles SET rowid = "+i+" WHERE Position="+q5[5]+"");
		local model = q5[0];
		splitPos = split(q5[1], ", ");
		x = splitPos[0];
		y = splitPos[1];
		z = splitPos[2];
		local Angle = q5[2];
		local Col1 = q5[3];
		local Col2 = q5[4];
		CreateVehicle(model.tointeger(), 0, Vector(x.tofloat(), y.tofloat(), z.tofloat()), Angle.tofloat(), Col1.tointeger(), Col2.tointeger());
		if (q5[5] != "N")
		{
			splitPark = split(q5[5], ", ");
			px = splitPark[0];
			py = splitPark[1];
			pz = splitPark[2];
			ax = splitPark[3];
			ay = splitPark[4];
			az = splitPark[5];
			FindVehicle(i).SpawnPos = Vector(px.tofloat(), py.tofloat(), pz.tofloat());
			FindVehicle(i).Pos = Vector(px.tofloat(), py.tofloat(), pz.tofloat());
			FindVehicle(i).EulerSpawnAngle = Vector(ax.tofloat(), ay.tofloat(), az.tofloat());
			FindVehicle(i).EulerAngle = FindVehicle(i).EulerSpawnAngle;
		}
		i++;
		if (i == mysql_num_rows(q4))
		{
			local finish = clock() - start;
			print(i + " vehicles created in " + finish + " sec");
		}
	}
	mysql_free_result(q4);
	/*GetSQLNextRow(q4);*/
}

function LoadPickups()
{
	local start = clock();
	local query = mysql_query(db, "SELECT * FROM properties"), splitPos, x, y, z
	local q5;
	local i = 0;
	while (q5 = mysql_fetch_assoc(query))
	{
		local ID = q5["ID"].tointeger();
	//	mysql_query( db, "UPDATE properties SET rowid = "+i+", ID = "+i+" WHERE ID="+ID+"");
		pickups[ID] = Pickups();
		pickups[ID].Model = q5["Model"];
		pickups[ID].Interior = q5["Interior"];
		pickups[ID].Name = q5["Name"];
		pickups[ID].Label = q5["Label"];
		pickups[ID].Cost = q5["Cost"];
		pickups[ID].Owner = q5["Owner"];
		pickups[ID].Shared = q5["Shared"];
		pickups[ID].Locked = q5["Locked"];
		local model = q5["Model"];
		splitPos = split(q5["Pos"], " ");
		x = splitPos[0];
		y = splitPos[1];
		z = splitPos[2];
		CreatePickup(model.tointeger(), Vector(x.tofloat(), y.tofloat(), z.tofloat()));		
		if (i == mysql_num_rows(query))
		{
			local finish = clock() - start;
			print(i + " Pickups created in " + finish + " sec");
		}
		i++;
	}
	mysql_free_result(query);
	HideMapObject(2403, -499.824, -467.798, 11.681); // gate starfish
	HideMapObject(2372, -372.609, -463.328, 11.3241); // gate 2 starfish
	HideMapObject(2420, -378.163, -335.954, 11.8024); // gate 3 starfish
	HideMapObject(2421, -443.166, -336.168, 11.7883); // gate 4 starfish
	HideMapObject(467, 347.122, -36.3925, 14.5308); // weed block 1
	HideMapObject(474, -963.205, -262.823, 9.27197); // weed block 2
	HideMapObject(474, -581.94, -468.205, 10.0574); // weed block 3 starfish
	HideMapObject(2416, -541.775, -421.413, 18.0098); // LODrtrees4  starfish
}

function SaveStats( player )
{
	/*mysql_query( db,
	   format(@"UPDATE [mhc_accounts] SET
		   [Level]=%i,
		   [UID]='%s',
		   [IP]='%s',
		   [Kills]=%i,
		   [Deaths]=%i,
		   [Cash]=%i,
		   [Bank]=%i,
		   [nogoto]='%s',
		   [AutoLogin]='%s'
		   WHERE [Name]='%s';",
		   stats[ player.ID ].Level.tointeger(),
			player.UID,
		   player.IP,
		   stats[ player.ID ].Kills.tointeger(),
		   stats[ player.ID ].Deaths.tointeger(),
		   stats[ player.ID ].Cash.tointeger(),
		   stats[ player.ID ].Bank.tointeger(),
		   stats[ player.ID ].Nogoto.tostring(),
		   stats[ player.ID ].AutoLogin.tostring(),
		   player.Name
	   )
	);*/
	//mysql_query( db, "UPDATE mhc_accounts SET IP = '"+player.IP+"', UID = '"+player.UID+"', Level = "+stats[ player.ID ].Level.tointeger()+", Kills = "+stats[ player.ID ].Kills.tointeger()+", Deaths = "+stats[ player.ID ].Deaths.tointeger()+", Cash = "+stats[ player.ID ].Cash.tointeger()+", Bank = "+stats[ player.ID ].Bank.tointeger()+", nogoto = '"+stats[ player.ID ].Nogoto.tostring()+"' WHERE Name = '"+player.Name+"'");
	mysql_query( db, "UPDATE `mhc_accounts` SET Level = " + stats[ player.ID ].Level + ", Kills = " + stats[ player.ID ].Kills + ", Deaths = " + stats[ player.ID ].Deaths + ", Cash = " + stats[ player.ID ].Cash + ", Bank = " + stats[ player.ID ].Bank + ", nogoto = '" + stats[ player.ID ].Nogoto + "', LastJoin = '"+time()+"', LogTime = '"+stats[player.ID].LogTime+"' WHERE `Name` = '" + player.Name + "' AND `NameLower` = '" + player.Name.tolower() + "'");
	//print( mysql_error( db ) );
}

function AccInfo( player )
{
	local q = mysql_query( db, "SELECT * FROM mhc_accounts WHERE NameLower = '" + mysql_escape_string( db, player.Name.tolower() ) + "'" );
	if( mysql_num_rows( q ) > 0 )
	{
		local data = mysql_fetch_assoc( q );
			player.Name = data[ "Name" ];
			stats[ player.ID ].Password = data[ "Password" ];
			stats[ player.ID ].UID = data[ "UID" ];
			stats[ player.ID ].IP = data[ "IP" ];
			stats[ player.ID ].AutoLogin = data[ "AutoLogin" ];
			stats[ player.ID ].Registered = true;		
		if( ( player.UID == stats[ player.ID ].UID ) && ( player.IP == stats[ player.ID ].IP ) )
		{
			if( stats[ player.ID ].AutoLogin == 1 )
			{
				MessagePlayer( WHITE+"( "+YELLOW+"INFO"+WHITE+" ) Welcome back to the server." , player );
				MessagePlayer( WHITE+"( "+YELLOW+"INFO"+WHITE+" ) You've been auto logged in, to disable this, type /autologin [ Toggles automatically ]" , player );
				LoginP( player );
			}
			else
			{
				MessagePlayer( WHITE+"( "+YELLOW+"INFO"+WHITE+" ) Welcome back to the server." , player );
				MessagePlayer( WHITE+"( "+YELLOW+"INFO"+WHITE+" ) Your nick is registered. Please login in order to continue." , player );
			}
		}
		else
		{
			MessagePlayer( WHITE+"( "+YELLOW+"INFO"+WHITE+" ) Welcome back to the server." , player );
			MessagePlayer( WHITE+"( "+YELLOW+"INFO"+WHITE+" ) Your nick is registered. Please login in order to continue." , player );
		}
	}
	else
	{
		MessagePlayer( WHITE+"( "+YELLOW+"INFO"+WHITE+" ) Welcome to the server." , player );
		MessagePlayer( WHITE+"( "+YELLOW+"INFO"+WHITE+" ) Your nick is [#FF0000]not [#FFFFFF]registered. Please register in order to continue." , player );
	}
	mysql_free_result( q );
}

function EventWinner( player )
{
	if( Event.Type )
	{
		local i = 0;
		foreach( val in Event.Players )
		{
			if( val == player.ID )
			{
				ClientMessageToAll( "( "+RED+"Event"+WHITE+" ) " + player.Name + " is out of the event.", 255, 255, 255);				
				EchoMessage( "( "+ICOL_RED+"Event"+ICOL_BLACK+" ) " + ICOL_BOLD+player.Name + " is out of the event." );
				player.World = 1;
				Event.Players.remove(i);
				if( Event.Players.len() == 0 )
				{
					local p = FindPlayer(i), plr = FindPlayer(i);
					ClientMessageToAll( "( "+RED+"Event"+WHITE+" ) No one has won the event.", 255, 255, 255);				
					EchoMessage( "( "+ICOL_RED+"Event"+ICOL_BLACK+" )  No one has won the event." );
					plr.World = 1;
					plr.CanAttack = true;
					plr.Pos = stats[ plr.ID ].LastPos;
					Event.Type = null;
					Event.Wep = null;
					Event.EntryFee = 0;
					Event.TotalFee = 0;
					Event.Players = [ ];
				}
				else if( Event.Players.len() == 1 )
				{
					local p = FindPlayer(i), plr = FindPlayer(i);
					ClientMessageToAll( "( "+RED+"Event"+WHITE+" ) " + plr.Name + " has won the event and got the total fee of event $"+Event.TotalFee+" as a reward.", 255, 255, 255);				
					EchoMessage( "( "+ICOL_RED+"Event"+ICOL_BLACK+" ) " + ICOL_BOLD+plr.Name + "  has won the event and got the total fee of event $"+Event.TotalFee+" as a reward." );
					SetCash( plr, stats[ plr.ID ].Cash + Event.TotalFee );
					plr.World = 1;
					plr.CanAttack = true;
					plr.Pos = stats[ plr.ID ].LastPos;
					Event.Type = null;
					Event.Wep = null;
					Event.EntryFee = 0;
					Event.TotalFee = 0;
					Event.Players = [ ];
				}
			}
			i++;
		}
	}	
}

function onPlayerFall(player, speed)
{
	if( Event.Type )
	{
		if( player.Pos.z > 100 ) return;
		else EventWinner( player );
	}
}

local g_PlayerFallAccum = array(GetMaxPlayers(), 0.0);

function onPlayerMove(player, px, py, pz, cx, cy, cz)
{
    // Get the speed to avoid too many table lookups
    local speed = g_PlayerFallAccum[player.ID];
    // Update the accumulated speed
    speed += pz > cz ? pz - cz : 0.0;
    // Check the accumulated speed
    if (speed > 1.0) onPlayerFall(player, speed);
    // Save the accumulated speed
    g_PlayerFallAccum[player.ID] = speed;
}

function _PlayerFallResetFunc()
{
    g_PlayerFallAccum.apply(@(v) 0.0);
}

local _PlayerFallResetTimer = NewTimer("_PlayerFallResetFunc", 1000, 0);

function JoinEvent( player )
{
	foreach( val in Event.Players )
	{
		if( val == player.ID )
		{
			return ErrorMessage( "You are already in a event.", player );
		}
	}
	stats[ player.ID ].LastPos = player.Pos;
	player.CanAttack = false;
	player.Disarm();
	player.World = 2;
	EMessage( player.Name + " has joined the event. Use /joinevent to join him" ); 
	player.Pos = Vector( -540.473, 793.28, 196.393  );
	player.SetWeapon( Event.Wep.tointeger(), 99999 );
	if( stats[ player.ID ].Cash >= Event.EntryFee.tointeger() ) SetCash( player, stats[ player.ID ].Cash.tointeger() - Event.EntryFee.tointeger() );
	else if( stats[ player.ID ].Bank >= Event.EntryFee.tointeger() ) SetBank( player, stats[ player.ID ].Bank.tointeger() - Event.EntryFee.tointeger() );
	Event.Players.push( player.ID );
	Event.TotalFee = ( Event.TotalFee.tointeger() + Event.EntryFee.tointeger() );
}

function StartEvent( player, wep, entryfee )
{
	stats[ player.ID ].LastPos = player.Pos;
	EMessage( player.Name+" has started a DM event. Weapon : "+GetWeaponName( wep )+"; Entry Fee : "+entryfee+"; Use /joinevent to join the event");
	Event.Type = "dm";
	Event.Wep = wep;
	Event.EntryFee = entryfee;
	Event.Players.push( player.ID );
	Event.TotalFee = Event.EntryFee.tointeger();
	Event.StartingIn = 0;
	stats[ player.ID ].LastPos = player.Pos;
	player.Pos = Vector( -540.473, 793.28, 196.393  );
	player.World = 2;
	player.CanAttack = true;
	if( stats[ player.ID ].Cash >= Event.EntryFee.tointeger() ) SetCash( player, stats[ player.ID ].Cash.tointeger() - Event.EntryFee.tointeger() );
	else if( stats[ player.ID ].Bank >= Event.EntryFee.tointeger() ) SetBank( player, stats[ player.ID ].Bank.tointeger() - Event.EntryFee.tointeger() );
	
}

function AutoCorrection ( text )
{
	local newtext = text.tolower();
	local firstchar = GetFirstChar( text );
	if( firstchar != null )
	{
		if( NeedsQuestionMark( newtext ) == 1 )
		{
			local len = text.len();
			local stext = newtext.slice( 1, len );
			local formattedtext = firstchar.toupper() + stext;
			return formattedtext;
		}
		else if( NeedsQuestionMark( newtext ) == 2 )
		{
			local len = text.len();
			local stext = newtext.slice( 1, len );
			local formattedtext = firstchar.toupper() + stext + "?";
			return formattedtext;
		}
		else if( NeedsQuestionMark( newtext ) == 3 )
		{
			local len = text.len();
			local stext = newtext.slice( 1, len );
			local formattedtext = firstchar.toupper() + stext;
			return formattedtext;
		}
	}
}

// This function adds commas every 3 digits for outputs like 12,345,678
function addCommas ( num )
{
	num = num.tostring();
	local last = NumTok( num, "." );
	local chk = last % 3;
	local decimaltrig = false;
	local output = "";

	foreach ( idx, digit in num )
	{
		output += digit.tochar();
		if ( digit == 44 ) decimaltrig = true;
		if ( !decimaltrig && idx < last && idx % 3 == chk ) output += ",";
	}
	return output;
}


function StripCol ( text )
{
	local a, z = text.len(), l;
	local coltrig = false, comtrig = false, num = 0, output = "";
	for ( a = 0; a < z; a++ )
	{
		l = text[ a ];
		if ( l == 3 ) { coltrig = !coltrig; num = 0; comtrig = false; }
		else if ( coltrig && num < 2 && l < 58 && 47 < l ) { num++; }
		else if ( coltrig && !comtrig && l == 44 ) { comtrig = true; num = 0; }
		else { num = 2; comtrig = false; output += l.tochar(); }
	}
	return output;
}


function SetKills( player, value )
{
	stats[ player.ID ].Kills = value.tointeger();
	UpdateStats( player, stats[ player.ID ].Cash+":"+stats[ player.ID ].Bank+":"+stats[ player.ID ].Kills+":"+stats[ player.ID ].Deaths );
}

function SetDeaths( player, value )
{
	stats[ player.ID ].Deaths = value.tointeger();
	UpdateStats( player, stats[ player.ID ].Cash+":"+stats[ player.ID ].Bank+":"+stats[ player.ID ].Kills+":"+stats[ player.ID ].Deaths );
}

function SetCash( player, value )
{
	stats[ player.ID ].Cash = value.tointeger();
	player.Cash = stats[ player.ID ].Cash;
	UpdateStats( player, stats[ player.ID ].Cash+":"+stats[ player.ID ].Bank+":"+stats[ player.ID ].Kills+":"+stats[ player.ID ].Deaths );
}

function SetBank( player, value )
{
	stats[ player.ID ].Bank = value.tointeger();
	UpdateStats( player, stats[ player.ID ].Cash+":"+stats[ player.ID ].Bank+":"+stats[ player.ID ].Kills+":"+stats[ player.ID ].Deaths );
}

function FindClanTag(strPlayer)
{
	
	local
	     D_DELIM = regexp(@"([\[(=^<]+\w+[\])=^>]+)").capture(strPlayer),
             S_DELIM = regexp(@"(\w.+[.*=]+)").capture(strPlayer);

	if ( D_DELIM != null )
	{
		return strPlayer.slice( D_DELIM[ 0 ].begin, D_DELIM[ 0 ].end );
	}
	else if ( S_DELIM != null )
	{
		return strPlayer.slice( S_DELIM[ 0 ].begin, S_DELIM[ 0 ].end );
	}
	else return "none";
}

function TopClans()
{//Message ( "[#FFFFFF]( "+MSG+"SERVER[#FFFFFF] ) Top 5 Clans with Most Kills:" );
	//EchoMessage( "( " +ICOL_CYAN+ "SERVER" +ICOL_BLACK+ " ) Top 5 Clans with Most Kills:" );
	local q = mysql_query( db, "SELECT Tag, Kills FROM clans ORDER BY Kills DESC LIMIT 5" ), data, val = "Top 5 Clans with Most Kills: ", vall = "Top 5 Clans with Most Kills: ";	
	if( mysql_num_rows( q ) > 0 )
	{
		while( data = mysql_fetch_assoc( q ) )
		{
			if( val == "Top 5 Clans with Most Kills: " ) val += ""+MSG+data["Tag"]+WHITE+" - "+MSG+data["Kills"]+WHITE;
			else val += ", "+MSG+data["Tag"]+WHITE+" - "+MSG+data["Kills"]+WHITE+"";
			if( vall == "Top 5 Clans with Most Kills: " ) vall += ""+ICOL_BOLD+data["Tag"]+ICOL_BLACK+" - "+ICOL_BOLD+data["Kills"]+ICOL_BLACK;
			else vall += ", "+ICOL_BOLD+data["Tag"]+ICOL_BLACK+" - "+ICOL_BOLD+data["Kills"]+ICOL_BLACK+"";
		}	
		Message ( "[#FFFFFF]( "+MSG+"SERVER[#FFFFFF] ) "+val );
		EchoMessage( "( " +ICOL_CYAN+ "SERVER" +ICOL_BLACK+ " ) "+vall );
	}	
	mysql_free_result( q );
}

function FindPlayersClan( player )
{
	local q = mysql_query( db, "SELECT Clan FROM mhc_accounts WHERE Name = '"+ player.Name +"'" ), data = mysql_fetch_assoc( q ), clan;
	if( data[ "Clan" ] != "none" )
	{
		clan = ClanAlias( data[ "Clan" ] );
		mysql_free_result( q );
		return clan;
	}
	else
	{
		return ClanAlias( FindClanTag( player.Name ) );
	}
	mysql_free_result( q );
	return "none";
}

function AddClanLeader( player, tag )
{
	local q = mysql_query( db, "SELECT Leaders FROM clan_leaders WHERE Tag = '"+ mysql_escape_string( db, ClanAlias(tag) ) +"'" ), rows = mysql_num_rows ( q );
	if( rows > 0 )
	{
		local data = mysql_fetch_assoc( q ), leaders = data[ "Leaders" ];
		leaders += ","+player;
		mysql_query( db, "UPDATE clan_leaders SET Leaders='"+leaders+"' WHERE Tag = '"+ mysql_escape_string( db, ClanAlias(tag) ) +"'" );
		mysql_query( db, "UPDATE mhc_accounts SET Clan='"+ClanAlias(tag)+"' WHERE Name = '"+ player +"'" );
	}
	else
	{
		mysql_query( db, "INSERT INTO clan_leaders (Tag, Leaders) VALUES ( '"+ClanAlias(tag)+"', '"+player+"' )" );
		AddClanMember( player, ClanAlias(tag) );
	}
	mysql_free_result( q );
}

function AddClanMember( player, tag )
{
	local q = mysql_query( db, "SELECT Members FROM clan_members WHERE Tag = '"+ mysql_escape_string( db, ClanAlias(tag) ) +"'" ), rows = mysql_num_rows ( q );
	if( rows > 0 )
	{
		local data = mysql_fetch_assoc( q ), members = data[ "Members" ];
		members += ","+player;
		mysql_query( db, "UPDATE clan_leaders SET Members='"+members+"' WHERE Tag = '"+ mysql_escape_string( db, ClanAlias(tag) ) +"'" );
	}
	else
	{
		mysql_query( db, "INSERT INTO clan_leaders (Tag, Members) VALUES ( '"+ClanAlias(tag)+"', '"+player+"' )" );
	}
	mysql_free_result( q );
}

function ClanRegistered( tag )
{
	local q = mysql_query( db, "SELECT Name FROM clans WHERE Tag = '"+ mysql_escape_string( db, ClanAlias(tag) ) +"'" ), rows = mysql_num_rows ( q );
	mysql_free_result( q );
	if( rows > 0 ) return 1;
	return 0;	
}

function GetClanKills( tag )
{
	if( ClanRegistered( ClanAlias(tag) ) )
	{
		local q = mysql_query( db, "SELECT Kills FROM clans WHERE Tag ='" + mysql_escape_string( db, ClanAlias(tag) ) + "'"), data = mysql_fetch_assoc( q ), kills = data[ "Kills" ];
		mysql_free_result( q );
		return kills;
	}
}

function GetClanDeaths( tag )
{
	if( ClanRegistered( ClanAlias(tag) ) )
	{
		local q = mysql_query( db, "SELECT Deaths FROM clans WHERE Tag ='" + mysql_escape_string( db, ClanAlias(tag) ) + "'"), data = mysql_fetch_assoc( q ), deaths = data[ "Deaths" ];
		mysql_free_result( q );
		return deaths;
	}
}

function SetClanKills( tag, value )
{
	if( ClanRegistered( ClanAlias(tag) ) )
	{
		mysql_query( db, "UPDATE clans SET Kills = '"+ value +"' WHERE Tag ='" + ClanAlias(tag) + "'");
	}
}

function SetClanDeaths( tag, value )
{
	if( ClanRegistered( ClanAlias(tag) ) )
	{
		mysql_query( db, "UPDATE clans SET Deaths = '"+ value +"' WHERE Tag ='" + ClanAlias(tag) + "'");
	}
}

function ClanAlias( tag )
{
	switch ( tag )
	{
		case "[VU]":
		case "[VU_T]":
		case "[VU_R]":
			return "[VU]";
		break;
		
		case "[DS]":
		case "[DS_T]":
		case "[DS_R]":
			return "[DS]";
		break;
		
		case "=AF=":
		case "[AFt]":
		case "[AFr]":
		case "[AF]":
			return "[AF]";
			
		case "[MK]":
		case "[MKt]":
		case "MK":
		case "MKs":
			return "[MK]";
		break;

		case "[CF]":
		case "=CF=":
		case "[CFt]":
		case "[CFr]":
			return "[CF]";
		break;
		
		case "[ON]":
		case "[OFF]":
			return "[ON]";
		break;
		
		case "OSK":
		case "[OSK]":
		case "[OSKr]":
		case "[OSKt]":
		case "[OSKa]":
		case "[OSK_A]":
		case "[OSK_O]":
		case "[OSK_R]":
		case "(OSK_A)":
			return "[OSK]";
		break;

		default: return tag; break;
	}
}

function InvalidNick( player )
{
	local q = mysql_query( db, "SELECT Name FROM invalidnicks WHERE Name = '"+ player.Name.tolower() +"'" );
	if( mysql_num_rows( q ) > 0 )
	{
		EMessage( player.Name+" is kicked from the server. Reason : Invalid Nick" );
		player.Kick();
	}
	mysql_free_result( q );
}

function RegisterP( player, text )
{
	local q = mysql_query( db, "SELECT Name FROM mhc_accounts" ), id = ( mysql_num_rows( q ) ) + 1;
	
	//INSERT INTO `mhc_accounts`(`ID`, `Name`, `NameLower`, `IP`, `UID`, `Password`, `Level`, `Kills`, `Deaths`, `Cash`, `Bank`, `AutoLogin`, `LoggedIn`, `DateRegistered`, `LastJoin`, `nogoto`, `PASS`, `LogTime`, `Clan`) VALUES ( " + id + ",'" + player.Name + "','"+player.Name.tolower()+"' , '"+player.IP+"', '"+player.UID+"', '"+SHA256(text)+"', '1', '0', '0', '0', '0', '1', '1', '"+GetFullTime()+"', '0', 'off', '"+SHA1( text )+"','0', '"+FindClanTag( player.Name )+"')
	//mysql_query( db , "INSERT INTO mhc_accounts( ID, Name, NameLower, Password, Level, DateRegistered, LastJoin, Cash, Bank, UID, IP, Kills, Deaths, PASS, LogTime, Clan ) VALUES ( " + id + ",'" + player.Name + "','"+player.Name.tolower()+"','"+SHA256(text)+"','1','"+GetFullTime()+"','0','0','0','"+player.UniqueID+"','"+player.IP+"','0','0', '"+SHA1( text )+"', '0', '"+FindClanTag( player.Name )+"'")
	mysql_query( db , "INSERT INTO `mhc_accounts`(`ID`, `Name`, `NameLower`, `IP`, `UID`, `Password`, `Level`, `Kills`, `Deaths`, `Cash`, `Bank`, `AutoLogin`, `LoggedIn`, `DateRegistered`, `LastJoin`, `nogoto`, `PASS`, `LogTime`, `Clan`) VALUES ( " + id + ",'" + player.Name + "','"+player.Name.tolower()+"' , '"+player.IP+"', '"+player.UID+"', '"+SHA256(text)+"', '1', '0', '0', '0', '0', '1', '1', '"+GetFullTime()+"', '0', 'off', '"+SHA1( text )+"','0', '"+FindClanTag( player.Name )+"' )" );
	MessagePlayer("[#FFFFFF]( [#00EE00]Account[#FFFFFF] ) You've been registered successfully!" , player );
	MessagePlayer("[#FFFFFF]( [#00EE00]Account[#FFFFFF] ) Don't forget your Password: "+text, player );
	MessageAllExcept("[#FFFFFF]( [#00EE00]Account[#FFFFFF] ) "+player.Name+" is a registered nickname now.", player);
	EchoMessage(ICOL_BLACK+"( "+ICOL_BROWN+"Account "+ICOL_BLACK+") "+player.Name+" is a registered nickname now!");
	stats[player.ID].Registered=true;
	stats[player.ID].LoggedIn=true;
	if( FindPlayersClan( player ) != "none" ) 
	{
		if( !ClanRegistered( FindPlayersClan( player ) ) )	MessagePlayer( WHITE+"( "+MSG+"Clan"+WHITE+" ) Your clan "+FindPlayersClan( player )+" is not registered in the server. Ask any online admin to register it and start counting the stats from today.", player );
	}
}

function LoginP( player )
{
	mysql_query( db, "UPDATE Accounts SET IP='" + player.IP + "', UID='" + player.UniqueID + "' WHERE LowerName='" + mysql_escape_string( db, player.Name.tolower() ) + "' " );
	local q = mysql_query( db, "SELECT * FROM mhc_accounts WHERE NameLower = '" + mysql_escape_string( db, player.Name.tolower() ) + "'" );
	local data = mysql_fetch_assoc( q );
	player.Name = data[ "Name" ];
	stats[ player.ID ].Password = data[ "Password" ];
	stats[ player.ID ].Level = data[ "Level" ].tointeger();
	stats[ player.ID ].Cash = data[ "Cash" ].tointeger();
	stats[ player.ID ].Bank = data[ "Bank" ].tointeger();
	stats[ player.ID ].Kills = data[ "Kills" ].tointeger();
	stats[ player.ID ].Deaths = data[ "Deaths" ].tointeger();
	stats[ player.ID ].UID = data[ "UID" ];
	stats[ player.ID ].IP = data[ "IP" ];
	stats[ player.ID ].AutoLogin = data[ "AutoLogin" ];	
	stats[ player.ID ].LogTime = data[ "LogTime" ];
	stats[ player.ID ].LastJoin = data[ "LastJoin" ];
	stats[ player.ID ].LoggedIn=true;
	local LeftTime = time() - stats[ player.ID ].LastJoin;
	MessagePlayer( WHITE+"( "+MSG+"SERVER"+WHITE+" ) You've joined the server after "+GetTimeFormat(LeftTime)+"" , player );
	UpdateStats( player, stats[ player.ID ].Cash+":"+stats[ player.ID ].Bank+":"+stats[ player.ID ].Kills+":"+stats[ player.ID ].Deaths );
	mysql_free_result( q );
	stats[ player.ID ].LastJoin = time();
	SetCash( player, GetCash( player ) );
	if( FindPlayersClan( player ) != "none" ) 
	{
		if( !ClanRegistered( FindPlayersClan( player ) ) )	MessagePlayer( WHITE+"( "+MSG+"Clan"+WHITE+" ) Your clan "+FindPlayersClan( player )+" is not registered in the server. Ask any online admin to register it and start counting the stats from today.", player );
	}
}

function GetCash( player ) return stats[ player.ID ].Cash.tointeger();
function GetBank( player ) return stats[ player.ID ].Bank.tointeger();
function GetLevel( player ) return stats[ player.ID ].Level.tointeger();

function onPlayerWeaponChange( player, oldwep, newwep )
{
	return 1;
}

function UpdateStats( player, data )
{
	SendDataToClient( player, 5, data );
}

function AnimatedAnnounce( plr, text )
{
 Stream.StartWrite();
 Stream.WriteInt( 7 );
 Stream.WriteString( text );
 Stream.SendStream( plr );
}

function AnimatedAnnounceAll( text )
{
 Stream.StartWrite();
 Stream.WriteInt( 7 );
 Stream.WriteString( text );
 Stream.SendStream( null );
}

function LoadClass()
{
AddClass( 1, RGB( 119, 136, 152 ) ,2, Vector( -657.547, 761.007, 11.5938  ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 1, RGB( 119, 136, 152 ) ,3, Vector( -657.547, 761.007, 11.5938  ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 1, RGB( 119, 136, 152 ) ,4, Vector( -657.547, 761.007, 11.5938  ), 140.020, 22, 999 ,17, 100, 21, 245 );
//============================ Team 2  ======================================================
AddClass( 2, RGB( 255, 141, 19 ) ,102, Vector( -872.58, -684.322, 11.2485  ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 2, RGB( 255, 141, 19 ) ,103, Vector( -872.58, -684.322, 11.2485  ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 2, RGB( 255, 141, 19 ) ,104, Vector( -872.58, -684.322, 11.2485  ), 140.020, 22, 999 ,17, 100, 21, 245 );
//=============================Team 3  ==========================================================
AddClass( 3, RGB( 163, 73, 164 ) ,117, Vector( -909.443, 868.406, 11.1285  ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 3, RGB( 163, 73, 164 ) ,143, Vector( -909.443, 868.406, 11.1285  ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 3, RGB( 163, 73, 164 ) ,157, Vector( -909.443, 868.406, 11.1285  ), 140.020, 22, 999 ,17, 100, 21, 245 );
//=============================Team 4  ========================================================
AddClass( 4, RGB( 32, 177, 170 ) ,180, Vector( -317.363, -582.453, 11.6022   ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 4, RGB( 32, 177, 170 ) ,147, Vector( -317.363, -582.453, 11.6022   ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 4, RGB( 32, 177, 170 ) ,146, Vector( -317.363, -582.453, 11.6022   ), 140.020, 22, 999 ,17, 100, 21, 245 );
//=============================Team 5  ===========================================================
AddClass( 5, RGB( 255, 215, 32 ) ,93, Vector( -596.914, 647.556, 11.6765 ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 5, RGB( 255, 215, 32 ) ,94, Vector( -596.914, 647.556, 11.6765 ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 5, RGB( 255, 215, 32 ) ,51, Vector( -596.914, 647.556, 11.6765 ), 140.020, 22, 999 ,17, 100, 21, 245 );
//=============================Team 6 ===========================================================
AddClass( 6, RGB( 99, 139, 236 ) ,140, Vector( 496.408, -85.5873, 10.0306 ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 6, RGB( 99, 139, 236 ) ,46, Vector( 496.408, -85.5873, 10.0306 ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 6, RGB( 99, 139, 236 ) ,158, Vector( 496.408, -85.5873, 10.0306 ), 140.020, 22, 999 ,17, 100, 21, 245 );
//=============================Team 7 =====================================================
AddClass( 7, RGB( 255, 141, 19 ) ,5, Vector( -133.334, -980.611, 10.4634 ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 7, RGB( 255, 141, 19 ) ,6, Vector( -133.334, -980.611, 10.4634 ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 7, RGB( 255, 141, 19 ) ,61, Vector( -133.334, -980.611, 10.4634 ), 140.020, 22, 999 ,17, 100, 21, 245 );
//=============================Team 8 ==============================================================
AddClass( 8, RGB( 244, 163, 97 ) ,62, Vector( 103.596, 245.139, 21.9012 ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 8, RGB( 244, 163, 97 ) ,76, Vector( 103.596, 245.139, 21.9012 ), 140.020, 22, 999 ,17, 100, 21, 245 );
AddClass( 8, RGB( 244, 163, 97 ) ,77, Vector( 103.596, 245.139, 21.9012 ), 140.020, 22, 999 ,17, 100, 21, 245 );

}

function GetFirstChar( string )
{
	if( string.len() > 0 )
	{
		local i = string.slice( 0, 1 );
		return i;
	}
	else return 0;
}

function NeedsQuestionMark( txt )
{
	local tx = "zzzz " + txt;
		if( tx.find( "." ) || tx.find( "?" ) || tx.find( "!") )
		{
		return 3;
		}
			if( tx.find( "que" ) || tx.find( "qui" ) || tx.find( "qu'" ) || tx.find( "pourquoi" ) || tx.find( "ce" ) || tx.find( "cand" ) || tx.find( "unde" ) || tx.find( "what" ) || tx.find( "when" ) || tx.find( "where" ) || tx.find( "why" ) || tx.find( "donde" ) || tx.find( "como" ) || tx.find( "cum" ) || tx.find( "how" ) )
			{
			return 2;
			}
			else { return 1; }
}

function rgbToTxt(rgb) 
{
  local str = "[#"+
  BASE16_TABLE[(rgb.r&0xf0) >> 4].tochar()+BASE16_TABLE[rgb.r&0x0f].tochar()+
  BASE16_TABLE[(rgb.g&0xf0) >> 4].tochar()+BASE16_TABLE[rgb.g&0x0f].tochar()+
  BASE16_TABLE[(rgb.b&0xf0) >> 4].tochar()+BASE16_TABLE[rgb.b&0x0f].tochar()+"]";
  return str;
}

function random( min, max )
{
 if ( min < max )
  return rand() % (max - min + 1) + min.tointeger();
 else if ( min > max )
  return rand() % (min - max + 1) + max.tointeger();
 else if ( min == max )
  return min.tointeger();
}

function CreatePlayerWeaponPickups( player )
{
 for ( local i = 0, world, pos, pickup, weapon; i < 7; i++ )
 {
  world = player.World;
  weapon = player.GetWeaponAtSlot( i );

  if ( weapon > 0 && weapon != 16 )
  {
   pos  = player.Pos;
   pos.x = random( pos.x - 2, pos.x + 2 );
   pos.y = random( pos.y - 2, pos.y + 2 );

   pickup = CreatePickup( 258 + weapon, world, player.GetAmmoAtSlot( i ), pos, 255, true );
   if ( pickup )
    wepPickups.rawset( pickup.ID, pickup );
  }
 }
}

function GetWeaponpName( weapon )
{
	local wep = weapon;
	switch( wep.tointeger() )
	{
		case 0: return "Fist";
		case 1: return "BrassKnuckle";
		case 2: return "ScrewDriver";
		case 3: return "GolfClub";
		case 4: return "NightStick";
		case 5: return "Knife";
		case 6: return "BaseballBat";
		case 7: return "Hammer";
		case 8: return "Cleaver";
		case 9: return "Machete";
		case 10: return "Katana";
		case 11: return "Chainsaw";
		case 12: return "Grenade";
		case 13: return "RemoteGrenade";
		case 14: return "TearGas";
		case 15: return "Molotov"
		case 16: return "Missile";
		case 17: return "Colt45";
		case 18: return "Python";
		case 19: return "Shotgun";
		case 20: return "Spaz";
		case 21: return "Stubby";
		case 22: return "Tec9";
		case 23: return "Uzi";
		case 24: return "Ingrams";
		case 25: return "MP5";
		case 26: return "M4";
		case 27: return "Ruger";
		case 28: return "SniperRifle";
		case 29: return "LaserScope";
		case 30: return "RocketLauncher";
		case 31: return "FlameThrower";
		case 32: return "M60";
		case 33: return "Minigun";
		case 35: return "HeliCannon";
		case 39: return "Vehicle";
		case 41: return "Explosion";
		case 42: return "Drive-By";
		case 60: return "Heli Blades";
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

function GetTimeFormat2( secs )
{
local nDays, nHours, nMinutes, nMonths, nYears, nTime = "";
nYears = secs/31536000;
secs = secs%31536000;
nMonths = secs/2678400;
secs = secs%2678400;
nDays = secs/86400;
secs = secs%86400;
nHours = secs/3600;
secs = secs%3600;
nMinutes = secs/60;
secs = secs%60;
if( nYears != 0 ) nTime = nTime + nYears + " [#FF0000]Year" + (nYears > 1 ? "s":"");
if( nMonths != 0 ) nTime = nTime + (nTime != "" ? ", [#1A6EFF]":"[#1A6EFF]") + nMonths + " Month" + (nMonths > 1 ? "s":"");
if( nDays != 0 ) nTime = nTime  + (nTime != "" ? ", [#FFD700]":"[#FFD700]") + nDays + " Day" + (nDays > 1 ? "s":"");
if( nHours != 0 ) nTime = nTime + (nTime != "" ? ", [#32CD32]":"[#32CD32]") + nHours + " Hour" + (nHours > 1 ? "s":"");
if( nMinutes != 0 ) nTime = nTime +  (nTime != "" ? ", [#FF8C00]":"[#FF8C00]") + nMinutes + " Minute" + (nMinutes > 1 ? "s":"");
if( secs != 0 ) nTime = nTime + (nTime != "" ? ", [#FFFFFF]":"[#FFFFFF]")+secs+" Second" + (secs > 1 ? "s":"");
return nTime;
}

function onPlayerGameKeysChange( player, oldKey, newKey )
{
	if ( stats[ player.ID ].AFKfor >= 120 ) 
	{
		EMessagePlayer( "You were AFK for "+GetTimeFormat( stats[ player.ID ].AFKfor ) , player );
		MessageAllExcept( WHITE+"( "+MSG+"SERVER"+WHITE+" ) "+player.Name+" is back after "+GetTimeFormat( stats[ player.ID ].AFKfor ) , player);
		EchoMessage( ICOL_BLACK+"( "+ICOL_CYAN+"SERVER"+ICOL_BLACK+" ) "+player.Name+" is back after "+GetTimeFormat( stats[ player.ID ].AFKfor ) );
		stats[ player.ID ].AFKfor = 0;
		stats[ player.ID ].Away = false;
		SendDataToClient( player, 8, "back" );
		return;
	}
	stats[ player.ID ].AFKfor = 0;
	stats[ player.ID ].Away = false;
}

function GetBodypartName(bodypart)
{
	switch( bodypart )
	{
		case 0:return"Body";
		case 1:return"Torso";
		case 2:return"Left Arm";
		case 3:return"Right Arm";
		case 4:return"Left Leg";
		case 5:return"Right Leg";
		case 6:return"Head";
		case 7:return"Hitting His Car";
		default:return"Unknown";
	}
}

function GetFullTime()
{
	local table = date();
	return GetHourMin(table.hour,table.min)+":"+table.min+":"+table.sec+" "+GetForm(table.hour,table.min)+", "+GetNMonth( table.month )+"/"+table.day+"/"+table.year+" ("+GetMonth(table.month)+"/"+GetDay( table.wday )+"/"+table.year+")";
}

function GetDay( int_day )
{
	switch( int_day )
	{
		case 0: return "Sunday";
		break;
		case 1: return "Monday";
		break;
		case 2: return "Tuesday";
		break;
		case 3: return "Wednesday";
		break;
		case 4: return "Thursday";
		break;
		case 5: return "Friday";
		break;
		case 6: return "Saturday"
		break;
	}
}

function GetMonth( int_day )
{
	switch( int_day )
	{
		case 0: return "January";
		break;
		case 1: return "February";
		break;
		case 2: return "March";
		break;
		case 3: return "April";
		break;
		case 4: return "May";
		break;
		case 5: return "June";
		break;
		case 6: return "July"
		break;
		case 7: return "August"
		break;
		case 8: return "September"
		break;
		case 9: return "October"
		break;
		case 10: return "November"
		break;
		case 11: return "December"
		break;
	}
}

function GetNMonth( int_day )
{
	switch( int_day )
	{
		case 0: return "1";
		break;
		case 1: return "2";
		break;
		case 2: return "3";
		break;
		case 3: return "4";
		break;
		case 4: return "5";
		break;
		case 5: return "6";
		break;
		case 6: return "7"
		break;
		case 7: return "8"
		break;
		case 8: return "9"
		break;
		case 9: return "10"
		break;
		case 10: return "11"
		break;
		case 11: return "12"
		break;
	}
}

function GetHourMin( hour, min )
{
	local thour;
	if( hour <= 12 && min <= 59 ) thour = hour;
	switch( hour )
	{
		case 13: thour = 1;
		break;
		case 14: thour = 2;
		break;
		case 15: thour = 3;
		break;
		case 16: thour = 4;
		break;
		case 17: thour = 5;
		break;
		case 18: thour = 6;
		break;
		case 19: thour = 7;
		break;
		case 20: thour = 8;
		break;
		case 21: thour = 9;
		break;
		case 22: thour = 10;
		break;
		case 23: thour = 11;
		break;
		case 0: thour = 12;
		break;
	}
	return thour;
}

function GetForm(iHour,iMin)
{
	local form;
	if( iHour >= 12 && iMin >= 00 ) form = "PM";
	else if( iHour <= 23 && iMin <= 59 ) form = "AM";
	return form;
}
function GetTok(string, separator, n, ...)
{
	local m = vargv.len() > 0 ? vargv[0] : n,
	tokenized = split(string, separator),
	text = "";
	if (n > tokenized.len() || n < 1) return null;
	for (; n <= m; n++)
	{
		text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
	}
	return text;
}

function NumTok(string, separator)
{
	local tokenized = split(string, separator);
	return tokenized.len();
	local s = split(string, separator);
	return s.len();
}

function Goto( p, pp, x, y )
{
	local player = GetPlayer( p ), plr = GetPlayer( pp );
	if( player )
	{
		if( plr )
		{
			if( plr.IsSpawned )
			{
				if( player.Pos.x == x && player.Pos.y == y )
				{
					EMessage( player.Name+" has teleported to "+plr.Name );
					player.Pos = plr.Pos;
				}
				else ErrorMessage( "Teleportation failed because you moved.", player );
			}
			else ErrorMessage( "Teleportation failed. Reason : The player hasn't spawned yet.", player );
		}
		else ErrorMessage( "Teleportation failed. Reason : The player either left the game or hasn't spawned yet.", player );
	}
}

function GetPlayer( target )
{
	if( typeof( target ) == "instance" ) return target;
	else if ( typeof( target ) == "integer" ) return FindPlayer( target.tointeger() );
	else if ( typeof( target ) == "string" ) return FindPlayer( target );
	else return null;
}

//===================================== Spree System ====================================================//
function GetPlayerSpree(player)
{
	return stats[ player.ID ].KillingSpree;
}
function SetPlayerSpree(player)
{
	stats[ player.ID ].KillingSpree = 0;
}
function IncPlayerSpree(player,amount)
{
	stats[ player.ID ].KillingSpree = GetPlayerSpree(player) + amount;
}
function DecPlayerSpree(player,amount)
{
	stats[ player.ID ].KillingSpree = GetPlayerSpree(player) - amount;
}
//==============================================================================
function StartKillingSpree( player )
{
	if ( GetPlayerSpree( player ) >= 5 )
    {
		local kills = GetPlayerSpree(player);
  		if ( kills == 5 ) EMessage( player + " is on a Killing Spree with " + kills + " kills in a row!" );
  		else if ( kills == 10 ) EMessage( player + " is Dangerous!  Killing Spree with " + kills + " kills in a row!" );
  		else if ( kills == 15 ) EMessage( player + " is Murderous!!  Deadly Killing Spree with " + kills + " kills in a row!" );
  		else if ( kills == 20 ) EMessage( player + " is Psychotic!!!  Insane Killing Spree with " + kills + " kills in a row!" );
  		else if ( kills == 25 ) EMessage( player + " is an Assassin!!!!  Professional Killing Spree with " + kills + " kills in a row!" );
		else if ( ( kills >= 30 ) && ( kills % 5 == 0 ) ) EMessage( player + " is UNSTOPPABLE!!!!  Untouchable Killing Spree with " + kills + " kills in a row!" );
		
		local reward = GetPlayerSpree(player) * 500;
		AnimatedAnnounce(player , "Spree reward: $" + reward + " ");
	    SetCash( player, stats[ player.ID ].Cash + reward );
     }
}
//==============================================================================
function EndKillingSpree( p1, p2 )
{
	if ( GetPlayerSpree( p1 ) >= 5 )
    {
	    if ( p2 == 255 )
        {
                EMessage(" " + p1.Name + " has ended their own killing spree.");
                DecPlayerSpree(p1, GetPlayerSpree(p1));
        }
		else if ( p2 != 255 )
        {
	            EMessage( p2.Name + " ended " + p1.Name + "'s Killing Spree of " + GetPlayerSpree(p1) + " kills in a row.");
	            DecPlayerSpree(p1, GetPlayerSpree(p1));
		}
    }
}


//================================= SPAWNWEP STSTEM ==========================================================
function CheckTableSpawnwep( player )
{
    local si = mysql_query( db, "SELECT Weps FROM spawnwep WHERE Nick='" + player.Name + "'" );
    if ( mysql_num_rows( si ) > 0 ) 
	{
		local data = mysql_fetch_assoc(si);
		return data[ "Weps" ];
	}
    else return 0;
}
//-------------------------------------------------------------------------------------------------------------------
function LoadSpawnwep(player)
{ 
 if(CheckTableSpawnwep( player )) SpawnwepPlayer[ player.ID ] = CheckTableSpawnwep( player );
 else SpawnwepPlayer[ player.ID ] = null;
}
//-------------------------------------------------------------------------------------------------------------------
function GiveSpawnwep(player)
{ 
 if (SpawnwepPlayer[ player.ID ] != null) 
 {
  local i = 1, khe = SpawnwepPlayer[ player.ID ], Nweps = NumTok( khe," ");
  while ( i < (Nweps.tointeger()+1))
  {
   local ID = GetTok( khe," ", i);
   player.SetWeapon( ID.tointeger(), 99999 ); i++;
  }
  ClientMessage("( "+YELLOW+"SPAWNWEP"+WHITE+" ) You have got your spawn weapons.",player,255,255,255);
 }
}
//================================= SPAWNWEP STSTEM ==========================================================

function SendDataToClient( player, integer, string )
{
	local stream = Stream();
	stream.StartWrite( );
	stream.WriteInt( integer );
	if ( string != null ) stream.WriteString( string );
//print( "Write Size "+stream.GetWriteSize() );
//print( " "+stream.HasWriteError() );
	stream.SendStream( player );
}

function GTAVSpawn(pPlayer, pPosition)
{
	pPlayer.Frozen = true;

	pPlayer.Pos = pPosition;

	SetGTAVSpawnCameraHigh(pPlayer.ID);

}

function SetCameraAbovePlayer(pPlayer, fDistance, style)
{
	switch( style.tointeger() )
	{
		case 1: pPlayer.SetCameraPos(Vector(pPlayer.Pos.x + fDistance, pPlayer.Pos.y + fDistance, pPlayer.Pos.z + fDistance), pPlayer.Pos);break;
		case 2: pPlayer.SetCameraPos(Vector(pPlayer.Pos.x - fDistance, pPlayer.Pos.y + fDistance, pPlayer.Pos.z + fDistance), pPlayer.Pos);break;
		case 3: pPlayer.SetCameraPos(Vector(pPlayer.Pos.x - fDistance, pPlayer.Pos.y - fDistance, pPlayer.Pos.z + fDistance), pPlayer.Pos);break;
		case 4: pPlayer.SetCameraPos(Vector(pPlayer.Pos.x - fDistance, pPlayer.Pos.y - fDistance, pPlayer.Pos.z - fDistance), pPlayer.Pos);break;
		case 5: pPlayer.SetCameraPos(Vector(pPlayer.Pos.x + fDistance, pPlayer.Pos.y - fDistance, pPlayer.Pos.z - fDistance), pPlayer.Pos);break;
	}

	return;

}

function SetGTAVSpawnCameraHigh(player)
{
	local pPlayer = FindPlayer(player);
	local style = rand()%5;
	SetCameraAbovePlayer(pPlayer, 1000.0, style);
	NewTimer("SetGTAVSpawnCameraMedium", 20, 100, pPlayer.ID, style);

}

function SetGTAVSpawnCameraMedium(player, style)
{
	i_Height[player] -= 5;
	local pPlayer = FindPlayer(player);
	SetCameraAbovePlayer(pPlayer, i_Height[player], style);
	if (i_Height[player] == 0)
	{
		pPlayer.Spawn();
		pPlayer.Frozen = false;
		pPlayer.RestoreCamera();
		i_Height[player] = 500;
	}
}

function ErrorMessage( text , player ) MessagePlayer ( "[#FFFFFF]( [#FF0000]Error[#FFFFFF] ) "+text ,player );
function SyntaxMessage( text , player ) MessagePlayer ( "[#FFFFFF]( [#FF0000]Syntax[#FFFFFF] ) "+text ,player );
function EMessagePlayer( text , player ) MessagePlayer ( "[#FFFFFF]( "+MSG+"INFO[#FFFFFF] ) "+text ,player );
function EMessage( text )
{
	Message ( "[#FFFFFF]( "+MSG+"SERVER[#FFFFFF] ) "+text );
	EchoMessage( "( " +ICOL_CYAN+ "SERVER" +ICOL_BLACK+ " ) "+text );
}
function TipMessage( text )
{
	Message ( "[#FFFFFF]( "+GREY+"TIPS[#FFFFFF] ) "+text );
	EchoMessage( "( " +ICOL_BROWN+ "TIPS" +ICOL_BLACK+ " ) "+ICOL_BOLD+text );
}	