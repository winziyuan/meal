/**
 * @author david
 */

//add cover
$("#cmscover_create_submmit").bind("click",function(){ 
 var brand = $("#brand").val();
    var device = $("#device").val();
    var channel = $("#channel").val();
    var screen = $("#screen").val();
    var resolution = $("#resolution").val();
    var title = $("#title").val();
    var icon = $("#icon").val();
    var note = $("#note").val();
   
    if(brand == null || brand == "")
    {
         // alert("brand == null  "+(brand == null));
    	$("#error_content_id").html("请选择品牌");
		$("#error_content_id").show();
		$("#brand").focus();
		return;
    }
    if(device == null || device == "")
    {
    	$("#error_content_id").html("请选择设备");
		$("#error_content_id").show();
		$("#device").focus();
		return;
    }
     if(channel == null || channel == "")
    {
    	$("#error_content_id").html("请选择渠道!");
		$("#error_content_id").show();
		$("#channel").focus();
		return;
    }
     if(screen == null || screen == "")
    {
    	$("#error_content_id").html("请选择屏幕方向!");
		$("#error_content_id").show();
		$("#screen").focus();
		return;
    }
     if(resolution == null || resolution == "")
    {
    	$("#error_content_id").html("请选择分辨率!");
		$("#error_content_id").show();
		$("#resolution").focus();
		return;
    }
     if(title == null || title == "")
    {
    	$("#error_content_id").html("请输入标题!");
		$("#error_content_id").show();
		$("#device").focus();
		return;
    }



    var Url = "/admincmscover/add_cover";
   
    var param = {brand:brand,device:device,channel:channel,screen:screen,resolution:resolution,title:title,icon:icon,note:note};
   
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("添加成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admincmscover/get_cover'",1000);
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
				$("#classified_name").focus();
			}
		}
    });	
});


//edit cover
$("#cmscover_edit_submmit").bind("click",function(){

      var brand = $("#brand").val();
    var device = $("#device").val();
    var channel = $("#channel").val();
    var screen = $("#screen").val();
    var resolution = $("#resolution").val();
    var title = $("#title").val();
    var icon = $("#icon").val();
    var note = $("#note").val();
  // alert("brand  "+brand);
    if(brand == null || brand == "")
    {
         // alert("brand == null  "+(brand == null));
    	$("#error_content_id").html("请选择品牌");
		$("#error_content_id").show();
		$("#brand").focus();
		return;
    }
    if(device == null || device == "")
    {
    	$("#error_content_id").html("请选择设备");
		$("#error_content_id").show();
		$("#device").focus();
		return;
    }
     if(channel == null || channel == "")
    {
    	$("#error_content_id").html("请选择渠道!");
		$("#error_content_id").show();
		$("#channel").focus();
		return;
    }
     if(screen == null || screen == "")
    {
    	$("#error_content_id").html("请选择屏幕方向!");
		$("#error_content_id").show();
		$("#screen").focus();
		return;
    }
     if(resolution == null || resolution == "")
    {
    	$("#error_content_id").html("请选择分辨率!");
		$("#error_content_id").show();
		$("#resolution").focus();
		return;
    }
     if(title == null || title == "")
    {
    	$("#error_content_id").html("请输入标题!");
		$("#error_content_id").show();
		$("#device").focus();
		return;
    }
    var coverid = $("#coverid").val();
    var Url = "/admincmscover/edit_cover";
    var param = {id:coverid,brand:brand,device:device,channel:channel,screen:screen,resolution:resolution,title:title,icon:icon,note:note};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("修改成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admincmscover/get_cover'",1000);  
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
				$("#classified_name").focus();
			}
		}
    });	
});


//delete cover
function del_cover(brandid,type)
{       
	var coverlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				coverlist = coverlist+"$"+el[i].value;
				elem = true;
			} 
		} 
		if(!elem)
		{
			$("#error_content_id").html("请选择品牌!");
			$("#error_content_id").show();
			return;
		}
	}else if(type == "3"){
		coverlist = $("#brandid").val();
	}else
	{
		coverlist = brandid;
	}
	var Url = "/admincmscover/del_cover";
	var brandlistnew =  coverlist.trim();
    // alert("brandlistnew "+brandlistnew);
    var param = {id:brandlistnew};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				window.setInterval("window.location='/admincmscover/get_cover'",1000);
                               
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
    
    
    $('#upload_img_1').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_1').fileupload({
          dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	return_img2(htmlEncodedJson);
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	return_img2(result);
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
		var html = "<div id='upload_img' onmousemove=\"$('.gb').show();\" onmouseout=\"$('.gb').hide();\" style='position:relative;float:left;margin-left:10px;'><div style='display:none;' class='gb' onClick=\"$('#upload_img').hide();$('#avata').val('');\"><img src='../static/trends/img/gb.png' /></div><img height='50' width='67' src='"+url+"'  /></div>";				
		$("#view_img").html(''); 
		$("#view_img").append(html); 
		$("#submit_form").attr("disabled", false);
		$("#file").attr("disabled", false);
		$("#icon").val('');
		$("#icon").val(url);
		setInterval("$('#progress_').hide()",2000);
	}
};

function return_img2(result)
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
		var html = "<div id='upload_img1' onmousemove=\"$('.gb').show();\" onmouseout=\"$('.gb').hide();\" style='position:relative;float:left;margin-left:10px;'><div style='display:none;' class='gb' onClick=\"$('#upload_img1').hide();$('#poster').val('');\"><img src='../static/trends/img/gb.png' /></div><img height='50' width='67' src='"+url+"'  /></div>";				
		$("#view_img1").html(''); 
		$("#view_img1").append(html); 
		$("#submit_form").attr("disabled", false);
		$("#file").attr("disabled", false);
		$("#poster").val('');
		$("#poster").val(url);
		setInterval("$('#progress_1').hide()",2000);
	}
};


$("#iphone_submit").bind("click",function(){
	var brand_id = $("#push_brand_id").val();
	var content = $("#push_note").val();
	var Url = "/apns/send_message";
	var param = {brand_id:brand_id, content:content};
	$.get(Url,param,function(result){
		if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id2").html("消息发送成功!");
				$("#error_content_id2").show();
				window.setInterval("$('#tinybox_1').hide();BtHide('popBox');BtHide('popIframe');",3000);
			}else
			{
				$("#error_content_id2").html("消息发送失败,请稍后操作!");
				$("#error_content_id2").show();
				window.setInterval("$('#tinybox_1').hide();BtHide('popBox');BtHide('popIframe');",3000);
				
			}
		}
	});
	window.setInterval("$('#error_content_id2').html('消息发送中!');$('#error_content_id2').show();",4000);
	window.setInterval("$('#tinybox_1').hide();BtHide('popBox');BtHide('popIframe');",5000);
});