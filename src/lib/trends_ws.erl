%%----------------------------------------------------------------------
%% File     :trends_ws
%% Autho    :langxianzhe@163.com
%% Description: public fuction
%% Created : 2012-09-02
%%----------------------------------------------------------------------
-module(trends_ws).

%% API
-export([send_msg/2]).

-include("trends.hrl").


-spec send_msg(UserId :: string(), Msg :: string())  -> any().
send_msg(UserId, Msg) ->
    case trends_utils:get_ws_by_userid(UserId) of
        [] ->
            ok;
        L when is_list(L)->
            [Ws:send(Msg)||Ws<-L];
        Ws ->
            Ws:send(Msg)
    end.



