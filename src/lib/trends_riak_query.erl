-module(trends_riak_query).

%% API
-export([
      count/3,
      count/2,
      count/1,
      find/5,
      find/3,
      find/2,
      find/1,
      get_date_sort_desc/1,
      lists_sort_field/2
     
]).

-include("trends.hrl").

find(RecordName)->
    find(RecordName,[],[]).

find(RecordName,QueryCondition)->
	find(RecordName,QueryCondition,[]).

find(RecordName,QueryCondition,Fields)->
   Bucket=trends_utils:record2bucket(RecordName),
   Query =
        [{map, {modfun, trend_riak, map2},
               {query_list,atom_to_list(RecordName),QueryCondition,Fields}, false},
          {reduce, {modfun, trend_riak, reduce2}, 
                  {}, true}
        ],
   Result= case boss_db:mapred(RecordName,Bucket,Query) of
           {ok, [{_,R}]} -> R;
            {ok,[]} -> []
           end,
   lists:reverse(lists_sort_field(Result,"createtime")).

find(RecordName,QueryCondition,Fields,Start,Count)->
   MapValue= find(RecordName,QueryCondition,Fields),
   Index=Start+1,
   SubResult=lists:sublist(MapValue,Index,Count),
   SubResult.


count(RecordName)->
	count(RecordName,[],[]).

count(RecordName,QueryCondition)->
	count(RecordName,QueryCondition,[]).



count(RecordName,QueryCondition,Fields)->
   Bucket=trends_utils:record2bucket(RecordName),
   Query =
        [{map, {modfun, trend_riak, map2},
               {query_list,atom_to_list(RecordName),QueryCondition,[]}, false},
          {reduce, {modfun, trend_riak, reduce2}, 
                  {count}, true}
        ],
   case boss_db:mapred(RecordName,Bucket,Query) of
           {ok, [{_,[R]}]} -> R;
            _ -> 0
   end.


get_date_sort_desc(List) ->
    F = fun(A, B) ->
        V1 = proplists:get_value("register_date", A),
        V2 = proplists:get_value("register_date", B),
        if 
            V1 < V2 -> true;
             V1 >= V2 -> false
        end 
    end,
    case List of
        [] -> [];
        _ -> lists:sort(F, List)
    end.


lists_sort_field(List,Field) ->
    F = fun(A, B) ->
        V1 = proplists:get_value(Field, A),
        V2 = proplists:get_value(Field, B),
        if 
            V1 < V2 -> true;
            V1 >= V2 -> false
        end 
        end,
   case List of
        [] -> [];
        _ -> 
      lists:sort(F, List)
   end.





















