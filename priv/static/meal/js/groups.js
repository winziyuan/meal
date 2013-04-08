

//delete classified
function del_groups(userid_,type)
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
	var Url = "/groups/delete";
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
                         window.location="/groups/show";
                   
                 
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

  
        var groupsname = $.trim($("#name").val());       
	var desc = $.trim($("#desc").val());       

	if(groupsname == "" || groupsname == null)
	{
		$("#error_content_id").html("请输入组合名");
		$("#error_content_id").show();
		$("#name").focus();
		return;
	}; 
	

        if(desc== "" || desc == null)
	{
		$("#desc").val(" ");
		
	};
         
      
    var Url = "/groups/add";
	
    var param = $("#create_groups_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("创建成功");
			 $("#error_content_id").show();
             setInterval("window.location='/groups/show'",2000);
                         
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


$("#groupmoney").keyup(function ()   
        {      
                 if($("#groupmoney").val()>parseInt($("#tatalmoney_").text())||$("#groupmoney").val()<0){                 
                   $("#groupmoney").val(parseInt($("#tatalmoney_").text()));
                    $("#percentage").val(0);
                    $("#percentage_").text(0);
                
                 }else{
                  
                   var percentage= parseInt($("#tatalmoney_").text())-$("#groupmoney").val();
                    $("#percentage").val(percentage);
                    $("#percentage_").text(percentage);
                   };
        }); 

$("#edit_submit").bind("click",function(){
   
     if($("#change_").val() == 'true'){
		$("#error_content_id").html("您没做任何改动,请修改后在进行保存!");
		$("#error_content_id").show();
        return;
	}  
	var groupsname = $.trim($("#name").val());       
	var desc = $.trim($("#desc").val());       
	var groupmoney = $.trim($("#groupmoney").val());	


	if(groupsname == "" || groupsname == null)
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
         if(groupmoney== "" || groupmoney == null)
	{
		$("#groupmoney").val(parseInt($("#groupmoney_").val())); 
		
	};
       

             
    var Url = "/groups/edit";	
    var param = $("#edit_groups_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("修改成功");
			 $("#error_content_id").show();
             setInterval("window.location='/groups/show'",2000);
                         
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












