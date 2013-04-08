$("#privileges_create").bind("click", function(){ 
      
	privileges_add();	
});


function privileges_add()
{       
	var name = $("#privilege_name").val();
	var desc = $("#privilege_desc").val();
	var Url = "/adminaccount/trends_privileges_add";
	$.post(Url,{name:name,desc:desc},function(result){
		if(result != null)
		{
			if(result.result == "add ok")
			{
				//window.location="/adminaccount/trends_privileges";
                                $("#error_content_id").html("权限添加成功!");
				$("#error_content_id").show();
                                window.setInterval("window.location='/adminaccount/trends_privileges'",3000);
                                
			}else if(result.result == "add exist")
			{
                                     
				$("#error_content_id").html("已经存在该权限!");
				$("#error_content_id").show();
				//$("#user_name_id").focus();
				//$("#passwd_id").val("");
			}
		}
	});	
};


//delete classified
function del_privileges(userid_,type,pid)
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
	var Url = "/adminaccount/trend_privileges_delete";
	var userlistnew =  privileges_l;
      alert("delete del_privileges");
    var param = {id:userlistnew,p_id:pid};
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
                          window.location="/adminaccount/trends_privileges";
                         
                         
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });



	
};


function edit_privileges(id)
{
       

        if($("#change_").val() == 'true'){
		$("#error_content_id").html("您没做任何改动,请修改后在进行保存!");
		$("#error_content_id").show();
	}else{

        var desc = $("#privileges_desc").val();
        var Url = "/adminaccount/trends_privileges_edit";
	$.post(Url,{id:id,desc:desc},function(result){
		if(result != null)
		{
			if(result.result == "edit ok")
			{
				//window.location="/adminaccount/trends_privileges";
                                $("#error_content_id").html("权限修改成功!");
				$("#error_content_id").show();
                                window.setInterval("window.location='/adminaccount/trends_privileges'",3000);
			}else 
			{
				$("#error_content_id").html("权限修改失败!");
				$("#error_content_id").show();
				//$("#user_name_id").focus();
				//$("#passwd_id").val("");
			}
		}
	});	

};
	
};



