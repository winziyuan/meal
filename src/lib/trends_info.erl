%%%-------------------------------------------------------------------
%%% @author wangguancheng <wangguancheng@trends.com.cn>
%%% @copyright (C) 2012, itrends
%%% @doc
%%%
%%% @end
%%% Created : 31 Aug 2012 by wangguancheng <wangguancheng@trends.com.cn>
%%%-------------------------------------------------------------------
-module(trends_info).
-include("trends.hrl").
-export([
         return_info_list/1,
         return_info_list_post/1,
         return_appcover_list_post/1,
         return_column_list_post/1,
         getinfo_first/1,
         get_value/2,
         get_content_list_json/1,
         get_content_list_json_base64/1
        ]).

return_info_list(InfoList) ->
    F = fun(X, Acc) ->
        Id = X:id(),
        Title = "",%%X:title(),
        Content = "",%%X:content(),
        Introduction = "",%%X:introduction(),
        Timestamp = X:timestamp(),
        Fromwhere = X:fromwhere(), 
        ImgUrl = "",%%X:img_url(),
        PageHeading = "",%%X:page_heading(),
        StyleContent = "",%%X:style_content(),
        StyleId = "",%%X:style_id(),
        TemId = "",%%X:tem_id(),
        UserName = 
            case boss_db:find(X:author_id()) of
                {error,notfound} -> "";
                _User -> _User:username()
            end,
        ColumnName = 
            case boss_db:find(X:column_id()) of
                {error,notfound} -> "";
		undefined -> "";
                _Column -> _Column:name()
            end,
        Info = 
            [{id, Id}, {title, Title}, {introduction, Introduction},
             {fromwhere, Fromwhere}, {username, UserName}, 
             {style_content, StyleContent},{style_id, StyleId},
             {content, Content}, {img_url, ImgUrl}, {page_heading, PageHeading}, 
             {timestamp, Timestamp}, {columnname, ColumnName}, {tem_id, TemId}
            ],
        [Info | Acc] 
    end,
    case InfoList of
        [] -> [];
        _InfoList -> 
           lists:foldr(F, [], InfoList) 
    end.  

return_info_list_post(InfoList) ->
    F = fun(X, Acc) ->
        Id = proplists:get_value("id", X),
        Title = proplists:get_value("title", X),
        Content = proplists:get_value("content", X),
        Introduction = proplists:get_value("introduction", X),
        Timestamp = proplists:get_value("timestamp", X),
        Fromwhere = proplists:get_value("fromwhere", X), 
        ImgUrl = proplists:get_value("img_url", X),
        PageHeading = proplists:get_value("page_heading", X),
        UserName = 
            case boss_db:find(proplists:get_value("author_id", X)) of
                {error,notfound} -> "";
                _User -> _User:username()
            end,
        ColumnName = 
            case boss_db:find(proplists:get_value("column_id", X)) of
                {error,notfound} -> "";
                _Column -> _Column:name()
            end,
        Info = 
            [{id, Id}, {title, Title}, {introduction, Introduction},
             {fromwhere, Fromwhere}, {username, UserName}, 
             {content, Content}, {img_url, ImgUrl}, {page_heading, PageHeading}, 
             {timestamp, Timestamp}, {columnname, ColumnName}
            ],
        [Info | Acc] 
    end,
    case InfoList of
        [] -> [];
        _InfoList -> 
           lists:foldr(F, [], InfoList) 
    end.

return_appcover_list_post(AppcoverList) ->
    F = fun(X, Acc) ->
        Id = proplists:get_value("id", X),
        Note = proplists:get_value("note", X),
        Status = proplists:get_value("status", X),
        ImgUrl = proplists:get_value("Img_3x2_url", X),
        Timestamp = proplists:get_value("timestamp", X),
        Appcover = 
            [{id, Id}, {note, Note}, {status, Status},
             {timestamp, Timestamp}, {img_url, ImgUrl}
            ],
        [Appcover | Acc] 
    end,
    case AppcoverList of
        [] -> [];
        _ -> 
           lists:foldr(F, [], AppcoverList) 
    end.

return_column_list_post(ColumnList) ->
    F = fun(X, Acc) ->
        Id = proplists:get_value("id", X),
        Note = proplists:get_value("note", X),
        Name = proplists:get_value("name", X),
        Prior = proplists:get_value("prior", X),
        Timestamp = proplists:get_value("timestamp", X),
        Column = 
            [{id, Id}, {note, Note}, {name, Name},
             {timestamp, Timestamp}, {prior, Prior}
            ],
        [Column | Acc] 
    end,
    case ColumnList of
        [] -> [];
        _ -> 
           lists:foldr(F, [], ColumnList) 
    end.

getinfo_first(List)->
   
    case List of
        [] -> [];
        _ -> 
         case get_value(List,[])of
              [] ->[];
             [Return]->Return
         end
    end.

get_value([],Acc)->
	Acc;
get_value([{_,Value}|T],Acc)->
    First_value = proplists:get_value(<<"1">>, Value),
       case First_value =/=undefined of
         true->  get_value(T,[First_value|Acc]);
         false->get_value(T,Acc)
        end.

get_content_list_json([]) ->
    mochijson2:encode([]);
get_content_list_json("[]") ->
    mochijson2:encode([]);
get_content_list_json(JsonList) ->
    ContentList = mochijson2:decode(JsonList),
    List = [X || {struct, [X]} <- ContentList],
    list_to_binary(mochijson2:encode(List)).
    
get_content_list_json_base64([]) ->
    [];
get_content_list_json_base64("[]") ->
    [];
get_content_list_json_base64(JsonList) ->
    ContentList = mochijson2:decode(JsonList),
    F = fun({struct, [X]}, Acc) ->
            {Id, V} = X,
            [{struct, [{Id, base64:encode(V)}]}|Acc]
           %% [{struct, [{list_to_binary("bt"++binary_to_list(Id)), base64:encode(V)}]}|Acc]
           %% [{list_to_binary("bt"++binary_to_list(Id)), base64:encode(V)}|Acc]
    end,
    List = lists:foldr(F, [], ContentList),
    ?DEBUG("List,mochijson2:encode(List) ~p~n ~p~n",[List,mochijson2:encode(List)]),
    list_to_binary(mochijson2:encode(List)).
    
    
