/**
 * @author david
 */

//add platform
$("#platform").bind("click",function(){
	var name = $("#platformname").val();
	if(name == null || name == "")
	{
		$("#error_content_id").html("请输入平台名称!");
		$("#error_content_id").show();
		$("#platformname").focus();
		return;
	}
	var param = {key:"platform",value:name};
	var Url = "/cms/add_conf";
    $.post(Url,param,function(result){
	    if(result != null)
		{
			if(result.result == "ok")
			{
			    var id = "";
			    id=result.id;
				$("#error_content_id").html("平台添加成功!");
				$("#error_content_id").show();
				$("#platformlist").append("<div id='"+id+"' style='float:left;'><input type=\"checkbox\" name=\"checkboxplatform\" value='"+id+"'/> "+name+"&nbsp;&nbsp;&nbsp;&nbsp;</div>");
				$("#platformname").val("");
				window.setInterval("$('#error_content_id').hide()",3000);
			}else
			{
				$("#error_content_id").html("平台添加失败!");
				$("#error_content_id").show();
				window.setInterval("$('#error_content_id').hide()",3000);
			}
		}
    });
});

//add resolution
$("#resolution_submit").bind("click",function(){
	var start = $("#start").val();
	var end = $("#end").val();
	if(start == null || start == "")
	{
		$("#error_content_id").html("请输入分辨率!");
		$("#error_content_id").show();
		$("#start").focus();
		return;
	}
	if(end == null || end == "")
	{
		$("#error_content_id").html("请输入分辨率!");
		$("#error_content_id").show();
		$("#end").focus();
		return;
	}
	var value = start+"@"+end;
	var param = {key:"resolution",value:value};
	var Url = "/cms/add_conf";
    $.post(Url,param,function(result){
	    if(result != null)
		{
			if(result.result == "ok")
			{
				var id = "";
			    id=result.id;
				$("#error_content_id").html("分辨率添加成功!");
				$("#error_content_id").show();
				$("#start").val("");
				$("#end").val("");
				$("#resolutionlist").append("<div id='"+id+"' style='float:left;'><input type=\"checkbox\" name=\"checkboxresolution\" value='"+id+"'/> "+value+"&nbsp;&nbsp;&nbsp;&nbsp;</div>");
				window.setInterval("$('#error_content_id').hide()",3000);
			}else
			{
				$("#error_content_id").html("分辨率添加失败!");
				$("#error_content_id").show();
				window.setInterval("$('#error_content_id').hide()'",3000);
			}
		}
    });
});

//add server
$("#server_submit").bind("click",function(){
	var name = $("#servername").val();
	var serverurl = $("#serverurl").val();
	if(name == null || name == "")
	{
		$("#error_content_id").html("请输入服务器名称!");
		$("#error_content_id").show();
		$("#servername").focus();
		return;
	}
	if(serverurl == null || serverurl == "")
	{
		$("#error_content_id").html("请输入服务器地址!");
		$("#error_content_id").show();
		$("#serverurl").focus();
		return;
	}
	var param = {key:"server",value:name,order:serverurl};
	var Url = "/cms/add_conf";
    $.post(Url,param,function(result){
	    if(result != null)
		{
			if(result.result == "ok")
			{
				var id = "";
			    id=result.id;
				$("#error_content_id").html("服务器添加成功!");
				$("#error_content_id").show();
				$("#servername").val("");
	 			$("#serverurl").val("");
				$("#serverlist").append("<div id='"+id+"' style='float:left;'><input type=\"checkbox\" name=\"checkboxreserver\" value='"+id+"-ck'/> "+name+"&nbsp;&nbsp;&nbsp;&nbsp;</div>");
				window.setInterval("$('#error_content_id').hide()",3000);
			}else
			{
				$("#error_content_id").html("服务器添加失败!");
				$("#error_content_id").show();
				window.setInterval("$('#error_content_id').hide()'",3000);
			}
		}
    });
});

