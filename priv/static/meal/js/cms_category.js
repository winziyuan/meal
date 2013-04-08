/**
 * @author david
 */

//add column
$("#brand_add_button_").bind("click",function(){
    var name = $("#name").val();
    var note = $("#note").val();
    if(name == null || name == "")
    {
    	$("#error_content_id").html("请输入分类名称!");
		$("#error_content_id").show();
		$("#name").focus();
		return;
    }
    var logo = $("#icon").val();
    var Url = "/admincategory/add_category";
    var param = {name:name,note:note,logo:logo};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("分类添加成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admincategory/get_category'",3000);
			}else if(result.result == "exsit")
			{
				$("#error_content_id").html("分类名称已经存在!");
				$("#error_content_id").show();
				$("#columnname").val('');
				$("#columnname").focus();
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
				$("#classified_name").focus();
			}
		}
    });	
});


//edit brand
$("#category_edit_button_").bind("click",function(){
    var name = $("#name").val();
    var note = $("#note").val();
    
    if(name == null || name == "")
    {
    	$("#error_content_id").html("请输入分类名称!");
		$("#error_content_id").show();
		$("#name").focus();
		return;
    }
    var logo = $("#icon").val();
    var id = $("#categoryid").val();
	var Url = "/admincategory/edit_category";
	var param = {id:id,name:name,note:note,logo:logo};
    $.post(Url,param,function(result){
	   if(result != null)
	   {
			if(result.result == "ok")
			{
				$("#error_content_id").html("分类修改成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admincategory/get_category'",3000);
			}else if(result.result == "column notfound")
			{
				$("#error_content_id").html("分类已经不存在!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admincategory/get_category'",3000);
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
				$("#classified_name").focus();
			}
		}
	 });
});

//delete brand
function del_category(brandid,type)
{
	var brandlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				brandlist = brandlist+"$"+el[i].value;
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
		brandlist = $("#categoryid").val();
	}else
	{
		brandlist = brandid;
	}
	var Url = "/admincategory/del_category";
	var brandlistnew =  brandlist.trim();
    var param = {id:brandlistnew};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				window.location="/admincategory/get_category";
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });			
};



var oTimer = null;
$(function () {
	$('#upload_img_').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_').fileupload({
        dataType: 'iframejson',
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
    $('#upload_img_').bind('fileuploadchange', function (e, data) {
    	$("#progress_").show();
    }).bind('fileuploadprogressall', function (e, data) {
    	var progress = parseInt(data.loaded / data.total * 100, 10);
    	$('#progress_ .bar').css('width', progress + '%');
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
		$("#upload_img").remove();
		var html = "<div id='upload_img' onmousemove=\"$('.gb').show();\" onmouseout=\"$('.gb').hide();\" style='position:relative;float:left;margin-left:10px;'><div style='display:none;' class='gb' onClick=\"$('#upload_img').hide();$('#avata').val('');\"><img src='../static/trends/img/gb.png' /></div><img width='50' height='67' src='"+url+"'  /></div>";				
		$("#view_img").html(''); 
		$("#view_img").append(html); 
		$("#submit_form").attr("disabled", false);
		$("#file").attr("disabled", false);
		$("#icon").val('');
		$("#icon").val(url);
		setInterval("$('#progress_').hide()",4000);
	}
		
};