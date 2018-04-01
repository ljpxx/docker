<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
body{
		background: #f5f5f5;
	}
*{margin:0;padding:0} 
#main_content {
	width: 100%;
	clear: both;
	text-align: center;
}

#main_content a
{
    color:blue;
    font-size: 1.2em;
}
</style>
</head>
<body>
<div id="main_content">
<div><img src="images/docker.png"></img></div>
<div>
	<ul>
		<li>"QQ:"2488348060</li><br/>
		<li>"微信:"17865193985</li><br/>
		<li>"邮箱:"2488348060@qq.com</li><br/>
		<li>"微博:"<a href="">http://weibo.com/lunjiapeng</a></li><br/><br/><br/>
	</ul>
</div>
<div id="footer"><!--尾部板块-->
  <p>Created by <a href="">lunjiapeng</a> 2018 | <a href=""> www.lunjiapeng.net</a></p>
</div><br/>
</div>
</body>
</html>