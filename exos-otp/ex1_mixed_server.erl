-module(ex1_mixed_server). 
-export([start/0]). 
-export([add_data/1, ls_data/0,clear/0]). 
-export([init/0]). 

-define(SERVER_NAME,ex1_mixed_server).

start() -> 
    spawn(?SERVER_NAME, init, []). 

add_data(Data) -> 
    
    ?SERVER_NAME ! {self(), {add_data,Data}}, 
    receive 
        {?SERVER_NAME, Res} -> 
            Res 
    end. 

ls_data() ->
    ?SERVER_NAME ! {self(),ls_data},
    receive
        D ->
            D
    end.


clear() -> 
    ex1_mixed_server ! {clear}, 
    ok. 

init() -> 
    
    register(?SERVER_NAME, self()), 
    State = [],
    loop(State). 

loop(State) -> 
    receive 
        {From, {add_data,D}} -> 
            NewState = [D|State],
            From ! {?SERVER_NAME, NewState}, 
            loop(NewState); 
        {clear} -> 
            loop([]) ; 
        {From,ls_data} ->
            From ! State,
            loop(State)
    end. 
