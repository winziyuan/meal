%%----------------------------------------------------------------------
%% File     :trends_utils
%% Autho    :langxianzhe@163.com
%% Description: public fuction
%% Created : 2012-08-30
%%----------------------------------------------------------------------
-module(trends_utils).

%% API
-export([get_guid/0,
         get_current_user_id/1,
         get_datetime/1,
         get_datetime/0,
         str_to_datetime/1,
         get_time_sec/0,
         get_ago_time_sec/1,
         get_after_time_sec/1,
         datetime_to_seconds/1,
         get_now_seconds/0,
         seconds_to_datatime/1,
         strdate_to_int/1,
         get_max/1,
         get_start/1,
         write_session/3,
         get_session_user/1,
         before_web_action/1,
         before_action/3,
         param_is_null/3,
         get_session_cookie/3,
         get_session_cookie_user_id/1,
         get_session_nickname/1,
         get_userid_by_ws/1,
         get_userid_by_token/1,
         get_ws_by_userid/1,
         del_session_cookie/3,
         verify_username/1,
         get_followed/2,
         verify_email/1,
         get_offset/1,
         to_integer/1,
         verify_email/1,
         get_user_friend_follower_count/1,
         get_ext_info_from_favorites/1,
         get_ext_info_from_infos/1,
         get_ext_columns/1,
         get_ext_comments/1,
         get_attributes/1,
         get_model_id/3,
         get_int_id/1,
         get_skip_num/2,
         get_pagecount_number/2,
         get_uuid/0,
         get_user_id/0,
         get_page_count/2,
         get_privileges_id/0,
         get_session_privilege/1,
         get_result/2,
         get_column_relevance/2,
         get_conf_value_by_key/1,
         write_conf/2, 
         write_conf/3,
         write_conf/4,
         get_conf/0,
         get_conf_book_or_publicity/0,
         update_collection_count/2,
         get_conf_list/1,
         screen_platform/2,
         record2bucket/1,
         admin_init/0,
         get_value/3,
         get_value_default_space/3,
         get_value/4,
         get_device_id_by_name/1,
         get_device_name_by_id/1,
         get_resolution_id_by_name/1,
         get_resolution_name_by_id/1,
         get_page_number/2,
         get_str_num/1,
         get_decode/1,
         get_session_value/2,
         init_session/2,
         get_return_append/2,
         before_session_action/1
]).

-include("trends.hrl").






init_session(Session,User)->
    boss_session:set_session_data(Session,id,User:id()), 
    boss_session:set_session_data(Session,name,User:name()),
    error_logger:info_msg("In ~p line ~p value=~p~n", [?MODULE, ?LINE, [User:id(),User:name(),boss_session:get_session_data(Session,id),
    boss_session:get_session_data(Session,name)]]),
    boss_session:set_session_data(Session,user,User).

get_session_value(Session,Field)->
     boss_session:get_session_data(Session,Field).

get_return_append(List,Session)->
    lists:append(List,[{name,get_session_value(Session,name)}]).

before_session_action(Session)->
         
         error_logger:info_msg("In ~p line ~p get_session_value(Session,id)=~p~n", [?MODULE, ?LINE, [get_session_value(Session,id)]]),
        case lists:member(get_session_value(Session,id),[undefined,"undefined",[]]) of
             true->
                 {redirect, [{controller, "index"}, {action, "login"}]};
             false->
                     ok
        end.














%% by xxc
get_uuid()->
    get_guid().

get_user_id()->
    get_uuid().
get_privileges_id()->
    get_uuid().
get_session_privilege(Session)->
    User_id = trends_utils:get_session_cookie_user_id(Session), 
    boss_session:get_session_data(Session, "privilege@"++User_id).


get_column_relevance(Column_id,Count)->
      UserIDList=[Item:user_id()||Item <- boss_db:find(collection,[{column_id,'equals',Column_id}])],
      ColumnsTail=get_columns(UserIDList,[]),
      Columns=sets:to_list(sets:del_element(Column_id,sets:from_list(ColumnsTail))),
     
      Result_Count=lists:sublist(lists:reverse(lists:sort(get_sum_columns(Columns,ColumnsTail,[]))),Count),
      ColumnsCount=get_result_columns(Result_Count,[]),
      get_ext_columns(ColumnsCount).

get_result_columns([],Acc)->
      Acc;
get_result_columns([{_,Column_id}|T],Acc)->
%boss_db:find(column,[{id,'equals',Column_id}])
     case boss_db:find(Column_id) of
         {error,_} -> get_result_columns(T,Acc);
          Item  -> get_result_columns(T,[Item|Acc])
     end.


get_columns([],Acc)->
    get_columns_append(Acc,[]);
get_columns([H|T],Acc)->
    ColumnList=[Citem:column_id()||Citem <- boss_db:find(collection,[{user_id,'equals',H}])],
    get_columns(T,[lists:sort(ColumnList)|Acc]). 


