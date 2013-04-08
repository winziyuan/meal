
//delete classified
function add(userid_,type,pid)
{
	var privileges_l = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				privileges_l = privileges_l+","+el[i].value;
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
		privileges_l = $("#userid").val();
	}else
	{
		privileges_l = userid_;
	}
	var Url = "/adminaccount/trend_privilege_add_user";
	var userlistnew =  privileges_l;

    var param = {id:userlistnew,p_id:pid};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "add ok")
			{
				//window.location="/adminaccount/meda_admin_user";
                                $("#error_content_id").html("添加该权限的用户成功!");
				$("#error_content_id").show();
                                 $('input:checkbox').attr("checked",false);
                               window.setInterval("window.location='/adminaccount/trends_privilege_users/"+pid+"'",3000);
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });		
};


function del(userid_,type,pid)
{        
	var privileges_l = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				privileges_l = privileges_l+","+el[i].value;
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
		privileges_l = $("#userid").val();
	}else
	{
		privileges_l = userid_;
	}
	var Url = "/adminaccount/trend_privilege_users_delete";
	var userlistnew =  privileges_l;

    var param = {id:userlistnew};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "delete")
			{
				//window.location="/adminaccount/meda_admin_user";
                        // var dels=userlistnew.split(",");
                           // alert("userlist="+userlistnew+" dels="+dels);
                         // for(var i=0; i<dels.length; i++){
                         // $("#item_"+dels[i]).remove();

                        // };
                          window.setInterval("window.location='/adminaccount/trends_privilege_users/"+pid+"'",1000);
                        // window.location="/adminaccount/trends_privilege_users/"+pid;
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });		
};




