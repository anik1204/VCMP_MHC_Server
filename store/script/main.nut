function errorHandling( err )
{

	local stackInfos = getstackinfos( 2 );

	if ( stackInfos )
	{
	
		local locals = "";

		foreach( index, value in stackInfos.locals )
		{
		
			if( index != "this" )
			locals = locals + "[ " + index + " ] " + value + "\n";
			
		}

	local callStacks = "",
		  level = 2;
	do
	{
	
		callStacks += "*FUNCTION [ " + stackInfos.func + "( ) ] " + stackInfos.src + " line [ " + stackInfos.line + " ]\n";
		level ++;
		
	}
	while ( ( stackInfos = getstackinfos( level ) ) );

	local errorMsg = "AN ERROR HAS OCCURRED [" + err + "]\n";
		  errorMsg += "\nCALLSTACK\n";
		  errorMsg += callStacks;
		  errorMsg += "\nLOCALS\n";
		  errorMsg += locals;

	Console.Print( errorMsg );
 
	}
	
}

sX <- GUI.GetScreenSize().X;
sY <- GUI.GetScreenSize().Y;

Timer <- {
 Timers = {}

 function Create(environment, listener, interval, repeat, ...)
 {
  // Prepare the arguments pack
  vargv.insert(0, environment);

  // Store timer information into a table
  local TimerInfo = {
   Environment = environment,
   Listener = listener,
   Interval = interval,
   Repeat = repeat,
   Args = vargv,
   LastCall = Script.GetTicks(),
   CallCount = 0
  };

  local hash = split(TimerInfo.tostring(), ":")[1].slice(3, -1).tointeger(16);

  // Store the timer information
  Timers.rawset(hash, TimerInfo);

  // Return the hash that identifies this timer
  return hash;
 }

 function Destroy(hash)
 {
  // See if the specified timer exists
  if (Timers.rawin(hash))
  {
   // Remove the timer information
   Timers.rawdelete(hash);
  }
 }

 function Exists(hash)
 {
  // See if the specified timer exists
  return Timers.rawin(hash);
 }

 function Fetch(hash)
 {
  // Return the timer information
  return Timers.rawget(hash);
 }

 function Clear()
 {
  // Clear existing timers
  Timers.clear();
 }

 function Process()
 {
  local CurrTime = Script.GetTicks();
  foreach (hash, tm in Timers)
  {
   if (tm != null)
   {
    if (CurrTime - tm.LastCall >= tm.Interval)
    {
     tm.CallCount++;
     tm.LastCall = CurrTime;

     tm.Listener.pacall(tm.Args);

     if (tm.Repeat != 0 && tm.CallCount >= tm.Repeat)
      Timers.rawdelete(hash);
    }
   }
  }
 }
};
ThreeD <-
{
 text = null
 Label = null
 style = null
 R = null
 G = null
 B = null
 Timer = null
}
seterrorhandler( errorHandling );	
dofile( "MHC_mem.nut" );