get_columns_append([],Acc)->
    Acc;
get_columns_append([H|T],Acc)->
    get_columns_append(T,lists:append(H,Acc)).


get_sum_columns([],ColumnsTail,Acc)->
    Acc;
get_sum_columns([H|T],ColumnsTail,Acc)->
    ColumnSum=get_sum(ColumnsTail,H,[]),
    get_sum_columns(T,ColumnsTail,[ColumnSum|Acc]).

get_sum([],ColumnId,Acc)->
{length(Acc),ColumnId};

get_sum([H|T],ColumnId,Acc)->
   case H==ColumnId of
        true->
              get_sum(T,ColumnId,[H|Acc]);
        false->
              get_sum(T,ColumnId,Acc)
   end.

get_page_count(Count,M)->
   if 
    Count>M ->
            case (Count rem M) >0 of
                 true ->
                   (Count div M)+1; 
                 false ->
                   (Count div M)
             end;
    Count=<M ->
          1
  end.

record2bucket(Record_a)->

    Record= atom_to_list(Record_a),
    case string:substr(Record,length(Record),1)=="s" of
          true->list_to_binary(Record);
          false->list_to_binary((Record++"s"))          
    end.

admin_init()->
	CreateTime = trends_utils:get_datetime(),
	Timesec = trends_utils:get_time_sec(),
     case boss_db:find(admin,[{name,'equals',"admin"}],[]) of
          [] ->
              User = boss_record:new(admin,
                                          [
                                           
                      {name,"admin"},
                      {desc,"administator"},
                      {passwd,"admin"},
                      {type,"admin"},
                      {email," "},
                      {phone," "},
                      {disable,"false"},
                      {createtime,CreateTime},
                      {timesec,Timesec}
                                          ]), 
                User:save();
           _ ->
                ok
      end.

%%%%%



get_max("") ->
   20; 
get_max(Max) ->
   list_to_integer(Max). 

get_start("") ->
   1; 
get_start(Start) ->
   list_to_integer(Start). 

str_to_datetime(Date) ->
     [Y, M, D, H, Mi, S] = string:tokens(Date,": -"),
     {{get_int(Y), get_int(M), get_int(D)}, {get_int(H), get_int(Mi), get_int(S)}}.

strdate_to_int("") ->
    list_to_integer(lists:flatten(string:tokens(get_datetime(),": -")));
strdate_to_int(Str) ->
    try get_int(Str) of
        R ->R
    catch 
        _:_ ->
        list_to_integer(lists:flatten(string:tokens(get_datetime(),": -")))
    end.
get_int(Str) ->
    list_to_integer(lists:flatten(string:tokens(Str,": -"))).

get_guid() ->
    TimeSpan = calendar:datetime_to_gregorian_seconds(calendar:local_time()) - 63113904000,
    {X, Y, Z} = erlang:now(),
    MicroSecs = Z,
    random:seed(X, Y, Z),
    Random = random:uniform(99),     
    List = lists:flatten(io_lib:format("~6..0w~9..0w~2..0w",[MicroSecs, TimeSpan, Random])),
   % list_to_binary(string:to_lower(erlang:integer_to_list(erlang:list_to_integer(List), 36))).
    string:to_lower(erlang:integer_to_list(erlang:list_to_integer(List), 36)).
get_datetime() ->
    {{Y,M,D},{H,Mn,S}}=erlang:localtime(),
    F=fun(X) -> if X>9  -> integer_to_list(X) ; true -> "0"++integer_to_list(X) end end,
    Ys = F(Y),
    Ms = F(M),
    Ds = F(D),
    Hs = F(H),
    Mns = F(Mn),
    Ss = F(S),
    Date = Ys ++ "-" ++ Ms ++ "-" ++ Ds ++ " " ++ Hs ++ ":" ++ Mns ++":" ++Ss,
    Date.

get_datetime(Datetime) ->
    {{Y,M,D},{H,Mn,S}}=Datetime,
    F=fun(X) -> if X>9  -> integer_to_list(X) ; true -> "0"++integer_to_list(X) end end,
    Ys = F(Y),
    Ms = F(M),
    Ds = F(D),
    Hs = F(H),
    Mns = F(Mn),
    Ss = F(S),
    Date = Ys ++ "-" ++ Ms ++ "-" ++ Ds ++ " " ++ Hs ++ ":" ++ Mns ++":" ++Ss,
    Date.
    
get_time_sec() ->	
	calendar:datetime_to_gregorian_seconds(calendar:local_time()).
	
get_ago_time_sec(Days) ->
	Seconds = calendar:datetime_to_gregorian_seconds(calendar:local_time()) - Days * 86400.

get_after_time_sec(Days) ->
	Seconds = calendar:datetime_to_gregorian_seconds(calendar:local_time()) + Days * 86400.	

get_now_seconds() ->
    Date = calendar:local_time(),
    calendar:datetime_to_gregorian_seconds(Date).

