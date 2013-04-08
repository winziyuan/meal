/**
 * @author david
 */

//add column
$("#brand_add_button_").bind("click",function(){
     var param;
    var name = $("#name").val();
    var ename = $("#ename").val();
    var note = $("#note").val();
    
    if(name == null || name == "")
    {
    	$("#error_content_id").html("请输入品牌名称!");
		$("#error_content_id").show();
		$("#name").focus();
		return;
    }
    if(ename == null || ename == "")
    {
    	$("#error_content_id").html("请输入品牌英文名称!");
		$("#error_content_id").show();
		$("#ename").focus();
		return;
    }
    var platform = "";
    var el=document.getElementsByName("checkboxplatform");
	var elem = false;
	for (var i=0;i<el.length;i++) 
	{ 
		if(el[i].checked==true) 
		{ 
			platform = platform+"$"+el[i].value;
			elem = true;
		} 
	} 
	if(!elem)
	{
		$("#error_content_id").html("请选择品牌适用的设备!");
		$("#error_content_id").show();
		return;
	}
    
    var logo = $("#icon").val();
    var poster = $("#poster").val();
     var ipadlogo_ = $("#ipadlogo_").val();
     /* if(is_ipadlogo){
       if(ipadlogo_id==""){
         $("#error_content_id").html("请选择ipad logo");
		$("#error_content_id").show();
       };
       };*/


    var Url = "/cms/add_brand";
  /*  if(is_ipadlogo){
       param= {name:name,id:ename,note:note,logo:logo,ipadlogo:ipadlogo_,platform:platform,poster:poster};
     }else{
        param= {name:name,id:ename,note:note,logo:logo,platform:platform,poster:poster};
     };*/
   param= {name:name,id:ename,note:note,logo:logo,ipadlogo:ipadlogo_,platform:platform,poster:poster};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("品牌添加成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/cms/brand'",2000);
			}else if(result.result == "brand_exit")
			{
				$("#error_content_id").html("品牌名称已经存在!");
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
$("#brand_edit_button_").bind("click",function(){
	var name = $("#name").val();
    var note = $("#note").val();

    if(name == null || name == "")
    {
    	$("#error_content_id").html("请输入品牌名称!");
		$("#error_content_id").show();
		$("#name").focus();
		return;
    }
    
    var platform = "";
    var el=document.getElementsByName("checkboxplatform");
	var elem = false;
	for (var i=0;i<el.length;i++) 
	{ 
		if(el[i].checked==true) 
		{ 
			platform = platform+"$"+el[i].value;
			elem = true;
		} 
	} 
	if(!elem)
	{
		$("#error_content_id").html("请选择品牌适用的设备!");
		$("#error_content_id").show();
		return;
	}
	
    var logo = $("#icon").val();
    var poster = $("#poster").val();
var ipadlogo_ = $("#ipadlogo_").val();
     /* if(is_ipadlogo){
       if(ipadlogo_id==""){
         $("#error_content_id").html("请选择ipad logo");
		$("#error_content_id").show();
       };
       };*/
    var id = $("#brandid").val();
	var Url = "/cms/edit_brand";
	var param = {id:id,name:name,note:note,logo:logo,ipadlogo:ipadlogo_,platform:platform,poster:poster};
    $.post(Url,param,function(result){
	   if(result != null)
	   {
			if(result.result == "ok")
			{
				$("#error_content_id").html("品牌修改成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/cms/brand'",2000);
			}else if(result.result == "column notfound")
			{
				$("#error_content_id").html("品牌已经不存在!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admin/column'",2000);
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
function del_brand(brandid,type)
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
			$("#error_content_id").html("请选择品牌!");
			$("#error_content_id").show();
			return;
		}
	}else if(type == "3"){
		brandlist = $("#brandid").val();
	}else
	{
		brandlist = brandid;
	}
	var Url = "/cms/del_brand";
	var brandlistnew =  brandlist.trim();
    var param = {id:brandlistnew};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				window.location="/cms/brand";
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });			
};



/*
//ipad select 
var is_ipadlogo=false;
 function checkon(val,el){
if(val=="ipad"){
if($(el).is(':checked')){
       $("#ipadlogo").show();
       $("#ipadlogo_pre").show();
       is_ipadlogo=true;
    } else {
        $("#ipadlogo").hide();
        $("#ipadlogo_pre").hide();
        $("#ipadlogo_").val('');
       is_ipadlogo=false;
    };
};


  
};


$(function () {

if($("input[type=checkbox,checked=true]").text()=="ipad"){
      $("#ipadlogo").show();
       $("#ipadlogo_pre").show();
       is_ipadlogo=true;

}else{

        $("#ipadlogo").hide();
        $("#ipadlogo_pre").hide();
        $("#ipadlogo_").val('');
       is_ipadlogo=false;

};


});

*/

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
    	//var progress=data.loaded / data.tota;  
    	$('#progress_1 .bar').css('width', progress + '%');
    	
    });



 $('#upload_img_ipad').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_ipad').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	return_img3(htmlEncodedJson);
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	return_img3(result);
		    }
		  }
    });

    $('#upload_img_ipad').bind('fileuploadchange', function (e, data) {
    	$("#progress_ipad").show();
    }).bind('fileuploadprogressall', function (e, data) {
    
    	var progress = parseInt(data.loaded / data.total * 100, 10);
    	//var progress=data.loaded / data.tota;  
    	$('#progress_ipad .bar').css('width', progress + '%');
    	
    });











});


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
		var html = "<div id='upload_img1' onmousemove=\"$('.gb').show();\" onmouseout=\"$('.gb').hide();\" style='position:relative;float:left;margin-left:10px;'><div style='display:none;' class='gb' onClick=\"$('#upload_img1').hide();$('#poster').val('');\"><img src='../static/trends/img/gb.png' /></div><img width='50' height='67' src='"+url+"'  /></div>";				
		$("#view_img1").html(''); 
		$("#view_img1").append(html); 
		$("#submit_form").attr("disabled", false);
		$("#file").attr("disabled", false);
		$("#poster").val('');
		$("#poster").val(url);
		setInterval("$('#progress_1').hide()",4000);
	}
};


function return_img3(result)
{
	if(result == "file error")
	{
		$("#progress_ipad").hide();
		$("#error_content_id").html("文件格式错误!");
		$("#error_content_id").show();
	}else if(result == "file error")
	{
		$("#progress_ipad").hide();
		$("#error_content_id").html("图片上传失败!");
		$("#error_content_id").show();
	}else
	{ 
		var url = img_host+result;
		var html = "<div id='upload_img_ipad' onmousemove=\"$('.gb').show();\" onmouseout=\"$('.gb').hide();\" style='position:relative;float:left;margin-left:10px;'><div style='display:none;' class='gb' onClick=\"$('#upload_img_ipad').hide();$('#ipadlogo_').val('');\"><img src='../static/trends/img/gb.png' /></div><img width='50' height='67' src='"+url+"'  /></div>";				
		$("#view_img_ipad").html(''); 
		$("#view_img_ipad").append(html); 
		$("#submit_form").attr("disabled", false);
		$("#file").attr("disabled", false);
		$("#ipadlogo_").val('');
		$("#ipadlogo_").val(url);
		setInterval("$('#progress_ipad').hide()",4000);
	}
};
