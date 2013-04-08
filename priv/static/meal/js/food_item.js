

//delete classified
function del_(userid_,type,controller)
{
	var groupsidlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				groupsidlist = groupsidlist+","+el[i].value;
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
		groupsidlist = $("#userid").val();
	}else
	{
		groupsidlist = userid_;
	}
	var Url = "/"+controller+"/delete_relate";
	var groupslistnew =  groupsidlist;
    
    var param = {id:groupslistnew};
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
                        
                        window.setInterval("window.location='/"+controller+"/show/'",2000);
                 
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });		
};




function add(userid_,type,controller,relateid)
{
	var relatelist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				relatelist = relatelist+","+el[i].value;
				elem = true;
			} 
		} 
		if(!elem)
		{
			$("#error_content_id").html("请选择!");
			$("#error_content_id").show();
			return;
		}
	}else if(type == "3"){
		relatelist = $("#userid").val();
	}else
	{
		relatelist = userid_;
	}
	var Url = "/"+controller+"/items_add_fun";
	var userlistnew =  relatelist;

    var param = {id:userlistnew,relateid:relateid};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				//window.location="/adminaccount/meda_admin_user";
                                $("#error_content_id").html("添加成功!");
				$("#error_content_id").show();
                                 $('input:checkbox').attr("checked",false);
                               window.setInterval("window.location='/"+controller+"/items_show/"+relateid+"'",2000);
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });		
};