datetime_to_seconds(Datetime) when is_list(Datetime) ->
	%[StrDay, StrTime] = string:tokens(Datetime, " "),
	%[YY,MM,DD,H,M,S] = string:tokens(Datetime,"- :"),
	case length(string:tokens(Datetime,"- :")) of
		6 ->
			[YY,MM,DD,H,M,S] = string:tokens(Datetime,"- :"),
			%[H,M,S] = string:tokens(StrTime,":"),
			Day = {list_to_integer(YY),list_to_integer(MM),list_to_integer(DD)},
			Time = {list_to_integer(H),list_to_integer(M),list_to_integer(S)},
			calendar:datetime_to_gregorian_seconds({Day,Time});
		_ ->
			0
	end;
datetime_to_seconds(Datetime) ->
	0.

    
-spec write_session(Id :: string(), UserId :: string(), Nickname :: string()) ->ok.
write_session(SessionID, UserId, Nickname) ->
    mnesia:dirty_write(#trends_session{id = SessionID, 
                                       user_id = UserId,
                                       nickname = Nickname,
                                       updated = calendar:local_time()}).

-spec before_web_action(SessionID :: string()) -> ok | {json, []}.
before_web_action(SessionID) ->
    case mnesia:dirty_read(trends_session,SessionID) of 
       [] -> {redirect, [{controller, "adminaccount"}, {action, "login"}]}; 
        _ -> ok
    end.

-spec get_session_user(SessionID :: string()) -> {user, _} | {error, notfound}.
get_session_user(SessionID) ->
    case mnesia:dirty_read(trends_session,SessionID) of 
       [] -> {error, notfound}; 
        _User -> _User 
    end.
    

-spec before_action(Req :: any(), Module :: string(), Action :: string()) -> ok | {json, []}.
before_action(Req, Module, Action) ->
    AccessToken = Req:cookie("AccessToken"),
    get_session_cookie(AccessToken, Module, Action).

-spec get_session_cookie(SessionID :: string(), Module :: string(), Action :: string()) ->ok | {json, []}.
get_session_cookie(SessionID, Module, Action) ->
    case mnesia:dirty_read(trends_session,SessionID) of    
        [] -> {redirect,[{action,"index"}, {result, Module},{result1,Action}]}; 
        _ -> ok 
    end.

-spec get_session_cookie_user_id(SessionID :: string()) -> userid | {json, []}.
get_session_cookie_user_id(SessionID) ->
    case mnesia:dirty_read(trends_session,SessionID) of    
        [] -> false; 
        [TrendUser] -> 
            TrendUser#trends_session.user_id
    end.

-spec get_session_nickname(Session :: any()) -> nickname | [].
get_session_nickname(Session) ->
    case get_session_user(Session) of
        {error, _} -> " ";
        [Users] -> Users#trends_session.nickname
    end.

-spec del_session_cookie(SessionID :: string(), Module :: string(), Action :: string()) -> {json, []}.
del_session_cookie(SessionID, Module, Action) ->
    DelSession = {trends_session, SessionID},
    case mnesia:dirty_delete(DelSession) of
        ok ->{json, ?SUCCESSFUL("/"++Module++"/"++Action, "200", "Successful")};
        _ ->{json, ?ERROR_CODE("/"++Module++"/"++Action, "10001", "System error")}
    end.

-spec param_is_null(Params :: list(), Module :: string(), Action :: string()) -> true | false.
param_is_null(Params, Module, Action) ->
    F = fun(X)-> case X of false->true; undefined -> true; _ ->false  end end, 
    NullList = lists:filter(F, Params),
    Boolean = length(NullList) > 0,
    case Boolean of
        true -> ?ERROR_CODE("/"++Module++"/"++Action,"10016","Miss required parameter (%s) , see doc for more info");
        false -> false
    end.

-spec verify_username(UserName :: string()) -> true | false.
verify_username(UserName) ->                   
    case trends_riak_query:count(users,[{"username", 'equal', UserName}],[]) of 
        0 -> true;
        _UserList ->
           false 
    end.

-spec verify_email(Email :: string()) -> true | false.
verify_email(Email) ->                        
    case trends_riak_query:count(users,[{"email", 'equal', Email}],[]) of 
        0 -> true;
        _UserList ->
           false 
    end.

get_userid_by_ws(Ws) ->
    [TrendSession] = mnesia:dirty_index_read(trends_session, Ws, ws),
    TrendSession#trends_session.user_id.

get_userid_by_token(Token) ->
    [TrendSession] =  mnesia:dirty_read(trends_session, Token),
    TrendSession#trends_session.user_id.


