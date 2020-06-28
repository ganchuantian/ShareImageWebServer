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
  <title>My JSP 'index.jsp' starting page</title>
  <meta charset="UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<link href="css/HomePage.css" rel="stylesheet" type="text/css"/>
	<style type="text/css">			
			/*发布界面部分*/
			
  </style>
  </head>
  <body id="scroll">
  	<%@ include file="top.jsp"%>
  	<center>
				<div class="Pics">
					<div id="title">
						<div style="margin-top: 5px;">
							所有作品
						</div>
					</div>
					<br />
					<div class="pics-box" id="pics-box">
									
						<c:forEach items="${requestScope.rs}" var="keyword">
									
							<div class="pic-box" id="pic-box">
								<div class="pic" id="p">
									<img src="http://localhost:8080/PicBase/${keyword.p_path}" onclick="detail('${keyword.p_id}')"/>
								</div>
								<div id="owner">
									<div id="someone">
										<div id="text_info">
											<div class="p_headline" style="margin-top:10px;">作品名：${keyword.headline}</div><br/>
											<div class="authorId">作者ID：${keyword.u_id}</div>
										</div>
									</div>
									<div id="watch-btn" class="btn">+关注</div>
								</div>
							</div>
									
						</c:forEach>
									
					</div>
				</div>	
			
		</center>
 	</body>
 	<script src="js/jquery-3.3.1.js"></script>
 	<script>
 		var index = 0;
 		var auto_c;
 		var auto_d;
 		
 		function detail(p_id){
 			window.location.href="detail?p_id="+p_id;
 		}
 		
        function lowEnough(){
            var pageHeight = Math.max(document.body.scrollHeight,document.body.offsetHeight);
            var viewportHeight = window.innerHeight || 
                document.documentElement.clientHeight ||
                document.body.clientHeight || 0;
            var scrollHeight = window.pageYOffset ||
                document.documentElement.scrollTop ||
                document.body.scrollTop || 0;
            // console.log(pageHeight);
            // console.log(viewportHeight);
            // console.log(scrollHeight);
            return pageHeight - viewportHeight - scrollHeight < 20;
        }

        function doSomething(){
            index++;

            $.getJSON("HP_GetNextPics", {
            	op:"3",
				index: index,
				headline:${headline}
			},function(data) {
				var i;
					$.each(data, function(index1) {
						var html = '';
						html += '<div class="pic-box" id="pic-box">';
						html += '	<div class="pic" id="p">';
						html += '		<img src="http://localhost:8080/PicBase/'+data[index1].P_path+'" onclick="detail('+data[index1].P_id+')"/>';
						html += '	</div>';
						html += '	<div id="owner">'
						html += '		<div id="someone">'
						html += '			<div id="text_info">'
						html += '				<div id="p_headline" style="margin-top:20px;">作品名：'+data[index1].Headline+'</div><br />';
						html += '               <div class="authorId">作者ID：'+data[index1].U_id+'</div>';
						html += '			</div>';
						html += '		</div>';
						html += '		<div id="watch-btn" class="btn">+关注</div>'
						html += '	</div>';
						html += '</div>';
						$("#pics-box").append(html);
						i = index1;
					});
				if(i<11)
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

            $('#spinner').show();
            auto_c = setTimeout(doSomething,900);
            
        }
        
        function pollScroll(){
            auto_d = setTimeout(checkScroll,1000);
        }
        checkScroll();
 	</script>
</html>