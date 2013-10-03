-module(my_hipe_test).

-export([test/0]).

test() ->
    hipe:compile(foo).