-spec get_ws_by_userid(UserId :: string()) -> port() | [].
get_ws_by_userid(UserId) ->
    case mnesia:dirty_index_read(trends_session, UserId, user_id) of
        [TrendSession] ->
            case TrendSession#trends_session.ws of
                [] -> 
                    mnesia:dirty_delete_object(TrendSession), 
                    [];
                Ws -> 
                    Ws
            end;
        L when is_list(L) ->
            F = fun(TrendSession, Acc) ->
                    case TrendSession#trends_session.ws of
                        [] -> 
                            mnesia:dirty_delete_object(TrendSession), 
                            Acc;
                        Ws -> 
                            [Ws | Acc]
                    end
                end,
            lists:foldl(F, [], L);
        [] ->
            []
    end.


-spec get_followed(FollowedId :: string(), FollowerId :: string()) -> list().
get_followed(FollowedId, FollowerId) ->
    boss_db:find(friendship,[{followed_id, FollowedId},
                             {follower_id, FollowerId}]).
-spec get_offset(Index :: string()) ->integer().
get_offset(Index) ->
    (to_integer(Index) - 1) * ?PAGE_MAX_ITEM.

-spec get_user_friend_follower_count(Users :: any()) -> [] .
get_user_friend_follower_count(Users) ->
    F = fun(U, Acc) ->
        Id = U:id(),
        FriendsCount = boss_db:count(friendship, [{follower_id, 'equals', Id}, {type, 'equals', "0"}]),
        FollowersCount = boss_db:count(friendship, [{followed_id, 'equals', Id}, {type, 'equals', "0"}]),
        ColumnsCount = boss_db:count(column, [{user_id, 'equals', Id}]),
        FavouritesCount = boss_db:count(favorite, [{author_id, 'equals', Id}]),
        InfoCount = boss_db:count(info, [{author_id, 'equals', Id}]),
        UserNew = boss_record:new(userlist, 
                                    [%{id,"userlist-temp1111"},
                                     {user_id,Id},
                                     {avata_url,U:avata_url()},
				     				 {cover_url, U:cover_url()},
                                     {location,U:location()},{bio,U:bio()},
                                     {username,U:username()},
                                     {nickname,U:nickname()},
                                     {register_date,U:register_date()},
                                     {email,U:email()},{whether_push,U:whether_push()},
                                     {reserved,U:reserved()},{use_type,U:use_type()},
                                     {need_confirmation,U:need_confirmation()},
                                     {blog,U:blog()},{phone,U:phone()},
                                     {friends_count, to_string(FriendsCount)},
                                     {favourites_count, to_string(FavouritesCount)},
                                     {columns_count, to_string(ColumnsCount)},
                                     {followers_count, to_string(FollowersCount)},
                                     {info_count,  to_string(InfoCount)}]
                                ),
        UserNew1 = UserNew:attributes(),
        [UserNew1|Acc]
    end,
    %[Us] = Users,
    %error_logger:info_msg("In ~p line ~p Username=~p~n", [?MODULE, ?LINE, Us:username()]),
    case Users of
        [] -> [];
        UserList -> lists:foldr(F, [], UserList) 
    end.
     
get_skip_num(Start, _Max) when Start<0 ->
    1;
get_skip_num(Start, Max) -> 
    (Start-1)*Max+1.

to_integer(X) when is_integer(X) -> X;
to_integer(X) when is_list(X) -> list_to_integer(X);
to_integer(X) when is_tuple(X) -> 1;
to_integer(X) -> 1.

to_string(X) when is_integer(X) -> integer_to_list(X);
to_string(X) when is_list(X) -> X; 
to_string(X) -> "0".

get_str_num(N) when N<10 ->
    "0"++integer_to_list(N);
get_str_num(N) ->
    integer_to_list(N).


%% @spec List = favorites_list()
get_ext_info_from_favorites(List) ->
	Fun = fun(X, Acc) ->
		Info_id = X:info_id(),
		Favorite_count = to_integer(X:count()),
		CC = boss_db:find(comment_count, [{info_id,Info_id}]),
		if
			CC == [] ->
				Comment_count = 0;
			is_tuple(CC) ->
				Comment_count = CC:count();
			is_list(CC) ->
				[Item1] = CC,
				Comment_count = Item1:count();
			true ->
				Comment_count = 0				
		end,
		User = boss_db:find(X:author_id()),
		%error_logger:info_report({?MODULE, ?LINE, User}),
		Info = boss_db:find(Info_id),
		case User of
			{error, _} ->
				UserExt = "user not exsit";
			_ ->
				[UserExt] = get_user_friend_follower_count([User])
		end,
		%error_logger:info_report({?MODULE, ?LINE, Info, UserExt}),
		InfoList = boss_record:new(info_list, [
			%{id, "info_list-temp0000"},
			{info_id, Info_id},
			{cid, Info:cid()}, % Cid
            {title, Info:title()},
			{introduction, Info:introduction()},
			{page_count, to_string(X:page_count())},
			{tmf,  mochijson2:decode(Info:tmf())},
			{map, mochijson2:decode(Info:map())},
            {template, mochijson2:decode(Info:template())},
            {fromwhere, Info:fromwhere()},     % Fromwhere,
            {lat, to_string(Info:lat())},     % Lat,
            {lng, to_string(Info:lng())},     % Lng,
            {phone, Info:phone()},     % Phone,
            {placename, Info:placename()},     % Placename,
            {timestamp, Info:timestamp()},     % Timestamp, 
            {time_int,  to_string(Info:time_int())}, 
            {author_id, Info:author_id()},     % AuthorId,
            {author_ext, UserExt},     % AuthorName,  %% only for info_list
            {parent_msg_id, Info:parent_msg_id()}, %      ParentMsgId,
            {reply_to_user_id, Info:reply_to_user_id()},    %   ReplyToUserId,
            {address, Info:address()},    %  Address,
            {tags, Info:tags()},      % Tags,
            {img_url, " "},  % 
            {video_url, " "},   %   VideoUrl,
            {column_id, Info:column_id()},   %   ColumnId,
            {favorite_count, to_string(Favorite_count)},    %  FavoriteCount,  %% only for info_list
            {comment_count, to_string(Comment_count)},    % CommentCount,  %% only for info_list
            {rank, to_string(Info:rank())}    %  Rank
		]),
		%error_logger:info_report({?MODULE, ?LINE, InfoList}),
		InfoExt = InfoList:attributes(),
		%error_logger:info_report({?MODULE, ?LINE, InfoExt}),
		[InfoExt|Acc]
	end,
	lists:foldr(Fun, [], List).
	 %[Fun(X) || X <- List].
	
