<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/top.css" rel="stylesheet" type="text/css"/>
        <style>
        	#headline>div{
     			display: inline-block;
     		}
        
        	.text{
        		font-size: 15px;
        		margin-top: 15px;
    			box-shadow: 0 0 5px; 
        	}
        
        	#hl{
        		
        		height: 25px;
        		width: 270px;
        		border: 1px;
        	}
        	
        	#info{
        		height: 120px;
        		width: 300px;
        		resize:none;
        	}
        	
        	#sub{
        		padding: 5px;
				height: 40px;
				width: 100px;
				border: 1px;
				border-radius: 10px;
				margin-left: 10px;
				margin-top: 10px;
				background-color: rgb(0, 200, 255);
				font-size: 20px;
        	}
        	
        	#sub:hover{
        		background-color: #03a9f4;
        		cursor: pointer;
        	}
        	
        	.Search{
        		height:67px;
        		width:300px;
        		padding:35px;
        	}
        	
        	.btn{
				width: 50px;
				height: 22px;
				border: 1px solid #DDDDDD;
				border-radius: 5px;
				vertical-align: middle;
				display: table-cell;
				color: white;
				margin-left:15px;
				background-color: deepskyblue;
			}
        </style>
    </head>
    <body>
    <div id="pop">
  		<center>
  			<div id="publish">
  				<div id="publish_close" onclick="closePublish()" title="关闭"><img src="imgs/publish_close.png" ></div>
  				<form id="pub_form" enctype="multipart/form-data">
	  				<input id="img_input" type="file" name="img" accept="image/*"/ hidden="true">
	   				<div class="preview_box" onclick="uploading()" title="添加图片"><img src="imgs/moren.png"></div>
	   				<input type="text" id="b64" name="b64" value="" hidden="true">
	   				<input type="text" name="u_id" id="u_id" value="${sessionScope.userName}" hidden="true"/>
	   				<input id="hl" class="text" type="text" name="headline" maxlength="20" placeholder="标题"/><br />
	   				<textarea id="info" class="text" name="info" placeholder="详细描述" maxlength="150"></textarea><br />
	   				<input id="sub" type="button" value="发   布" onclick="upload()">
   				</form>
  			</div>
  		</center>
  	</div>
  	<center>
	    <div id="headline">
		    <div id="logo" class="top">
		   		<img src="imgs/1_Primary_logo_on_transparent_264x67.png"/>
		   	</div>
		   	<div id="Page" class="top">
			   	<div class="page" onclick="oHomePage()">
			   		首页
			    </div>
			   	<div class="page"  onclick="oWatchPage()">
			   		关注
			   	</div>
			   	<div class="page" onclick="oMy_Works()">
			   		动态
			   	</div>
			   	<div class="page" onclick="oMy_Collections()">
			   		收藏
			   	</div>
			   	<div class="page" onclick="showPublish()">
			    	发布
			   	</div>
		   	</div>
		   	<div class="Search" style=";">
		   		<input id="headl"  type="text" value="">
		   		<input type="button" class="btn" value="搜索" onclick="oSearch()">
		   	</div>
		   	<div id="header" class="top">
		   		欢迎用户：${sessionScope.userName}
		   	</div>
	    </div>
	    </center>
 	</body>
 	<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
 	<script type="text/javascript">
 		function showPublish(){
 			document.getElementById("pop").style.display='block';
 			document.getElementById("scroll").style.overflow= "hidden";
 		}
 		
 		function p_empty(){
 			document.getElementById("img_input").value="";
 			document.getElementById("hl").value="";
 			document.getElementById("info").value="";
 			var img = '<img class="preview" src="imgs/moren.png" alt="preview"/>';
			$(".preview_box").empty().append(img);
 		}
 		
 		function closePublish(){
 			p_empty();
 			document.getElementById("pop").style.display='none';
 			document.getElementById("scroll").style.overflow= "visible";	
 		}
 		
 		function uploading(){
 			var file = document.getElementById("img_input");
			file.click();
 		}
 		

 		
 		$(document).ready(function(){
			$("#publish").hover(function(){
			/*	$("#publish_close").css("display","block");*/
			$("#publish_close").show(200)
			},function(){
		/*		$("#publish_close").css("display","none");*/
			$("#publish_close").hide(200)
			});
		});
 		
 		$("#img_input").on("change", function(e) {
  		var file = e.target.files[0]; //获取图片资源
			// 只选择图片文件
  		if (!file.type.match('image.*')) {
    		return false;
  		}
  		var reader = new FileReader();
		  reader.readAsDataURL(file); // 读取文件
		  // 渲染文件
  		reader.onload = function(arg) {
		    var img = '<img class="preview" id="p_base64" src="' + arg.target.result + '" alt="preview"/>';
		   	document.getElementById("b64").value = arg.target.result;
    		$(".preview_box").empty().append(img);
  		}
		});
		
		function upload(){
		if(toVaild()){
			$.post(
				url="upload",
				data=$('#pub_form').serialize(),
				function(d){
					alert("上传成功！");
					closePublish();
					oHomePage();
				}
			);
		}
			/*$.ajax({
				type:"POST",
				dataType:"JSON",
				url:"upload.jsp?",	
        		data:$('#pub_form').serialize(),
        		async: false,
				processData : false,
				contentType : false,
				success :function (data) {
					alert(data);
          		},
          		error : function(data) {  
            
     			}
        }); */
    	}
    
	    function oHomePage(){
	 			window.location.href="HomePage";
	 	}
		
		function oWatchPage(){
	 			window.location.href='My_Watch?author_id=all&index=0';
	 	}
		
		function oMy_Works(){
				window.location.href='AuthorSpace?author_id='+${sessionScope.userId};
		}
		
		function oMy_Collections(){
				window.location.href='My_Collections.jsp';
		}
		
		function oSearch(){
			if(document.getElementById("headl").value!="")
				window.location.href="Search?headline="+document.getElementById("headl").value;
			else
				window.location.href="HomePage";
		}
		
		function toVaild(){
			if(document.getElementById("b64").value=="")
			{
				alert("图片输入不能为空！");
				return false;
			}
			else if(document.getElementById("hl").value=="")
			{
				alert("标题输入不能为空！");
				return false;
			}
			else 
				return true;
		}
 	</script>
</html>