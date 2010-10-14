%%%-------------------------------------------------------------------
%%% File    : ex1_callback_2.erl
%%% Author  : Didier Hoareau <didier@ambika.home>
%%% Description : 
%%%
%%% Created : 14 Oct 2010 by Didier Hoareau <didier@ambika.home>
%%%-------------------------------------------------------------------
-module(ex1_callback_2).

-define(SERVER_NAME,ex1_mixed_server).

start() ->
    ex1_generic_part_2:start(server1,ex1_callback_1).
    
init() -> 
    [].

handle_call({add_data,D},From,State) ->
    NewState = [D|State],
    {ok,NewState} ;

handle_call({ls_data},From,State) ->
    {State,State}.

handle_cast({clear},_,State) ->
    [].


