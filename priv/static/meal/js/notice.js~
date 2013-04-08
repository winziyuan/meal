

//delete classified
function del_notice(userid_,type)
{
	var noticeidlist = "";
	if(type=="1")
	{
		var el=document.getElementsByName("checkbox");
		var elem = false;
		for (var i=0;i<el.length;i++) 
		{ 
			if(el[i].checked==true) 
			{ 
				noticeidlist = noticeidlist+","+el[i].value;
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
		noticeidlist = $("#userid").val();
	}else
	{
		noticeidlist = userid_;
	}
	var Url = "/notice/delete";
	var noticelistnew =  noticeidlist;

    var param = {id:noticelistnew};
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
                         window.location="/notice/show";
                   
                 
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

  
        var title = $.trim($("#title").val());       
	var summent = $.trim(editor.html());       

	if(title == "" || title == null)
	{
		$("#error_content_id").html("请输入标题");
		$("#error_content_id").show();
		$("#title").focus();
		return;
	}; 
	

        if(summent== "" || summent == null)
	{
		$("#error_content_id").html("请输入内容");
		$("#error_content_id").show();
		$("#title").focus();
		return;
		
	};
         
      
    var Url = "/notice/add";
	
    var param = $("#create_notice_form").serialize();
   
    $.post(Url,{title:title,summent:editor.html()},function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("创建成功");
			 $("#error_content_id").show();
             setInterval("window.location='/notice/show'",2000);
                         
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
	var title = $.trim($("#title").val());       
	var summent = $.trim($("#summent").text());       
	

	if(title == "" || title == null)
	{
		$("#error_content_id").html("标题不能为空");
		$("#error_content_id").show();
		$("#title").focus();
		return;
	}; 
	if(summent == "" || summent == null)
	{
		$("#error_content_id").html("内容不能为空");
		$("#error_content_id").show();
		$("#summent").focus();
		return;
	}; 

        

             
    var Url = "/notice/edit";	
    var param = $("#edit_notice_form").serialize();
   
    $.post(Url,param,function(result){
    	if(result != null)
		{       
			if(result.result == "ok")
			{
			 $("#error_content_id").html("修改成功");
			 $("#error_content_id").show();
             setInterval("window.location='/notice/show'",2000);
                         
			}
                         else
			{
				$("#error_content_id").html("服务错误请刷新后进行操作!");
				$("#error_content_id").show();
			}
		}
    });
	
});




/*

var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="summent"]', {
					resizeType : 1,
					allowPreviewEmoticons : true,
					allowImageUpload : true,
                                   
					items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'image', 'link','unlink','flash', 'quote',]
				});
			});



*/
var editor;
KindEditor.ready(function(K) {
	editor=K.create('#summent', {
               // imageUploadJson : 'post_templatefile',
		imageUploadJson : ' http://dev.ihuanyue.me:8080/web',
 
		allowFileManager : true
	});
});







/*

 CKEDITOR.replace( 'summent',
                                {
                                        extraPlugins : 'devtools',
                                        // Remove unused plugins.
                                        removePlugins : 'bidi,button,dialogadvtab,div,filebrowser,flash,format,forms,horizontalrule,iframe,indent,justify,liststyle,pagebreak,showborders,stylescombo,table,tabletools,templates',
                                        // Width and height are not supported in the BBCode format, so object resizing is disabled.
                                        disableObjectResizing : true,
                                        // Define font sizes in percent values.
                                        fontSize_sizes : "30/30%;50/50%;100/100%;120/120%;150/150%;200/200%;300/300%",
                                        toolbar :
                                        [
                                                ['Source', '-', 'Save','NewPage','-','Undo','Redo'],
                                                ['Find','Replace','-','SelectAll','RemoveFormat'],
                                                ['Link', 'Unlink','Image', 'Smiley','SpecialChar'],
                                                ['Bold', 'Italic','Underline'],
                                                ['FontSize'],
                                                ['TextColor'],
                                                ['NumberedList','BulletedList','-','Blockquote'],
                                                ['Maximize']
                                        ],
                                        // Strip CKEditor smileys to those commonly used in BBCode.
                                        smiley_images :
                                        [
                                                'regular_smile.gif','sad_smile.gif','wink_smile.gif','teeth_smile.gif','tounge_smile.gif',
                                                'embaressed_smile.gif','omg_smile.gif','whatchutalkingabout_smile.gif','angel_smile.gif','shades_smile.gif',
                                                'cry_smile.gif','kiss.gif'
                                        ],
                                        smiley_descriptions :
                                        [
                                                'smiley', 'sad', 'wink', 'laugh', 'cheeky', 'blush', 'surprise',
                                                'indecision', 'angel', 'cool', 'crying', 'kiss'
                                        ]
                        } );


*/







