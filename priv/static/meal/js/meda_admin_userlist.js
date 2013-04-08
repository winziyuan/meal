/**
 * @author david
 */

//edit user


var edit_radio;

$("#update_user_").bind("click",function(){
	if($("#change_").val() == 'true'){
		$("#error_content_id").html("您没做任何改动,请修改后在进行保存!");
		$("#error_content_id").show();
	}else{              
                var url="/admin/edit";
		var id = $.trim($("#id").val());
		var name = $.trim($("#name").val());
                var desc = $.trim($("#desc").val());
       		var passwd = $.trim($("#passwd").val());
	        var email = $.trim($("#email").val());
		var phone = $.trim($("#phone").val());
       		var createtime = $.trim($("#createtime").val());
	       // var disable = $.trim($("input[type='radio'][id='disable'][checked]").val());

    if(email == "" || email == null)
	{
		$("#error_content_id").html("请输入邮箱");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}else 
          if(!validate_email(email))
	{
		$("#error_content_id").html("邮箱不合法");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}else








                   

		var param = {id:id,name:name,desc:desc,passwd:passwd,email:email,phone:phone,createtime:createtime,disable:edit_radio};
		 $.post(url,param,function(result){
		 	if(result != null)
			{
				if(result.result == "ok")
				{
				$("#error_content_id").html("用户修改成功");
			        $("#error_content_id").show();
                                setInterval("window.location='/admin/show'",2000);
				}else if(result.result == "exsit"){
                                $("#error_content_id").html("用户已存在");
			        $("#error_content_id").show();
                                     
                                }else

				{
					$("#error_content_id").html("服务错误请刷新后进行操作!");
					$("#error_content_id").show();
				}
			}
		 });
		
	}
	
	
    
});

//delete classified
function del_user(userid_,type)
{
	var useridlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				useridlist = useridlist+","+el[i].value;
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
		useridlist = $("#userid").val();
	}else
	{
		useridlist = userid_;
	}
	var Url = "/admin/delete";
	var userlistnew =  useridlist;

    var param = {id:userlistnew};
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
                         window.location="/admin/show";
                   
                 
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

       
	var username = $.trim($("#username").val());
       
	var email = $.trim($("#email").val());
	var passwd = $.trim($("#passwd").val());
	var repasswd = $.trim($("#repasswd").val());
	if(username == "" || username == null)
	{
		$("#error_content_id").html("请输入用户名");
		$("#error_content_id").show();
		$("#username").focus();
		return;
	}else 
	 if(!validate_name_pass(username))
	{
		$("#error_content_id").html("用户名不合法");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}else


       if(email == "" || email == null)
	{
		$("#error_content_id").html("请输入邮箱");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}else 
          if(!validate_email(email))
	{
		$("#error_content_id").html("邮箱不合法");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}else
    
	if(passwd == "" || passwd == null)
	{
		$("#error_content_id").html("请输入密码");
		$("#error_content_id").show();
		$("#passwd").focus();
		return;
	}else 
	      if(!validate_name_pass(passwd))
	{
		$("#error_content_id").html("密码不合法");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}else 
	if(repasswd == "" || repasswd == null)
	{
		$("#error_content_id").html("请输入确认密码");
		$("#error_content_id").show();
		$("#repasswd").focus();
		return;
	}else 
	if(passwd != repasswd)
	{
		$("#error_content_id").html("确认密码不一致");
		$("#error_content_id").show();
		$("#repasswd").focus();
		return;
	};
	var Url = " /admin/add";
	
    var param = $("#create_user_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("用户创建成功");
			$("#error_content_id").show();
                         setInterval("window.location='/admin/show'",2000);
                         
			}else if(result.result == "exsit"){
             
                          $("#error_content_id").html("用户名或邮箱已存在！");
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


function validate_email(email){

var patten = new RegExp(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+(com|cn)$/);
  return patten.test(email);


};

function validate_name_pass(value){

var patten = new RegExp(/^[a-zA-Z0-9_@#$%&*~.\?]+$/);
    return patten.test(value);

};







