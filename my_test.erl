-module(my_test).

-export([test/0]).

test() ->
    dialyzer:run([{files, ["/home/stavros/git/Concuerror/foo.beam"]},
                  {analysis_type, plt_build}]).
