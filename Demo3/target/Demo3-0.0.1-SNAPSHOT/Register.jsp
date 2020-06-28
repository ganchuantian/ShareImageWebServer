<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    	<meta charset="UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
        <title>欢迎注册</title>
        <style>
        	.info{
        		width: 700px;
				border-radius: 10px;
				font-size: 25px;
				font-family: "微软雅黑";
        	}
        	
        	#account,#pw,#pw_s{
				padding: 0;
				height: 35px;
				width: 265px;
				line-height: 30px;
				margin-top: 10px;
				border-radius:5px;
				margin-left: 7px;
				color: #000000;
				font-size: 19px;
			}
			
			#register{
				padding: 5px;
				height: 40px;
				width: 275px;
				border-radius: 10px;
				margin-left: 10px;
				margin-top: 10px;
				background-color: red;
				font-size: 20px;
				color: white;
			}
			
			#register:hover{
				background-color:rgb(172,37,46);
				cursor: pointer;
			}
			
			#register>h4{
				margin-left: 1px;
				margin-top: 5px;
				color: white;
			}
			
			#reLogin{
				padding: 5px;
				height: 35px;
				width: 265px;
				border-radius: 10px;
				margin-left: 10px;
				margin-top: 16px;
				background-color: gray;
			}
			
			#reLogin:hover{
				background-color:gainsboro;
				cursor: pointer;
			}
			
			#reLogin>h4{
				margin-left: 1px;
				margin-top: 5px;
				color: white;
			}
        </style>
    </head>
    <body>
    	<center>
    		<h1 style="font-size:50px;margin-top: 170px;">欢&nbsp迎&nbsp新&nbsp用&nbsp户&nbsp注&nbsp册！</h1>
    		<form action="RegisterCheck" method="post" onsubmit="return toVaild()">
				<div class="info">
					
	  				用&nbsp户&nbsp名：&nbsp<input id="account" name="account" placeholder="请输入你的用户名！" maxlength="10" onblur="blurUser()" onfocus="focusUser()"/>
	  				<div id="accountError" style="color: red; font-size: 17px;"></div>
	  				<br>		
	  				密&nbsp&nbsp&nbsp&nbsp&nbsp码：&nbsp<input id="pw" name="pw" type="password" maxlength="15" placeholder="请输入你的密码！" onblur="blurPassword()" onfocus="focusPassword()"/>
	  				<div id="pwError" style="color: red; font-size: 17px;"></div>
	  				<br>
	  				确认密码：<input id="pw_s" type="password" maxlength="15" placeholder="请输入你的密码！" onblur="blurPw_s()" onfocus="focusPw_s()"/>
	  				<div id="pw_sError" style="color: red; font-size: 17px;"></div>
	  				<br>
	  				<div>
	  				<%
  					if(request.getAttribute("me")!=null&&request.getAttribute("me").toString()!="") 
  					{
  						String fal=request.getAttribute("me").toString();
  						out.print(fal);
  					}
  					%>
  					</div>
	  				<div id=""><h4><input id="register" type="submit" value="注&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp册"></h4></div>
	  				<div id="reLogin" onclick="rL()"><h4>已&nbsp有&nbsp账&nbsp号</h4></div>
	  			</div>
  			</form>
  		</center>
 	</body>
 	
 	<script type="text/javascript" src="js/cropbox.js"></script>
 	
 	<script>
 		function blurUser(){
	  		var ip = document.getElementById("account")
	  		if(ip.value=="")
	  		{
	  			var html="用户名不能为空";
	  			var self = document.getElementById("accountError");
	  			self.innerHTML=html;
	  			ip.style.borderColor="red";
	  			return true;
	  		}
	  		return false;
  		}
  	
	  	function focusUser(){
	  		var html = "";
	  		document.getElementById("accountError").innerHTML=html;
	  		document.getElementById("account").style.borderColor="black";
	  	}
	  	
	  	function blurPassword(){
	  		var ip = document.getElementById("pw")
	  		if(ip.value=="")
	  		{
	  			var html="密码不能为空";
	  			var self = document.getElementById("pwError");
	  			self.innerHTML=html;
	  			ip.style.borderColor="red";
	  			return true;
	  		}
	  		else if(ip.value.length<6){
	  			var html="密码长度因在6~15位之间！";
	  			var self = document.getElementById("pwError");
	  			self.innerHTML=html;
	  			ip.style.borderColor="red";
	  			return true;
	  		}
	  		return false;
	  	}
	  	
	  	function focusPassword(){
	  		var html = "";
	  		document.getElementById("pwError").innerHTML=html;
	  		document.getElementById("pw").style.borderColor="black";
	  	}
 		
 		function blurPw_s(){
 			var ip = document.getElementById("pw_s")
	  		if(ip.value=="")
	  		{
	  			var html="密码不能为空";
	  			var self = document.getElementById("pw_sError");
	  			self.innerHTML=html;
	  			ip.style.borderColor="red";
	  			return true;
	  		}
	  		else if(ip.value.length<6){
	  			var html="密码长度应为6~15位";
	  			var self = document.getElementById("pw_sError");
	  			self.innerHTML=html;
	  			ip.style.borderColor="red";
	  			return true;
	  		}
	  		else if(ip.value!=document.getElementById("pw").value)
	  		{
	  			var html="两次密码输入不正确";
	  			var self = document.getElementById("pw_sError");
	  			self.innerHTML=html;
	  			ip.style.borderColor="red";
	  			return true;
	  		}
	  		return false;
 		}
 		
 		function focusPw_s(){
 			var html = "";
	  		document.getElementById("pw_sError").innerHTML=html;
	  		document.getElementById("pw_s").style.borderColor="black";
 		}
 		
 		
 		function rL(){
 			window.location.href="Login.jsp";
 		}
 		
 		 function toVaild(){
            if(blurUser()||blurPassword()||blurPw_s())
			{
				alert("注册信息不符合规范，请检查！");
				return false;
			}
			else
				return true;
           }
 	</script>
</html>