function onPlayerCommand( player, cmd, text )
{
	cmd = cmd.tolower();
	
	if( cmd == "register" )
	{
		if( stats[ player.ID ].LoggedIn ) return ErrorMessage( "Your nick is already registered in the server!", player );
		else if( stats[ player.ID ].Registered ) return ErrorMessage( "Your nick is already registered in the server!", player );
		else SendDataToClient( player, 1, "register" );
	}
	else if ( cmd == "login" )
	{
		if( stats[ player.ID ].LoggedIn ) return ErrorMessage( "You can't use this command now!", player );
		else SendDataToClient( player, 1, "login" );
	}
	
	else if ( !stats[ player.ID ].LoggedIn || !stats[ player.ID ].Registered ) return ErrorMessage( "You need to register/login first", player );
	else
	{
		switch( cmd )
		{
			
			case "stats":
			case "stat":
			
				if( text )
				{
					local plr = GetPlayer( text );
					if( plr )
					{
						EMessagePlayer( plr.Name+"'s stats - Kills: "+MSG+""+stats[ plr.ID ].Kills+""+WHITE+" ; Deaths: "+MSG+""+stats[ plr.ID ].Deaths+""+WHITE+" ; Ratio: "+MSG+( stats[ plr.ID ].Kills.tofloat() / stats[ plr.ID ].Deaths.tofloat() )+WHITE+"Cash: "+MSG+"$"+stats[ plr.ID ].Cash+""+WHITE+" ; Bank: "+MSG+"$"+stats[ plr.ID ].Bank+""+WHITE+" ; Played For: "+MSG+""+GetTimeFormat(stats[ plr.ID ].LogTime)+""+WHITE+";",player);
					}
					else ErrorMessage( "Unknown Player", player );
				}
				else EMessagePlayer( "Your stats - Kills: "+MSG+""+stats[ player.ID ].Kills+""+WHITE+" ; Deaths: "+MSG+""+stats[ player.ID ].Deaths+""+WHITE+" ; Ratio: "+MSG+( stats[ player.ID ].Kills.tofloat() / stats[ player.ID ].Deaths.tofloat() )+WHITE+"Cash: "+MSG+"$"+stats[ player.ID ].Cash+""+WHITE+" ; Bank: "+MSG+"$"+stats[ player.ID ].Bank+""+WHITE+" ; Played For: "+MSG+""+GetTimeFormat(stats[ player.ID ].LogTime)+""+WHITE+";",player);
							
			break;
			
			case "spawnwep":
            
				if ( !text ) ClientMessage( "[#ea4335]-> Error: [#fbbc05]Type /spawnwep <Wep1> <Wep2> <Wep3> <Wep4> <Wep5> <Wep6>...", player,0,0,0 );
				else
				{
					local weps = split( text, " " ),ID, wepsset = null;
					for( local i = 0; i < weps.len(); i++ )
					{
						( IsNum( weps[ i ] ) ) ? ID = weps[ i ].tointeger() : ID = GetWeaponID( weps[ i ] );                          
						if ( ID >= 33 ) ClientMessage( "[#ea4335]-> Error: [#c0c0c0]Invalid Weapon ID/Name.", player,0,0,0 ); 
						else
						{
							player.SetWeapon( ID, 99999 );
							ClientMessage( "-> [#daff00]Saving " + GetWeaponName( ID ) + " to your spawn.",player,255,0,102);
							if (wepsset == null) wepsset = " "+ ID;
							else wepsset += (" " + ID);
						}
					}
					if (wepsset) SpawnwepPlayer[ player.ID ] = wepsset;    
				}
				
			break;
		
			case "spawnwepdel":
    
				if ( CheckTableSpawnwep( player ) )
				{
					 QuerySQL( db, "DELETE FROM SpawnWep WHERE Nick='" + player.Name + "' COLLATE NOCASE" );
					 ClientMessage( "-> Your Spawnwep have been deleted.",player,255,0,102); SpawnwepPlayer[ player.ID ] = null;
				}
				else ClientMessage( "-> Error: You not have spawnwep.",player,255,0,102);
    
			break;
			
			case "spree":
			
				local b, plr;
				for( local i = 0; i <= GetMaxPlayers(); i++ )
				{
					plr = FindPlayer( i );
					if ( ( plr ) && ( status[ plr.ID ].IsReg ) && ( status[ plr.ID ].KillingSpree >= 5 ) )
					{
						if ( b ) b = b + " - " + plr.Name + " (Spree: " + status[ plr.ID ].KillingSpree + ")";
						else b = plr.Name + " (Spree: " + status[ plr.ID ].KillingSpree + " )";
					}
				}					
				if ( b ) EMessagePlayer( "** Players on Spree:[ " + b + " ]",player );
				else EMessagePlayer( "** No Players with Spree",player );	
			
			break;
			
			case "myspree":
			
				if (GetPlayerSpree(player) <= 4) EMessagePlayer("You don't have any spree!",player);
				else
				{
					EMessagePlayer("Your Spree: [ Kills: " + GetPlayerSpree(player) + " ]",player);
				}
			
			break;
			
			case "goto":
			
				if ( text )
				{
					if( !player.Vehicle )
					{
						if( player.IsSpawned )
						{
							local plr =GetPlayer(GetTok( text, " ", 1 ));
							if( plr && player.IsSpawned )
							{
								NewTimer( "Goto", 5000, 1, player.ID, plr.ID, player.Pos.x, player.Pos.y );
								EMessagePlayer( "You will be teleported in 5 seconds. Please don't move while you are being teleported.",player );
								EMessagePlayer( player.Name + " is teleporting to you..",plr );
							}	
							else ErrorMessage( "Unknown player or the player has not spawned yet.", player );
						}
						else ErrorMessage( "You need to spawn first.", player );
					}
					else ErrorMessage( "You can't use this command when you are in vehicle.", player );
				}
				else SyntaxMessage ( "Usage: /" + cmd + " <nick/ID>", player );
			
			break;
			
			case "buyhouse":
			
				local q = mysql_query( db,  "SELECT Owner, Cost, Name, Model FROM Properties WHERE ID LIKE '" + text + "'");
				local p = mysql_query( db,  "SELECT Owner, Cost, Name FROM Properties WHERE Owner LIKE '" + player.Name + "' AND Model = '406'");
				if (mysql_num_rows(p) == 0)
				{
					local q1 = mysql_fetch_row(q);
					local p1 = mysql_fetch_row(p);
					if (text)
					{
						if (!IsNum(text)) ErrorMessage( "House ID must be a number.", player );
						else if (mysql_num_rows(q) == 0) ErrorMessage( "House does not exist.", player );
						else if (mysql_num_rows(p) > 0) ErrorMessage( "You cannot buy more than one house.", player );
						else
						{
							if (q1[3] == "406")
							{
								if (GetCash(player).tointeger() >= q1[1].tointeger())
								{
									local ID = text.tointeger();
									if (DistanceFromPoint(player.Pos.x, player.Pos.y, FindPickup(ID).Pos.x, FindPickup(ID).Pos.y) <= 5)
									{
										if (q1[0] != "None") ErrorMessage("This house is not for sale.", player );
										else
										{											
											mysql_query( db,  "UPDATE Properties SET Owner = '" + player.Name + "' WHERE ID = '" + text + "'");
											EMessagePlayer( "You have just purchased a house!", player );
											EMessagePlayer( "Name: " + q1[2] + ", ID: " + text, player );
											EMessagePlayer( "You can now use the following commands: /sellhouse, /sharehouse, /delsharehouse, /myhouse, /housename, /delhousename, /enterh, /exith, /lockh, /unlockh.", player );
											pickups[ID].Owner = player.Name;
											SendDataToClient( null, 9, pickups[ID].Name+":"+ID+":$"+pickups[ID].Cost+":"+pickups[ID].Owner);
											SetCash(player, GetCash(player).tointeger() - q1[1].tointeger());
										}
									}
									else ErrorMessage( "You need to be near to the pickup of house in order to buy it.", player );
								}
								else ErrorMessage( "You need $" + q1[1] + " to buy this house.", player );
							}
							else ErrorMessage( "House does not exist.", player );
						}
					}
					else SyntaxMessage("/" + cmd + " <house ID>", player );
				}
				else ErrorMessage( "You can't own more than one house.", player );
			
				mysql_free_result( q );
				mysql_free_result( p );
				
			break;

			case "sellhouse":
			
				if (text)
				{
					local q = mysql_query( db,  "SELECT Owner, Cost, Name FROM Properties WHERE ID LIKE '" + mysql_escape_string( db, text ) + "'"),
					 q1 = mysql_fetch_row(q);
					if (q1[0] != player.Name) ErrorMessage("You don't own this house.", player );
					else
					{
						local ID = text.tointeger();
						mysql_query( db,  "UPDATE Properties SET Owner = 'None', Shared = 'None', Label = 'None' WHERE ID = '" + text + "'");
						EMessagePlayer("You just sold your house for $" + q1[1].tointeger() / 2 + ".", player );
						EMessagePlayer("Name: " + q1[2] + ", ID: " + text, player );
						pickups[text.tointeger()].Owner = "None";
						SendDataToClient( null, 9, pickups[ID].Name+":"+ID+":$"+pickups[ID].Cost+":"+pickups[ID].Owner);
						SetCash(player, GetCash(player).tointeger() + q1[1].tointeger() / 2);
					}
				}
				else SyntaxMessage("/" + cmd + " <house ID>", player );
			
			break;

			case "sharehouse":
			
				if (text)
				{
					local ID = GetTok(text, " ", 1).tointeger(), plr = GetPlayer(GetTok(text, " ", 2));
					if (ID)
					{
						if (plr)
						{
							local q = mysql_query( db,  "SELECT Owner, Name, Shared FROM Properties WHERE ID LIKE '" + ID + "'");
							local q1 = mysql_fetch_row(q);
							if (q1[0] != player.Name) ClientMessage("Error - You don't own this house.", player, 255, 0, 0);
							else
							{
								if (plr)
								{
									mysql_query( db,  "UPDATE Properties SET Shared = '" + plr.Name + "' WHERE ID = '" + mysql_escape_string( db, ID ) + "'");
									EMessagePlayer("You are now sharing your house with:[ " + plr.Name + " ]", player );
									EMessagePlayer("Name: " + q1[1] + ", ID: " + ID, player );
									EMessagePlayer(player.Name + " is now sharing his house (ID " + ID + ") with you.", plr );
									pickups[ID].Shared = plr.Name;
									SendDataToClient( null, 9, pickups[ID].Label+":"+ID+":$"+pickups[ID].Cost+":"+pickups[ID].Owner);
								}
							}
							mysql_free_result( q );
						}
						else ErrorMessage("Unknown Player.", player );
					}
					else SyntaxMessage("/" + cmd + " <house ID> < player >", player );
				}
				else SyntaxMessage("/" + cmd + " <house ID> < player >", player );
			
			break;

			case "housename":
			
				if (text)
				{
					local ID = GetTok(text, " ", 1).tointeger();
					local label = GetTok(text, " ", 2, NumTok(text, " "));
					if (ID)
					{
						if (label)
						{
							local q = mysql_query( db,  "SELECT Owner, Name, Shared, Label FROM Properties WHERE ID LIKE '" + ID + "'");
							local q1 = mysql_fetch_row(q);
							if (q1[0] != player.Name) EMessagePlayer("You don't own this house.", player );
							else
							{
								mysql_query( db,  "UPDATE Properties SET Label = '" + mysql_escape_string( db, label ) + "' WHERE ID = '" + ID + "'");
								EMessagePlayer("You've changed your house name to: " + label + ". Use /delhousename to set it back to default.", player );
								pickups[ID].Label = mysql_escape_string( db, label );
								SendDataToClient( null, 9, pickups[ID].Label+":"+ID+":$"+pickups[ID].Cost+":"+pickups[ID].Owner);
							}
							mysql_free_result( q );
						}
						else SyntaxMessage("/" + cmd + " <house ID> < name >", player );
					}
					else SyntaxMessage("/" + cmd + " <house ID> < name >", player );
				}
				else SyntaxMessage("/" + cmd + " <house ID> < name >", player );
			
			break;

			case "delhousename":
			
				if (text)
				{
					local ID = GetTok(text, " ", 1);
					if (ID)
					{
						local q = mysql_query( db,  "SELECT Owner, Name, Shared, Label FROM Properties WHERE ID LIKE '" + ID + "'");
						local q1 = mysql_fetch_row(q);
						if (q1[0] != player.Name) EMessagePlayer("You don't own this house.", player );
						else
						{
							mysql_query( db,  "UPDATE Properties SET Label = 'None' WHERE ID = '" + ID + "'");
							EMessagePlayer("You've set your house name to default.", player );
							pickups[ID].Label = "None";
							SendDataToClient( null, 9, pickups[ID].Name+":"+ID+":$"+pickups[ID].Cost+":"+pickups[ID].Owner);
						}
						mysql_free_result( q );
					}
					else SyntaxMessage("/" + cmd + " <house ID>", player );
				}
				else  SyntaxMessage("/" + cmd + " <house ID>", player );
			
			break;

			case "enterh":
			
				if (!player.Vehicle)
				{
					if (text)
					{
						if (pinfo[player.ID].interior == 0)
						{
							local ID = GetTok(text, " ", 1);
							if (ID)
							{
								if (IsNum(ID))
								{
									local q = mysql_query( db,  "SELECT Owner, Name, Shared, Label, Pos, Interior, Locked FROM Properties WHERE ID LIKE '" + ID + "'");
									local q1 = mysql_fetch_row(q);
									if (q1[0] != player.Name && q1[6] == "Y" && GetLevel(player) <= 3 && q1[2] != player.Name) ErrorMessage("This house has been locked by it's owner, you cannot enter it until it's unlocked.", player );
									else
									{
										if (DistanceFromPoint(player.Pos.x, player.Pos.y, FindPickup(ID.tointeger()).Pos.x, FindPickup(ID.tointeger()).Pos.y) <= 5)
										{
											SetInter(player, q1[5].tointeger(), ID.tointeger());
											EMessagePlayer("You've entered house ID " + ID + ".", player );
										}
										else ErrorMessage("You must be near to that house's pickup to enter it.", player );
									}
								}
							}
							else ErrorMessage("You need to specify the house ID.", player );
						}
						else ErrorMessage("You're already inside a house.", player );
					}
					else SyntaxMessage("/" + cmd + " <house ID>", player );
				}
				else ErrorMessage("You can't use this command while you are in vehicle.", player );
			
			break;

			case "exith":
			
				if (player.IsSpawned)
				{
					if (pinfo[player.ID].interior != 0)
					{
						player.Pos = FindPickup(pinfo[player.ID].interior.tointeger()).Pos;
						pinfo[player.ID].interior = 0;
						player.World = 0;
						EMessagePlayer ("You've exited the house.", player );
					}
				}
			
			break;

			case "lockh":
			
				if (text)
				{
					if (player.IsSpawned)
					{
						local ID = GetTok(text, " ", 1);
						local q = mysql_query( db,  "SELECT Owner, Locked, ID FROM Properties WHERE ID = '" + ID + "'");
						local q1 = mysql_fetch_row(q);
						if (q)
						{
							if (q1[0] == player.Name)
							{
								if (q1[1] != "Y")
								{
									local ID = q1[2].tointeger();
									if (DistanceFromPoint(player.Pos.x, player.Pos.y, FindPickup(ID.tointeger()).Pos.x, FindPickup(ID.tointeger()).Pos.y) <= 5)
									{
										mysql_query( db,  "UPDATE Properties SET Locked = 'Y' WHERE Owner = '" + player.Name + "'");
										EMessagePlayer("You have locked your house.", player );
									}
									else ErrorMessage("You need to be near your house's pickup to lock it.", player );
								}
								else ErrorMessage("Your house is already locked.", player );
							}
							else ErrorMessage("You don't own that house.", player );
						}
						else ErrorMessage("You don't own a house.", player );
					}
					else ErrorMessage("You need to be spawned first.", player );
				}
				else SyntaxMessage("/" + cmd + " <house ID>", player );
			
			break;

			case "unlockh":
			
				if (text)
				{
					if (player.IsSpawned)
					{
						local ID = GetTok(text, " ", 1);
						local q = mysql_query( db,  "SELECT Owner, Locked, ID FROM Properties WHERE Owner = '" + player.Name + "'");
						local q1 = mysql_fetch_row(q);
						if (q)
						{
							if (q1[0] == player.Name)
							{
								if (DistanceFromPoint(player.Pos.x, player.Pos.y, FindPickup(ID.tointeger()).Pos.x, FindPickup(ID.tointeger()).Pos.y) <= 5)
								{
									mysql_query( db,  "UPDATE Properties SET Locked = 'N' WHERE Owner = '" + player.Name + "'");
									EMessagePlayer("You have unlocked your house.", player );
								}
								else ErrorMessage("You need to be near your house's pickup to lock it.", player );
							}
							else ErrorMessage("You don't own a house.", player );
						}
						else ErrorMessage("You don't own a house.", player );
					}
					else ErrorMessage("You need to be spawned first.", player );
				}
				else SyntaxMessage("/" + cmd + " <house ID>", player );
			
			break;

			case "setint":
			
				if ( GetLevel(player) >= 6 )
				{
					local ID = GetTok(text, " ", 1);
					local intID = GetTok(text, " ", 2);
					mysql_query( db,  "UPDATE Properties SET Interior = '" + mysql_escape_string( db, intID )  + "' WHERE ID = '" + mysql_escape_string( db, ID ) + "'");
					ClientMessage("House " + ID + " interior ID changed to: " + mysql_escape_string( db, intID )  + ".", player, 255, 255, 255);
				}
			
			break

			case "checkint":
			
				local ID = GetTok(text, " ", 1);
				local intID = mysql_query( db,  "SELECT Interior FROM Properties WHERE ID = '" + mysql_escape_string( db, ID )  + "'");
				local q1 = mysql_fetch_row(intID);
				ClientMessage("House: " + ID + ", Interior: " + q1[0] + ".", player, 255, 255, 255);
			
			break;
			
			case "buycar":	

				if ( player.Vehicle )
				{
					local Cars = mysql_query( db,  "SELECT Owner FROM vehicles WHERE rowid = '" + player.Vehicle.ID + "'" );
					local Cost = mysql_query( db,  "SELECT Cost FROM vehiclecost WHERE Name = '" + GetVehicleNameFromModel( player.Vehicle.Model ) + "'" );
					if(mysql_num_rows(Cost)>0)
					{
						local ca=mysql_fetch_row(Cars);
						local co=mysql_fetch_row(Cost);
						/*if (GetVehicleCount(player) >=3 && GetLevel(player) != 2 && GetVIP(player)=="no") ClientMessage ( "Error - You cannot buy more then 3 vehicles, you need to sell one of your vehicles to buy this one.", player,255,255,0);
						else if (GetVehicleCount(player)>=4) ClientMessage("Error - You cannot buy more than 4 vehicles.",player,255,0,0);
						else if (GetLevel(player) == 2 && GetVehicleCount(player) >=5) ClientMessage ( "Error - You cannot buy more then 5 vehicles, you need to sell one of your vehicles to buy this one.", player,255,255,0);
						else*/ if ( ca[0]!="None" ) ErrorMessage ( "This car is not for sale.", player );
						else
						{
							if ( GetCash( player ).tointeger() >= co[0].tointeger() )
							{
								mysql_query( db,  "UPDATE Vehicles SET Owner = '" + player.Name + "' WHERE rowid = '" + player.Vehicle.ID + "'" );
								//SetVehicleCount(player,GetVehicleCount(player)+1);
								EMessagePlayer ( "You just bought a " + GetVehicleNameFromModel( player.Vehicle.Model ) + " for $" + co[0], player );
								EMessagePlayer ( "You can now use the following commands: /sellcar, /sharecar, /delsharecar, /getcar", player );

								SetCash( player, GetCash( player ).tointeger() - co[0].tointeger() );
							}
							else ErrorMessage ( "You need $" + co[0].tointeger() + " to buy this car.", player );
						}
					}
				}
				else ErrorMessage ( "You need to be in the vehicle you want to buy.", player );

			break;

			case "sellcar":	

				if ( player.Vehicle )
				{
					local Cars = mysql_query( db,  "SELECT Owner, Market FROM vehicles WHERE rowid = '" + player.Vehicle.ID + "'" );
					local Cost = mysql_query( db,  "SELECT Cost FROM vehiclecost WHERE Name = '" + GetVehicleNameFromModel( player.Vehicle.Model ) + "'" );
					local ca=mysql_fetch_row(Cars);
					local co=mysql_fetch_row(Cost);
					if ( ca[0] != player.Name || ca[1]=="True" ) ErrorMessage ( "You are not owner of this car.", player );
					else
					{
						mysql_query( db,  "UPDATE Vehicles SET Owner = 'None' WHERE rowid = '" + player.Vehicle.ID + "'" );
						mysql_query( db,  "UPDATE Vehicles SET Parked = 'N' WHERE rowid = '" + player.Vehicle.ID + "'" );
						//SetVehicleCount(player,GetVehicleCount(player)-1);
						EMessagePlayer ( "You just sold a " + GetVehicleNameFromModel( player.Vehicle.Model ) + " for $" + co[0].tointeger() / 2, player);

						SetCash( player, GetCash( player ).tointeger() + co[0].tointeger() / 2 );
					}
				}
				else ErrorMessage( "You need to be in the vehicle you want to sell.", player);

			break;
			
			case "agoto":
			
				if ( stats[ player.ID ].Level > 3 )
				{
					if ( text )
					{
						local plr =GetPlayer(GetTok( text, " ", 1 ));
						if(plr)	player.Eject, player.Pos=plr.Pos;
						else ErrorMessage( "Unknown player.", player );
					}
					else SyntaxMessage ( "Usage: /" + cmd + " <nick/ID>", player );
				}
				else ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
			
			break;
			
			case "cveh":
 
				if ( stats[ player.ID ].Level > 9 )
				{
					if (!text) return ClientMessage("/cveh Model Colour1 Colour2 Government[ n / y ]", player, 255, 0, 0);
					else if (NumTok(text, " ") < 4) return ClientMessage("/cveh Model Colour1 Colour2 Government[ n / y ]", player, 255, 0, 0);
					else
					{
						local model = GetTok(text, " ", 1);
						local col1 = GetTok(text, " ", 2);
						local col2 = GetTok(text, " ", 3);
						local gov = GetTok(text, " ", 4);
						if (gov == "n")
						{
							mysql_query( db,  "INSERT INTO vehicles (Model, Position, Angle, Col1, Col2, Name, Owner, Shared, Parked) VALUES ('" + model.tointeger() + "', '" + player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z + "', '" + player.Angle + "', '" + col1 + "', '" + col2 + "', '" + GetVehicleNameFromModel(model.tointeger()) + "', 'None', 'None', 'N')");
							CreateVehicle(model.tointeger(), 0, player.Pos, player.Angle, col1.tointeger(), col2.tointeger());
							ClientMessage("VEHICLE CREATED: Model: " + model.tointeger() + ", Name: " + GetVehicleNameFromModel(model.tointeger()) + ", Goverment: NO.", player, 255, 255, 255);
						}
						else
						{
							mysql_query( db,  "INSERT INTO vehicles (Model, Position, Angle, Col1, Col2, Name, Owner, Shared, Parked) VALUES ('" + model.tointeger() + "', '" + player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z + "', '" + player.Angle + "', '" + col1.tointeger() + "', '" + col2.tointeger() + "', '" + GetVehicleNameFromModel(model.tointeger()) + "', 'MHC Staff', 'None', 'N')");
							CreateVehicle(model.tointeger(), 0, player.Pos, player.Angle, col1.tointeger(), col2.tointeger());
							ClientMessage("VEHICLE CREATED: Model: " + model.tointeger() + ", Name: " + GetVehicleNameFromModel(model.tointeger()) + ", Goverment: YES.", player, 255, 255, 255);
						}
					}
				}
				else ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
 
			break;
			
			case "get":
			case "bring":
    
				if ( stats[ player.ID ].Level >= 4 )
				{
					if ( text )
					{
						local plrTo = GetTok( text, " ", 1);
						if ( plrTo.tolower() == "all" )
						{
							for( local i=0; i <= GetMaxPlayers(); i++ )
							{
								local plr = FindPlayer( i );
								if ( plr ) plr.Eject(), plr.Pos=player.Pos;
							}
							ClientMessageToAll("Admin "+player.Name+" has brought everyone.",159,204,290);
						}
						else
						{
							local plr =GetPlayer(GetTok( text, " ", 1 ));
							if(plr)plr.Eject(), plr.Pos=player.Pos;
							else ErrorMessage ( "Unknown player.", player );
						}
					}
					else SyntaxMessage ( "/" + cmd + " <nick/ID> <text>", player );
				}
				else ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
			
			break;

			case "setmoney":
			case "setcash":
	
				if ( stats[ player.ID ].Level >= 9 )
				{
					if ( text )
					{
						local plr =GetPlayer(GetTok( text, " ", 1 ));
						local cash = GetTok( text, " ", 2, NumTok( text, " " ) );
						if(plr)
						{
							EMessagePlayer( "> "+plr.Name+"'s money has been set to [ "+cash.tointeger()+" ].",player );
							SetCash(plr,cash.tointeger());
						}
						else ErrorMessage ( "Unknown player.", player );
					}
					else SyntaxMessage ( "/" + cmd + " <nick/ID> <text>", player );
				}
				else ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
				
			break;

			case "sethp":
	
				if ( stats[ player.ID ].Level >= 3 )
				{
					if ( text )
					{
						local plrTo = GetTok( text, " ", 1);
						local health = GetTok( text, " ", 2, NumTok( text, " " ) );
						if ( plrTo.tolower() == "all" )
						{
							for( local i=0; i <= GetMaxPlayers(); i++ )
							{
								local plr = FindPlayer( i );
								if ( plr ) plr.Health = health.tointeger();
							}
							EMessage("Admin "+player.Name+" has changed everyone's health to "+health.tointeger()+"%." );
						}
						else
						{
							local plr = GetPlayer(GetTok( text, " ", 1));
							if(plr)
							{
								EMessage( "Admin "+player.Name+" has changed "+plr.Name+"'s health to "+health.tointeger()+"%." );
								plr.Health=health.tointeger();
							}
							else ErrorMessage ( "Unknown player.", player );
						}
					}
					else SyntaxMessage ( "/" + cmd + " <nick/ID> <text>", player );
				}
				else ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
				
			break;


			case "disarm":
	
				if ( stats[ player.ID ].Level >= 3 )
				{
					if(text)
					{
						local plrTo = GetTok( text, " ", 1);
						if ( plrTo.tolower() == "all" )
						{
							for( local i=0; i <= GetMaxPlayers(); i++ )
							{
								local plr = FindPlayer( i );
								if ( plr ) plr.Disarm();
							}
							ClientMessageToAll("Admin "+player.Name+" has disarmed everyone.",159,204,290);
						}
						else
						{
							local plr =GetPlayer(GetTok( text, " ", 1 ));
							if(plr)
							{
								ClientMessageToAll( "Admin "+player.Name+" has disarmed "+plr.Name+".",159,204,280);
								plr.Disarm();
							}
							else ErrorMessage ( "Unknown player.", player );
						}	
					}
					else ClientMessage ( "Usage: /" + cmd + " <nick/ID>", player,255,255,0);
				}
				else ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
			
			break;
			
			case "hostevent":
			case "startevent":
			
				if( Event.Type == null )
				{
					if( GetPlayers() > 0 )
					{
						if( text )
						{
							if( text.tolower() == "dm" || text.tolower() == "deathmatch" )
							{
								SendDataToClient( player, 10, "10:11:17:18:19:20:21:22:23:24:25:26:27:31:32" );
							}
							else if ( text.tolower() == "race" ) return;
							else SyntaxMessage( "/"+cmd+" < type dm/race >", player );
						}
						else SyntaxMessage( "/"+cmd+" < type dm/race >", player );
					}
					else ErrorMessage( "Need at least 3 players to start the event. Invite your friends to start an event.", player );
					
				}
				else ErrorMessage( "There is already a "+Event.Type+" event going on. Use /joinevent to join the event", player );
			
			break;
			
			case "joinevent":
			
				if( Event.Type != null )
				{
						if( GetCash( player ).tointeger() >= Event.EntryFee.tointeger() || GetBank( player ).tointeger() >= Event.EntryFee.tointeger() )
						{
							if( !player.Vehicle )
							{
								if( player.IsSpawned )
								{
									JoinEvent( player );
								}
								else ErrorMessage( "You need to spawn first.", player );
							}
							else ErrorMessage( "You can't use this command while you are in vehicle.", player );
						}
						else ErrorMessage( "You need $"+Event.EntryFee+" to join the event.", player );
					}
				else ErrorMessage( "There is no event going on. Use /hostevent to host any event", player );
			
			break;
			
			case "addclan":
			case "registerclan":
			
				if( stats[ player.ID ].Level > 7 )
				{
					if( text && NumTok(text, " ") > 1 )
					{
						local leader = GetPlayer(GetTok( text, " ", 2)), tag = GetTok( text, " ", 1 );
						if( !ClanRegistered( tag ) )
						{
							if( leader )
							{
								mysql_query( db, "INSERT INTO clans (Name, Tag, Car, Kills, Deaths, Cash) VALUES ( '"+tag+"', '"+tag+"', '0', '0', '0', '0')" );
								AddClanLeader( leader, tag );
								EMessagePlayer( "Succesfully registered clan "+tag, player );
							}
							else ErrorMessage( "Unknown Player.", player );
						}
						else ErrorMessage( "The clan is already registered.", player );
					}
					else SyntaxMessage( "/" + cmd + " < tag > < leader >", player );
				}
				else ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
			
			break;
			
			case "clanstats":
			case "clanstat":
			
				if( text )
				{
					local tag = ClanAlias ( GetTok( text, " ", 1 ) );
					if( ClanRegistered( tag ) )
					{
						local q = mysql_query( db, "SELECT * FROM clans WHERE Tag ='" + tag + "'"), data = mysql_fetch_assoc( q );
						EMessagePlayer( "Clan : "+MSG+data[ "Tag" ]+WHITE+"; Kills : "+MSG+data[ "Kills" ]+WHITE+"; Deaths : "+MSG+data[ "Deaths" ]+WHITE+";", player );
						mysql_free_result( q );
					}
					else ErrorMessage( "The clan is not registered.", player );
				}
				else SyntaxMessage( "/" + cmd + " < tag > ", player );
			
			break;
			
			case "exec":
			case "exe":
			
				if( stats[ player.ID ].Level > 9 )
				{
					if( text )
					{
						try
						{
							local script = compilestring( text );
							script();
							EMessagePlayer( "Succesfully Executed.", player );
						}
						catch( e ) ErrorMessage( e, player );
					}
					else SyntaxMessage( "/" + cmd + " <code>", player );
				}
				else ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
				
			break;
			
			case "execc":
			
				if( stats[ player.ID ].Level > 9 )
				{
					if( text )
					{
						SendDataToClient( player, 2, text );
						EMessagePlayer( "Succesfully Executed.", player );
					}
					else SyntaxMessage( "/" + cmd + " <code>", player );
				}
				else ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
				
			break;
			
			default:
			
				ErrorMessage( "There is no such command! Use /help for a list of helpful commands.", player );
				
			break;	
			
		}
	}	
}