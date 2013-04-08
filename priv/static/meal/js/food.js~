

//delete classified
function del_food(userid_,type)
{
	var foodidlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				foodidlist = foodidlist+","+el[i].value;
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
		foodidlist = $("#userid").val();
	}else
	{
		foodidlist = userid_;
	}
	var Url = "/food/delete";
	var foodlistnew =  foodidlist;

    var param = {id:foodlistnew};
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
                         window.location="/food/show";
                   
                 
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

  
        var foodname = $.trim($("#name").val());       
	var desc = $.trim($("#desc").val());       
	var icon = $.trim($("#icon").val());
	var price = $.trim($("#price").val());
	var known = $.trim($("#known").val());



	if(foodname == "" || foodname == null)
	{
		$("#error_content_id").html("请输入食物名");
		$("#error_content_id").show();
		$("#name").focus();
		return;
	}; 
	

         
        if( price== "" || price == null)
	{
		$("#error_content_id").html("请输入单价");
		$("#error_content_id").show();
		$("#price").focus();
		return;
	};
        
        /*
        if( icon== "" || icon == null)
	{
		$("#error_content_id").html("请上传食物图片");
		$("#error_content_id").show();
		//$("#desc").focus();
		return;
	};*/      
    var Url = "/food/add";
	
    var param = $("#create_food_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("创建成功");
			 $("#error_content_id").show();
             setInterval("window.location='/food/show'",2000);
                         
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
	var foodname = $.trim($("#name").val());       
	var desc = $.trim($("#desc").val());       
	var icon = $.trim($("#icon").val());
	var price = $.trim($("#price").val());
	var known = $.trim($("#known").val());



	if(foodname == "" || foodname == null)
	{
		$("#error_content_id").html("请输入食物名");
		$("#error_content_id").show();
		$("#name").focus();
		return;
	}; 
	
        /*  
        if(desc== "" || desc == null)
	{
		$("#desc").val(" ");
		
	};
         */
        if( price== "" || price == null)
	{
		$("#error_content_id").html("请输入单价");
		$("#error_content_id").show();
		$("#price").focus();
		return;
	};
        /*
        if( known== "" || known == null)
	{
		$("#known").val(" ");
		
	};
        
        if( icon== "" || icon == null)
	{
		$("#error_content_id").html("请上传食物图片");
		$("#error_content_id").show();
		//$("#desc").focus();
		return;
	};      
        */
             
    var Url = "/food/edit";	
    var param = $("#edit_food_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("修改成功");
			 $("#error_content_id").show();
             setInterval("window.location='/food/show'",2000);
                         
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










