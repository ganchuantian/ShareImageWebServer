<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'My_Works.jsp' starting page</title>
   <meta charset="UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="css/HomePage.css" rel="stylesheet" type="text/css"/>
	<style type="text/css">
		.Works_Box{
			width:604px;
			height:750px;
			margin-top:10px;
			border: 5px solid #D3D4D3;
			border-radius:20px;
		}
		
		.works{
			width:600px;
			height:550px;
			vertical-align: middle;
			background-color: rgba(150,150,150,0.7);
			display: table-cell;
			border-radius:20px;
		}
		
		.works>img {
			width: auto;
			height: auto;
			max-width: 100%;
			max-height: 100%;
			border-radius:15px;
		}
		
		.worksWord{
			width:800px;
			height:140px;
			margin-top:10px;
		}
		
		.worksHeadline{
			width:600px;
			height:40px;
			float:left;
		}
		
		.worksInfo{
			width:600px;
			height:90px;
			margin-top:10px;
			float:left;
		}
		
		.delete_btn{
			width:100px;
			height:35px;
			float:right;
			bottom:0px;
			padding-top:10px;
			border-radius:15px;
			background-color: rgb(210,210,210);
			color:rgb(255,255,255)
		}
		
		.delete_btn:hover{
			background-color: red;
			cursor: pointer;
		}
   	</style>
  </head>
  
  <body>
  	<%@ include file="top.jsp"%>
  	<center>
     	<div class="Pics" style="margin-left:20px;width:890px;">
			<div id="title" style="width:850px;">
				<div style="margin-top: 5px;">所有作品</div>
			</div><br />
			<div class="pics-box" id="pics-box">	
				<center id="ct">
				<c:forEach items="${requestScope.rs}" var="keyword">
					
					<div class="Works_Box" onclick="detail('${keyword.p_id}')">
						<div class="works">
							<img src="http://localhost:9080/PicBase/${keyword.p_path}">
						</div>
						<div class="worksWord">
							<div class="worksHeadline">作品名：${keyword.headline}</div>
							<div class="worksInfo">介绍：${keyword.info}</div>
						</div>
						<div class="delete_btn" onclick="deletePic(${keyword.p_id})">删除</div>
					</div>
										
				</c:forEach>
				</center>				
			</div>
		</div>
	</center>
  </body>
  <script>
  	var index=0;
  	var auto_c;
  	var auto_d;
  
  	function lowEnough(){
            var pageHeight = Math.max(document.body.scrollHeight,document.body.offsetHeight);
            var viewportHeight = window.innerHeight || 
                document.documentElement.clientHeight ||
                document.body.clientHeight || 0;
            var scrollHeight = window.pageYOffset ||
                document.documentElement.scrollTop ||
                document.body.scrollTop || 0;
            return pageHeight - viewportHeight - scrollHeight < 20;
        }
        
  	function doSomething(){
            index++;
            $.getJSON("HP_GetNextPics", {
            	op:"1",
				index: index,
				author_id:${sessionScope.userId}
			},function(data) {
					var i;
					$.each(data, function(index1) {
						var html = '';
						html += '<div class="Works_Box" onclick="detail('+data[index1].P_id+')">';
						html += '	<div class="works">';
						html += '		<img src="http://localhost:8080/PicBase/'+data[index1].P_path+'">';
						html += '	</div>';
						html += '	<div class="worksWord">';
						html += '		<div class="worksHeadline">作品名：'+data[index1].Headline+'</div>';
						html += '       <div class="worksInfo">介绍：'+data[index1].Info+'</div>';
						html += '	</div>';
						html += '<div class="delete_btn" onclick="deletePic('+data[index1].P_id+')">删除</div>';
						html += '</div>';
						$("#ct").append(html);
						i = index1;
					});
				if(i<5)
				{
					clearTimeout(auto_c);
					clearTimeout(auto_d);
				}
			});
            pollScroll();//继续循环
             $('#spinner').hide();
  		}
  		
  		function checkScroll(){
            if(!lowEnough()) return pollScroll();
            auto_c = setTimeout(doSomething,900);
            $('#spinner').show();
        }
        
        
        
        function pollScroll(){
            auto_d = setTimeout(checkScroll,1000);
        }
        
        checkScroll()
  
  	function deletePic(p_id){
  	$.post(
				url="userOperation?op=7",
				{
					p_id:p_id
				},
				function(data){
					if(status="true")
					{
						window.location.href='AuthorSpace?author_id='+${sessionScope.userId};
					}
					else
					{
						alert("删除失败！结果为："+data);
					}
				}
			);
  }
  </script>
</html>
