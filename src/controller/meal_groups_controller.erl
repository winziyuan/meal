-module(meal_groups_controller,[Req,Session]).

-export([
        before_/1,
        show/2,
        add/2,
        edit/2,
        delete/2,
        delete_relate/2,
        items_show/2,
        items_add/2,
        items_add_fun/2
        ]).

-include("trends_admin.hrl").
-include("trends.hrl").

before_(_Other)->
     trends_utils:before_session_action(Session).


show('GET', [])->

	 Page = case Req:query_param("page_get") of
            [] ->
                1;
            undefined ->
                1;
            _ ->
                list_to_integer(Req:query_param("page_get"))
             end,
      Count=boss_db:count(groups),    
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page), 
      %error_logger:info_msg("In ~p line ~p count=~p pages=~p max_item=~p Offset=~p~n",[?MODULE, ?LINE,Count,Page_count,?PAGE_MAX_ITEM, Offset]),
      List = boss_db:find(groups, [], [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      %error_logger:info_msg("In ~p line ~p Page Page_count List ~p~n ~p~n ~p~n",[?MODULE, ?LINE,Page, Page_count ,List]),     
      Return=trends_utils:get_return_append([{groupslist,List},{current_p,Page},
             {page_count,Page_count},{count,Count},{method_type, "get"}],Session),
    
      {ok,Return};


show('POST', [])->
 
     Page = case Req:post_param("page_post") of
            [] ->
                1;
            undefined ->
                1;
            _ ->
                list_to_integer(Req:post_param("page_post"))
           end,      
     S_Time=case Req:post_param("starttime") of
           [] ->[];
           Vs->Vs

            end, 
     E_Time=case Req:post_param("endtime") of
           [] ->[];
           Ve->Ve

            end, 
     Time=case (S_Time==[]) and (E_Time==[]) of
              true ->[];
              false->[{"createtime",'in',{S_Time,E_Time}}]
          end,

     Name_=case Req:post_param("name") of
           [] ->lists:append([],Time);
           Name->lists:append([{"name",'contains',Name}],Time)

       end,
   
     State_=case Req:post_param("state") of
           [] ->lists:append([],Name_);
           State->lists:append([{"state",'equal',State}],Name_)

       end,
      Isused_=case Req:post_param("isused") of
           [] ->lists:append([],State_);
           Isused->lists:append([{"isused",'equal',Isused}],State_)

       end,
     Paytype_=case Req:post_param("paytype") of
           [] ->lists:append([],Isused_);
           Paytype->lists:append([{"paytype",'equal',Paytype}],Isused_)

       end,
     Address_=case Req:post_param("address") of
           [] ->lists:append([],Paytype_);
           Address->lists:append([{"address",'contains',Address}],Paytype_)

       end,
     P=case Req:post_param("phone") of
           [] ->lists:append([],Address_);
           Phone->lists:append([{"phone",'contains',Phone}],Address_)

       end,      
     N=case Req:post_param("desc") of
           [] ->lists:append([],P);
           Desc ->lists:append([{"desc",'contains',Desc}],P)

       end, 
 
      Count=trends_riak_query:count(groups,N,[]), 
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page),
      error_logger:info_msg("In ~p line ~p    N =>~p~n  Offset=~p Page=~p~n",[?MODULE, ?LINE, N,Offset,Page]),
      List=trends_riak_query:find(groups,N,[],Offset,?PAGE_MAX_ITEM),
      QE=[{starttime,Req:post_param("starttime")},{endtime,Req:post_param("endtime")},{phone,Req:post_param("phone")},
          {name,Req:post_param("name")},{isused,Req:post_param("isused")},{state,Req:post_param("state")},{paytype,Req:post_param("paytype")},
          {tel,Req:post_param("address")},{desc,Req:post_param("desc")}],
      Append=lists:append([{groupslist,List},{current_p,Page},{page_count,Page_count},{method_type, "post"},{count, Count}],QE),
      Return=trends_utils:get_return_append(Append,Session),
      {ok,Return}.




add('GET', [])->
   Return=trends_utils:get_return_append([{img_upload_url, ?IMGURL}],Session),
   {ok,Return};
add('POST', [])->
	save("save").




edit('GET',[Id])->
       
	Groups=boss_db:find(Id),
    error_logger:info_msg("In ~p line ~p Id=~p~n groups =>~p~n",[?MODULE, ?LINE, Id,Groups]),
 	Return=trends_utils:get_return_append([{groups,Groups},{img_upload_url, ?IMGURL}],Session),
    {ok,Return};
edit('POST', [])->
	save("edit").

save(Type)->
	Name=Req:post_param("name"),
	Desc=Req:post_param("desc"),
	Isused=Req:post_param("isused"),
	Groupmoney=Req:post_param("groupmoney"),
	Percentage=Req:post_param("percentage"),
	case Type of
		     "save"->
              Fields= [{name,Name},
                      {desc,Desc},                   
                      {isused,Isused},
                      {tatalmoney,0},
                      {groupmoney,0},  
					  {percentage,0},                  
                      {sum,0},
                      {sellerid,trends_utils:get_session_value(Session,id)},  
					  {creator,trends_utils:get_session_value(Session,name)},   
					  {createtime,trends_utils:get_datetime()},
                      {timesec,trends_utils:get_time_sec()}
                    ],
              Groups = boss_record:new(groups,Fields), 
	      case Groups:save() of
                    {ok,_}->
                              {json,[{result,"ok"}]};  
         
                     _  ->
                              {json,[{result,"error"}]}
	      end;

              "edit"->
                   Id=Req:post_param("id"),
                   
                   Fields2= [  
                      {name,Name},
                      {desc,Desc},
                      {isused,Isused},      
                      {groupmoney,Groupmoney},  
                      {percentage,Percentage}
                    ],
                   Groups2=(boss_db:find(Id)):set(Fields2),                  
	           case Groups2:save() of
                          {ok,_}->
                                  {json,[{result,"ok"}]};           
                           _  ->
                                  {json,[{result,"error"}]}
	           end
	       end.
	

delete('POST', [])->
	Id = Req:post_param("id"),
    %error_logger:info_msg("In ~p line ~p Userid =~p~n",[?MODULE, ?LINE, Userid]),
    Ids=string:tokens(Id,","),
	[begin 		

        N=[{"sellerid",'equal',trends_utils:get_session_value(Session,id)},{"relateid",'equal',NewId}],
        Relateids=trends_riak_query:find(food_item,N,["id"]),
		error_logger:info_msg("In ~p line ~p delete values= ~p~n",[?MODULE, ?LINE,[Relateids]]),    
        [boss_db:delete(Relateid)||Relateid <- lists:merge(Relateids)],
        case catch boss_db:delete(NewId) of 
            ok -> ok; 
            Err->Err 
        end
     end || NewId <- Ids],
	{json,[{result,"ok"}]}.
delete_relate('POST', [])->
	Id = Req:post_param("id"),
    %error_logger:info_msg("In ~p line ~p Userid =~p~n",[?MODULE, ?LINE, Userid]),
    Ids=string:tokens(Id,","),
	[begin     
       FoodItem=boss_db:find(NewId),   
       Groups=boss_db:find(FoodItem:relateid()), 
       Newtatal= Groups:tatalmoney()-FoodItem:price(),
       Newsum=Groups:sum()-1,
       (Groups:set([{tatalmoney,Newtatal},{groupmoney,Newtatal},{sum,Newsum}])):save(),

        case catch boss_db:delete(NewId) of 
            ok -> ok; 
            Err->Err 
        end
     end || NewId <- Ids],
	{json,[{result,"ok"}]}.

items_show('GET', [Id])->
	 Currentid=trends_utils:get_session_value(Session,id),
	 Page = case Req:query_param("page_get") of
            [] ->
                1;
            undefined ->
                1;
            _ ->
                list_to_integer(Req:query_param("page_get"))
             end,
      N=[{"sellerid",'equal',Currentid},{"relateid",'equal',Id}],
      Count=trends_riak_query:count(food_item,N),    
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page), 
      
      %error_logger:info_msg("In ~p line ~p count=~p pages=~p max_item=~p Offset=~p~n",[?MODULE, ?LINE,Count,Page_count,?PAGE_MAX_ITEM, Offset]),
      List = lists:reverse(trends_riak_query:lists_sort_field(trends_riak_query:find(food_item,N,[],Offset,?PAGE_MAX_ITEM),"createtime")),
      %error_logger:info_msg("In ~p line ~p Page Page_count List ~p~n ~p~n ~p~n",[?MODULE, ?LINE,Page, Page_count ,List]),     
      Return=trends_utils:get_return_append([{items,List},{current_p,Page},
             {page_count,Page_count},{count,Count},{method_type, "get"},{method_type, "get"},{controller,groups},{relateid,Id}],Session),
    
      {ok,Return}.