//add cover
$("#cover_gz_submit").bind("click",function(){
	var title = $("#covertitle").val();
	var note = $("#covernote").val();
	var img_url = $("#img_cover_sub").val();
	if(title == null || title == "")
	{
		$("#error_content_id").html("请输入标题!");
		$("#error_content_id").show();
		$("#covertitle").focus();
		return;
	}
	if(note == null || note == "")
	{
		$("#error_content_id").html("请输入cover说明!");
		$("#error_content_id").show();
		$("#covernote").focus();
		return;
	}
	if(img_url == null || img_url == "")
	{
		$("#error_content_id").html("请输入cover图!");
		$("#error_content_id").show();
		return;
	}
	value_id = $("#cover_id").val();
	value = "{\"title\":\""+title+"\",\"note\":\""+note+"\",\"img_url\":\""+img_url+"\"}";
	var param = {key:"cover_conf",value_id:value_id,value:value,order:"1"};
	var Url = "/cms/add_conf";
    $.post(Url,param,function(result){
	    if(result != null)
		{
			if(result.result == "ok")
			{
			    var id = "";
			    id=result.id;
				$("#error_content_id").html("cover添加成功!");
				$("#error_content_id").show();
				window.setInterval("$('#error_content_id').hide()",3000);
			}else
			{
				$("#error_content_id").html("cover添加失败!");
				$("#error_content_id").show();
				window.setInterval("$('#error_content_id').hide()",3000);
			}
		}
    });
});

//add book_conf
$("#book_conf_img_submit").bind("click",function(){

	var id_1 = $("#book_conf_id_1").val();
	var id_2 = $("#book_conf_id_2").val();
	var id_3 = $("#book_conf_id_3").val();
	var id_4 = $("#book_conf_id_4").val();
	
	
	var gg_url_1 = $("#img_url_1").val();
	var gg_url_2 = $("#img_url_2").val();
	var gg_url_3 = $("#img_url_3").val();
	var gg_url_4 = $("#img_url_4").val();
	
	var icon_1 = $("#img_1").val();
	var icon_2 = $("#img_2").val();
	var icon_3 = $("#img_3").val();
	var icon_4 = $("#img_4").val();
	var icon_5 = $("#img_5").val();
	var icon_6 = $("#img_6").val();
	var icon_7 = $("#img_7").val();
	var icon_8 = $("#img_8").val();
	
	value1 = "{\"big\":\""+icon_1+"\",\"smal\":\""+icon_2+"\",\"url\":\""+gg_url_1+"\"}";
	value2 = "{\"big\":\""+icon_3+"\",\"smal\":\""+icon_4+"\",\"url\":\""+gg_url_2+"\"}";
	value3 = "{\"big\":\""+icon_5+"\",\"smal\":\""+icon_6+"\",\"url\":\""+gg_url_3+"\"}";
	value4 = "{\"big\":\""+icon_7+"\",\"smal\":\""+icon_8+"\",\"url\":\""+gg_url_4+"\"}";
 
	if(icon_1 =="" || icon_2 =="" || icon_3 =="" || icon_4 =="" || icon_5 =="" || icon_6 =="" || icon_7 =="" || icon_8 =="")
	{
		$("#error_content_id").html("图片必须为4份,请填充完整!");
		$("#error_content_id").show();
		window.setInterval("$('#error_content_id').hide()",3000);
		return;
	}
	//testJson = $.parseJSON(value1);  
	
	var Url = "/cms/add_conf";
    var param1 = {key:"book_conf",value:value1,value_id:id_1};
    var param2 = {key:"book_conf",value:value2,value_id:id_2};
    var param3 = {key:"book_conf",value:value3,value_id:id_3};
    var param4 = {key:"book_conf",value:value4,value_id:id_4};
    
	window.setTimeout("sub_book_img1('"+Url+"','book_conf','"+value1+"','"+id_1+"')",1000);
	window.setTimeout("sub_book_img1('"+Url+"','book_conf','"+value2+"','"+id_2+"')",2000);
	window.setTimeout("sub_book_img1('"+Url+"','book_conf','"+value3+"','"+id_3+"')",3000);
	window.setTimeout("sub_book_img1('"+Url+"','book_conf','"+value4+"','"+id_4+"')",4000);
});

function sub_book_img1(Url,key,value,value_id)
{
	var param = {key:key,value:value,value_id:value_id};
	$.post(Url,param,function(result){
	    if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("添加成功!");
				$("#error_content_id").show();
				window.setInterval("$('#error_content_id').hide()",3000);
			}else
			{
				re="error";
				$("#error_content_id").html("服务器添加失败!");
				$("#error_content_id").show();
				window.setInterval("$('#error_content_id').hide()'",3000);
			}
		}
	});
}

