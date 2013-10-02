-module(foo).

-export([foo/0]).

foo() ->
    a() == id(a).

a() ->
    a.

id(X) ->
    X.
