/**
 * @author david
 */

//add magazines
$("#magazines_add_button_").bind("click",function(){
	var name = $("#magazinesname").val();
	var issue = $("#issue").val();
	var year = $("#year").val();
	var brand_id = $("#brand_id").val();
	var note = $("#note").val();
	var platform = $("#platform").val();
	var resolution = $("#resolution").val();
	var magazine_type = $("#magazine_type").val();
	var server = $("#server").val();
	var order_date = $("#order_date").val();
	var cover = $("#cover").val();
	var preview_img = $("#preview_img").val();
	var downloadname = $("#downloadname").val();
	var pres = $("#platform_resolution").val();
	var radio = "";
	var ok=document.getElementsByName("radio");
	for(i=0;i<ok.length;i++)
	{
		if (ok[i].checked == true){
			radio = ok[i].value;
		}
	}
	$("#is_free").val(radio);
	if(name == null || name == "")
	{
		$("#error_content_id").html("请输入杂志名称!");
		$("#error_content_id").show();
		$("#magazinesname").focus();
		return;
	}
	if(pres != "" && pres == "android" && resolution == "")
	{
		$("#error_content_id").html("请输入android设备分辨率!");
		$("#error_content_id").show();
		$("#resolution").focus();
		return;
	}
	/*if(downloadname == null || downloadname == "")
	{
		$("#error_content_id").html("请选择内容包名称,如果下拉框为空请先利用ftp工具上传文件!");
		$("#error_content_id").show();
		$("#downloadname").focus();
		return;
	}*/
	
	
	$("#magazines_form_").submit();
});

//edit magazines
$("#magazines_edit_button_").bind("click",function(){
	var name = $("#magazinesname").val();
	var resolution = $("#resolution").val();
	var pres = $("#platform_resolution").val();
	var radio = "";
	var ok=document.getElementsByName("radio");
	for(i=0;i<ok.length;i++)
	{
		if (ok[i].checked == true){
			radio = ok[i].value;
		}
	}
	$("#is_free").val(radio);
	if(name == null || name == "")
	{
		$("#error_content_id").html("请输入杂志名称!");
		$("#error_content_id").show();
		$("#magazinesname").focus();
		return;
	}
	if(pres != "" && pres == "android" && resolution == "")
	{
		$("#error_content_id").html("请输入android设备分辨率!");
		$("#error_content_id").show();
		$("#resolution").focus();
		return;
	}
	$("#magazine_edit").submit();
});


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
    
    
    var num = 1;
    $('#upload_img_1').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_1').fileupload({
          dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	return_img1_1(htmlEncodedJson,num);
		    	num++;
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	return_img1_1(result,num);
		    	num++;
		    }
		  }
    });
    $('#upload_img_1').bind('fileuploadchange', function (e, data) {
    	$("#progress_1").show();
    }).bind('fileuploadprogressall', function (e, data) {
       	var progress = parseInt(data.loaded / data.total * 100, 10);
    	$('#progress_1 .bar').css('width', progress + '%');
    });


});

function del_img(num_p)
{
  var param = $("#preview_img").val();
  //$("#view_img").remove("#upload_img"+num_p);
  $("#upload_img"+num_p).empty();
  var paramnew = "";
  lists = param.split("$");
  for(i=1;i<=lists.length;i++)
  {
    if(lists[i] != null && i != num_p)
    {
      paramnew = paramnew + lists[i]+"$";
    }
  }
  $("#preview_img").val(paramnew);
}

function change(platform) 
{ 
	$("#platform_resolution").val(platform);
	if(platform == "android")
	{
		$("#resolution_tr").show();
	}else
		$("#resolution_tr").hide();
} ;

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
		//var url = "http://ihuanyue.me/media/pic/"+data.result;
		var html = "<div id='upload_img' onmousemove=\"$('.gb').show();\" onmouseout=\"$('.gb').hide();\" style='position:relative;margin-left:10px;'><div style='display:none;' class='gb' onClick=\"$('#upload_img').hide();$('#cover').val('');\"><img src='../static/trends/img/gb.png' width='20' height='20' /></div><img width='50' height='67' src='"+url+"'  /></div>";				
		$("#view_img").html(''); 
		$("#view_img").append(html); 
		$("#submit_form").attr("disabled", false);
		$("#file").attr("disabled", false);
		$("#cover").val('');
		$("#cover").val(url);
		setInterval("$('#progress_').hide()",2000);
	}
};

function return_img1_1(result,num)
{
	if(result == "file error")
	{
		$("#progress_1").hide();
		$("#error_content_id").html("文件格式错误!");
		$("#error_content_id").show();
	}else if(result == "file error")
	{
		$("#progress_1").hide();
		$("#error_content_id").html("图片上传失败!");
		$("#error_content_id").show();
	}else
	{ 
		var url = img_host+result;
		var html = "<div id='upload_img"+num+"' onmousemove=\"$('#gb"+num+"').show();\" onmouseout=\"$('#gb"+num+"').hide();\" style='position:relative;margin-left:10px;width:60px;float:left;'><div style='display:none;' id='gb"+num+"' class='gb_d' onClick=\"del_img('"+num+"');\"><img src='../../static/trends/img/gb.png' width=\"20\" height=\"20\"/></div><img width=\"50\" id='img"+num+"' height=\"67\" src='"+url+"'  /></div>";	
		$("#view_img1").append(html); 
		$("#file").attr("disabled", false);
		var value = $("#preview_img").val()+"$"+url;
		$("#preview_img").val(value);
		setInterval("$('#progress_1').hide()",2000);
	}
};

