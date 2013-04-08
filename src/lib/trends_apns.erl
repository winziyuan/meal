%%----------------------------------------------------------------------
%% File     :trends_apns.erl
%% Autho    :langxianzhe@163.com
%% Description: public fuction
%% Created : 2012-10-25
%%----------------------------------------------------------------------
-module(trends_apns).

%% API
-export([get_connect/0,
         close_connect/1,
         send/2,
         send/3
        ]).
-record(apns_connection, {apple_host        = "gateway.sandbox.push.apple.com"      :: string(),
                          apple_port        = 2195                                  :: integer(),
                          cert_file         = "priv/cert.pem"                       :: string(),
                          key_file          = undefined                             :: undefined | string(),
                          timeout           = 30000                                 :: integer(),
                          error_fun         = fun(X,Y) -> erlang:display({X,Y}) end :: fun((binary(), apns:status()) -> stop | _), 
                          feedback_host     = "feedback.sandbox.push.apple.com"     :: string(),
                          feedback_port     = 2196                                  :: integer(),
                          feedback_fun      = fun erlang:display/1                  :: fun((string()) -> _), 
                          feedback_timeout  = 30*60*1000                            :: pos_integer()
                          }). 
-record(apns_msg, {id = apns:message_id()       :: binary(),
                   expiry = apns:expiry(86400)  :: non_neg_integer(), %% default = 1 day
                   device_token                 :: string(),
                   alert = none                 :: none | apns:alert(),
                   badge = none                 :: none | integer(),
                   sound = none                 :: none | string(),
                   extra = []                   :: [apns_mochijson2:json_property()]}).
-record(loc_alert, {body    = none  :: none | string(),                                                                                               
                    action  = none  :: none | string(),
                    key     = ""    :: string(),
                    args    = []    :: [string()],
                    image   = none  :: none | string()}).



-include("trends.hrl").


close_connect(ConnId) ->
    apns:disconnect(ConnId).

get_connect() ->
    {ok, Pid} = apns:connect(),
    Pid.

send(Token, ConnId, Msg) ->
     Alert = #apns_msg{device_token = Token,
                       badge = 9,
                       sound = "bingbong.aiff",
                       %extra = [{"jump","yes"}],
                       extra = [{jump, yes}],
                       alert = #loc_alert{body = Msg
                                        }}, 
    ?DEBUG("appns_packet ~p Alert = ~p ~n", [?MODULE, ?LINE, Alert]),
    apns:send_message(ConnId, Alert).


send(Tokens, Msg) ->
    ConnId = get_connect(),
    F = fun(Token) -> 
            send(Token, ConnId, Msg)
        end,
    lists:foreach(F, Tokens),
    close_connect(ConnId).

