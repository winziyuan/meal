-module(meal_service_controller,[Req,Session]).

-export([
       % before_/1,
        show/2,
        add/2,
        edit/2,
        delete/2 
        ]).

-include("trends_admin.hrl").
-include("trends.hrl").




%before_(_Other)->

%     trends_utils:before_session_action(Session).




show('GET', [])->

	 Page = case Req:query_param("page_get") of
            [] ->
                1;
            undefined ->
                1;
            _ ->
                list_to_integer(Req:query_param("page_get"))
             end,
      Count=boss_db:count(service),    
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page), 
      %error_logger:info_msg("In ~p line ~p count=~p pages=~p max_item=~p Offset=~p~n",[?MODULE, ?LINE,Count,Page_count,?PAGE_MAX_ITEM, Offset]),
      List = boss_db:find(service, [], [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      error_logger:info_msg("In ~p line ~p Page Page_count List ~p~n ~p~n ~p~n",[?MODULE, ?LINE,Page, Page_count ,List]),     
      Return=trends_utils:get_return_append([{servicelist,List},{current_p,Page},
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
           undefined ->lists:append([],Time);
           Name->lists:append([{name,'matches',Name}],Time)

       end,
     Email_=case Req:post_param("email") of
           [] ->lists:append([],Name_);
           undefined ->lists:append([],Name_);
           Email->lists:append([{email,'matches',Email}],Name_)

       end,
     State_=case Req:post_param("state") of
           [] ->lists:append([],Email_);
           undefined ->lists:append([],Email_);
           State->lists:append([{state,'equals',State}],Email_)

       end,
      Isused_=case Req:post_param("isused") of
           [] ->lists:append([],State_);
           undefined ->lists:append([],State_);
           Isused->lists:append([{isused,'equals',Isused}],State_)

       end,
     Paytype_=case Req:post_param("paytype") of
           [] ->lists:append([],Isused_);
           undefined ->lists:append([],Isused_);
           Paytype->lists:append([{paytype,'equals',Paytype}],Isused_)

       end,
     Address_=case Req:post_param("address") of
           [] ->lists:append([],Paytype_);
           undefined ->lists:append([],Paytype_);
           Address->lists:append([{address,'matches',Address}],Paytype_)

       end,
     P=case Req:post_param("phone") of
           [] ->lists:append([],Address_);
           undefined ->lists:append([],Address_);
           Phone->lists:append([{phone,'matches',Phone}],Address_)

       end,      
     N=case Req:post_param("desc") of
           [] ->lists:append([],P);
           undefined ->lists:append([],P); 
           Desc ->lists:append([{descs,'matches',Desc}],P)

       end, 
 
      Count=boss_db:count(service,N),    
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page), 
      error_logger:info_msg("In ~p line ~p N=~p~n",[?MODULE, ?LINE,[N]]),
      List = boss_db:find(service, N, [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      QE=[{starttime,Req:post_param("starttime")},{endtime,Req:post_param("endtime")},{phone,Req:post_param("phone")},
          {name_,Req:post_param("name")},{email,Req:post_param("email")},{isused,Req:post_param("isused")},{state,Req:post_param("state")},{paytype,Req:post_param("paytype")},
          {tel,Req:post_param("address")},{descs,Req:post_param("desc")}],
      Append=lists:append([{servicelist,List},{current_p,Page},{page_count,Page_count},{method_type, "post"},{count, Count}],QE),
      Return=trends_utils:get_return_append(Append,Session),
      {ok,Return}.

edit('GET', [Id])->
     Service=boss_db:find(Id),
     Return=trends_utils:get_return_append([{service,Service},{img_upload_url, ?IMGURL}],Session),
     {ok,Return};
edit('POST', [])->
     save("edit").

add('GET', [])->  
   Return=trends_utils:get_return_append([{img_upload_url, ?IMGURL}],Session),
   {ok,Return};
add('POST', [])->
   save("save").


save(Type)->
	Name=Req:post_param("name"),
	Passwd=Req:post_param("passwd"),
	Descs=Req:post_param("descs"),
	Email=Req:post_param("email"),
	Phone=Req:post_param("phone"),
	Logo=Req:post_param("icon"),
	Lat=Req:post_param("lat"),
	Tel=Req:post_param("tel"),
	Paytype=Req:post_param("paytype"),
	Lan=Req:post_param("lan"),
        Address=Req:post_param("address"),
	CreateTime = trends_utils:get_datetime(),
	Timesec = trends_utils:get_time_sec(),
	State=Req:post_param("state"),
	Isused=Req:post_param("isused"),

	Fields=case Type of
		      "save"->
                   [  {name,Name},
                      {descs,Descs},
                      {passwd,Passwd},
                      {email,Email},
                      {phone,Phone},
		      {logo,Logo},
                      {lat,Lat},
                      {tel,Tel},
                      {type,"service"},
                      {lan,Lan},
                      {paytype,Paytype},
                      {address,Address}, 
                      {state,State},
                      {isused,Isused},
                      {creator,trends_utils:get_session_value(Session,name)},          
                      {createtime,CreateTime},
                      {timesec,Timesec}
                    ];
              "edit"->
                   Id=Req:post_param("id"),
                   
                   [  {id,Id},
                      {name,Name},
                      {descs,Descs},
                      {passwd,Passwd},
                      {email,Email},
                      {phone,Phone},
		      {logo,Logo},
                      {lat,Lat},
                      {tel,Tel},
                      {type,"service"},
                      {lan,Lan},
                      {paytype,Paytype},
                      {address,Address}, 
                      {state,State},
                      {isused,Isused},
                      {creator,trends_utils:get_session_value(Session,name)},        
                      {createtime,CreateTime},
                      {timesec,Timesec}
                    ]
	       end,
	Service = boss_record:new(service,Fields), 
	case Service:save() of
         {ok,_}->
                  {json,[{result,"ok"}]};  
         
          _  ->
                  {json,[{result,"error"}]}
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













      