items_add('GET', [Id])->
	 Currentid=trends_utils:get_session_value(Session,id),
	 Page = case Req:query_param("page_get") of
            [] ->
                1;
            undefined ->
                1;
            _ ->
                list_to_integer(Req:query_param("page_get"))
             end,
      
      Count=trends_riak_query:count(food,[{"sellerid",'equal',Currentid}]),    
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page), 
      %error_logger:info_msg("In ~p line ~p count=~p pages=~p max_item=~p Offset=~p~n",[?MODULE, ?LINE,Count,Page_count,?PAGE_MAX_ITEM, Offset]),
      List = lists:reverse(trends_riak_query:lists_sort_field(trends_riak_query:find(food,[{"sellerid",'equal',Currentid}],[],Offset,?PAGE_MAX_ITEM),"createtime")),
      %error_logger:info_msg("In ~p line ~p Page Page_count List ~p~n ~p~n ~p~n",[?MODULE, ?LINE,Page, Page_count ,List]),     
      Return=trends_utils:get_return_append([{foodlist,List},{current_p,Page},
             {page_count,Page_count},{count,Count},{method_type, "get"},{controller,groups},{relateid,Id}],Session),
    
      {ok,Return}.





items_add_fun('POST', [])->
    Relateid=Req:post_param("relateid"),
    Ids = Req:post_param("id"),
    IdList=string:tokens(Ids,","),
    [items_add_impl(Id,Relateid)||Id <- IdList],
    error_logger:info_msg("In ~p line ~p values= ~p~n",[?MODULE, ?LINE,[IdList,Ids,Relateid]]),    
    {json,[{result,"ok"}]}.


