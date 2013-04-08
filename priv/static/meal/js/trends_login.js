/**
 * @author david
 */
var r=false;

$("#login_submit").bind("click", function(){ 
	login();	
});

$("#user_name_id").mouseout(function(){
	$("#error_content_id").hide();
});

$(window).keydown(function(event){
	if(event.keyCode == 13){
		login();
	}
});

$("#user_name_id").keyup(function(){  
    var val= $("#user_name_id").val();  
   // var regex= /^[/\[u4E00-\u9FA5a]-zA-Z0-9\-])$/; 
   //  var ret = regex.test(val);
  //  alert("aaaaaaa "+ret);
     if(val.length>0){    
          $("#user_p").hide();
       }else{
         $("#user_p").show();
           };

    });   
$("#passwd_id").keyup(function(){  
    var val= $("#passwd_id").val();
     if(val.length>0){
          $("#pass_p").hide();
       }else{
         $("#pass_p").show();
           };

    });   


$("#rember_pass").bind("click", function(){ 
 

if(r){
r=false;
}else{
r=true;
};


     if(r){
$("#rember_pass").attr("class","j-ok");

}else{      

$("#rember_pass").attr("class","c j-ok");

 };

});

function rember_user(name,password){
    
         if(r){
       
         $.cookie("name", name,{expires: 7});	
         $.cookie("password", password,{expires: 7});	
          
          }else{
          $.cookie("name", null);	
         $.cookie("password", null);	
          };


};

$(function (){


var a = new Array();

a[0] = '/static/trends/img/bj1.jpg';
a[1] = '/static/trends/img/bj2.jpg';
a[2] = '/static/trends/img/bj3.jpg';
a[3] = '/static/trends/img/bj4.jpg';
var b = Math.floor(Math.random()*10+1);
//alert("tttttttttttttttttttttt");
//alert("a[b%4] "+a[b%4]);
//document.getElementById('#login_bg').src = a[b%4];
$("#login_bg").attr("src",a[b%4]);






var name= $.cookie("name");
var password= $.cookie("password");
if((name!=null)&&(password!=null)){
   
  r=true;
  $("#rember_pass").attr("class","j-ok");
  $("#pass_p").hide();
  $("#user_p").hide();
  $("#user_name_id").val(name);
  $("#passwd_id").val(password);
};

});







function login()
{
	var Username = $("#user_name_id").val();
	var Passwd = $("#passwd_id").val();
        
        var type = "";
	var ok=document.getElementsByName("type");
	for(i=0;i<ok.length;i++)
	{
		if (ok[i].checked == true){
			type = ok[i].value;
		}
	}
 



	var Url = "/index/login";
        if(Username==""){
           $("#error_content_id").html("用户名为空!");
				$("#error_content_id").show();
				$("#user_name_id").focus();
                                return;
          };
        if(Passwd==""){
           $("#error_content_id").html("密码为空!");
				$("#error_content_id").show();
				$("#passwd_id").focus();
                                return;
          };
         
	$.post(Url,{name:Username,password:Passwd,type:type},function(result){
               
		if(result.result != null)
		{      
			if(result.result == "ok")
			{
				$("#error_content_id").html("");
                                //rember_user(Username,Passwd);
				window.location="/index/welcome";
                                return;
			}
                         else  if(result.result == "user_error")
			{
				$("#error_content_id").html("用户名或密码错误!");
				$("#error_content_id").show();
				$("#user_name_id").focus();
				$("#passwd_id").val("");
                               return;
			}else
			{
				$("#error_content_id").html("服务器错误,请稍后!");
				$("#error_content_id").show();
				$("#user_name_id").focus();
				$("#passwd_id").val("");
                                return;
			}




		}else
		{
			        $("#error_content_id").html("服务器无响应!");
				$("#error_content_id").show();
				$("#user_name_id").focus();
				$("#passwd_id").val("");			
		}
	});	
};
