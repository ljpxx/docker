<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">

<title>homePage</title>
<link rel="stylesheet" type="text/css" href="css/homePage.css">
<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery-1.6.min.js"></script>
<script type="text/javascript" src='js/snowfall.jquery.js'></script>
<style type="text/css">
*{margin:0;padding:0} 
</style>
<script type="text/javascript">

// var userid_index = document.cookie;
// var userid=userid_index.substring(9);
var userid=sessionStorage.getItem("userid");
console.log("userid:"+userid);
getname();
function getname()
{
   
	$.ajax({
			type:"Post",
			url:"getmyinfo_nickname.action",
			dataType:"json",
			data: {"userid": userid},
			async: true,
			success: function(data){
				console.log(data);
				var member = eval("("+data+")");
				if(member.result=="1"){
					document.getElementById("nickname").innerHTML =member.nickname;
					if(member.usertype=="1"){
						//普通用户
						document.getElementById('li2').style.display = 'none';
						document.getElementById('li5').style.display = 'none';
						document.getElementById('li7').style.display = 'none';
					}else if(member.usertype=="2"){
						document.getElementById('li5').style.display = 'none';
						document.getElementById('li8').style.display = 'none';
					}else{
						document.getElementById('li4').style.display = 'none';
						document.getElementById('li6').style.display = 'none';
						document.getElementById('li8').style.display = 'none';
					}
				}
				
				if(member.resultnum!=0){
					shan();
				}
				
				if(member.email==""){
					alert("请完善个人信息");
					shan1();
				}
				//location.reload();
			},
			error: function(data){
				alert("登陆失败，请检测网络。。");
			}
		});
}
var setin;
function changeColor() { 
    var color="#f00|#0f0|#00f|#880|#808|#088|yellow|green|blue|gray"; 
    color=color.split("|");
    document.getElementById("agency_matters").style.color=color[parseInt(Math.random() * color.length)]; 
}function shan(){
	setin=setInterval("changeColor()",200);
}
function cal(){
	clearInterval(setin);
}
function changeColor1() { 
    var color="#f00|#0f0|#00f|#880|#808|#088|yellow|green|blue|gray"; 
    color=color.split("|");
    document.getElementById("myinfo").style.color=color[parseInt(Math.random() * color.length)]; 
}function shan1(){
	setInterval("changeColor1()",200);
}
function choose(index,index1)
{
	document.getElementById("homepage").style.color="";
	document.getElementById("agency_matters").style.color="";
	document.getElementById("myinfo").style.color="";
	document.getElementById("my_application").style.color="";
	document.getElementById("application_resource").style.color="";
	document.getElementById("application_record").style.color="";
	document.getElementById("user_info").style.color="";
	document.getElementById("contact_us").style.color="";
	
	document.getElementById("li1").style.background="#ececec";
	document.getElementById("li2").style.background="#ececec";
	document.getElementById("li3").style.background="#ececec";
	document.getElementById("li4").style.background="#ececec";
	document.getElementById("li5").style.background="#ececec";
	document.getElementById("li6").style.background="#ececec";
	document.getElementById("li7").style.background="#ececec";
	document.getElementById("li8").style.background="#ececec";
	
	document.getElementById(index).style.color="#ffffff";
	document.getElementById(index1).style.background="#5080d8";
}
window.onload=function(){
    //do something
}
</script>
</head>

<body class="linear">
	<div id="container">
		<div id="top"><iframe src="jsp/top.jsp" name="top"></iframe></div>
		<marquee><span style="font-weight: bolder;font-size: 20px;color: red;">Welcom here!</span></marquee>
		<div id="left">	
			<div style="width:100%;height:auto;background-color:#ececec;">
				<div style="width:100%;height:170px;"><img  src="images/logo1.png" width="100%" height="100%" ></div>
				<div style="width:100%;height:40px;text-align:center;">Hi~:<span id="nickname" style="color:red"></span></div>
				
			</div>
			<ul class="ddsmoothmenu">
			  <li id="li1"><a id="homepage" href="jsp/homepage.jsp" target="mainFrame" onClick="choose('homepage','li1')">首页</a></li>
			  <li id="li2"><a id="agency_matters" href="jsp/agency_matters.jsp" target="mainFrame" onClick="choose('agency_matters','li2')">待办事项</a></li>
	          <li id="li3"><a id="myinfo" href="jsp/myinfo.jsp" target="mainFrame" onClick="choose('myinfo','li3')">个人信息</a></li>
	          <li id="li4"><a id="my_application" href="jsp/my_application.jsp" target="mainFrame" onClick="choose('my_application','li4')">我的申请</a></li>
	          <li id="li5"><a id="user_info" href="jsp/user_info.jsp" target="mainFrame" onClick="choose('user_info','li5')">用户信息</a></li>
	          <li id="li6"><a id="application_resource" href="jsp/application_resource.jsp" target="mainFrame" onClick="choose('application_resource','li6')">资源申请</a></li>
	          <li id="li7"><a id="application_record" href="jsp/application_record.jsp" target="mainFrame" onClick="choose('application_record','li7')">申请记录</a></li>
	          <li id="li8"><a id="contact_us" href="jsp/contact_us.jsp" target="mainFrame" onClick="choose('contact_us','li8')">联系我们</a></li>
	        </ul>
		</div>
		<div id="right"><iframe src="jsp/homepage.jsp" id="right_iframe"  name="mainFrame" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"  width="100%" onload="this.height=420"></iframe>
		<script type="text/javascript">
function reinitIframe()
{
var iframe = document.getElementById("right_iframe");
try{
var bHeight = iframe.contentWindow.document.body.scrollHeight;
var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
var height = Math.max(bHeight, dHeight);
iframe.height = height;
}catch (ex){}
}
window.setInterval("reinitIframe()", 200);
</script>
		</div>
		<div class="clear"></div>
	</div>
</body>
</html>