get_ext_info_from_infos(List) ->
	Fun = fun(X, Acc) ->
		Info_id = X:id(),
		Favorite = boss_db:find(favorite_count, [{info_id, Info_id}]),
		if
			Favorite == [] ->
				Favorite_count = 0;
			is_tuple(Favorite) ->
				Favorite_count = Favorite:count();
			is_list(Favorite) ->
				[Item] = Favorite,
				Favorite_count = Item:count();
			true ->
				Favorite_count = 0				
		end,
		CC = boss_db:find(comment_count, [{info_id,Info_id}]),
		if
			CC == [] ->
				Comment_count = 0;
			is_tuple(CC) ->
				Comment_count = CC:count();
			is_list(CC) ->
				[Item1] = CC,
				Comment_count = Item1:count();
			true ->
				Comment_count = 0				
		end,
                AuthorId = X:author_id(),
		User = boss_db:find(AuthorId),
                %error_logger:info_report({?MODULE,?LINE,X}),
		case User of
			{error, _} ->
				Acc;
			_ ->
				[UserExt] = get_user_friend_follower_count([User]),
				InfoList = boss_record:new(info_list, [
					%{id, "info_list-temp0011"},
					{info_id, Info_id},
					{cid, X:cid()}, % Cid
					{title, X:title()},
					{introduction, X:introduction()},
           			{page_count, to_string(X:page_count())},
           			{tmf,   mochijson2:decode(X:tmf())},
			        {map,  mochijson2:decode(X:map())},
                    {template, mochijson2:decode(X:template())},
            		{fromwhere, X:fromwhere()},     % Fromwhere,
            		{lat, to_string(X:lat())},     % Lat,
            		{lng, to_string(X:lng())},     % Lng,
            		{phone, X:phone()},     % Phone,
            		{placename, X:placename()},     % Placename,
            		{timestamp, X:timestamp()},     % Timestamp,  
            		{time_int,  to_string(X:time_int())},
            		{author_id, X:author_id()},     % AuthorId,
            		% {author_ext, UserExt},     % AuthorName,  %% only for info_list
            		{parent_msg_id, X:parent_msg_id()}, %      ParentMsgId,
            		{reply_to_user_id, X:reply_to_user_id()},    %   ReplyToUserId,
            		{address, X:address()},    %  Address,
            		{tags, X:tags()},      % Tags,
            		{img_url, " "},  %    ImgUrl,%% [FileName, Url, FileSize]
            		{video_url, " "},   %   VideoUrl,
            		{column_id, X:column_id()},   %   ColumnId,
            		{favorite_count,  to_string(Favorite_count)},    %  FavoriteCount,  %% only for info_list
            		{comment_count,  to_string(Comment_count)},    % CommentCount,  %% only for info_list
            		{rank,  to_string(X:rank())},    %  Rank
            		{author_ext, UserExt}
				]),
                error_logger:info_report({?MODULE,?LINE,X}),
				InfoExt = InfoList:attributes(),
				[InfoExt|Acc]
		end end,
		lists:foldr(Fun, [], List).
	%%[Fun(X) || X <- List].
