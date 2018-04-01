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
<title>Insert title here</title>
<style type="text/css">
	*{margin:0;padding:0} 
</style>
<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
var userid=sessionStorage.getItem("userid");
getinfo();
function getinfo()
{
   
	$.ajax({
			type:"Post",
			url:"getmyinfo_getinfo.action",
			dataType:"json",
			data: {"userid": userid},
			async: true,
			success: function(data){
				console.log(data);
				var member = eval("("+data+")");
				if(member.result=="1"){
					document.getElementById('nickname').value = member.nickname;
					document.getElementById('telphone').value = member.telphone;
					document.getElementById('number').value = member.number;
					document.getElementById('email').value = member.email;
				}
				
			},
			error: function(data){
				alert("登陆失败，请检测网络。。");
			}
		});
}

function submit(){
	var nickname = document.getElementById("nickname");if(nickname.value==""){alert("姓名不能为空！");return;}
    var number = document.getElementById("number");if(number.value==""){alert("学号不能为空！");return;}
    var telphone = document.getElementById("telphone");if(telphone.value==""){alert("手机号不能为空！");return;}
    var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
    if(!myreg.test(telphone.value)){
    	alert("请输入正确的手机号！");return;
    }
    
    var email = document.getElementById("email");if(email.value==""){alert("邮箱不能为空！");return;}
    var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); 
    if(!reg.test(email.value)){
    	alert("请输入正确的邮箱！");return;
    }
    
    var title = document.getElementById("title");if(title.value==" "){alert("标题不能为空！");return;}
    var original = document.getElementById("original");if(original.value==" "){alert("申请原由不能为空！");return;}
    var starttime = document.getElementById("starttime");if(starttime.value==""){alert("开始日期不能为空！");return;}
    var endtime = document.getElementById("endtime");if(endtime.value==""){alert("结束日期不能为空！");return;}
    
    if(endtime.value<=starttime.value){
    	alert("开始日期不能大于等于结束日期！");return;
    }
    var system ;
    var obj=document.getElementsByName("system");
    for (var i=0;i<obj.length;i++){ //遍历Radio 
	    if(obj[i].checked){ 
	    	system=obj[i].value; 
	    } 	
    } 
    if(system== undefined ){alert("没有选择申请的系统！");return;}
    var software="" ;
    obj = document.getElementsByName("software");
    var objnum=0;
    for(k in obj){
        if(obj[k].checked){
        	objnum++;
        	software+=(obj[k].value+";");
        	if(obj[k].value=="no"&&objnum!=1){
        		alert("软件申请错误！");return;
        	}
        }
    }
    if(software==""){alert("若没有选择申请的软件，请选择无！");return;}
    var applicantnote = document.getElementById("applicantnote");
    
    $.ajax({
		type:"Post",
		url:"resource_submit.action",
		dataType:"json",
		data: {"userid": userid,"nickname":nickname.value,"telphone":telphone.value,"email":email.value,"number":number.value,"title":title.value,"original":original.value,"starttime":starttime.value,"endtime":endtime.value,"system":system,"software":software,"applicantnote":applicantnote.value},
		async: true,
		success: function(data){
			console.log(data);
			var member = eval("("+data+")");
			if(member.result=="1"){
				alert("提交成功！");
				location.reload();
			}else{
				alert("提交失败，请检测网络。。");
			}
			
			//location.reload();
		},
		error: function(data){
			alert("失败，请检测网络。。");
		}
	});
} 

</script> 
</head>
<body>
<div id="maincontent">
	<div>
		<table class="roleinfo" id="a">
			<tbody>
				<tr>				
					<th colspan="4"><h1>资源申请</h1></th>
					
				</tr>
				<tr>				
					<td colspan="4">个人信息</td>
				</tr>
				<tr>
					<td>姓名：</td>
					<td><input type="text" id="nickname" style="width: 100%; height: 100%" /></td>
					<td>学号：</td>
					<td><input type="text" id="number" style="width: 100%; height: 100%" /></td>
				</tr>
				<tr>
					<td>手机号：</td>
					<td><input type="text" id="telphone" style="width: 100%; height: 100%" /></td>
					<td>邮箱：</td>
					<td><input type="text" id="email" style="width: 100%; height: 100%" /></td>
				</tr>
				<tr>				
					<td colspan="4">申请内容</td>
				</tr>
				<tr>
					<td >申请标题：</td>
					<td colspan="3" ><textarea style="width:100%;height:100%;" id="title"> </textarea></td>
				</tr>
				<tr>
					<td style="height:100px ">申请原由：</td>
					<td colspan="3" ><textarea style="width:100%;height:100%;" id="original"> </textarea></td>
				</tr>
				<tr>
					
				</tr>
				<tr>
					<td>开始日期：</td>
					<td><input type="date" style="width: 100%; height: 100%" id="starttime"/></td>
					<td>结束日期：</td>
					<td><input type="date" style="width: 100%; height: 100%" id="endtime"/></td>
				</tr>
				
				<tr>	
					<td>系统：</td>
				    <td colspan="4">			
					<input id="system" type="radio" value="windows" name="system">windows</input>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="system" type="radio" value="ubuntu" name="system">ubuntu</input> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="system" type="radio" value="centos" name="system">centos</input>
					</td>
				</tr>
				<tr>	
					<td>软件：</td>			
					<td colspan="3">
					<input type="checkbox" name="software" value="apache">apache&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="software" value="ngins">ngins&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="software" value="tomcat">tomcat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="software" value="no">无
					</td>
				</tr>
				<tr>
					<td style="height:50px ">备注：</td>
					<td colspan="3"><textarea style="width:100%;height:100%;" id="applicantnote"> </textarea></td>
				</tr>
				
			</tbody>
		</table>
	</div>
	<div>
		<p class="button" onClick="submit()">
			<a>提交</a>
		</p>
	</div>
	
</div>
</body>
</html>