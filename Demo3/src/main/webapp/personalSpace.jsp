<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <title>JSP Page</title>
        <link href="css/HomePage.css" rel="stylesheet" type="text/css"/>
   		<style type="text/css">
   			#overall{
				width:1600px;
				height:1000px;
			}
		
			#overall>div{
				display: inline-block;
			}
			
			#Author_Box{
				width:200px;
				height:200px;
				float:left;
				margin-top: 50px;
				margin-left:30px;
				border: 2px solid;
				border-radius:6px;
			}
			
			#authorName{
				width:160px;
				height:30px;
				float:left;
				margin-left:10px;
				margin-top:10px;
			}
			
			#authorInfo{
				border: 1px solid #D3D4D3;
				width:160px;
				height:100px;
				margin-left:10px;
				margin-top:10px;
				border-radius:12px;
			}
			
			.Works_Box{
				width:604px;
				height:750px;
				margin-bottom:20px;
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
			
			.works:hover{
				cursor:pointer;
				border:2px solid;
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
			
			#cancelWatch-btn{
				color: white;
				width:75px;
				margin-top:20px;
				margin-left:15px;
				background-color: red;

			}
			
			#cancelWatch-btn:hover{
				background-color: rgb(221,82,70);
				cursor: pointer;
			}
   		</style>
    </head>
    <body>
    	<%@ include file="top.jsp"%>
    	<center>
		    <div id="overall">
		    	<div id="Author_Box">
		    		<div id="authorName">
		    			${requestScope.author_name}
		    		</div>
		    		<br />
		    		<br />
		    		<div id="authorInfo">
		    			${requestScope.author_info}
		    		</div>
		    		<br />
					<div id="watch_box">
			    		
		    		</div>
		    	</div>
			    <div class="Pics" style="float:left;margin-left:20px;width:890px;">
					<div id="title" style="width:850px;">
						<div style="margin-top: 5px;">所有作品</div>
					</div><br />
					<div class="pics-box" id="pics-box">
						<center id="p_box">
						<c:forEach items="${requestScope.rs}" var="keyword">

							<div class="Works_Box" >
								<div class="works" onclick="detail(${keyword.p_id})">
									<img src="http://localhost:8080/PicBase/${keyword.p_path}">
								</div>
								<div class="worksWord">
									<div class="worksHeadline">作品名：${keyword.headline}</div>
									<div class="worksInfo">介绍：${keyword.info}</div>
								</div>
							</div>

						</c:forEach>
						</center>
					</div>
				</div>
			</div>
		</center>
 	</body>
 	<script src="js/jquery-3.3.1.js"></script>
 	<script>
 		var index = 0;
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
				author_id:${requestScope.author_id}
			},function(data) {
				var i;
					$.each(data, function(index1) {
						var html = '';
						html += '<div class="Works_Box" >';
						html += '	<div class="works" onclick="detail('+data[index1].P_id+')">';
						html += '		<img src="http://localhost:8080/PicBase/'+data[index1].P_path+'">';
						html += '	</div>';
						html += '	<div class="worksWord">';
						html += '		<div class="worksHeadline">作品名：'+data[index1].Headline+'</div>';
						html += '       <div class="worksInfo">介绍：'+data[index1].Info+'</div>';
						html += '	</div>';
						html += '</div>';
						$("#p_box").append(html);
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
 		
 		function Check(){
  			if(${sessionScope.userId}!=${requestScope.author_id})
			{
			    $.getJSON(url="userOperation",
					{
						op:"4",
						u_id:${sessionScope.userId},
						author_id:${requestScope.author_id},
					},
					function(data){
						var html = '';
						if(data=="0"){
							html = '<div id="watch-btn" class="btn" onclick="Watch('+${requestScope.author_id}+')">+关注</div>';
							$("#watch_box").append(html);
						}
						else if(data=="1")
						{
							html = '<div id="cancelWatch-btn" class="btn" onclick="cancelWatch('+${requestScope.author_id}+')">取消关注</div>';
							$("#watch_box").append(html);
						}
					}
				);
			}
		}
		
		Check();
		
		function Watch(author_id){
			$.post(url="userOperation?op=0",
				{
					u_id:${sessionScope.userId},
					author_id:author_id
				},
				function(status){
					
					if(status="true"){
						$('#watch_box').html("");
						var html = '<div id="cancelWatch-btn" class="btn" onclick="cancelWatch('+${requestScope.author_id}+')">取消关注</div>';
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
						var html = '<div id="watch-btn" class="btn" onclick="Watch('+${requestScope.author_id}+')">+关注</div>';
						$("#watch_box").append(html);
					}
					else
						alert("取消结果！"+status);
				}
			);
    	}
    	
    	function detail(p_id){
 			window.location.href="detail?p_id="+p_id;
 		}
 		
 		checkScroll()
        
 	</script>
</html>