//add pulicity_conf
$("#pulicity_conf_img_submit").bind("click",function(){

	var id_1 = $("#tj_id_1").val();
	var id_2 = $("#tj_id_2").val();
	var id_3 = $("#tj_id_3").val();
	var id_4 = $("#tj_id_4").val();
	
	
	var gg_url_1 = $("#tj_img_url_1").val();
	var gg_url_2 = $("#tj_img_url_2").val();
	var gg_url_3 = $("#tj_img_url_3").val();
	var gg_url_4 = $("#tj_img_url_4").val();
	
	var icon_1 = $("#tj_img_1").val();
	var icon_2 = $("#tj_img_2").val();
	var icon_3 = $("#tj_img_3").val();
	var icon_4 = $("#tj_img_4").val();
	var icon_5 = $("#tj_img_5").val();
	var icon_6 = $("#tj_img_6").val();
	var icon_7 = $("#tj_img_7").val();
	var icon_8 = $("#tj_img_8").val();
	
	value1 = "{\"big\":\""+icon_1+"\",\"smal\":\""+icon_2+"\",\"url\":\""+gg_url_1+"\"}";
	value2 = "{\"big\":\""+icon_3+"\",\"smal\":\""+icon_4+"\",\"url\":\""+gg_url_2+"\"}";
	value3 = "{\"big\":\""+icon_5+"\",\"smal\":\""+icon_6+"\",\"url\":\""+gg_url_3+"\"}";
	value4 = "{\"big\":\""+icon_7+"\",\"smal\":\""+icon_8+"\",\"url\":\""+gg_url_4+"\"}";
	if(icon_1 =="" || icon_2 =="" || icon_3 =="" || icon_4 =="" || icon_5 =="" || icon_6 =="" || icon_7 =="" || icon_8 =="")
	{
		$("#error_content_id").html("图片必须为4份,请填充完整!");
		$("#error_content_id").show();
		window.setInterval("$('#error_content_id').hide()",3000);
		return;
	}
	//testJson = $.parseJSON(value1);  
	
	var Url = "/cms/add_conf";
    var param1 = {key:"publicity_conf",value:value1,value_id:id_1};
    var param2 = {key:"publicity_conf",value:value2,value_id:id_2};
    var param3 = {key:"publicity_conf",value:value3,value_id:id_3};
    var param4 = {key:"publicity_conf",value:value4,value_id:id_4};
	window.setTimeout("sub_book_img1('"+Url+"','publicity_conf','"+value1+"','"+id_1+"')",1000);
	window.setTimeout("sub_book_img1('"+Url+"','publicity_conf','"+value2+"','"+id_2+"')",2000);
	window.setTimeout("sub_book_img1('"+Url+"','publicity_conf','"+value3+"','"+id_3+"')",3000);
	window.setTimeout("sub_book_img1('"+Url+"','publicity_conf','"+value4+"','"+id_4+"')",4000);
});

$(function () {
	$('#upload_img_1').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_1').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result1(htmlEncodedJson,"1");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result1(result,"1");
		    }
		  }
    });
    $('#upload_img_1').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
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
		    	result1(htmlEncodedJson,"2");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result1(result,"2");
		    }
		  }
    });
    $('#upload_img_2').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_3').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_3').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result1(htmlEncodedJson,"3");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result1(result,"3");
		    }
		  }
    });
    $('#upload_img_3').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_4').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_4').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result1(htmlEncodedJson,"4");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result1(result,"4");
		    }
		  }
    });
    $('#upload_img_4').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_5').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_5').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result1(htmlEncodedJson,"5");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result1(result,"5");
		    }
		  }
    });
    $('#upload_img_5').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_6').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_6').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result1(htmlEncodedJson,"6");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result1(result,"6");
		    }
		  }
    });
    $('#upload_img_6').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_7').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_7').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result1(htmlEncodedJson,"7");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result1(result,"7");
		    }
		  }
    });
    $('#upload_img_7').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_8').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_8').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result1(htmlEncodedJson,"8");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result1(result,"8");
		    }
		  }
    });
    $('#upload_img_8').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    
    
    $('#upload_img_tj_1').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_tj_1').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result2(htmlEncodedJson,"1");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result2(result,"1");
		    }
		  }
    });
    $('#upload_img_tj_1').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_tj_2').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_tj_2').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result2(htmlEncodedJson,"2");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result2(result,"2");
		    }
		  }
    });
    $('#upload_img_tj_2').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_tj_3').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_tj_3').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result2(htmlEncodedJson,"3");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result2(result,"3");
		    }
		  }
    });
    $('#upload_img_tj_3').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_tj_4').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_tj_4').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result2(htmlEncodedJson,"4");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result2(result,"4");
		    }
		  }
    });
    $('#upload_img_tj_4').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_tj_5').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_tj_5').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result2(htmlEncodedJson,"5");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result2(result,"5");
		    }
		  }
    });
    $('#upload_img_tj_5').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_tj_6').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_tj_6').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result2(htmlEncodedJson,"6");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result2(result,"6");
		    }
		  }
    });
    $('#upload_img_tj_6').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_tj_7').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_tj_7').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result2(htmlEncodedJson,"7");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result2(result,"7");
		    }
		  }
    });
    $('#upload_img_tj_7').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
    $('#upload_img_tj_8').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_tj_8').fileupload({
        dataType: 'iframejson',
		  converters: {
		    'html iframejson': function(htmlEncodedJson) {
		    	result2(htmlEncodedJson,"8");
		    },
		    'iframe iframejson': function (iframe) {
		    	result = iframe.find('body').text();
		    	result2(result,"8");
		    }
		  }
    });
    $('#upload_img_tj_8').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });
    
   
   $('#upload_img_cover').fileupload('option', {
   	 xhrFields: {
    	    withCredentials: false
    	    }
    });  
  
    $('#upload_img_cover').fileupload({
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
    $('#upload_img_cover').bind('fileuploadchange', function (e, data) {
    }).bind('fileuploadprogressall', function (e, data) {
    });

});