items_add_impl(Id,Relateid)->
	Currentid=trends_utils:get_session_value(Session,id),
    Ids=trends_riak_query:find(food_item,[{"sellerid",'equal',Currentid},{"relateid",'equal',Relateid},{"foodid",'equal',Id}],["id"]),
	error_logger:info_msg("In ~p line ~p values= ~p~n",[?MODULE, ?LINE,[lists:merge(Ids)]]),
    case  lists:merge(Ids) of

               [] ->
                         Food=boss_db:find(Id),
						 Foodname=Food:name(),
						 Groups=boss_db:find(Relateid),
						 Relatename=Groups:name(),
						 Newtatal=list_to_integer(Food:price())+Groups:tatalmoney(),
						 Newsum=1+Groups:sum(),
						 (Groups:set([{tatalmoney,Newtatal},{groupmoney,Newtatal},{sum,Newsum}])):save(),
                         Item = boss_record:new(food_item,
                                          [                                        
                                           {foodname,Foodname},
                                           {foodid,Id},
                                           {price,list_to_integer(Food:price())},
                                           {sellername,trends_utils:get_session_value(Session,name)},
                                           {sellerid,Currentid},
                                           {relatename,Relatename},
                                           {relateid,Relateid},
                                           {sum,1},
                                           {createtime,trends_utils:get_datetime()},
                      					   {timesec,trends_utils:get_time_sec()}
                                           ]
                               ),
                   case Item:save() of
                              {ok, R} ->
                                     error_logger:info_msg("In ~p line ~p Item:save() r=~p",[?MODULE, ?LINE, R]),
                                     {"ok"};
                               _ ->
                         
                                     {"error"}
                    end;
                 [Id2] ->
                    FoodItem=boss_db:find(Id2),
                    Foodsum=FoodItem:sum()+1,
                    (FoodItem:set([{sum,Foodsum}])):save(),
					Groups=boss_db:find(Relateid),
					Newtatal=FoodItem:price()+Groups:tatalmoney(),
				    Newsum=1+Groups:sum(),
				    (Groups:set([{tatalmoney,Newtatal},{groupmoney,Newtatal},{sum,Newsum}])):save()
     end.
	










      

