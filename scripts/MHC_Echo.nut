local BotNick		=	[ "MHC-Bot", "MHC-Slave" ];		// The BotNames

const NickServ		=	"manhuntcityserverbyanik";						// The NickServ Password

const server		=	"91.121.134.5";					// Server Ip
const port		=	 6667;						// Server port

const chan		=	"#Manhunt";					// Home channel
const pass		=	"";						// Channel password

const PREFIX		=	"!";						// The command prefix.

szBotName <- "MHC | Manhunt City Server"; // The bots "real" name

local socket		=	{};						// A empty table to put our socket instances in.

local count 		= 	0;						// A counter to count recieved data.

local prev 		= 	null; 						// A var to hold the BotName that last sent data to IRC.


function LoadBot()
{
	// A var to count.
	local t = 0;

	// Iterate our BotNames.
	while ( t < BotNick.len() ) 
	{
		// Open a new socket and send the data to be parsed.
		socket[ t ] <- NewSocket( "connect" );

		// Connect our socket to the server.
		socket[ t ].Connect( server, port );

		// The function to call, once connected.
		socket[ t ].SetNewConnFunc( "Login" );

		// Increase our var.
		t++;
	}
}

function connect( data )
{
	// Parse the data
	local	
		raw 		= 	split( data, "\r\n" ),
		event		= 	raw.len() > 1 ? split( raw[ 1 ], " " ) : "",
		EventID 	=	event.len() > 1 ? event[ 1 ] : "";

	// Find the Ping event.
	local 
		FindPing	=	split( raw[ 0 ], " " ),
		ping		=	FindPing[ 0 ];

	
	// Find the channel event ( I've done this separately for de-bugging purposes )
	local 
		FindChan	=	split( raw[ 0 ], " " ),
		channel		=	FindChan.len() > 2 ? FindChan[ 2 ] : "";


	// Ok, Now let's get those irc commands ( Join, part, Kick...etc etc )
	local 
		FindIrcCommand	= 	split( raw[ 0 ], " " ),
		IrcCommand	=	FindIrcCommand.len() > 1 ? FindIrcCommand[ 1 ] : "";

	// Reply to ping's ( 'PONG' + irc server )
	if ( ping == "PING" ) 
	{
		// A var to count.
		local t = 0;

		// Iterate our BotNames.
		while ( t < BotNick.len() )
		{
			socket[ t ].Send( "PONG " + FindPing[ 1 ] + "\n" );

			// Increase var.
			t++;
		}
	}

	// We got the welcome message, so We're connected.
	if ( EventID == "001" )
	{
		// A var to count.
		local t = 0;

		// Iterante the BotNames
		while ( t < BotNick.len() )
		{
			// Join our HomeChannel
			socket[ t ].Send( "JOIN " + chan + " " + pass + "\n" );

			// Login to NickServ.
			socket[ t ].Send( "PRIVMSG NickServ IDENTIFY " + NickServ + "\n" ); 

			// Increase var.
			t++;
		}
	}

	// This is returned at the end of a NAMES request, after all visible names are returned.
	else if ( EventID == "366" )
	{
		// A dynamic array to store each user's class instance in.
		NickList		<-	[];

		// Now, Lets parse the names query.
		local 
			FindUsers	=	split( raw[ 0 ], ":" ),
			users		=	split( FindUsers[ 1 ], " " );

		// Iterate our parsed list of users.
		for ( local i = 0; i < users.len(); i++ )
		{
			// Establish the level symbol.
			local 
				Level	=	users[ i ].slice( 0, 1 );

			if ( Level == "~" ) NickList.push( UserLevels( users[ i ].slice( 1, users[ i ].len() ), "Owner", 5 ) );
			else if ( Level == "&" ) NickList.push( UserLevels( users[ i ].slice( 1, users[ i ].len() ), "SOP", 4 ) );
			else if ( Level == "@" ) NickList.push( UserLevels( users[ i ].slice( 1, users[ i ].len() ), "AOP", 3 ) );
			else if ( Level == "%" ) NickList.push( UserLevels( users[ i ].slice( 1, users[ i ].len() ), "HOP", 2 ) );
			else if ( Level == "+" ) NickList.push( UserLevels( users[ i ].slice( 1, users[ i ].len() ), "VOP", 1 ) );
			else NickList.push( UserLevels( users[ i ], "User", 0 ) );
		}
	}
	if ( IrcCommand == "KICK" )
	{
		// A var to count.
		local t = 0;

		// Iterante the BotNames
		while ( t < BotNick.len() )
		{
			// Re-join our channel when kicked
			socket[ t ].Send( "JOIN " + chan + " " + pass + "\n" );			
			// Increase var.
			t++;
			print( "BOT"+t+" has joined successfully!" );
		}
	}
	else if ( ( IrcCommand == "MODE" ) || ( IrcCommand == "NICK" ) || ( IrcCommand == "JOIN" ) || ( IrcCommand == "PART" ) || ( IrcCommand == "QUIT" ) )
	{
		// Send a NAMES request.
		socket[ 0 ].Send( "NAMES :" + chan + "\n" );
	}
	
	// Somethings been said in our HomeChannel.
	if ( channel == chan )
	{
		// Find the text that was typed.
		local 
			FindText	=	split( raw[ 0 ], ":" ),
			text		=	FindText.len() > 1 ? FindText[ 1 ] : "",
			prefix		=	text != "" ? text.slice( 0, 1 ) : "";
			if( FindText.len() > 1 )
			{
				local count = NumTok( raw[ 0 ], ":" );
				if( count >= 2 )
				{
					for( local i = 2; i < count; ++i )
					{
						text += ":"+FindText[i];
					}
				}
			}
		// Find the command that was typed.
		local
			Findcmd		=	text != "" ? split( text, " " ) : "",
			cmd		=	Findcmd != "" ? Findcmd[ 0 ].slice( 1, Findcmd[ 0 ].len() ) : "";


		// Find the text that was typed after the command.
		local 
			NewText		=	text != "" ? strip( text.slice( cmd.len() + 1, text.len() ) ) : "",
			formattext = text.slice( 1, text.len() );

		// Find the person that typed the text.
		local 
			FindNick 	=	split( raw[ 0 ], "!" ),
			Nick		=	FindNick[ 0 ].slice( 1, FindNick[ 0 ].len() );

		// Ensure a command was typed with our prefix.
		if( prefix == "." )
		{
			if ( count % BotNick.len() == 0 )
			{
				if( formattext != "" )
				{
					formattext = AutoCorrection ( formattext );
					Message( MSG+"[ irc " + FindLevel( Nick, false ) + " ] " + Nick + ":" +  " " + WHITE+formattext );
					if( formattext.slice(0,1) == ":" ) SendToIRC( ICOL_BLACK+"[ IRC " + ICOL_LBLUE+FindLevel( Nick, false ) +ICOL_BLACK+" ] " + Nick + ":" +  " :" + formattext );
					else SendToIRC( ICOL_BLACK+"[ IRC " + ICOL_LBLUE+FindLevel( Nick, false ) +ICOL_BLACK+ " ] " + Nick + ":" +  " " + formattext );
					//SendToIRC( "[ irc " + FindLevel( Nick, false ) + " ] " + Nick + ":" +  " " + text );
				}
				else SendToIRC( ICOL_BOLD+".< text >" );
			}

			// Increase our 'recieved data' counter.
			count++;
		}
		else if ( prefix  == PREFIX )
		{
			// Depending how many bot's we have connected, depends how many times we recieve the data.
			// So we need to only forward the last recieved data to the command handler.

			// We do this using the 'Modulus Operator', This checks that our 'data recieved counter' devides into
			// the total number of bot's we have connected, ensuring that we only forward the recieved data once.

			if ( count % BotNick.len() == 0 )
			{
				// Forward to our command handler.
				ProcessCommands( Nick, cmd, NewText );
			}

			// Increase our 'recieved data' counter.
			count++;
		}
	}
}

