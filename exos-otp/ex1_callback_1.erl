%%%-------------------------------------------------------------------
%%% File    : ex1_callback_1.erl
%%% Author  : Didier Hoareau <didier@ambika.home>
%%% Description : 
%%%
%%% Created : 14 Oct 2010 by Didier Hoareau <didier@ambika.home>
%%%-------------------------------------------------------------------
-module(ex1_callback_1).

-compile(export_all).

-define(SERVER_NAME,ex1_mixed_server).

start() ->
    ex1_generic_part:start(?SERVER_NAME,ex1_callback_1).
    
init() ->
    [].

handle_call({add_data,D},From,State) ->
    NewState = [D|State],
    From ! {?SERVER_NAME, NewState}, 
    NewState ;

handle_call({clear},_,State) ->
    [] ;

handle_call({ls_data},From,State) ->
    From ! State,
    State.
