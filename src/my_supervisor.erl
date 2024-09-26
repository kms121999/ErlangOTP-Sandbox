%% Define the module and behavior
-module(my_supervisor).
-behaviour(supervisor).

%% API functions
-export([start_link/0]).

%% Callback functions for supervisor behavior
-export([init/1]).

%% Start the supervisor and link it to the current process
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% Initialize the supervisor
%% This function sets up the supervisor's strategy and child specifications
init([]) ->
    % Define the list of child processes (workers or supervisors)
    Children = [
        % Child specification for worker my_worker
        {traffic_light_statem, % Child ID
         {traffic_light_statem, start_link, []},  % Start function (module, function, args)
         permanent,   % Restart strategy (permanent, transient, temporary)
         5000,        % Shutdown timeout in milliseconds
         worker,      % Process type (worker or supervisor)
         [traffic_light_statem]  % Modules
        },

        % Another child specification for worker another_worker
        {my_event_manager, {my_event_manager, start_link, []},
         permanent, 5000, worker, [my_event_manager]}
    ],

    % Supervision strategy: one_for_one, one_for_all, rest_for_one, simple_one_for_one
    % MaxRestarts: 5 restarts allowed within 10 seconds
    {ok, {{one_for_one, 5, 10}, Children}}.
