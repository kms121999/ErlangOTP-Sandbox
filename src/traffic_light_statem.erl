-module(traffic_light_statem).
-behaviour(gen_statem).
 
%% API
-export([start_link/0, next/0, stop/0]).
 
%% gen_statem callbacks
-export([init/1, callback_mode/0, handle_event/4, terminate/3]).
 
%%%======================
%%% API Functions
%%%======================
start_link() ->
    %% Starts the gen_statem process
    gen_statem:start_link({local, ?MODULE}, ?MODULE, [], []).
 
next() ->
    %% Sends an asynchronous event to move to the next state
    gen_statem:cast(?MODULE, next).
 
stop() ->
    %% Stops the state machine gracefully
    gen_statem:stop(?MODULE).
 
%%%======================
%%% gen_statem Callbacks
%%%======================
init([]) ->
    %% Initial state is 'red' with no additional data
    io:format("Traffic light starting in state: Red~n"),
    {ok, red, #{}}.
 
callback_mode() ->
    %% Defines the mode as handle_event_function, meaning we handle all events in handle_event/4
    handle_event_function.
 
handle_event(cast, next, red, Data) ->
    %% Transitions from 'red' to 'green'
    io:format("Transitioning from Red to Green~n"),
    {next_state, green, Data};
 
handle_event(cast, next, green, Data) ->
    %% Transitions from 'green' to 'yellow'
    io:format("Transitioning from Green to Yellow~n"),
    {next_state, yellow, Data};
 
handle_event(cast, next, yellow, Data) ->
    %% Transitions from 'yellow' to 'red'
    io:format("Transitioning from Yellow to Red~n"),
    {next_state, red, Data}.
 
terminate(_Reason, _State, _Data) ->
    %% Handles cleanup when the state machine terminates
    io:format("Traffic light state machine terminated.~n"),
    ok.