function Login()
{
	// Our counter.
	local t = 0;
	
	// Iterate the BotNames
	while ( t < BotNick.len() ) 
	{
		// Set the bots name and real name
		socket[ t ].Send( "USER " + BotNick[ t ] + " 0 * : " + BotNick[ t ] + " \n" );

		// Set the nick that the bot will use on the irc server
		socket[ t ].Send( "NICK " + BotNick[ t ] + "\n" );
	
		// Increase our counter.
		t++;
	}
}

// Send a message to be echoed.
function SendToIRC( text )
{
	// Establish the index of the next bot.
	local 
		BotID		=	FindNexBotId();

	// Send the data to IRC.
	socket[ BotID ].Send( "PRIVMSG " + chan + " " + text + "\n" );
}

function EchoMessage( text )
{
	SendToIRC( text );
}

// Establish the index of the next bot.
function FindNexBotId()
{
	// If the index exists.
	try{
		local 
			next 	= 	BotNick.find( prev ) + 1;	// Find the next array index.
			prev 	= 	BotNick[ next ];		// Put it's value in our var.
		return  next;						// Return the index.
	} catch ( e ) { prev = BotNick[ 0 ]; return 0; }		// Return index zero on error.
}

// A empty class to store Channel Users and their levels.
class UserLevels
{
	// The Constructor.
 	constructor( ... ) {

		user 	= 	vargv[ 0 ];
		level	=	vargv[ 1 ];
		ilevel	=	vargv[ 2 ];
	}

