-module(meal_food_controller,[Req,Session]).

-export([
        before_/1,
        show/2,
        add/2,
        edit/2,
        delete/2
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
      Count=boss_db:count(food),    
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page), 
      error_logger:info_msg("In ~p line ~p count=~p pages=~p max_item=~p Offset=~p~n",[?MODULE, ?LINE,Count,Page_count,?PAGE_MAX_ITEM, Offset]),
      List = boss_db:find(food, [], [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      error_logger:info_msg("In ~p line ~p  List= ~p~n",[?MODULE, ?LINE,List]),     
      Return=trends_utils:get_return_append([{foodlist,List},{current_p,Page},
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
           undefined ->[];
           Vs->Vs

            end, 
     E_Time=case Req:post_param("endtime") of
           [] ->[];
           undefined ->[];
           Ve->Ve

            end, 
     Time=case (S_Time==[]) and (E_Time==[]) of
              true ->
                [];
              false->
                case (S_Time=/=[]) and (E_Time==[]) of
                      true->
                         [{createtime,'gt',S_Time}];
                      false->
                         case (S_Time==[]) and (E_Time=/=[]) of
                               true->
                                  [{createtime,'lt',E_Time}];
                               false->
                                  [{createtime,'in',{S_Time,E_Time}}]  
                         end      
                end      
           
          end,

     Name_=case Req:post_param("name") of
           [] ->lists:append([],Time);
           Name->lists:append([{name,'matches',Name}],Time)

       end,
     Isused_=case Req:post_param("isused") of
           [] ->lists:append([],Name_);
           Isused->lists:append([{isused,'equals',Isused}],Name_)

       end,
   
     N=case Req:post_param("desc") of
           [] ->lists:append([],Isused_);
           Desc ->lists:append([{descs,'matches',Desc}],Isused_)

       end, 
 
      Count=boss_db:count(food,N), 
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page),
      %error_logger:info_msg("In ~p line ~p    N =>~p~n  Offset=~p Page=~p~n",[?MODULE, ?LINE, N,Offset,Page]),
      List = boss_db:find(food,N, [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      QE=[{starttime,Req:post_param("starttime")},{endtime,Req:post_param("endtime")},
          {name_,Req:post_param("name")},{isused,Req:post_param("isused")},
         {desc,Req:post_param("desc")}],
      Append=lists:append([{foodlist,List},{current_p,Page},{page_count,Page_count},{method_type, "post"},{count, Count}],QE),
      Return=trends_utils:get_return_append(Append,Session),
      {ok,Return}.




add('GET', [])->
   Return=trends_utils:get_return_append([{img_upload_url, ?IMGURL}],Session),
   {ok,Return};
add('POST', [])->
	save("save").




edit('GET',[Id])->
       
	Food=boss_db:find(Id),
    error_logger:info_msg("In ~p line ~p Id=~p~n food =>~p~n",[?MODULE, ?LINE, Id,Food]),
 	Return=trends_utils:get_return_append([{food,Food},{img_upload_url, ?IMGURL}],Session),
    {ok,Return};
edit('POST', [])->
	save("edit").

save(Type)->
	Name=Req:post_param("name"),
	Desc=Req:post_param("desc"),
	Price=Req:post_param("price"),
	Image=Req:post_param("icon"),
	Unit=Req:post_param("unit"),
	Isused=Req:post_param("isused"),
	Known=Req:post_param("known"),
	CreateTime = Req:post_param("createtime"),
	Timesec = Req:post_param("timesec"),
	case Type of
		      "save"->
              Fields= [  {name,Name},
                      {descs,Desc},
                      {price,Price},
                      {unit,Unit},
					  {known,Known},
					  {image,Image},
                      {isused,Isused},
                      {sellerid,trends_utils:get_session_value(Session,id)},  
					  {sellername,trends_utils:get_session_value(Session,name)},   
					  {createtime,trends_utils:get_datetime()},
                      {timesec,trends_utils:get_time_sec()}
                    ],
              Food = boss_record:new(food,Fields), 
	      case Food:save() of
                    {ok,_}->
                              {json,[{result,"ok"}]};  
         
                     _  ->
                              {json,[{result,"error"}]}
	      end;

              "edit"->
                   Id=Req:post_param("id"),
                   
                  Fields2= [  
                      {name,Name},
                      {descs,Desc},
                      {price,Price},
                      {unit,Unit},
					  {known,Known},
					  {image,Image},
                      {isused,Isused}
                    
                    ],
                   Food2=(boss_db:find(Id)):set(Fields2),                  
	           case Food2:save() of
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
        case catch boss_db:delete(NewId) of 
            ok -> ok; 
            Err->Err 
        end
     end || NewId <- Ids],
	{json,[{result,"ok"}]}.








      

