-module(stateful).
-export([start/0,rpc/2,loop/1,stop/1]).

start() ->
  % {Timestamp, Last_Pid, Counter}
  spawn(stateful,loop,[{nil, nil, 0}]).

rpc(Pid, Request) ->
  Pid ! {self(), Request},
  receive
    {ok, Response} ->
      Response;
    {ok} ->
      ok;
    Response ->
      Response
  end.

loop({Timestamp, Last_Pid, Counter}) ->
  receive
    {From, {echo, Message}} ->
      From ! {ok, Message},
      loop({erlang:timestamp(), From, Counter + 1});
    {From, {add, A, B}} ->
      From ! {ok, A + B},
      loop({erlang:timestamp(), From, Counter + 1});
    {From, {greet, Name}} ->
      From ! {ok, "Welcome " ++ Name ++ ". It is a pleasure to meet you."},
      loop({erlang:timestamp(), From, Counter + 1});
    {From, {count}} ->
      From ! {ok, Counter},
      loop({erlang:timestamp(), From, Counter + 1});
    {From, {last}} ->
      From ! {ok, Last_Pid, Timestamp},
      loop({erlang:timestamp(), From, Counter + 1});
    {From, {set, counter, N}} ->
      From ! {ok},
      loop({erlang:timestamp(), From, N});
    stop ->
      ok
  end.

stop(Pid) ->
  Pid ! stop.
