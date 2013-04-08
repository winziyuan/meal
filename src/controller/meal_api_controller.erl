-module(meal_api_controller,[Req,Session]).

-export([
        %before_/1,
        login/2,
        register/2,
        sellers/2
        ]).

-include("trends_admin.hrl").
-include("trends.hrl").






%before_("login")->
%     ok;
%before_("register")->
%     ok;
before_(_Other)->
     trends_utils:before_session_action(Session).

login('POST',[]) ->
   
	Phone=Req:post_param("phone"), 
	PassWord=Req:post_param("password"), 	
        error_logger:info_msg("In ~p line ~p value=~p~n", [?MODULE, ?LINE, [Phone,PassWord]]),   
  
        case lists:member(Phone,[undefined,"undefined",[]]) or lists:member(PassWord,[undefined,"undefined",[]]) of
             true->
              {json,[{result,"logininfo error"}]};
             false->
     
                      case trends_riak_query:find(consumer,[{"phone",'equal',Phone},{"passwd",'equal',PassWord}]) of
                           []->
                                 {json,[{result,"logininfo error"}]};        
                           [User]-> 
                                 trends_utils:init_session(Session,User),
                                 {json,[{result,"ok"}]}
                      end
                    

         end.         
   

register('POST',[]) ->
	Phone=Req:post_param("phone"), 
	Passwd=Req:post_param("password"), 	
        case lists:member(Phone,[undefined,"undefined",[]]) or lists:member(Passwd,[undefined,"undefined",[]]) of
                      true->        
                           {json,[{result,"userinfo error"}]};

                      false->
                          case trends_riak_query:find(consumer,[{"phone",'equal',Phone}]) of
                                [] ->
		                          Consumer = boss_record:new(consumer,
		                               [{name,Phone},
		                                {age," "},
		                                {sex,"o"},
		                                {passwd,Passwd},
						{avator," "},
						{note," "},
						{email," "},
						{phone,Phone},
						{type,"consumer"},
						{salary," "},
						{integration,0},
						{isused,"true"}, 
						{creator,Phone},          
						{createtime,trends_utils:get_datetime()},
						{timesec,trends_utils:get_time_sec()}  
		                              ]), 
					     case Consumer:save() of
						  {ok,_}->
							 {json,[{result,"ok"}]};  
					 
						  _  ->
							 {json,[{result,"error"}]}
					     end;        
				  _ ->
					{json,[{result,"user exist"}]}
                          end

         end.
          

sellers('GET',[]) ->
	
  	Page=Req:query_param("page"), 
	Number=Req:query_param("number"), 
        error_logger:info_msg("In ~p line ~p api sellers value=~p~n", [?MODULE, ?LINE, [Page,Number]]),   	
       Page2= case lists:member(Page,[undefined,"undefined",[]])  of
                       true->
                              1;
                       false->
                              case catch list_to_integer(Page) of 
                                    {error,_} -> 1; 
                                     V->V 
                              end
              end,
       Number2= case lists:member(Number,[undefined,"undefined",[]])  of
                       true->
                              ?PAGE_MAX_ITEM;
                       false->
                              case catch list_to_integer(Number) of 
                                    {error,_} -> 0; 
                                     V2->V2
                              end
              end,

      Count=boss_db:count(seller),    
      Page_count=trends_utils:get_page_count(Count,Number2),
      Offset = (Page2-1)* Number2,
      error_logger:info_msg("In ~p line ~p count=~p pages=~p max_item=~p Offset=~p~n",[?MODULE, ?LINE,Count,Page_count,?PAGE_MAX_ITEM, Offset]),
      List = boss_db:find(seller, [], [{limit, Number2},{offset, Offset},{order_by, createtime}, {descending, true}]),
        %,{currentpage,Page2},{count,Count}
     R= [{result, "200"},{brands, List}, {app, "sss"}],
    
      {json, List}.
      

