-module(my_event_manager).
 
%% Exported functions
-export([start_link/0, add_handler/1, remove_handler/1, notify/1]).
 
%% Starts the event manager
start_link() ->
    gen_event:start_link({local, ?MODULE}).
 
%% Adds a handler to the event manager
add_handler(Handler) ->
    gen_event:add_handler(?MODULE, Handler, []).
 
%% Removes a handler from the event manager
remove_handler(Handler) ->
    gen_event:remove_handler(?MODULE, Handler, []).
 
%% Sends an event to the event manager (which distributes it to all handlers)
notify(Event) ->
    gen_event:notify(?MODULE, Event).