

//delete classified
function del_category(userid_,type)
{
	var categoryidlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				categoryidlist = categoryidlist+","+el[i].value;
				elem = true;
			} 
		} 
		if(!elem)
		{
			$("#error_content_id").html("请选择分类!");
			$("#error_content_id").show();
			return;
		}
	}else if(type == "3"){
		categoryidlist = $("#userid").val();
	}else
	{
		categoryidlist = userid_;
	}
	var Url = "/category/delete";
	var categorylistnew =  categoryidlist;

    var param = {id:categorylistnew};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				//window.location="/adminaccount/meda_admin_user";
                         //var dels=userlistnew.split(",");
                           // alert("userlist="+userlistnew+" dels="+dels);
                         // for(var i=0; i<dels.length; i++){
                        //  $("#item_"+dels[i]).remove();

                        // };
                         window.location="/category/show";
                   
                 
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });		
};




// user add
$("#create_submit").bind("click",function(){

  
        var categoryname = $.trim($("#name").val());       
	var desc = $.trim($("#desc").val());       




	if(categoryname == "" || categoryname == null)
	{
		$("#error_content_id").html("请输入分类名");
		$("#error_content_id").show();
		$("#name").focus();
		return;
	}; 
	

        if(desc== "" || desc == null)
	{
		$("#desc").val(" ");
		
	};
         
      
    var Url = "/category/add";
	
    var param = $("#create_category_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("创建成功");
			 $("#error_content_id").show();
             setInterval("window.location='/category/show'",2000);
                         
			}else if(result.result == "exsit"){
             
                $("#error_content_id").html("名称已存在！");
				$("#error_content_id").show();
                        }
                         else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });
	
});



$("#edit_submit").bind("click",function(){
   
     if($("#change_").val() == 'true'){
		$("#error_content_id").html("您没做任何改动,请修改后在进行保存!");
		$("#error_content_id").show();
        return;
	}  
	var categoryname = $.trim($("#name").val());       
	var desc = $.trim($("#desc").val());       
	


	if(categoryname == "" || categoryname == null)
	{
		$("#error_content_id").html("请输入分类名");
		$("#error_content_id").show();
		$("#name").focus();
		return;
	}; 
	

        if(desc== "" || desc == null)
	{
		$("#desc").val(" ");
		
	};
         
       

             
    var Url = "/category/edit";	
    var param = $("#edit_category_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("修改成功");
			 $("#error_content_id").show();
             setInterval("window.location='/category/show'",2000);
                         
			}else if(result.result == "exsit"){
             
                $("#error_content_id").html("名称已存在！");
				$("#error_content_id").show();
                        }
                         else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });
	
});












