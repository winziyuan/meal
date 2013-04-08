-define(DEBUG(), error_logger:info_msg("~p:  ~p",[?MODULE, ?LINE])).
-define(DEBUG(Input), 
        error_logger:info_msg("~p:" ++ Input ++ "~n",[?MODULE])).
-define(DEBUG(Input, Args), 
        error_logger:info_msg("~p:" ++ Input ++ "~n", Args)).

-define(ERROR(Input, Args), 
        error_logger:error_msg("~p:" ++ Input ++ "~n", Args)).

-define(SESSION_TIMEOUT, 60000*24*60).
-define(MAX, 20).

%% mapred Input 
-define(INFOBUCKET, <<"infos">>).
-define(COLUMNBUCKET, <<"columns">>).
-define(APPCOVERBUCKET, <<"appcovers">>).

%% error code 
-define(ERROR_CODE(Request,Code,Error),
        [   {"request", Request},
            {"code" , Code},
            {"error", Error}
        ]). 
-define(SUCCESSFUL(Request,Code,Note),
        [   {"request", Request},
            {"code" , Code},
            {"note", Note}
        ]). 
%% 
%% @type trends_session() = {trends_session, Id, UserId, Ws, Updated, Nickname}
%%       Id = string() %%session_id
%%       UserId = string() 
%%       Ws = {misultin_ws,<0.177.0>} 
%%       Updated = calendar:local_time()}
%%       Nickname = string() by user wanggc 
-record(trends_session, {id = "", user_id = "", ws = "", updated = "", nickname = ""}).
-record(users, {id,
               avatar,
               cover,
               bio,
               confirmation,
               blog,
               nickname,
               email,
               phone,
               location,
               need_confirmation,
               password,
               register_date,
               reserved,
               username,
               points,
               sex,
               exp,
               level,
               assets,
               custom_design_id,
               type
              }).
-record(favorite,{id,
                  timestamp,
                  info_id,
                  user_id,
                  author_id                                                               
                }).
-record(column, { id,
                  name,
                  user_id,
                  timestamp,
                  img_url,
                  note,
                  share 
                }).
-define(PAGE_MAX_ITEM, 1).
-define(SUCCESS, "ok").
-define(FAILURE, "error").
-define(DOWNLOADS_DIR, "/app/svn/huanyue/server/trunk/trends/priv/static/www").
-define(IMGURL, "http://dev.ihuanyue.me:8080/web").
