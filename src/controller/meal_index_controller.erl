-module(meal_index_controller,[Req,Session]).

-export([
       before_/1,
       tooltip/2,
       login/2,
       welcome/2  
        ]).

-include("trends_admin.hrl").
-include("trends.hrl").

before_("trends_login")->
    ok;
before_("tooltip")->
    ok;
before_("login")->
    ok;
before_(_Other)->
     trends_utils:before_session_action(Session).



tooltip('GET', [])->
    ok.

login('GET', [])->
 
    ok;

login('POST',[]) ->
   
	Name=Req:post_param("name"), 
	PassWord=Req:post_param("password"), 	
	Type=Req:post_param("type"),
     error_logger:info_msg("In ~p line ~p value=~p~n", [?MODULE, ?LINE, [Name,PassWord,Type]]),   
    case lists:member(Type,[undefined,"undefined",[]]) of
         true->
                {json,[{result,"type_error"}]};
         false->
                case lists:member(Type,[undefined,"undefined",[]]) or lists:member(Type,[undefined,"undefined",[]]) of
                     true->
                      {json,[{result,"user_error"}]};
                     false->
                      case Type of
                           "admin" ->
                              case boss_db:find(admin,[{name,'equals',Name},{passwd,'equals',PassWord}],[]) of
                                   []->
                                         {json,[{result,"user_error"}]};        
                                   [User]-> 
                                         trends_utils:init_session(Session,User),
                                         {json,[{result,"ok"}]}
                              end;
                            "seller"->
                                case boss_db:find(seller,[{name,'equals',Name},{passwd,'equals',PassWord}],[]) of
                                   []->
                                         {json,[{result,"user_error"}]};        
                                   [User]-> 
                                         {json,[{result,"ok"}]}
                               end

                      end

                 end         
    end.            



welcome('GET', [])->
	Return=trends_utils:get_return_append([],Session),
    {ok,Return}.









      

