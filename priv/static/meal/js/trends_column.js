/**
 * @author david
 */

//add column
$("#column_add_button_").bind("click",function(){
	var prior = "0";
	var radios=document.getElementsByName("prior");
        for(var i=0;i<radios.length;i++)
        {
            if(radios[i].checked==true)
            {
                prior = radios[i].value;
            }
        }
        
    var defaults = "0";
	var radio1=document.getElementsByName("defaults");
        for(var i=0;i<radio1.length;i++)
        {
            if(radio1[i].checked==true)
            {
                defaults = radio1[i].value;
            }
        }
    var columnname = $("#columnname").val();
    var columnnote = $("#columnnote").val();
    if(columnname == null || columnname == "")
    {
    	$("#error_content_id").html("请输入频道名称!");
		$("#error_content_id").show();
		$("#columnname").focus();
		return;
    }
    var avata = $("#avata").val();
    var cover = $("#cover").val(); 
    var coverlink = $("#coverlink").val();
    var category = $("#category").val();
    var Url = "/admin/column_create";
    var param = {coverlink:coverlink,columnname:columnname,columnnote:columnnote,prior:defaults,defaults:prior,avata:avata,cover:cover,category:category};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("频道添加成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admin/column'",3000);
			}else if(result.result == "column_exit")
			{
				$("#error_content_id").html("频道名称已经存在!");
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

//edit classified
$("#column_edit_button_").bind("click",function(){
	var prior = "0";
	var radios=document.getElementsByName("prior");
        for(var i=0;i<radios.length;i++)
        {
            if(radios[i].checked==true)
            {
                prior = radios[i].value;
            }
        }
    var defaults = "0";
	var radio1=document.getElementsByName("defaults");
        for(var i=0;i<radio1.length;i++)
        {
            if(radio1[i].checked==true)
            {
                defaults = radio1[i].value;
            }
        }

    var columnname = $("#columnname").val();
    var columnnote = $("#columnnote").val();
     var category = $("#category").val();
   var coverlink = $("#coverlink").val();
    if(columnname == null || columnname == "")
    {
    	$("#error_content_id").html("请输入频道名称!");
		$("#error_content_id").show();
		$("#columnname").focus();
		return;
    }
    var avata = $("#avata").val();
    var cover = $("#cover").val();
    var id = $("#columtid").val();
	var create_time = $("#create_time").val();
	var Url = "/admin/column_edit";
	var param = {coverlink:coverlink,id:id,columnname:columnname,columnnote:columnnote,avata:avata,cover:cover,prior:defaults,defaults:prior,category:category};
	$.post(Url,param,function(result){
	   if(result != null)
	   {
			if(result.result == "ok")
			{
				$("#error_content_id").html("频道修改成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admin/column'",3000);
			}else if(result.result == "column notfound")
			{
				$("#error_content_id").html("频道已经不存在!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admin/column'",3000);
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
				$("#classified_name").focus();
			}
		}
	 });
});

//delete column
function del_column(columnid,type)
{
	var columnlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				columnlist = columnlist+"$"+el[i].value;
				elem = true;
			} 
		} 
		if(!elem)
		{
			$("#error_content_id").html("请选择频道!");
			$("#error_content_id").show();
			return;
		}
	}else if(type == "3"){
		columnlist = $("#columtid").val();
	}else
	{
		columnlist = columnid;
	}
	var Url = "/admin/column_del";
	var columnlistnew =  columnlist.trim();
    var param = {columnidlist:columnlistnew};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				window.location="/admin/column";
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });			
};

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
		//var url = "http://ihuanyue.me/media/pic/"+result;
		var html = "<div id='upload_img' onmousemove=\"$('#gb').show();\" onmouseout=\"$('#gb').hide();\" style='position:relative;margin-left:10px;'><div style='display:none;' class='gb' id='gb' onClick=\"$('#upload_img').hide();$('#avata').val('');\"><img src='http://huanyue.me/static/trends/img/gb.png' /></div><img width='50' height='67' src='"+url+"'  /></div>";				
		$("#view_img").html(''); 
		$("#view_img").append(html); 
		$("#submit_form").attr("disabled", false);
		$("#file").attr("disabled", false);
		$("#avata").val('');
		$("#avata").val(url);
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
		//var url = "http://ihuanyue.me/media/pic/"+result;
		var html = "<div id='upload_img1' onmousemove=\"$('#gb1').show();\" onmouseout=\"$('#gb1').hide();\" style='position:relative;float:left;margin-left:10px;'><div style='display:none;' class='gb' id='gb1' onClick=\"$('#upload_img1').hide();$('#cover').val('');\"><img src='http://huanyue.me/static/trends/img/gb.png' /></div><img width='50' height='67' src='"+url+"'  /></div>";				
		$("#view_img1").html('');
		$("#view_img1").append(html); 
		$("#file").attr("disabled", false);
		$("#cover").val('');
		$("#cover").val(url);
		setInterval("$('#progress_1').hide()",2000);
	}
}
function return_img3(result)
{
	if(result == "file error")
	{
		$("#progress_2").hide();
		$("#error_content_id").html("文件格式错误!");
		$("#error_content_id").show();
	}else if(result == "file error")
	{
		$("#progress_2").hide();
		$("#error_content_id").html("图片上传失败!");
		$("#error_content_id").show();
	}else
	{ 
                  
		var url = img_host+result;
		//var url = "http://ihuanyue.me/media/pic/"+result;
		var html = "<div id='upload_img2' onmousemove=\"$('#gb1').show();\" onmouseout=\"$('#gb1').hide();\" style='position:relative;float:left;margin-left:10px;'><div style='display:none;' class='gb' id='gb1' onClick=\"$('#upload_img2').hide();$('#coverlink').val('');\"><img src='http://huanyue.me/static/trends/img/gb.png' /></div><img width='50' height='67' src='"+url+"'  /></div>";		


                	
		$("#view_img2").html('');
		$("#view_img2").append(html); 
		$("#file").attr("disabled", false);
		$("#coverlink").val('');
		$("#coverlink").val(url);
		setInterval("$('#progress_2').hide()",2000);
	}
}




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
    }).bind('fileuploaddone', function (e, data) {
		var result = data.result;
		
		
    });


$('#upload_img_2').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_2').fileupload({
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
    $('#upload_img_2').bind('fileuploadchange', function (e, data) {
    	$("#progress_2").show();
    }).bind('fileuploadprogressall', function (e, data) {
    	var progress = parseInt(data.loaded / data.total * 100, 10);
    	$('#progress_2 .bar').css('width', progress + '%');
    }).bind('fileuploaddone', function (e, data) {
		var result = data.result;
		 
		
    });




















});

/*

$(function(){



$('#upload_img_2').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_2').fileupload({
          dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	return_img2(htmlEncodedJson);
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
                        alert("upload_img_2 ssssssssssssssss");
		    	return_img3(result);
		    }
		  }
    });
    $('#upload_img_2').bind('fileuploadchange', function (e, data) {
    	$("#progress_2").show();
    }).bind('fileuploadprogressall', function (e, data) {
    	var progress = parseInt(data.loaded / data.total * 100, 10);
    	$('#progress_2 .bar').css('width', progress + '%');
    }).bind('fileuploaddone', function (e, data) {
		var result = data.result;
		 alert("upload_img_2 ddddddddddddddddddddddddddd");
		
    });



});


*/














