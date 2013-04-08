/**
 * @author david
 */
$(function() { 

var method_type = $("#method_type").val();
	if(method_type=="get")
	{
		$("#page_post").val("");
		$("#count_post").val("");
	}else
	{
		$("#page_get").val("");
		$("#count_get").val("");
	}
});
// page under click
$("#page_under").bind("click",function(){
        var method_type = $("#method_type").val();
        var page = $("#page_"+method_type).val();
        var count = $("#count_"+method_type).val();
        if(Number(page) < Number(count) && Number(page) >= 1)
        {
                $("#page_"+method_type).val(Number(page)+1);
                //alert("ssssssssssssssssss");
                $("#user_"+method_type+"_page").submit();
        }else if(page == count)
        {
                $("#error_content_id").html("已经是最后一页了!");
                $("#error_content_id").show();
        }
});

// page on click  page_go
$("#page_on").bind("click",function(){
        var method_type = $("#method_type").val();
        var page = $("#page_"+method_type).val();
        var count = $("#count_"+method_type).val();
        if(Number(page) >= 2)
        {
                $("#page_"+method_type).val(Number(page)-1);
                $("#user_"+method_type+"_page").submit();
        }else if(Number(page) <= 1)
        {
                $("#error_content_id").html("已经是第一页了!");
                $("#error_content_id").show();
        }
});
$("#search").bind("click",function(){
 
          $("#page_post").val(1);
         $("#user_post_page").submit();
        
});

// page page_go click  
$("#page_go").bind("click",function(){
        $("#error_content_id").html(" ");
        var method_type = $("#method_type").val();
        var page = $("#page_"+method_type).val();
        var count = $("#count_"+method_type).val();
        var page_go_number = $("#page_go_number").val();
        if(!isNaN(page_go_number))
        {
                if(Number(page_go_number) <= Number(count) && Number(page_go_number) >= 1)
                {
                        $("#page_"+method_type).val(page_go_number);
                        $("#user_"+method_type+"_page").submit();
                }else 
                {
                        $("#error_content_id").html("输入有误,请重新输入!");
                        $("#error_content_id").show();
                }
        }else
        {
                $("#error_content_id").html("输入有误,请重新输入!");
                $("#error_content_id").show();
        }
});
