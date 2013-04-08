-module(meal_seller_controller,[Req,Session]).

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
      Count=boss_db:count(seller),    
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page), 
      %error_logger:info_msg("In ~p line ~p count=~p pages=~p max_item=~p Offset=~p~n",[?MODULE, ?LINE,Count,Page_count,?PAGE_MAX_ITEM, Offset]),
      List = boss_db:find(seller, [], [{limit, ?PAGE_MAX_ITEM},
			{offset, Offset},
			{order_by, createtime}, {descending, true}]),
      %error_logger:info_msg("In ~p line ~p Page Page_count List ~p~n ~p~n ~p~n",[?MODULE, ?LINE,Page, Page_count ,List]),     
      Return=trends_utils:get_return_append([{sellerlist,List},{current_p,Page},
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
 
      Count=trends_riak_query:count(seller,N,[]), 
      Page_count=trends_utils:get_page_count(Count,?PAGE_MAX_ITEM),
      Offset = trends_utils:get_offset(Page),
      error_logger:info_msg("In ~p line ~p    N =>~p~n  Offset=~p Page=~p~n",[?MODULE, ?LINE, N,Offset,Page]),
      List=trends_riak_query:find(seller,N,[],Offset,?PAGE_MAX_ITEM),
      QE=[{starttime,Req:post_param("starttime")},{endtime,Req:post_param("endtime")},{phone,Req:post_param("phone")},
          {name,Req:post_param("name")},{isused,Req:post_param("isused")},{state,Req:post_param("state")},{paytype,Req:post_param("paytype")},
          {tel,Req:post_param("address")},{desc,Req:post_param("desc")}],
      Append=lists:append([{sellerlist,List},{current_p,Page},{page_count,Page_count},{method_type, "post"},{count, Count}],QE),
      Return=trends_utils:get_return_append(Append,Session),
      {ok,Return}.




add('GET', [])->
   Return=trends_utils:get_return_append([{img_upload_url, ?IMGURL}],Session),
   {ok,Return};
add('POST', [])->
	save("save").




edit('GET',[Id])->
       
	Seller=boss_db:find(Id),
    error_logger:info_msg("In ~p line ~p Id=~p~n Seller =>~p~n",[?MODULE, ?LINE, Id,Seller]),
 	Return=trends_utils:get_return_append([{seller,Seller},{img_upload_url, ?IMGURL}],Session),
    {ok,Return};
edit('POST', [])->
	save("edit").

save(Type)->
	Name=Req:post_param("name"),
	Passwd=Req:post_param("passwd"),
	Desc=Req:post_param("desc"),
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
                      {desc,Desc},
                      {passwd,Passwd},
                      {email,Email},
                      {phone,Phone},
		      {logo,Logo},
                      {lat,Lat},
                      {tel,Tel},
                      {type,"seller"},
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
                      {desc,Desc},
                      {passwd,Passwd},
                      {email,Email},
                      {phone,Phone},
		      {logo,Logo},
                      {lat,Lat},
                      {tel,Tel},
                      {type,"seller"},
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
	Seller = boss_record:new(seller,Fields), 
	case Seller:save() of
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








      

