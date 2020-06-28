<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'detail.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta charset="UTF-8">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">	
		/*113132*/
		a:link { text-decoration: none;color: blue}
		a:active { text-decoration:blink}
		a:hover { text-decoration:underline;color: red} 
		a:visited { text-decoration: none;color: green}
		
		#all_box{
			width: 1200px;
			height: auto;
			margin-top:50px;
			
		}
		
		#all_box>div{
			display: inline-block;
		}
		
		#Pic_box{
			
			width:750px;
			height:auto;
			float:left;
			background-color:rgba(190,190,190,0.4);
			border-radius:10px
		}
		
		#p_headline{
			width: 750px;
			height: 45px;
			margin-top: 10px;
			float: left;
			font-size: 23px;
		}
		
		#p_headline>div{
			display: inline-block;
		}
		
		#collect_btn{
			color: white;
			border: hidden;
			border-radius: 4px;
			margin-top:20px;
			margin-left:20px;
			float:right;
			background-color: deepskyblue;
		}
		
		#collect_btn:hover{
			background-color: cornflowerblue;
			cursor: pointer;
		}
		
		#cancelCollect_btn{
			color: white;
			border: hidden;
			border-radius: 4px;
			margin-top:20px;
			margin-left:20px;
			float:right;
			background-color: red;
		}
		
		#cancelCollect_btn:hover{
			background-color: rgb(221,82,70);
			cursor: pointer;
		}
		
		#pic{
			width: 750px;
			height: auto;
			display: table-cell;
			vertical-align: middle;
		}
		
		#pic img{
			width: 100%;
			height: auto;
			max-width: 750px;
		}
		
		#author_box{
			width: 277px;
			height: 131px;
			float: left;
			margin-left: 30px;
			background-color:rgba(190,190,190,0.4);
			padding: 15px;
		}
		
		#author_box>div{
			display: inline-block;
		}
		
		#author_header{
			height: 90px;
			width: 90px;
			float: left;
			border-radius: 50%;
			background-color: rgb(147,80,215);
		}
		
		#watch_btn{
				color: white;
				border: hidden;
				border-radius: 4px;
				margin-top:20px;
				margin-left:10px;
				background-color: deepskyblue;
		}
		
		#watch_btn:hover{
			background-color: cornflowerblue;
			cursor: pointer;
		}
		
		#cancelWatch_btn{
			color: white;
			border: hidden;
			border-radius: 4px;
			margin-top:20px;
			margin-left:10px;
			background-color: red;
		}
		
		#cancelWatch_btn:hover{
			background-color:rgb(221,82,70);
			cursor: pointer;
		}
		
		#author_info{
			height: 130px;
			width: 170px;
			float: right;
		}
		
		#author_name{
			margin-top: 10px;
		}
		
		#author_intro{
			margin-top: 4px;
			font-size: 15px;
			height: 75px;
		}
		
		#author_info>a{
			color: gray;
		}
	</style>
  </head>
  <body>
    <%@ include file="top.jsp"%>
    <center>
    <div id="all_box">
    
    	<!-- 图片模块 -->
    	<div id="Pic_box">
			<div id="p_headline">
				<span>${requestScope.headline}</span>
				<div id="c_box" style="float:right">
					
				</div>
			</div>
			<hr>
			<div id="pic">
				<img src="http://localhost:9080/PicBase/${requestScope.p_path}"/>
			</div>
			<hr>
			<div style="margin-top:10px;margin-left:15px;font-size:20px;">
				${requestScope.p_info}
			</div>
    	</div>
    	
		<!--  评论模块 -->
    	
    	
    	<!-- 作者模块 -->
    	<div id="author_box">
    		<div id="author_header_box">
    			<div id="author_header"></div>
    			<div id="watch_box">
    			
    			</div>
    		</div>
    		
    		<div id="author_info">
    			<center>
	    			<div>
	    				<span id="author_name" style="font-size: 20px;">${requestScope.author_name}</span>
	    			</div>
	    			<div id="author_intro">
	    				简介内容
	    			</div>
	    			<div id="more">
	    				<a href="AuthorSpace?author_id=${requestScope.author_id}">查看作者更多作品>></a>
	    			</div>
	    		</center>
    		</div>
    	</div>
    </div>
    </center>
  </body>
  <script type="text/javascript" src="js/jquery-3.3.1.js"></script>
  <script type="text/javascript">
  		function Check(){
  		if(${sessionScope.userId}!=${requestScope.author_id})
		{
			    $.getJSON(url="userOperation",
					{
						op:"6",
						u_id:${sessionScope.userId},
						author_id:${requestScope.author_id},
						p_id:${requestScope.p_id}
					},
					function(data){
						var html = '';
						if(data=="0")
						{
							html = '<button id="watch_btn" onclick="Watch('+${requestScope.author_id}+')">+关注</button>';
							$("#watch_box").append(html);
							html = '<button id="collect_btn" style="float: right; margin-right: 30px; margin-top: 10px;" onclick="Collect('+${requestScope.p_id}+')">添加收藏</button>';
							$("#c_box").append(html);
						}
						else if(data=="1")
						{
							html = '<button id="cancelWatch_btn" onclick="cancelWatch('+${requestScope.author_id}+')">取消关注</button>';
							$("#watch_box").append(html);
							html = '<button id="collect_btn" style="float: right; margin-right: 30px; margin-top: 10px;" onclick="Collect('+${requestScope.p_id}+')">添加收藏</button>';
							$("#c_box").append(html);
						}
						if(data=="2")
						{
							html = '<button id="watch_btn" onclick="Watch('+${requestScope.author_id}+')">+关注</button>';
							$("#watch_box").append(html);
							html = '<button id="cancelCollect_btn" style="float: right; margin-right: 30px; margin-top: 10px;" onclick="cancelCollect('+${requestScope.p_id}+')">取消收藏</button>';
							$("#c_box").append(html);
						}
						else if(data=="3")
						{
							html = '<button id="cancelWatch_btn" onclick="cancelWatch('+${requestScope.author_id}+')">取消关注</button>';
							$("#watch_box").append(html);
							html = '<button id="cancelCollect_btn" style="float: right; margin-right: 30px; margin-top: 10px;" onclick="cancelCollect('+${requestScope.p_id}+')">取消收藏</button>';
							$("#c_box").append(html);
						}
					}
				);
			}
		}
		Check()
 	 </script>
 	  <script type="text/javascript">
  		function Watch(author_id){
			$.post(url="userOperation?op=0",
				{
					u_id:${sessionScope.userId},
					author_id:author_id
				},
				function(status){
					
					if(status="true"){
						$('#watch_box').html("");
						var html = '<button id="cancelWatch_btn" onclick="cancelWatch('+${requestScope.author_id}+')">取消关注</button>';
						$("#watch_box").append(html);
					}
					else
						alert("关注结果！"+status);
				}
			);
    	}
    	
    	function cancelWatch(author_id){
    		$.post(url="userOperation?op=1",
				{
					u_id:${sessionScope.userId},
					author_id:author_id
				},
				function(status){
					if(status="true"){
						$('#watch_box').html("");
						var html = '<button id="watch_btn" onclick="Watch('+${requestScope.author_id}+')">+关注</button>';
						$("#watch_box").append(html);
					}
					else
						alert("取消结果！"+status);
				}
			);
    	}
    	
    	function Collect(p_id){
    		$.post(url="userOperation?op=2",
				{
					u_id:${sessionScope.userId},
					p_id:p_id
				},
				function(status){
					if(status="true"){
						$('#c_box').html("");
						var html = '<button id="cancelCollect_btn" style="float: right; margin-right: 30px; margin-top: 10px;" onclick="cancelCollect('+${requestScope.p_id}+')">取消收藏</button>';
						$("#c_box").append(html);
					}
					else
						alert("收藏结果！"+status);
				}
			);
    	}
    	
    	function cancelCollect(p_id){
    		$.post(url="userOperation?op=3",
				{
					u_id:${sessionScope.userId},
					p_id:p_id
				},
				function(status){
					if(status="true"){
						$('#c_box').html("");
						var html = '<button id="collect_btn" style="float: right; margin-right: 30px; margin-top: 10px;" onclick="Collect('+${requestScope.p_id}+')">添加收藏</button>';
						$("#c_box").append(html);
					}
					else
						alert("取消结果！"+status);
				}
			);
    	}
    </script>
</html>
