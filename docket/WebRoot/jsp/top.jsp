<%@page import="org.omg.CORBA.Request"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>top</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	*{margin:0;padding:0} 
	</style>
<script type="text/javascript">
function pass(){
	window.parent.frames.location.href="jsp/login.jsp" ;
}

// var curIndex = 0;
// //时间间隔(单位毫秒)，每秒钟显示一张，数组共有3张图片放在img文件夹下。
// var timeInterval = 3000;

// var arr = new Array();
// arr[0] = "images/background1.jpg";
// arr[1] = "images/background2.jpg";
// arr[2] = "images/background3.jpg";
// setInterval(changeImg, timeInterval);
// function changeImg() {
// 	var obj = document.getElementById("background");
// 	if (curIndex == arr.length - 1) {
// 	curIndex = 0;
// 	} else {
// 	curIndex += 1;
// 	}
// 	obj.style.backgroundImage= "URL("+arr[curIndex]+")";       //显示对应的图片
// 	obj.style.width= "100%";
// 	obj.style.height= "100%";
// }
</script>
  </head>
   
  <body>
	<div style="width:100%;height:100%;background:url(images/blue2.jpg);" id="background">
	<div style="position:absolute;right:0px;bottom:0px;width:80px;"><a onclick="pass()" style="text-decoration:none;color:red;cursor:pointer;font-size:20px" target="_blank">退出登录</a></div>
		<!-- <img alt="City Information Management System" src="images/login.jpg" width="100%" height="100%" > -->
	</div>
  </body>
</html>

