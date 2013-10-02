#!/bin/bash

OTP_PATH=../otp
CONC_PATH=../Concuerror

$CONC_PATH/concuerror_mem -t my_test test \
    -f my_test.erl --wait-messages -T 2000 \
    --fail-uninstrumented \
    --ignore crypto crypto_app erl_prim_loader epp erl_parse code \
             public_key erl_syntax compile prim_file global ordsets orddict \
             beam_lib cerl cerl_trees cerl_closurean erl_bifs erl_bif_types erl_types \
             io io_lib file \
    -pa . \
    \
    -I $OTP_PATH/lib/kernel/include \
    -f $OTP_PATH/lib/kernel/src/inet_parse.erl \
       $OTP_PATH/lib/kernel/src/error_logger.erl \
       $OTP_PATH/lib/kernel/src/application*.erl \
       $OTP_PATH/lib/kernel/src/gen_tcp.erl \
       $OTP_PATH/lib/kernel/src/inet_tcp.erl \
       $OTP_PATH/lib/kernel/src/inet.erl \
       $OTP_PATH/lib/kernel/src/inet_db.erl \
       $OTP_PATH/lib/kernel/src/inet_gethost_native.erl \
       $OTP_PATH/lib/kernel/src/os.erl \
    \
    -D VSN=5 \
    -I $OTP_PATH/lib/dialyzer/src \
    -f $OTP_PATH/lib/dialyzer/src/dialyzer*.erl \
    \
    -I $OTP_PATH/lib/stdlib/include \
    -f \
    $OTP_PATH/lib/stdlib/src/calendar.erl \
    $OTP_PATH/lib/stdlib/src/dict.erl \
    $OTP_PATH/lib/stdlib/src/digraph.erl \
    $OTP_PATH/lib/stdlib/src/digraph_utils.erl \
    $OTP_PATH/lib/stdlib/src/erl_lint.erl \
    $OTP_PATH/lib/stdlib/src/erl_posix_msg.erl \
    $OTP_PATH/lib/stdlib/src/erl_scan.erl \
    $OTP_PATH/lib/stdlib/src/filelib.erl \
    $OTP_PATH/lib/stdlib/src/filename.erl \
    $OTP_PATH/lib/stdlib/src/gb_trees.erl \
    $OTP_PATH/lib/stdlib/src/gen.erl \
    $OTP_PATH/lib/stdlib/src/gen_event.erl \
    $OTP_PATH/lib/stdlib/src/gen_fsm.erl \
    $OTP_PATH/lib/stdlib/src/gen_server.erl \
    $OTP_PATH/lib/stdlib/src/lists.erl \
    $OTP_PATH/lib/stdlib/src/math.erl \
    $OTP_PATH/lib/stdlib/src/sofs.erl \
    $OTP_PATH/lib/stdlib/src/proc_lib.erl \
    $OTP_PATH/lib/stdlib/src/proplists.erl \
    $OTP_PATH/lib/stdlib/src/queue.erl \
    $OTP_PATH/lib/stdlib/src/random.erl \
    $OTP_PATH/lib/stdlib/src/re.erl \
    $OTP_PATH/lib/stdlib/src/sets.erl \
    $OTP_PATH/lib/stdlib/src/string.erl \
    $OTP_PATH/lib/stdlib/src/supervisor*.erl \
    $OTP_PATH/lib/stdlib/src/sys.erl \
    $OTP_PATH/lib/stdlib/src/timer.erl \
    $OTP_PATH/lib/stdlib/src/unicode.erl \
    \
    -I $OTP_PATH/lib/kernel/src \
    -f $OTP_PATH/erts/preloaded/src/prim_inet.erl \
       $OTP_PATH/erts/preloaded/src/init.erl \
    $@
