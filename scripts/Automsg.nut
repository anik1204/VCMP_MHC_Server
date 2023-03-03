Messages <- [ "Visit our forum at "+Forum,
"If you find any bug, feel free to report to us.",
"You get more cash as bonus when you are in a killing spree.",
"The server is developed by Anik",
"Your can view your total time spent in the server using /stats",
"Your play time will not increase in case you are not spawned or away.",
"You can get a list of helpful commands using /help",
"Visit our IRC #Manhunt @ LUnet",
"You can set your spawnweps using /spawnwep",
"Top 5 Clans" ]

function AutoMsg()
{
	if( GetPlayers() > 0 )
	{
		local val = random( 0, Messages.len()-1 );
		if( val == 9 ) return TopClans();
		TipMessage( Messages[val] );
	}	
}