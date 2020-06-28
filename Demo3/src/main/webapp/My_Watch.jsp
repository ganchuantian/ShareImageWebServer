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
    
    <title>My JSP 'My_Watch.jsp' starting page</title>
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
		#overall{
			width:1500px;
			height:1000px;
		}
		
		#overall>div{
			display: inline-block;
		}
		
		#Watch_box{
			width:200px;
			height:700px;
			float:left;
			margin-top: 30px;
			margin-left:30px;
		}
		
		#Watch_list{
			width:200px;
			height:600px;
			overflow:auto;
		}
		
		ul>li{
			margin-top: 10px;
		}
		
		.author_name1{
			background-color:rgba(220,220,220,0.5);
		}
		
		.author_name2{
			background-color:rgba(240,240,240,0.4);
		}
		
		.author_name1:hover,.author_name2:hover{
			background-color:rgba(140,140,140,0.4);
			cursor: pointer;
		}
	</style>
  </head>
  
  <body style="background-image: url(imgs/stock-photo-275239703.jpg);">
    <%@ include file="top.jsp"%>
    <center>
	    <div id="overall">
	    	<div id="Watch_box">
	    		<div id="Watch_headline">
	    			关注列表
	    		</div>
	    		<div id="Watch_list">
	    			<ul>
	    			
	    				<c:forEach items="${requestScope.a_rs}" var="keyword" varStatus="id">
		    				<c:choose>
		    					<c:when test="${id.index%2==0}">
			    					<div class="author_name1" onclick="getAuthorWorks(${keyword.account},${keyword.uname})">
			    						<li>${keyword.uname}</li>
			    					</div>
		    					</c:when>
		    					<c:otherwise>
			    					<div class="author_name2" onclick="getAuthorWorks(${keyword.account},${keyword.uname})">
			    						<li >${keyword.uname}</li>
			    					</div>
		    					</c:otherwise>
		    				</c:choose>
	    				</c:forEach>

					</ul>
	    		</div>
	    	</div>
		    <div class="Pics" style="float:left;margin-left:20px">
				<div id="title" >
					<div id="a_name" style="margin-top: 5px;" >所有作品</div>
				</div><br />
				<div class="pics-box" id="pics-box">	
								
					<c:forEach items="${requestScope.p_rs}" var="keyword" >
						
						<div class="pic-box" id="pic-box">
							<div class="pic" id="p">
								<img src="http://localhost:9080/PicBase/${keyword.p_path}" onclick="detail('${keyword.p_id}')"/>
							</div>
							<div id="owner">
								<div id="someone">
									<div id="text_info">
										<div class="p_headline" style="margin-top:10px;">作品名：${keyword.headline}</div><br/>
									</div>
								</div>
							</div>
						</div>
											
					</c:forEach>
											
				</div>
			</div>
		</div>
	</center>
  </body>
  
  <script>
  
  var index=0;
  var auto_c;
  var auto_d;
  var author = "all";
  
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
            return pageHeight - viewportHeight - scrollHeight < 20;
        }
        
  function doSomething(){
            index++;
            getNextAuthorWorks(author);
  }
            
  
  function getAuthorWorks(account,Name){
  	index=0;	
  	$("#pics-box").html("");
  	$("#a_name").html("");
  	$("#a_name").append(Name+"的作品");
  	clearTimeout(auto_c);
	clearTimeout(auto_d);
  	checkScroll();
  	author=account;
  	getNextAuthorWorks(author);
  }
  
  function getNextAuthorWorks(account){
  	$.getJSON(url="My_Watch",
					{
						author_id:author,
						index:index
					},
					function(data){
						var i;
						$.each(data, function(index1) {
							var html = '';
							html += '<div class="pic-box" id="pic-box">';
							html += '	<div class="pic" id="p">';
							html += '		<img src="http://localhost:9080/PicBase/'+data[index1].P_path+'" onclick="detail('+data[index1].P_id+')"/>';
							html += '	</div>';
							html += '	<div id="owner">'
							html += '		<div id="someone">'
							html += '			<div id="text_info">'
							html += '				<div id="p_headline" style="margin-top:20px;">作品名：'+data[index1].Headline+'</div><br />';
							html += '			</div>';
							html += '		</div>';
							html += '	</div>';
							html += '</div>';
							$("#pics-box").append(html);
							i = index1;
						});
						if(i<5)
						{
							clearTimeout(auto_c);
							clearTimeout(auto_d);
						}
				
					}
				);
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
  
  </script>
</html>
