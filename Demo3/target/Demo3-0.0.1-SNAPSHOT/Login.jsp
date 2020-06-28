<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
  <head> 
  <title>登陆</title>
 	<meta charset="UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
  #all{
				background-image: url(imgs/stock-photo-88557399.jpg);
				background-color: #F7F7F7;
				height: 830px;
				width: 1510px;
				display: table-cell;
	}
	
	#self{
		margin-top: 120px;
		width: 400px;
		height: 500px;
		background-color: rgba(240, 240, 240, 0.7);
		border-radius: 10px;
	}
	
	#logo{
		width: 250px;
		height: 100px;
		padding-top: 50px;
		margin-bottom: 15px;
	}
	
	.info{
		width: 400px;
		height: 500px;
		border-radius: 10px;
		font-size: 20px;
		font-family: "å¾®è½¯éé»";
	}
	
	#account,#pw{
				border: 2px solid;
				padding: 2px;
				height: 35px;
				width: 265px;
				line-height: 30px;
				margin-top: 10px;
				border-radius:5px;
				margin-left: 7px;
				color: #000000;
				font-size: 19px;
			}
			
	#account:focus {
   	border-style:solid;  
    border-color: #03a9f4;  
    box-shadow: 0 0 15px #03a9f4; 
	}
	
	#pw:focus {
   	border-style:solid;  
    border-color: #03a9f4;  
    box-shadow: 0 0 15px #03a9f4; 
	}
	
	#login{
				padding: 5px;
				height: 40px;
				width: 275px;
				border-radius: 10px;
				margin-left: 10px;
				margin-top: 10px;
				background-color: rgba(37, 255, 255);
				font-size: 20px;
	}
	
	#login:hover{
				background-color: rgb(0, 175, 255);
				cursor: pointer;
	}
			
	#login>h4{
				margin-left: 1px;
				margin-top: 5px;
				color: white;
	}
	
	
	
	#register{
				padding: 5px;
				height: 35px;
				width: 265px;
				border-radius: 10px;
				margin-left: 10px;
				background-color: #5CB85C;
	}
	
	#register:hover{
				background-color: #009F95;
				cursor: pointer;
	}
	
	#register>h4{
				margin-left: 1px;
				margin-top: 5px;
				color: white;
	}
  </style>
  </head>
  <body>
  	<div id="all">
  		<center>
  		<div id="self" style="">
  			<div id="logo" style=""><img src="imgs/1_Primary_logo_on_transparent_264x67.png"></div>
  		
  			<div class="info">
  			<form action="loginCheck" method="post" >
  				用户名<input id="account" name="account" placeholder="请输入用户名" maxlength="10" onblur="blurUser()" onfocus="focusUser()"/>
  				<div id="accountError" style="color: red; font-size: 17px;"></div>
  				<br>
  				密&nbsp&nbsp&nbsp码<input id="pw" name="pw" type="password" maxlength="15" placeholder="请输入密码" onblur="blurPassword()" onfocus="focusPassword()"/>
  				<div id="passwordError" style="color: red; font-size: 17px;">
  				<%
  					if(request.getAttribute("fal")!=null&&request.getAttribute("fal").toString()!="") 
  					{
  						String fal=request.getAttribute("fal").toString();
  						out.print(fal);	
  					}
  				%>
  				</div>
  				<br>
  				<a href="" style="font-size: 15;margin-right: 135px;padding-top: 10px;">忘记密码</a>
  				<div id="" ><h4><input id="login" type="submit" value="登&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp陆"></h4></div>
  				</form>
  				<div id="register" onclick="rgt()"><h4>注&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp册</h4></div>
  			</div>
  			</form>
  		</div>
  		</center>
  	</div>
  </body>
  <script type="text/javascript" charset="utf-8">
  	function blurUser(){
  		var ip = document.getElementById("account");
  		if(ip.value=="")
  		{
  			var html="用户名错误";
  			var self = document.getElementById("accountError");
  			self.innerHTML=html;
  			ip.style.borderColor="red";
  		}
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
  			var self = document.getElementById("passwordError");
  			self.innerHTML=html;
  			ip.style.borderColor="red";
  		}
  		else if(ip.value.length<6){
  			var html="密码长度不能少于6";
  			var self = document.getElementById("passwordError");
  			self.innerHTML=html;
  			ip.style.borderColor="red";
  		}
  	}
  	
  	function focusPassword(){
  		var html = "";
  		document.getElementById("passwordError").innerHTML=html;
  		document.getElementById("pw").style.borderColor="black";
  	}
  	
  	function rgt(){
  		window.location.href="Register.jsp";
  	}
  </script>
</html>