	// Reset Property values
	user 	= 	null;
	level 	= 	null;
	ilevel	=	null;
}

// Find the specified user's level.
function FindLevel( user, ilevel )
{
	// Iterate our NickList array.
	foreach ( obj in NickList )
	{
		// Ensure a class instance was found.
		if ( obj != null )
		{
			// Add the object properties to a tmp variable, so we can access squirrel's VM built in manipulation functions for that data type.
			local tmp = obj.user;

			// Perform a string comparison, if we get a match, return the 'level' property.
			if ( tmp.find( user ) != null )
			{
				// Return the numerical level if 'true'
				if ( ilevel ) return obj.ilevel;
		
				// Otherwise return the Non-Numerical level.
				else return obj.level;
			}
		}
	}
}


// The commands.
function ProcessCommands( nick, cmd, text )
{
	if ( cmd == "commands" )
	{
		SendToIRC( ">> Current commands: " + "say, players" );
	}
	else if ( cmd == "level" )
	{
		// Change parameter two, to 'true' for numerical level.
		SendToIRC( FindLevel( nick, false ) );
	}
	else if ( cmd == "say" )
	{
		// Check text is not a empty string.
		if ( text == "" ) SendToIRC( "Error: Missing paremeter - text" );
		else 
		{
			// Send the message in-game
			Message( "[ irc " + FindLevel( nick, false ) + " ] " + nick + ":" +  " " + text );
			
			// Echo it back, so we know whats happening. 			
			//if( text.slice(0,1) == ":" ) text = ":"+text.slice(1,text.len());
			//print( text );
			if( text.slice(0,1) == ":" ) SendToIRC( "[ irc " + FindLevel( nick, false ) + " ] " + nick + ":" +  " :" + text );
			else SendToIRC( "[ irc " + FindLevel( nick, false ) + " ] " + nick + ":" +  " " + text );
		}
	}
	
	else if ( cmd == "server" )
	{
		EchoMessage( ICOL_CYAN+ "Server Name:" +ICOL_BLACK+ " [0.4] MHC | Manhunt City Server " );
		EchoMessage( ICOL_CYAN+ "IP:" +ICOL_BLACK+ " "+ServerIP+ICOL_CYAN+" | Forum: "+ICOL_BLACK+""+Forum );
		EchoMessage( ICOL_CYAN+ "Created By:" +ICOL_BLACK+ICOL_BOLD+ " "+Creator );
	}
	
	else if ( cmd == "script" )
	{
		EchoMessage( ICOL_CYAN+ "[0.4] MHC | Manhunt City Server " );
		EchoMessage( ICOL_CYAN+ "Version 1.8" );
		EchoMessage( ICOL_CYAN+ "Created By:" +ICOL_BLACK+ICOL_BOLD+ " "+Creator );
	}
	
	else if ( cmd == "exec" || cmd == "exe" )
	{
		if ( FindLevel( nick, true ) > 4 )
		{
			if( text )
			{
				try
				{
					local script = compilestring( text );
					script();
					SendToIRC( "Succesfully Executed." );
				}
				catch( e ) SendToIRC( e );
			}
			else SendToIRC( "/" + cmd + " <code>" );
		}
	}
	
	else if ( cmd == "ping" )
	{
		if( text )
		{
			local player = GetPlayer( text );
			if( player )
			{
				EMessage( player.Name+"'s ping: "+player.Ping );
			}
			else SendToIRC( "( Error ) Unknown Player." );
		}
		else SendToIRC( "/" + cmd + " <player>" );
	}
	
	else if ( cmd == "fps" )
	{
		if( text )
		{
			local player = GetPlayer( text );
			if( player )
			{
				EMessage( player.Name+"'s fps: "+player.FPS );
			}
			else SendToIRC( "( Error ) Unknown Player." );
		}
		else SendToIRC( "/" + cmd + " <player>" );
	}
	
	else if ( cmd == "players" )
	{
		// A tempory var to collect our players in
		local 	tmp 	= 	"",
			count	= 	0;

		// Iterate all players	
		for( local i=0; i < 50; ++i ) 
		{
			// Grab it's instance in a variable.
			local plr = FindPlayer( i );

			// If a instance has been found
			if ( plr ) 
			{
				// Add it to our temp string.
				tmp = tmp + " " + plr.Name + "[" + plr.ID + "]" + ",",

				// Increase our counter
				count++;
			}
		}
		
		// Output if tmp is not a empty string still.
		tmp != "" ? SendToIRC( "Online Players: " + strip( tmp.slice(0, tmp.len() - 1) ) ) : "";

		// Output our player count.
		SendToIRC( "Total players: " + count );
	}

	// Anything else is a unknown command.
	else SendToIRC( "I don't know that command!" );
}