get_ext_columns(Columns) ->
    F = fun(U, Acc) ->
        Id = U:id(),
        CollectionCount = boss_db:count(collection, [{column_id, 'equals', Id}]),
        InfoCount = boss_db:count(info, [{column_id, 'equals', Id}]),
        End = trends_utils:get_time_sec(),
		Begin = trends_utils:get_ago_time_sec(7),
        WeeklyNewinfoCount = boss_db:count(info, [{column_id, 'equals', Id},
        							{time_int, 'in', {Begin,End}}]),
        ColumnExt = boss_record:new(column_ext, [
        							{id, U:id()},
                                    {name, U:name()},
                                    {type_id, U:type_id()},
                                    {user_id, U:user_id()},
                                    {timestamp, U:timestamp()},
                                    {time_int, to_string(U:time_int())},
                                    {avata_url, U:avata_url()},
                                    {cover_url, U:cover_url()},
                                    {prior, U:prior()},
                                    {defaults,U:defaults()},
                                    {note, U:note()},
                                    {collection_count, to_string(CollectionCount)},
                                    {info_count, to_string(InfoCount)},
                                    {weekly_newinfo_count, to_string(WeeklyNewinfoCount)},
                                    {share, U:share()}
                                ]),
        error_logger:info_msg("In ~p line ~p columnExt=~p~n", [?MODULE, ?LINE, ColumnExt]),
        [ColumnExt:attributes()|Acc]
    end,
    case Columns of
        [] -> [];
        ColumnList -> lists:foldr(F, [], ColumnList) 
    end.	

get_ext_comments(Comments)->
	F = fun(X, Acc) ->
        User = boss_db:find(X:user_id()),
        UserExt = get_user_friend_follower_count([User]),
        NewComments = boss_record:new(comment_ext,[
        				{id, X:id()},
        				{timestamp,X:timestamp()},
        				{time_int,to_string(X:time_int())},
        				{content, X:content()},
        				{info_id, X:info_id()},
        				{user_id, X:user_id()},
        				{user_ext, UserExt}
        				]),
    	[NewComments:attributes()|Acc]
    end,
    case Comments of
        [] -> [];
        CommentList -> lists:foldr(F, [], CommentList) 
    end.
    
get_attributes(List) ->
	[X:attributes() || X <- List].
	
get_model_id(Model, OldMode, Id) when is_integer(Id) ->
    ?DEBUG(":get_model_id ~p Id=~p~n", [?MODULE, ?LINE, Id]),
    Model ++ "-" ++ integer_to_list(Id);
get_model_id(Model, OldMode, Id) when is_list(Id)->
    case string:tokens(Id, "-") of
        [Id] ->
            ?DEBUG(":get_model_id ~p Id=~p~n", [?MODULE, ?LINE, Id]),
            Model ++ "-" ++ Id;
        [OldMode, NewId] ->
            ?DEBUG(":get_model_id ~p Id=~p~n", [?MODULE, ?LINE, Id]),
            Model ++ "-" ++ NewId;
        _ ->
            ?DEBUG(":get_model_id ~p Id=~p~n", [?MODULE, ?LINE, Id]),
            Id
    end;
get_model_id(_Model, _OldMode, Id) ->
    ?DEBUG(":get_model_id ~p Id=~p~n", [?MODULE, ?LINE, Id]), Id.


get_int_id(Id) when is_integer(Id)->
    Id;
get_int_id(Id) ->
    [_Model, NewId] = string:tokens(Id, "-"),
    case catch list_to_integer(NewId) of
        {'EXIT', _ } -> Id;
        R -> R
    end.
   
get_pagecount_number(Count, SinglePageNumber) ->
    PageCount =
        case Count of
            0 ->
                0;  
            _ ->
                IntNumber = Count rem SinglePageNumber,
                Number = Count div SinglePageNumber,
                case IntNumber>=1  of  
                    true ->
                       Number+1; 
                    false ->
                       Number
                end 
        end,
    PageCount. 


seconds_to_datatime(Seconds) ->
    DateTime = calendar:gregorian_seconds_to_datetime(Seconds),
    get_datetime(DateTime).
	
get_result(List, Session)->
    NickName = trends_utils:get_session_nickname(Session),
    PR=trends_utils:get_session_privilege(Session),
    A = lists:append([{username, NickName}, {img_upload_url, ?IMGURL}], PR),
    Result = lists:append(A, List),
    Result.

get_conf()->
    PlatformJson =
        case boss_db:find("cms_configuration-platform") of
            {error,notfound} -> [];        
            {_, _, Pla} -> Pla
        end,
    PlatformList = get_conf_list(PlatformJson),
    ServerJson = 
        case boss_db:find("cms_configuration-server") of
            {error,notfound} -> [];        
            {Mos, Kes, ServerJson_} -> ServerJson_
        end,
    ServerList = get_conf_list(ServerJson),
    ResolutionJson = 
        case boss_db:find("cms_configuration-resolution") of
            {error,notfound} -> [];        
            {_, _, Res} -> Res
        end,
    ResolutionList = get_conf_list(ResolutionJson),

    [PlatformList, ServerList, ResolutionList].