function return_img(result)
{
	if(result == "file error")
	{
		$("#error_content_id").html("文件格式错误!");
		$("#error_content_id").show();
	}else if(result == "file error")
	{
		$("#error_content_id").html("图片上传失败!");
		$("#error_content_id").show();
	}else
	{ 
		$("#cover_img_").val('')
		var url = img_host+result;
		//var url = "http://ihuanyue.me/media/pic/"+data.result;
		$("#file").attr("disabled", false);
		$("#success_cover_img").attr("src",url);
		$("#cover_img_").attr("src",url);
		$("#img_cover_sub").attr("value",url);
		//$("#icon_"+num).src(url);
	}
};

function result1(results,num)
{
	if(results == "file error")
	{
		$("#error_content_id").html("文件格式错误!");
		$("#error_content_id").show();
	}else if(results == "file error")
	{
		$("#error_content_id").html("图片上传失败!");
		$("#error_content_id").show();
	}else
	{ 
		$("#icon_"+num).val('')
		var url = img_host+results;
		//var url = "http://ihuanyue.me/media/pic/"+data.result;
		$("#file").attr("disabled", false);
		$("#icon_"+num).attr("src",url);
		$("#img_"+num).attr("value",url);
		//$("#icon_"+num).src(url);
	}
}

function result2(results,num)
{
	if(results == "file error")
	{
		$("#error_content_id").html("文件格式错误!");
		$("#error_content_id").show();
	}else if(results == "file error")
	{
		$("#error_content_id").html("图片上传失败!");
		$("#error_content_id").show();
	}else
	{ 
		$("#tj_icon_"+num).val('')
		var url = img_host+results;
		//var url = "http://ihuanyue.me/media/pic/"+data.result;
		$("#file").attr("disabled", false);
		$("#tj_icon_"+num).attr("src",url);
		$("#tj_img_"+num).attr("value",url);
		//$("#icon_"+num).src(url);
	}
}


function del_conf(type)
{
	var conlist="";
	var el=document.getElementsByName("checkbox"+type);
	var elem = false;
	for (var i=0;i<el.length;i++) 
	{ 
		if(el[i].checked==true) 
		{ 
			conlist = conlist+"$"+el[i].value;
			elem = true;
		} 
	} 
	if(!elem)
	{
		$("#error_content_id").html("请选择需要删除的配置!");
		$("#error_content_id").show();
		return;
	}
	var Url = "/admincmsconfigurations/delete_conf";
    var param = {key:type,value_id:conlist};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				lists = conlist.split("$");
				  for(i=1;i<=lists.length;i++)
				  {
				    if(lists[i] != null && lists[i] != "undefined")
				    {
				    	$("#"+lists[i]).empty();
				    }
				  }
				$("#error_content_id").html("操作成功!");
				$("#error_content_id").show();
				window.setInterval("$('#error_content_id').hide()",3000);
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });	
}