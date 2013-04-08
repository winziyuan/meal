/**
 * @author david
 */
 
var count = 1;
var tem = {};
var map = {};
var tmf = {};
var temmap = {};
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
		var url = img_host+result;
		var img_id = $("#v").val();
		$("#img_"+img_id).attr("src",url);
		$("#"+img_id).val(url);
		$("#"+id).val(url);
	}
}; 
  
//动态生成可编辑部分内容 
function xml_read_html(str1,upload_url,tem_url)
{
	var push_count = parseInt($("#showpage").html()); 
	var tema = {
		map: str1,
		upload_url: upload_url,
		tem_url: tem_url
	};
	temmap[push_count] = tema;
	$("#mpa_id_list").val("");
	var unicode= BASE64.decoder(str1);//返回会解码后的unicode码数组。  
  
  	//可由下面的代码编码为string  

	var str2 = '';  
	for(var i = 0 , len =  unicode.length ; i < len ;++i){  
	      str2 += String.fromCharCode(unicode[i]);  
	};
	//跨浏览器，ie和火狐解析xml使用的解析器是不一样的。  
	var xmlStrDoc=null;  
	if (window.DOMParser){// Mozilla Explorer  
	  parser=new DOMParser();  
	  xmlStrDoc=parser.parseFromString(str2,"text/xml");  
	}else{// Internet Explorer  
	  xmlStrDoc=new ActiveXObject("Microsoft.XMLDOM");  
	  xmlStrDoc.async="false";  
	  xmlStrDoc.loadXML(str2);  
	}  
	$("#content_t").html(" ");
	//解析  
	 $(xmlStrDoc).find('mapResource').each( function ()  {
	      var  id = $( this ).attr('id');  
	      var  type = $( this ).attr('type');
	      var  name = $( this ).attr('name');
	      var mapid = $.trim($("#mpa_id_list").val());
	      $("#mpa_id_list").val(mapid+"$"+id)
	      if(type == 'image')
	      {
	      		$("#content_t").append("<form action='"+upload_url+"' method='POST'"+ 
	      		"id='upload_img_"+id+"' enctype='multipart/form-data' target='ifa'>"+
	      		"<table><tr><td class='w230'>"+name+
	      		":</td><td><span class='btn btn-success fileinput-button'>"+
	      		"<span>选择文件</span>"+       	
	      		"<input type='file' id='file_"+id+"' name='files'>"+
	      		"</span><img src='' width='40' id='img_"+id+"' height='40'/>"+
	      		"<input type='hidden' id='"+id+"' />"+
	      		"</td></tr></table></form>"); 
	      		$("#file_"+id).die().live("click",function(){
			      $("#v").val("");
			      $("#v").val(id);
			      $('#upload_img_'+id).fileupload('option', {
				   	 xhrFields: {
				    	    withCredentials: false
				    	    }
				    });  
				  
				    $('#upload_img_'+id).fileupload({
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
				    
				    
				});
		      	
	      }else if(type == 'textBoxPicture')
	      {
		      $("#content_t").append("<table><tr><td class='w230'>"+name+":</td><td>"+
		      	"<textarea cols=\"50\" name=\""+id+"\" id=\""+id+"\" "+
		      	"style=\"margin: 0px; width: 621px; height: 158px;\"></textarea></td></tr></table>");
	      } 
	 });
};   


//点击上一页
$("#before_create_page").bind("click",function(){
	save_page("before");
});

//点击下一页
$("#after_create_page").bind("click",function(){
	save_page("after");    
});

//提交内容
$("#from_submit").bind("click",function(){
	save_page("save");  
	if(getJsonLength(map) >=1)
	{
		var countnumber = parseInt($("#showcount").html());
		var parms = {map:JSON.stringify(map),tem:JSON.stringify(tem),tmf:JSON.stringify(tmf),nodename:$("#nodename").val(),page_count:countnumber,temmap:JSON.stringify(temmap)};
		var Url = "/admininfo/trends_info_create";
		var edit = $("#edit_bs").val();
		var error_c = "文章创建成功!";
		if(edit == "edit")
		{
			var id = $("#edit_id").val();
			Url = "/admininfo/trends_info_edit";
			error_c = "文章修改成功!";
			parms = {id:id,map:JSON.stringify(map),tem:JSON.stringify(tem),tmf:JSON.stringify(tmf),nodename:$("#nodename").val(),page_count:countnumber,temmap:JSON.stringify(temmap)};
		}
		$.post(Url,parms,function(result){
			if(result != null)
			{
				if(result.result == "ok")
				{        
					$("#error_content_id").html(error_c);
					$("#error_content_id").show();
	                window.setInterval("window.location='/admin/info'",2000);
				}else
				{       remove_disable();
					$("#error_content_id").html("服务错误请刷新后进行操作!");
					$("#error_content_id").show();
				}
			}
		});
	}else
	{
		$("#error_content_id").html("未创建任何内容,请添加内容!");
		$("#error_content_id").show();
	}
	
});


//保存上一页信息
function save_page(type_page)
{
	var mapresidstring = $("#mpa_id_list").val();
	$("#mpa_id_list").val("");
	var tem_file_url =  $('input:radio[name="radio"]:checked').val();
	var mapresidlist = mapresidstring.split("$");
	var mappage = [];
	for(i = 0; i<mapresidlist.length; i++)
	{
		if(mapresidlist[i] != "")
		{
			var text = {
				id: ""+mapresidlist[i],
				name: "url",
				value: $("#"+mapresidlist[i]).val()
			};
			if($("#"+mapresidlist[i]).val() != "")
			{
				mappage.push(text);
			}
		}
	};
	var mappage1 = {
		page1 : mappage
	};
	var tempage1 = {
		page1 : tem_file_url
	};
	var tmp_v = "<content id=\"100_Cover_0812\" slideDirection=\"vertical\">"+
				"<publication title=\"FashionMagazine\" height=\"768\" width=\"1024\" orientation=\"landsacpe\"/>"+
				"<metadata flowing=\"no\"><pRectangle x=\"0\" y=\"0\" width=\"1\" height=\"1\"/></metadata>"+
				"<layouts><layout pageFolder=\"pageFolder1\"/></layouts><catalogs/><objects/></content>";
	var push_count = parseInt($("#showpage").html()); 
	if(mappage.length > 0)
	{
		map[push_count] = {};
		tem[push_count] = {};
		map[push_count] = mappage1;
		tem[push_count] = tempage1;
		tmf[push_count] = tmp_v;
		$("#content_t").html(" ");
		if(type_page != "save")
		{
			pagenumber(type_page);
			$("input[name=radio][value=\""+temmap[push_count].tem_url+"\"]").attr("checked",false);
		}
	}else if(type_page == "before"){
		pagenumber(type_page);
	}else if(type_page == "save")
	{
		if(parseInt($("#showpage").html()) > 1){
			$("#showpage").html(parseInt($("#showpage").html())-1);
			$("#showcount").html(parseInt($("#showcount").html())-1)
		}
		return;
	}
		
	var mapcount = parseInt($("#showpage").html());
	var pagecount = parseInt($("#showcount").html());
	if(type_page == "after")
	{
		if(mapcount <= getJsonLength(map))
		{
			change_data_reappear(mapcount);
		}
	}else
	{
		if(mapcount <= pagecount)
		{
			change_data_reappear(mapcount);
		}
	}
	
	//alert(JSON.stringify(map));
	//alert(JSON.stringify(tem));
	//alert(JSON.stringify(tmf));
	//alert(JSON.stringify(temmap));
}

//上下页公共方法
function click_page(type)
{
	var tem_count = count;
	if(type == "before")
		tem_count = count - 1;
	else{
		tem_count = count + 1;
		count += count;
	}
	
	if(tem_count <= 1)
	{
		$("#before_create_page").attr("disabled","disabled");  
	}else
	{
		$("#before_create_page").removeAttr("disabled");
	}
};

//获取json长度
function getJsonLength(json){
	var len=0;
    if(Boolean(json)){
	    for(i in json)len++;
	}
	return len;
};

//获取当前页数
function pagenumber(type)
{
	var pagenum = parseInt($("#showpage").html());
	var pagecount = parseInt($("#showcount").html());
	$("#before_create_page").removeAttr("disabled");
	if(pagenum == pagecount)
	{
		if(type == "after")
		{
			$("#showpage").html(pagenum+1);
			$("#showcount").html(pagecount+1);
		}else
		{
			if(pagenum > 1){
				$("#showpage").html(pagenum-1);
				if(parseInt($("#showpage").html()) == 1)
					$("#before_create_page").attr("disabled","disabled");
			}else
				$("#before_create_page").attr("disabled","disabled");
		}
	}else if(pagenum < pagecount)
	{
		if(type == "after")
		{
			$("#showpage").html(pagenum+1);
		}else
		{
			if(pagenum > 1){
				$("#showpage").html(pagenum-1);
				if(parseInt($("#showpage").html()) == 1)
					$("#before_create_page").attr("disabled","disabled");
			}else
				$("#before_create_page").attr("disabled","disabled");
		}
	}
};

//页面切换时数据加载
function change_data_reappear(pagenum)
{
	var temmap_cdr = temmap[pagenum];
	$("input[name=radio][value=\""+temmap_cdr.tem_url+"\"]").attr("checked",true);
	xml_read_html(temmap_cdr.map, temmap_cdr.upload_url, temmap_cdr.tem_url);
	var map_cdr = map[pagenum].page1;
	for(i = 0; i<map_cdr.length; i++)
	{
		var t = map_cdr[i];
		$("#"+t.id).val(t.value);
		$("#img_"+t.id).attr("src", t.value);
	}
};



$(function () {
	var edit = $("#edit_bs").val();
	if(edit == "edit")
	{
		tem = JSON.parse($("#edit_tem_json_string").val());
		map = JSON.parse($("#edit_map_json_string").val());
		tmf = JSON.parse($("#edit_tmf_json_string").val());
		temmap = JSON.parse($("#edit_temmap_json_string").val());
		change_data_reappear(parseInt($("#showpage").html()));
	}
	
});