get_conf_book_or_publicity()->
    BookConfJson = 
        case boss_db:find("cms_configuration-book_conf") of
            {error,notfound} -> [];        
            {_, _, Bok} -> Bok 
        end,
    BookConfList = get_conf_list(BookConfJson),
    PublicityConfJson =                     
        case boss_db:find("cms_configuration-publicity_conf") of
            {error,notfound} -> [];        
            {_, _, Pub} -> Pub 
        end,
    PublicityConfList = get_conf_list(PublicityConfJson),
    
    CoverConfJson = 
        case boss_db:find("cms_configuration-cover_conf") of
            {error,notfound} -> [];
            {_, _, Cov} -> Cov
        end,
    CoverConfList = get_conf_list(CoverConfJson),

    F = fun([{_, Id},{_, Val}], Acc) ->
        Value = mochijson2:decode(Val), 
        {_, V} = Value,
        Ma = [{id, Id}|V],
        [Ma|Acc]
    end,
    BookConf = 
        case BookConfList of
            [] -> [];
            _ -> lists:foldl(F, [], BookConfList) 
        end,
    PublicityConf = 
        case PublicityConfList of
            [] -> [];
            _ ->  lists:foldl(F, [], PublicityConfList)
        end, 
    CoverConf = 
        case CoverConfList of
            [] -> [];
            _ ->  lists:foldl(F, [], CoverConfList)
        end, 
    %%[lists:reverse(BookConf), lists:reverse(PublicityConf)].
    [BookConf, PublicityConf, CoverConf].

get_conf_list(List) ->
    ConfTurn = 
        case List of
            [] -> [];
            "[]" -> [];
            ListJson ->
                case mochijson2:decode(ListJson) of
                    [{struct, T2}] -> 
                            case T2 of
                                [{<<"id">>,_},_,_] -> 
                                     [{Ids2, Vas2} ||  [{<<"id">>, Ids2}, {<<"value">>, Vas2},_] <- [T2]];
                                _ -> [{Ids3, Vas3} ||  [{<<"id">>, Ids3}, {<<"value">>, Vas3},_] <- T2]
                            end;
                    [{H, T}] -> T;
                    {H1, T1} -> T1;
                    V -> [{Ids, Vas} || {struct, [{<<"id">>, Ids}, {<<"value">>, Vas},_]} <- V]
                end
        end,
    F = fun({Id, Va}, Acc) ->
            It = [{id, Id},{value, Va}],   
            [It|Acc];
        ({struct, V3}, Acc) ->
            It1 = [{id, proplists:get_value(<<"id">>, V3)},
                   {value, proplists:get_value(<<"value">>, V3)}],   
            [It1|Acc]
    end,
    Conflist = 
        case ConfTurn of
            [] -> [];
            _ -> lists:foldr(F, [], ConfTurn)
        end,
    Conflist.
    
get_conf_value_by_key(Key) ->
    case boss_db:find("cms_configuration-"++Key) of
        {error, notfound} -> [];
        O -> 
            mochijson2:decode(O:value())
    end.

write_conf(Key, Value) ->
    write_conf(Key, Value, "").

write_conf(Key, Value, "") ->
    write_conf(Key, Value, trends_utils:get_guid());
write_conf(Key, Value, ValueId) ->
    case boss_db:find("cms_configuration-"++Key) of
        {error, notfound} ->
            NewValue = list_to_binary(mochijson2:encode([{trends_utils:get_guid(), Value}])),
            Obj = boss_record:new(cms_configuration, [{id, "cms_configuration-"++Key},
                                                      {value, NewValue}]),
            case Obj:save() of
                {ok, V} -> 
                    {cms_configuration, _, Va} = V, 
                    {struct, Value1} = mochijson:decode(binary_to_list(Va)),
                    [{Id, _}] = Value1,
                    [{result, "ok"},{id, Id}];
                _ -> [{result, "error"}] 
            end;
        R ->
            NewValue = 
                case mochijson2:decode(R:value()) of
                    {struct, L} ->
                        L1 = proplists:delete(ValueId, L),
                        L2 = proplists:delete(list_to_binary(ValueId), L1),
                        L3 = lists:keydelete(Value, 2, L2),
                        list_to_binary(mochijson2:encode([{ValueId, Value}|L3]));
                    [] -> list_to_binary(mochijson2:encode([{ValueId, Value}]))
                end,
            Obj = boss_record:new(cms_configuration, [{id, "cms_configuration-"++Key},
                                                      {value, NewValue}]),
            case Obj:save() of
                {ok, V} -> 
                    {cms_configuration, _, Va} = V, 
                    {struct, Value1} = mochijson:decode(binary_to_list(Va)),
                    [{Id, _}|H] = Value1,
                    [{result, "ok"},{id, Id}];
                _ -> [{result, "error"}] 
            end
    end.

write_conf(Key, Value, "", Order) ->
    write_conf(Key, Value, trends_utils:get_guid(), Order);
write_conf(Key, Value, " ", Order) ->
    write_conf(Key, Value, trends_utils:get_guid(), Order);
