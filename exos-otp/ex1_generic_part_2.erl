-module(ex1_generic_part_2). 
-export([start/2]). 
-export([call/2,cast/2]). 

start(ServerName,Module) -> 
    spawn(ServerName, init, [ServerName,Module]). 

call(ProcessName,Req) ->
    ProcessName ! {call,Req,erlang:self()},
    receive 
        {ProcessName,Resp} ->
            Resp
    end.
    
cast(ProcessName,Req) ->
    ProcessName ! {cast,Req,erlang:self()},
    ok.    

    
init(ServerName,Module) -> 
    register(ServerName, self()), 
    State = Module:init(),
    loop(Module,State). 

loop(Mod,State) -> 
    receive 
        {call,Req,From} ->
            {Resp,NewState} = Mod:handle_call(Req,From,State),
            From ! {Mod,Resp},
            loop(Mod,NewState) ;
        {cast,Req,From} ->
            NewState = Mod:handle_cast(Req,From,State),
            loop(Mod,NewState)
    end.
