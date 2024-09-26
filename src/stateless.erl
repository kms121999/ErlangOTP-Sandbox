-module(stateless).
-export([start/0,rpc/2,loop/0,stop/1]).

start() ->
  spawn(stateless,loop,[]).

rpc(Pid, Request) ->
  Pid ! {self(), Request},
  receive
    {ok, Response} ->
      Response
  end.

loop() ->
  receive
    {From, {echo, Message}} ->
      From ! {ok, Message},
      loop();
    {From, {add, A, B}} ->
      From ! {ok, A + B},
      loop();
    {From, {greet, Name}} ->
      From ! {ok, "Welcome " ++ Name ++ ". It is a pleasure to meet you."},
      loop();
    stop ->
      ok
  end.

stop(Pid) ->
  Pid ! stop.
