/**
 * @author david
 */

//add cover
$("#template_create_submmit").bind("click",function(){

    
 var name = $("#name").val();
    var desc = $("#desc").val();
    var map = $("#map").val().replace(/"/g, "'");
    var icon = $("#icon").val();
    var fileurl = $("#fileurl").val();
   
    if(name == null || name == "")
    {
         // alert("brand == null  "+(brand == null));
    	$("#error_content_id").html("请输入名称");
		$("#error_content_id").show();
		$("#name").focus();
		return;
    }
    
     if(map == null || map == "")
    {
    	$("#error_content_id").html("请输入map");
		$("#error_content_id").show();
		$("#map").focus();
		return;
    }
    if(icon == null || icon == "")
    {
    	$("#error_content_id").html("请上传图片");
		$("#error_content_id").show();
		$("#icon").focus();
		return;
    }
     if(fileurl == null || fileurl == "")
    {
    	$("#error_content_id").html("请上传模板文件");
		$("#error_content_id").show();
		$("#fileurl").focus();
		return;
    }

    var Url = "/admintemplate/add_template";
   
    var param = {name:name,desc:desc,map:map,icon:icon,fileurl:fileurl};
   
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("添加成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admintemplate/get_template'",1000);
			}else if(result.result == "exist"){
                $("#error_content_id").html("名称已存在!");
				$("#error_content_id").show();
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
$("#template_edit_submmit").bind("click",function(){

    var id = $("#id").val();
    var name = $("#name").val();
    var desc = $("#desc").val();
    var map = $("#map").val().replace(/"/g, "'");
    var icon = $("#icon").val();
    var fileurl = $("#fileurl").val();
   
    if(name == null || name == "")
    {
         // alert("brand == null  "+(brand == null));
    	$("#error_content_id").html("请输入名称");
		$("#error_content_id").show();
		$("#name").focus();
		return;
    }
    
     if(map == null || map == "")
    {
    	$("#error_content_id").html("请输入map");
		$("#error_content_id").show();
		$("#map").focus();
		return;
    }
      if(icon == null || icon == "")
    {
    	$("#error_content_id").html("请上传图片");
		$("#error_content_id").show();
		$("#icon").focus();
		return;
    }
     if(fileurl == null || fileurl == "")
    {
    	$("#error_content_id").html("请上传模板文件");
		$("#error_content_id").show();
		$("#fileurl").focus();
		return;
    }
    



    var Url = "/admintemplate/edit_template";
   
    var param = {id:id,name:name,desc:desc,map:map,icon:icon,fileurl:fileurl};
   
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				$("#error_content_id").html("修改成功!");
				$("#error_content_id").show();
				window.setInterval("window.location='/admintemplate/get_template'",1000);
			}else if(result.result == "exist"){
                            $("#error_content_id").html("名称已存在!");
				$("#error_content_id").show();
                         }
                        else

			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
				$("#classified_name").focus();
			}
		}
    });	
});


//delete cover
function del_template(brandid,type)
{       
	var templist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				templist = templist+"$"+el[i].value;
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
		templist = $("#brandid").val();
	}else
	{
		templist = brandid;
	}
	var Url = "/admintemplate/del_template";
	var brandlistnew =  templist.trim();
     //alert("brandlistnew "+brandlistnew);
    var param = {id:brandlistnew};
    $.post(Url,param,function(result){
    	if(result != null)
		{
			if(result.result == "ok")
			{
				window.setInterval("window.location='/admintemplate/get_template'",1000);
                               
			}else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });			
};


$(function (){
   $('#upload_tempfile_').fileupload('option', {
         xhrFields: {
             withCredentials: false
             }
        });  
      
        $('#upload_tempfile_').fileupload({
            dataType: 'iframejson',
            converters: {
        'html iframejson': function(htmlEncodedJson) {
          return_tempfile(htmlEncodedJson);
        },
        'iframe iframejson': function (iframe) {
         result = iframe.find('body').text();
         return_tempfile(result);
        }
      }
        });
        $('#upload_tempfile_').bind('fileuploadchange', function (e, data) {
              
         $("#t_progress_").show();
        }).bind('fileuploadprogressall', function (e, data) {
         var progress = parseInt(data.loaded / data.total * 100, 10);
         $('#t_progress_ .bar').css('width', progress + '%');
        }); 


});




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





function return_tempfile(result)
    {
    
    if(result == "file error")
    {
   
    $("#error_content_id").html("文件格式错误!");
    $("#error_content_id").show();
    }else if(result == "file error")
    {
    $("#t_progress_").hide();
    $("#error_content_id").html("图片上传失败!");
    $("#error_content_id").show();
    }
    else if(result == "file exist")
    {
    $("#t_progress_").hide();
    $("#error_content_id").html("该文件已存在，请重新上传!");
    $("#error_content_id").show();
    }
    else
    { 
    $("#error_content_id").html("");
    var host = window.location.host;
    var url = "http://"+host+result;
    $("#t_progress_").hide();
    var html = "<span>"+url+" </span>";
    $("#view_file").html(''); 
    $("#view_file").append(html); 
    $("#submit_form").attr("disabled", false);
    $("#file").attr("disabled", false);
    $("#fileurl").val('');   
    $("#fileurl").val(url);
    setInterval("$('#t_progress_').hide()",4000);
    }
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










