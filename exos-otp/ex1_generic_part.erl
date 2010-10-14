-module(ex1_generic_part). 
-export([start/2]). 
-export([request/2]). 



start(ServerName,Module) -> 
    spawn(ServerName, init, [ServerName,Module]). 

request(ProcessName,Req) ->
    ProcessName ! {Req,erlang:self()},
    receive 
        R ->
            R
    end.
    
    
init(ServerName,Module) -> 
    register(ServerName, self()), 
    State = Module:init(),
    loop(Module,State). 

loop(Mod,State) -> 
    receive 
        {Req,From} ->
            NewState = Mod:handle_call(Req,From,State),
            loop(Mod,NewState)
    end.
