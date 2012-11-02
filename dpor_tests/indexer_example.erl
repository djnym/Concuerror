-module(indexer_example).

-export([main/1]).

-define(size, 128).
-define(max, 4).

thread(Tid) ->
    thread(Tid, 0).

thread(Tid, M) ->
    case getmsg(M, Tid) of
        stop -> parent ! exit;
        {W, NewM} -> 
            H = hash(W),
            while_cas_table(H, W),
            thread(Tid, NewM)
    end.

getmsg(M, Tid) ->
    case M < ?max of
        true ->
            NewM = M + 1,
            {NewM * 11 + Tid, NewM};
        false ->
            stop
    end.

hash(W) ->
    (W * 7) rem ?size.

while_cas_table(H, W) ->
    case ets:insert_new(table, {H, W}) of
        false -> while_cas_table((H + 1) rem ?size, W);
        true -> ok
    end.

main(Threads) ->
    register(parent, self()),
    ets:new(table, [public, named_table]),
    spawn_threads(Threads-1),
    collect_threads(Threads-1),
    receive
        forever_alone -> ok
    end.
    
spawn_threads(-1) -> ok;
spawn_threads(N) ->
    spawn(fun() -> thread(N) end),
    spawn_threads(N-1).

collect_threads(-1) -> ok;
collect_threads(N) -> 
    receive
        exit -> collect_threads(N-1)
    end.
