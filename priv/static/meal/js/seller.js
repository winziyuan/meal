

//delete classified
function del_seller(userid_,type)
{
	var selleridlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				selleridlist = selleridlist+","+el[i].value;
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
		selleridlist = $("#userid").val();
	}else
	{
		selleridlist = userid_;
	}
	var Url = "/service/delete";
	var sellerlistnew =  selleridlist;

    var param = {id:sellerlistnew};
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
                         window.location="/service/show";
                   
                 
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

  
        var name = $.trim($("#name").val());       
	var email = $.trim($("#email").val());
	var passwd = $.trim($("#passwd").val());
	var repasswd = $.trim($("#repasswd").val());
	var descs = $.trim($("#descs").val());       
	var icon = $.trim($("#icon").val());
	var phone = $.trim($("#phone").val());
	var tel = $.trim($("#tel").val());
	var paytype = $.trim($('input[name=paytype][checked]').val());       
	var state = $.trim($('input[name=state][checked]').val());
	var isused = $.trim($('input[name=isused][checked]').val());
	var address = $.trim($("#address").val());


	if(name == "" || name == null)
	{
		$("#error_content_id").html("请输入服务商名");
		$("#error_content_id").show();
		$("#name").focus();
		return;
	}; 
	

       if(email == "" || email == null)
	{
		$("#error_content_id").html("请输入邮箱");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}; 
          if(!validate_email(email))
	{
		$("#error_content_id").html("邮箱不合法");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	};
    
	if(passwd == "" || passwd == null)
	{
		$("#error_content_id").html("请输入密码");
		$("#error_content_id").show();
		$("#passwd").focus();
		return;
	}; 
	      if(!validate_name_pass(passwd))
	{
		$("#error_content_id").html("密码不合法");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}; 
	if(repasswd == "" || repasswd == null)
	{
		$("#error_content_id").html("请输入确认密码");
		$("#error_content_id").show();
		$("#repasswd").focus();
		return;
	}; 
	if(passwd != repasswd)
	{
		$("#error_content_id").html("确认密码不一致");
		$("#error_content_id").show();
		$("#repasswd").focus();
		return;
	};
       /* if( descs== "" || descs == null)
	{
		$("#error_content_id").html("请输入简介");
		$("#error_content_id").show();
		$("#descs").focus();
		return;
	};*/
         
      
        
        if( (tel== "" || tel == null)&&(phone== "" || phone == null))
	{
		$("#error_content_id").html("请至少填写1种联系方式");
		$("#error_content_id").show();
		$("#phone").focus();
		return;
	};
        if( paytype== "" || paytype == null)
	{
		$("#error_content_id").html("请选择支付方式");
		$("#error_content_id").show();
		$("paytype").focus();
		return;
	};
        if( state== "" || state == null)
	{
		$("#error_content_id").html("请选择当前状态");
		$("#error_content_id").show();
		$("state").focus();
		return;
	};
         if( isused== "" || isused == null)
	{
		$("#error_content_id").html("请选择是否禁用");
		$("#error_content_id").show();
		$("isused").focus();
		return;
	};
        
        if(address== "" || address == null){
                $("#error_content_id").html("请输入地址");
		$("#error_content_id").show();
		$("address").focus();
		return;
        };
       /* if( icon== "" || icon == null)
	{
		$("#error_content_id").html("请上传LOGO/封面");
		$("#error_content_id").show();
		//$("#desc").focus();
		return;
	};*/      
    var Url = "/service/add";
	
    var param = $("#create_seller_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("创建成功");
			 $("#error_content_id").show();
             setInterval("window.location='/service/show'",2000);
                         
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
	    var name = $.trim($("#name").val());       
	var email = $.trim($("#email").val());
	var passwd = $.trim($("#passwd").val());
	var repasswd = $.trim($("#repasswd").val());
	var descs = $.trim($("#descs").val());       
	var icon = $.trim($("#icon").val());
	var phone = $.trim($("#phone").val());
	var tel = $.trim($("#tel").val());
	var paytype = $.trim($('input[name=paytype][checked]').val());       
	var state = $.trim($('input[name=state][checked]').val());
	var isused = $.trim($('input[name=isused][checked]').val());
	var address = $.trim($("#address").val());

	if(name == "" || name == null)
	{
		$("#error_content_id").html("请输入服务商名");
		$("#error_content_id").show();
		$("#name").focus();
		return;
	}; 
	

       if(email == "" || email == null)
	{
		$("#error_content_id").html("请输入邮箱");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}; 
          if(!validate_email(email))
	{
		$("#error_content_id").html("邮箱不合法");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	};
    
	if(passwd == "" || passwd == null)
	{
		$("#error_content_id").html("请输入密码");
		$("#error_content_id").show();
		$("#passwd").focus();
		return;
	}; 
	      if(!validate_name_pass(passwd))
	{
		$("#error_content_id").html("密码不合法");
		$("#error_content_id").show();
		$("#email").focus();
                
		return;
	}; 
	if(repasswd == "" || repasswd == null)
	{
		$("#error_content_id").html("请输入确认密码");
		$("#error_content_id").show();
		$("#repasswd").focus();
		return;
	}; 
	if(passwd != repasswd)
	{
		$("#error_content_id").html("确认密码不一致");
		$("#error_content_id").show();
		$("#repasswd").focus();
		return;
	};
        /*if( descs== "" || descs == null)
	{
		$("#error_content_id").html("请输入简介");
		$("#error_content_id").show();
		$("#descs").focus();
		return;
	};*/
         
        if( (tel== "" || tel == null)&&(phone== "" || phone == null))
	{
		$("#error_content_id").html("请至少填写1种联系方式");
		$("#error_content_id").show();
		$("#phone").focus();
		return;
	};
        if( paytype== "" || paytype == null)
	{
		$("#error_content_id").html("请选择支付方式");
		$("#error_content_id").show();
		$("paytype").focus();
		return;
	};
        if( state== "" || state == null)
	{
		$("#error_content_id").html("请选择当前状态");
		$("#error_content_id").show();
		$("state").focus();
		return;
	};
         if( isused== "" || isused == null)
	{
		$("#error_content_id").html("请选择是否禁用");
		$("#error_content_id").show();
		$("isused").focus();
		return;
	};
        if(address== "" || address == null){
                $("#error_content_id").html("请输入地址");
		$("#error_content_id").show();
		$("address").focus();
		return;
        };
        /*if( icon== "" || icon == null)
	{
		$("#error_content_id").html("请上传LOGO/封面");
		$("#error_content_id").show();
		//$("#desc").focus();
		return;
	};*/

             
    var Url = "/service/edit";
	
    var param = $("#edit_seller_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("修改成功");
			 $("#error_content_id").show();
             setInterval("window.location='/service/show'",2000);
                         
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















function validate_email(email){

	var patten = new RegExp(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+(com|cn)$/);
  	return patten.test(email);


};

function validate_name_pass(value){

	var patten = new RegExp(/^[a-zA-Z0-9_@#$%&*~.\?]+$/);
    return patten.test(value);

};


 $(function () { 
     
        $('#upload_img').fileupload('option', {
         xhrFields: {
             withCredentials: false
             }
        });  
      
        $('#upload_img').fileupload({
            dataType: 'iframejson',
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
           converters: {
        'html iframejson': function(htmlEncodedJson) {
         return_img(htmlEncodedJson);       
        },
        'iframe iframejson': function (iframe) {
         result = iframe.find('body').text();
       
         return_img(result);
        }
      }
        });

});


 function return_img(result)
    {
	if(result == "file error")
    {
    $("#progress_").hide();
    $("#error_content_id").html("文件格式错误!");
    $("#error_content_id").show();
    }else if(result == "file error")
    {
    $("#progress_").hide();
    $("#error_content_id").html("图片上传失败!");
    $("#error_content_id").show();
    }else
    { 
    var url = img_host+result;
    var html = "<img width='90' height='78' src='"+url+"'  />";
    $("#view_img").html(''); 
    $("#view_img").append(html); 
    $("#submit_form").attr("disabled", false);
    $("#file").attr("disabled", false);
    $("#icon").val('');
    $("#icon").val(url);
    }
    };   










