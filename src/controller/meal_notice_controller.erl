-module(meal_notice_controller,[Req,Session]).

-export([
        before_/1,
        show/2,
        add/2,
        edit/2,
        post_templatefile/2,
        delete/2
        ]).

-include("trends_admin.hrl").
-include("trends.hrl").

before_(_Other)->

     trends_utils:before_session_action(Session).




post_templatefile('POST', [])->
       
  case catch Req:post_files() of
        [] ->
            "error";
       [{uploaded_file, FileName, Url, FileSize}] ->
         case Url=="file exist"  of
             true->
                {output,Url};
             false->
                
                ImageUrl=string:sub_string(Url,7,length(Url)),   
                Http="http://"++Req:header(host)++ImageUrl, 
				error_logger:info_msg("In ~p line ~p value= ~p~n",[?MODULE, ?LINE,[Req:header(host),Req:header(domain),Http]]), 
               {json,[{url,Http},{error, 0}]}
         end;
 
        Error ->
            "error"
   end.




show('GET', [])->

	 Page = case Req:query_param("page_get") of
            [] ->
                1;
            undefined ->
                1;
            _ ->
                list_to_integer(Req:query_param("page_get"))
             end,
      Count=boss_db:count(notice),    
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page), 
      %error_logger:info_msg("In ~p line ~p count=~p pages=~p max_item=~p Offset=~p~n",[?MODULE, ?LINE,Count,Page_count,?PAGE_MAX_ITEM, Offset]),
      List = boss_db:find(notice, [], [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      %error_logger:info_msg("In ~p line ~p Page Page_count List ~p~n ~p~n ~p~n",[?MODULE, ?LINE,Page, Page_count ,List]),     
      Return=trends_utils:get_return_append([{noticelist,List},{current_p,Page},
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
     Title_=case Req:post_param("title") of
           [] ->lists:append([],Time);
           Title->lists:append([{title,'matches',Title}],Time)

       end,
   
     N=case Req:post_param("creator") of
           [] ->lists:append([],Title_);
           Creator->lists:append([{creator,'matches',Creator}],Title_)

       end,
     
 
      Count=boss_db:count(notice,N), 
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page),
      %error_logger:info_msg("In ~p line ~p    N =>~p~n  Offset=~p Page=~p~n",[?MODULE, ?LINE, N,Offset,Page]),
      List = boss_db:find(notice, N, [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      QE=[{starttime,Req:post_param("starttime")},{endtime,Req:post_param("endtime")},
          {title,Req:post_param("title")},{creator,Req:post_param("creator")}],
      Append=lists:append([{noticelist,List},{current_p,Page},{page_count,Page_count},{method_type, "post"},{count, Count}],QE),
      Return=trends_utils:get_return_append(Append,Session),
      {ok,Return}.




add('GET', [])->
   Return=trends_utils:get_return_append([{img_upload_url, ?IMGURL}],Session),
   {ok,Return};
add('POST', [])->
	save("save").




edit('GET',[Id])->
       
	Notice=boss_db:find(Id),
    error_logger:info_msg("In ~p line ~p Id=~p~n notice =>~p~n",[?MODULE, ?LINE, Id,Notice]),
 	Return=trends_utils:get_return_append([{notice,Notice},{img_upload_url, ?IMGURL}],Session),
    {ok,Return};
edit('POST', [])->
	save("edit").

save(Type)->
	Title=Req:post_param("title"),
	Content=Req:post_param("summent"),
	case Type of
		     "save"->
              Fields= [{title,Title},
                      {content,Content},                                       
					  {creator,trends_utils:get_session_value(Session,name)},   
					  {createtime,trends_utils:get_datetime()},
                      {timesec,trends_utils:get_time_sec()}
                    ],
              Notice = boss_record:new(notice,Fields), 
	      case Notice:save() of
                    {ok,_}->
                              {json,[{result,"ok"}]};  
         
                     _  ->
                              {json,[{result,"error"}]}
	      end;

              "edit"->
                   Id=Req:post_param("id"),                  
                   Fields2= [  
                     
                    {title,Title},
                    {content,Content}
                     
                    ],
                   
                   Notice2=(boss_db:find(Id)):set(Fields2),  
                   % error_logger:info_msg("In ~p line ~p Notice2=>~p~n",[?MODULE, ?LINE, [Notice2]]),               
	           case Notice2:save() of
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








      

