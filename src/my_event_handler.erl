-module(my_event_handler).
-behaviour(gen_event).
 
%% Exported callback functions
-export([init/1, handle_event/2, handle_call/2, terminate/2]).
 
%% Initialize the handler
init([]) ->
    {ok, []}.  %% State can be anything, here we use an empty list.
 
%% Handle an incoming event
handle_event(Event, State) ->
    io:format("Received event: ~p~n", [Event]),
    {ok, State}.
 
%% Handle synchronous calls (optional, not often used in gen_event)
handle_call(_Request, State) ->
    {ok, reply, State}.
 
%% Handle termination
terminate(_Reason, _State) ->
    io:format("Handler terminating~n"),
    ok.