-module(sample).

-export([sample/0]).

-export([scenarios/0]).

scenarios() -> [{?MODULE, inf, dpor}].

sample() ->
    ets:new(table, [public, named_table]),
    ets:insert(table, {x, 0}),
    ets:insert(table, {y, 0}),
    ets:insert(table, {z, 0}),
    spawn(fun() -> ets:insert(table, {x, 1}) end),
    spawn(fun() -> ets:insert(table, {y, 1}) end),
    spawn(fun() ->
                  [{y, Y}] = ets:lookup(table, y),
                  case Y =:= 0 of
                      true  -> ets:insert(table, {z, 1});
                      false -> ok
                  end
          end),
    spawn(fun() ->
                  [{z, Z}] = ets:lookup(table, z),
                  [{y, Y}] = ets:lookup(table, y),
                  case Z =:= 1 andalso Y =:= 0 of
                      true  -> ets:insert(table, {x, 2});
                      false -> ok
                  end
          end),
    block().

block() ->
    receive
    after
        infinity -> ok
    end.
