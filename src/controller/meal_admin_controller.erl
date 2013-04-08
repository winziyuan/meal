-module(meal_admin_controller ,[Req,Session]).

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
      Count=boss_db:count(admin),    
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page), 
      %error_logger:info_msg("In ~p line ~p count=~p pages=~p max_item=~p Offset=~p~n",[?MODULE, ?LINE,Count,Page_count,?PAGE_MAX_ITEM, Offset]),
      List = boss_db:find(admin, [], [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      error_logger:info_msg("In ~p line ~p Page Page_count List ~p~n ~p~n ~p~n",[?MODULE, ?LINE,Page, Page_count ,List]),
      %PR=trends_utils:get_session_privilege(Session),
      Return=trends_utils:get_return_append([{userlist,List},{current_p,Page},{page_count,Page_count},{method_type, "get"},{count,Count}],Session),
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
     error_logger:info_msg("In ~p line ~p start time=~p end time=~p~n role=~p sex=~p isdisplay=~p ",
     [?MODULE, ?LINE, Req:post_param("starttime"),Req:post_param("endtime"),Req:post_param("role"),Req:post_param("sex"),Req:post_param("isdisplay")]),
  
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
     P=case Req:post_param("phone") of
           [] ->lists:append([],Time);
           Phone->lists:append([{phone,'matches',Phone}],Time)

       end,
     E=case Req:post_param("email") of
           [] ->lists:append([],P);
           Email->lists:append([{email,'matches',Email}],P)

       end,      
     Name_=case Req:post_param("name") of
           [] ->lists:append([],E);
           Name->lists:append([{name,'matches',Name}],E)

       end, 
     N=case Req:post_param("desc") of
           [] ->lists:append([],Name_);
           Desc ->lists:append([{descs,'matches',Desc}],Name_)

       end, 
 
      Count=boss_db:count(admin,N), 
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page),
      %error_logger:info_msg("In ~p line ~p    N =>~p~n  Offset=~p Page=~p~n",[?MODULE, ?LINE, N,Offset,Page]),
      List = boss_db:find(admin, N, [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      QE=[{starttime,Req:post_param("starttime")},{endtime,Req:post_param("endtime")},{phone,Req:post_param("phone")},
          {email,Req:post_param("email")},{desc,Req:post_param("desc")},{name_,Req:post_param("name")}],
      %error_logger:info_msg("In ~p line ~p    value =>~p~n ",[?MODULE, ?LINE, [List]]),   
      Append=lists:append(trends_utils:get_return_append([{userlist,List},{current_p,Page},{page_count,Page_count},{method_type, "post"},{count,Count}],Session),QE),
      {ok,Append}.



add('GET', [])->
   Return=trends_utils:get_return_append([],Session),
   {ok,Return};

add('POST', [])->
	Name=Req:post_param("name"),
	Email=Req:post_param("email"),
	case boss_db:count(admin,[{name,'equals',Name},{email,'equals',Email}]) of
              0->
                   save("save");
              _ ->
                   {json,[{result,"exsit"}]}
	end.

edit('GET',[Id])->
    
	User=boss_db:find(Id),
 	Return=trends_utils:get_return_append([{user,[User]}],Session),
    error_logger:info_msg("In ~p line ~p trends_admin_user_modify Return =>~p~n",[?MODULE, ?LINE, Return]),
    {ok,Return};


edit('POST', [])->
         
	Name=Req:post_param("name"),
        Id=Req:post_param("id"),
        error_logger:info_msg("In ~p line ~p trends_admin_user_modify disable =>~p~n",[?MODULE, ?LINE, Req:post_param("disable")]),
	case boss_db:find(admin,[{name,'equals',Name}]) of
              []->
                  save("edit");
              [Admin] ->
                   case Admin:id()==Id of
                        false->
                            {json,[{result,"exsit"}]};
                        true->
                            save("edit")
                   end
	end.
	

save(Type)->
	Name=Req:post_param("name"),
	Email=Req:post_param("email"),
	Passwd=Req:post_param("passwd"),
	Desc=Req:post_param("desc"),
	Phone=Req:post_param("phone"),
        Disable=Req:post_param("disable"),
        CreateTime = trends_utils:get_datetime(),
	Timesec = trends_utils:get_time_sec(),
	Fields=case Type of
		      "save"->
                   [  {name,Name},
                      {descs," "},
                      {passwd,Passwd},
                      {type,"admin"},
                      {email,Email},
                      {phone," "},
                      {disable,"false"},
                      {createtime,CreateTime},
                      {timesec,Timesec}
                    ];
              "edit"->
                   Id=Req:post_param("id"),
                   [  {id,Id},
                      {name,Name},
                      {descs,Desc},
                      {passwd,Passwd},
                      {type,"admin"},
                      {email,Email},
                      {phone,Phone},
                      {disable,Disable},
                      {createtime,CreateTime},
                      {timesec,Timesec}
                    ]
	       end,
	Admin = boss_record:new(admin,Fields), 
	case Admin:save() of
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













      

