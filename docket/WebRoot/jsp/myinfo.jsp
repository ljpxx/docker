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
<link rel="stylesheet" href="css/rm.css" type="text/css">
<style type="text/css">
	*{margin:0;padding:0} 
	</style>
<title>Insert title here</title>
<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
// var userid_index = document.cookie;
// console.log(userid_index);
var userid=sessionStorage.getItem("userid");
getmyinfo();
function getmyinfo()
{   
	
	$.ajax({
			type:"Post",
			url:"getmyinfo.action",
			dataType:"json",
			data: {"userid": userid},
			async: true,
			success: function(data){
				console.log(data);
				var member = eval("("+data+")");
				if(member.result=="1"){
					document.getElementById("nickname").value=member.nickname;
				    document.getElementById("number").value=member.number;
				    document.getElementById("telphone").value=member.telphone;
				    document.getElementById("email").value=member.email;
				    document.getElementById("address").value=member.address;
				    
				    document.getElementById("createtime").value=member.createtime;
				    document.getElementById("lastedittime").value=member.lastedittime;
				    
				}else{
					alert("用户名信息错误。。");
				}
				
				//location.reload();
			},
			error: function(data){
				alert("登陆失败，请检测网络。。");
			}
		});
}
function edit()
{ 
	document.getElementById("nickname").readOnly = "";
	document.getElementById("number").readOnly = "";
	document.getElementById("telphone").readOnly = "";
	document.getElementById("email").readOnly = "";
	document.getElementById("address").readOnly = "";
	document.getElementById("nickname").style.backgroundColor = "#FFEFDB";
	document.getElementById("number").style.backgroundColor = "#FFEFDB";
	document.getElementById("telphone").style.backgroundColor = "#FFEFDB";
	document.getElementById("email").style.backgroundColor = "#FFEFDB";
	document.getElementById("address").style.backgroundColor = "#FFEFDB";
	
}
function no_edit()
{ 
	document.getElementById("nickname").readOnly = "readOnly";
	document.getElementById("number").readOnly = "readOnly";
	document.getElementById("telphone").readOnly = "readOnly";
	document.getElementById("email").readOnly = "readOnly";
	document.getElementById("address").readOnly = "readOnly";
	document.getElementById("nickname").style.backgroundColor = "";
	document.getElementById("number").style.backgroundColor = "";
	document.getElementById("telphone").style.backgroundColor = "";
	document.getElementById("email").style.backgroundColor = "";
	document.getElementById("address").style.backgroundColor = "";
	
}
function save()
{   
	
	var nickname=document.getElementById("nickname").value;
	var number=document.getElementById("number").value;
	var telphone=document.getElementById("telphone").value;
	var email=document.getElementById("email").value;
	var address=document.getElementById("address").value;
	
	if(nickname==""){alert("昵称不能为空！");return;}
	
	var is_phone=isPoneAvailable(telphone);
	if(is_phone=="1"){
		alert("手机号不能为空。。");return;
	}else if(is_phone=="2"){
		alert("手机号格式不正确。。");return;
	}
	
	var is_email=check_email(email);
	if(is_email=="1"){
		alert("邮箱不能为空。。");return;
	}else if(is_email=="2"){
		alert("邮箱格式不正确。。");return;
	}
	
	
	$.ajax({
			type:"Post",
			url:"getmyinfo_save.action",
			dataType:"json",
			data: {"userid": userid,"nickname":nickname,"telphone":telphone,"email":email,"number":number,"address":address},
			async: true,
			success: function(data){
				console.log(data);
				var member = eval("("+data+")");
				if(member.result=="1"){
					/* document.getElementById("nickname").value=member.nickname;
				    document.getElementById("number").value=member.number;
				    document.getElementById("telphone").value=member.telphone;
				    document.getElementById("email").value=member.email;
				    document.getElementById("address").value=member.address; */
				    
				    document.getElementById("lastedittime").value=member.lastedittime;
				    no_edit();
				    alert("保存成功。。");
				    parent.location.reload();
				}else{
					alert("用户手机号已重复。。");
				}
				
				//location.reload();
			},
			error: function(data){
				alert("登陆失败，请检测网络。。");
			}
		});
}
function check_email(email){
	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //正则表达式
	if(email == ""){ //输入不能为空
		//alert("输入不能为空!");
		return "1";
	}else if(!reg.test(email)){ //正则验证不通过，格式不对
		//alert("验证不通过!");
		return "2";
	}else{
		//alert("通过！");
		return "3";
	}
}
function isPoneAvailable(phone) {
	
    var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;  
    if (phone=="") {  
        return "1";  
    } else if(!myreg.test(phone)){  
        return "2";  
    }else{
		//alert("通过！");
		return "3";
	}  
} 
</script>
</head>

<body>

<div id="maincontent">
	<div>
		<table class="roleinfo" id="a">
			<tbody>
				<tr>				
					<th colspan="4"><h1>个人信息</h1></th>
					
				</tr>
				<tr>
					<td style="font-size:15px;height: 35px;">姓名：<span style="color:red;float:right">*</span></td>
					<td><input type="text" id="nickname" style="width: 100%; height: 100%" readonly="readonly"/></td>
					<td style="font-size:15px;height: 35px;">学号：</td>
					<td><input type="text" id="number" style="width: 100%; height: 100%" readonly="readonly"/></td>
				</tr>
				<tr>
					<td style="font-size:15px;height: 35px;">手机号：<span style="color:red;float:right">*</span></td>
					<td><input type="text" id="telphone" style="width: 100%; height: 100%" readonly="readonly"/></td>
					<td style="font-size:15px;height: 35px;">邮箱：<span style="color:red;float:right">*</span></td>
					<td><input type="text" id="email" style="width: 100%; height: 100%" readonly="readonly"/></td>
				</tr>
				<tr>
					<td style="font-size:15px;height: 35px;">详细地址：</td>
					<td colspan="3"><input type="text" id="address" style="width: 100%; height: 100%" readonly="readonly"/></td>
				</tr>
				<tr>
					<td style="font-size:15px;height: 35px;">创建时间：</td>
					<td><input type="text" id="createtime" style="width: 100%; height: 100%" readonly="readonly"/></td>
					<td style="font-size:15px;height: 35px;">最后修改时间：</td>
					<td><input type="text" id="lastedittime" style="width: 100%; height: 100%" readonly="readonly"/></td>
				</tr>
			</tbody>
		</table>
	</div>
	<br/><br/><br/>
	<div>
		
		<p class="button" onClick="edit()">
			<a>编辑</a>
		</p>
		<p class="button" onClick="save()">
			<a>修改</a>
		</p>
		
	</div>
	<br/><br/><br/>
	<div >
		<p style="color:red;font-size:15px">注：手机号和邮箱请填写正确，短信、邮箱通知会以此为准。</p>
	</div>
</div>

</body>
</html>