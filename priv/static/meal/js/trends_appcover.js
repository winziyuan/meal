var oTimer = null;

$(function () {
	var num = 1;
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
		$("#upload_img").hide();
		$("#icon").val('')
		var url = img_host+result;
		//var url = "http://ihuanyue.me/media/pic/"+data.result;
		var html = "<div id='upload_img' onmousemove=\"$('.gb').show();\" onmouseout=\"$('.gb').hide();\" style='position:relative;float:left;margin-left:10px;'><div style='display:none;' class='gb' onClick=\"$('#upload_img').hide();$('#icon').val('');\"><img src='../../../static/trends/img/gb.png' /></div><img width='50' height='67' src='"+url+"'  /></div>";
		$("#view_img").append(html); 
		$("#submit_form").attr("disabled", false);
		$("#file").attr("disabled", false);
		$("#icon").val(url);
		setInterval("$('#progress_').hide()",3000);
	}
}

// create  appcover
$("#appcover_create_submmit").bind("click",function(){
	var note = $("#note").val();
	var action_url = $("#action_url").val();
	var icon = $("#icon").val();
	if(note == null || note == "")
	{
		$("#error_content_id").html("请输入封面说明!");
		$("#error_content_id").show();
		$("#title").focus();
		return;
	}
	if(icon == null || icon == "")
	{
		$("#error_content_id").html("请选择图片!");
  		$("#error_content_id").show();
  		return; 
	}
	//summent=summent.replace(/\n/g,'<br />');
	//summent = summent.replace(/ /g, '&nbsp;');
	var status = "";
	var ok=document.getElementsByName("status");
	for(i=0;i<ok.length;i++)
	{
		if (ok[i].checked == true){
			status = ok[i].value;
		}
	}
	 
	var Paramlist = $('#appcover_form_').serialize();
	var Url = "/admin/appcover_create";
	$.post(Url,Paramlist,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("封面添加成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admin/appcover'",3000);
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });
	//$("#create_info").submit();
});



//edit appcover
$("#appcover_edit_submmit").bind("click",function(){
	var note = $("#note").val();
	var action_url = $("#action_url").val();
	var icon = $("#icon").val();
	if(note == null || note == "")
	{
		$("#error_content_id").html("请输入封面说明!");
		$("#error_content_id").show();
		$("#title").focus();
		return;
	}
	if(icon == null || icon == "")
	{
		$("#error_content_id").html("请选择图片!");
  		$("#error_content_id").show();
  		return; 
	}
	//summent=summent.replace(/\n/g,'<br />');
	//summent = summent.replace(/ /g, '&nbsp;');
	var status = "";
	var ok=document.getElementsByName("status");
	for(i=0;i<ok.length;i++)
	{
		if (ok[i].checked == true){
			status = ok[i].value;
		}
	}
	var Paramlist = $('#appcover_edit_form_').serialize();
	var url = "/admin/appcover_edit";
	$.post(url,Paramlist,function(result){
		if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("封面更新成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admin/appcover'",3000);
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
	});
});

//delete  appcover
function del_appcover(id,type)
{
	var appcoveridlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				appcoveridlist = appcoveridlist+"$"+el[i].value;
				elem = true;
			} 
		} 
		if(!elem)
		{
			$("#error_content_id").html("请选择文章!");
			$("#error_content_id").show();
			return;
		}
	}else if(type == "3"){
		appcoveridlist = $("#appcoverid").val();
	}else
	{
		appcoveridlist = id;
	}
	var Url = "/admin/appcover_del";
	var appcoverlistnew =  appcoveridlist.trim();
    var param = {id:appcoverlistnew};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				window.location="/admin/appcover";
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });		
};





function del_img(num_p)
{
  var param = $("#icon").val();
  //$("#view_img").remove("#upload_img"+num_p);
  $("#upload_img"+num_p).hide();
  var paramnew = "";
  lists = param.split("$");
  for(i=0;i<lists.length-1;i++)
  {
    if(lists[i] != null && (i+1) != num_p)
    {
      paramnew = paramnew + lists[i]+"$";
    }
  }
  $("#icon").val(paramnew);
}