write_conf(Key, Value, ValueId, Order) ->
    case boss_db:find("cms_configuration-"++Key) of
        {error, notfound} ->
            NewValue = list_to_binary(
                            mochijson2:encode([[{"id", ValueId},%%trends_utils:get_guid()}, 
                                                {value, Value}, 
                                                {order, Order}]])),
            Obj = boss_record:new(cms_configuration, [{id, "cms_configuration-"++Key},
                                                      {value, NewValue}]),
            case Obj:save() of
                {ok, V} -> 
                    {cms_configuration, _, Va} = V, 
                    [{struct, Value1}|H1] = mochijson2:decode(binary_to_list(Va)),
                    Id = proplists:get_value(<<"id">>, Value1, ""),
                    [{result, "ok"},{id, Id}];
                _ -> [{result, "error"}] 
            end;
        R ->
            L = mochijson2:decode(R:value()),
            L2 = filter(L, ValueId),
            NewValue = list_to_binary(
                            mochijson2:encode([[{"id", ValueId}, 
                                                {value, Value}, 
                                                {order, Order}]|L2])),
            ?DEBUG("write_conf ~p L1=~p~n L2=~p~n NewValue=~p~n ValueId=~p~n", 
                    [?MODULE, ?LINE, L, L2, NewValue, ValueId]),
            Obj = boss_record:new(cms_configuration, [{id, "cms_configuration-"++Key},
                                                      {value, NewValue}]),
            case Obj:save() of
                {ok, V} -> 
                    {cms_configuration, _, Va} = V, 
                    [{struct, Value1}|H1] = mochijson2:decode(binary_to_list(Va)),
                    Id = proplists:get_value(<<"id">>, Value1, ""),
                    [{result, "ok"},{id, Id}];
                _ -> [{result, "error"}] 
            end
    end.

filter(L, ValueId) ->
    [[{Id, Value}, {Id1, Value1}, {Id2, Value3}]||
        {struct, [{Id, Value}, {Id1, Value1}, {Id2, Value3}]}<-L, ValueId /= Value].

update_collection_count(Column_id, Int) ->
	case boss_db:find(Column_id) of
		{error,_} ->
			error;
		Column ->
			Colunm1 = Column:set(collection_count, to_integer(Column:collection_count()) + Int),
			Colunm1:save()
	end.
			
screen_platform(List, Platform)->   
    F = fun(Brand, Acc)->
        Plat = 
            case Brand:platform() of
                undefined -> ""; 
                [] -> ""; 
                _P -> _P                                                                                                                        
            end,
        Boolean = string:str(Plat, Platform) >=1,
        case Boolean of
            true ->  [Brand|Acc];
            false -> Acc 
        end 
    end,
    case List of
        [] -> []; 
        _ -> lists:foldr(F, [], List)
    end.
get_current_user_id(Req) ->
    AccessToken = Req:cookie("AccessToken"),
    trends_utils:get_session_cookie_user_id(AccessToken).


get_value(Req, Method, Param) ->
    get_value(Req, Method, Param, " ").
get_value_default_space(Req, Method, Param) ->
    get_value(Req, Method, Param, " ").

get_value(Req, 'POST', Param, Default) ->
    case Req:post_param(Param) of
        [] -> Default;
        undefined -> Default;
        R -> R
    end; 
get_value(Req, 'GET', Param, Default) ->
    case Req:query_param(Param) of
        [] -> Default;
        undefined -> Default;
        R -> R
    end. 


%% page number
get_page_number(Count, SinglePageNumber) ->
    get_pagecount_number(Count, SinglePageNumber).


get_device_name_by_id(Id) ->
    {struct, L} = get_conf_value_by_key("platform"),
    error_logger:info_msg("In ~p line ~p get_device_name_by_id  id L  ~p~n ~p~n",[?MODULE, ?LINE, Id,L]), 
    case lists:keyfind(list_to_binary(Id), 1, L) of
        {_Id, Name} ->
            Name; 
        false->
            ""
    end.
 
get_device_id_by_name(Name) ->
    {struct, L} = get_conf_value_by_key("platform"),
    case lists:keyfind(Name, 2, L) of
        {Id, Name} when is_binary(Id)->
            binary_to_list(Id);
        {Id, Name} when is_list(Id)->
            Id
    end.
    
get_resolution_name_by_id(Id) ->
    {struct, L} = get_conf_value_by_key("resolution"),
    case lists:keyfind(list_to_binary(Id), 1, L) of
        {_Id, Name} ->
            Name ;
             false->
            ""
    end.
 
get_resolution_id_by_name(Name) ->
    {struct, L} = get_conf_value_by_key("resolution"),
    case lists:keyfind(Name, 2, L) of
        {Id, Name} when is_binary(Id)->
            binary_to_list(Id);
        {Id, Name} when is_list(Id)->
            Id
    end.


get_decode(Year) ->
    case catch list_to_integer(Year) of
        {'EXIT', _} -> 
            base64:decode_to_string(Year);
        _Year -> 
            Year
    end.



