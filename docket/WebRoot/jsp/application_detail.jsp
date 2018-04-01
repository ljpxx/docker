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
<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
var id=<%=request.getParameter("id")%>;

getdetail();
function getdetail(){
	$.ajax({
		type:"Post",
		url:"resource_getdetail.action",
		dataType:"json",
		data: {"id": id},
		async: true,
		success: function(data){
			console.log(data);
			var member = eval("("+data+")");
			if(member.result=="1"){
				document.getElementById("nickname").value=member.nickname;
				document.getElementById("number").value=member.number;
				document.getElementById("telphone").value=member.telphone;
				document.getElementById("email").value=member.email;
				document.getElementById("title").value=member.title;
				document.getElementById("original").value=member.original;
				document.getElementById("starttime").value=member.starttime;
				document.getElementById("endtime").value=member.endtime;
				
				var obj=document.getElementsByName("system");
			    for (var i=0;i<obj.length;i++){ //遍历Radio 
			    	if(obj[i].value==member.system){
			    		obj[i].checked=true;break;
			    	}
			    }
			    var softwarelist=member.software.split(";");
			    for(var i=0;i<softwarelist.length-1;i++){
			    	obj = document.getElementsByName("software");
				    for(k in obj){
				        if(obj[k].value==softwarelist[i]){
				        	obj[k].checked=true;break;
				        }
				    }
			    }
			    
			    document.getElementById("applicantnote").value=member.applicantnote;
			    document.getElementById("opinion").value=member.opinion;
			    document.getElementById("managernote").value=member.managernote;
			    
			    if(member.result1=="同意"){
			    	document.getElementById("opinion").readOnly = "readOnly";
			    	document.getElementById("managernote").readOnly = "readOnly";
			    	document.getElementById('button1').style.display = 'none';
			    	document.getElementById('button2').style.display = 'none';
			    }else{
			    	document.getElementById('button3').style.display = 'none';
			    }
			}else{
				alert("失败，请检测网络。。");
			}
			
			//location.reload();
		},
		error: function(data){
			alert("失败，请检测网络。。");
		}
	});
}


function save(){
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
    var obj=document.getElementsByName("system")
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
		url:"resource_edit_save.action",
		dataType:"json",
		data: {"id": id,"nickname":nickname.value,"telphone":telphone.value,"email":email.value,"number":number.value,"title":title.value,"original":original.value,"starttime":starttime.value,"endtime":endtime.value,"system":system,"software":software,"applicantnote":applicantnote.value},
		async: true,
		success: function(data){
			console.log(data);
			var member = eval("("+data+")");
			if(member.result=="1"){
				alert("提交成功！");
				document.getElementById("opinion").value = "";
				document.getElementById("managernote").value = "";
				no_edit();
			}else{
				alert("失败，请检测网络。。");
			}
			
			//location.reload();
		},
		error: function(data){
			alert("失败，请检测网络。。");
		}
	});
} 

function edit()
{ 
	document.getElementById("nickname").readOnly = "";
	document.getElementById("number").readOnly = "";
	document.getElementById("telphone").readOnly = "";
	document.getElementById("email").readOnly = "";
	document.getElementById("title").readOnly = "";
	document.getElementById("original").readOnly = "";
	document.getElementById("starttime").readOnly = "";
	document.getElementById("endtime").readOnly = "";
	document.getElementById("system1").disabled=false;
	document.getElementById("system2").disabled=false;
	document.getElementById("system3").disabled=false;
	document.getElementById("software1").disabled=false;
	document.getElementById("software2").disabled=false;
	document.getElementById("software3").disabled=false;
	document.getElementById("software4").disabled=false;
	document.getElementById("applicantnote").readOnly = "";
	document.getElementById("nickname").style.backgroundColor = "#FFEFDB";
	document.getElementById("number").style.backgroundColor = "#FFEFDB";
	document.getElementById("telphone").style.backgroundColor = "#FFEFDB";
	document.getElementById("email").style.backgroundColor = "#FFEFDB";
	document.getElementById("title").style.backgroundColor = "#FFEFDB";
	document.getElementById("original").style.backgroundColor = "#FFEFDB";
	document.getElementById("starttime").style.backgroundColor = "#FFEFDB";
	document.getElementById("endtime").style.backgroundColor = "#FFEFDB";
	document.getElementById("applicantnote").style.backgroundColor = "#FFEFDB";
}

function no_edit()
{ 
	document.getElementById("nickname").readOnly = "readOnly";
	document.getElementById("number").readOnly = "readOnly";
	document.getElementById("telphone").readOnly = "readOnly";
	document.getElementById("email").readOnly = "readOnly";
	document.getElementById("title").readOnly = "readOnly";
	document.getElementById("original").readOnly = "readOnly";
	document.getElementById("starttime").readOnly = "readOnly";
	document.getElementById("endtime").readOnly = "readOnly";
	document.getElementById("system1").disabled=true;
	document.getElementById("system2").disabled=true;
	document.getElementById("system3").disabled=true;
	document.getElementById("software1").disabled=true;
	document.getElementById("software2").disabled=true;
	document.getElementById("software3").disabled=true;
	document.getElementById("software4").disabled=true;
	document.getElementById("applicantnote").readOnly = "readOnly";
	document.getElementById("nickname").style.backgroundColor = "";
	document.getElementById("number").style.backgroundColor = "";
	document.getElementById("telphone").style.backgroundColor = "";
	document.getElementById("email").style.backgroundColor = "";
	document.getElementById("title").style.backgroundColor = "";
	document.getElementById("original").style.backgroundColor = "";
	document.getElementById("starttime").style.backgroundColor = "";
	document.getElementById("endtime").style.backgroundColor = "";
	document.getElementById("applicantnote").style.backgroundColor = "";
}
</script>
<title>Insert title here</title>
</head>
<body>
<div id="maincontent">
	<div>
		<table class="roleinfo" id="a">
			<tbody>
				<tr>				
					<th colspan="4"><h3>申请</h3></th>
					
				</tr>
				<tr>				
					<td colspan="4">申请者信息</td>
				</tr>
				<tr>
					<td>姓名：</td>
					<td><input type="text" id="nickname" style="width: 100%; height: 100%" readonly="readonly"/></td>
					<td>学号：</td>
					<td><input type="text" id="number" style="width: 100%; height: 100%" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>手机号：</td>
					<td><input type="text" id="telphone" style="width: 100%; height: 100%" readonly="readonly"/></td>
					<td>邮箱：</td>
					<td><input type="text" id="email" style="width: 100%; height: 100%" readonly="readonly"/></td>
				</tr>
				<tr>				
					<td colspan="4">申请内容</td>
				</tr>
				<tr>
					<td >申请标题：</td>
					<td colspan="3" ><textarea style="width:100%;height:100%;" id="title" readonly="readonly"> </textarea></td>
				</tr>
				<tr>
					<td style="height:100px ">申请原由：</td>
					<td colspan="3" ><textarea style="width:100%;height:100%;" id="original" readonly="readonly"> </textarea></td>
				</tr>
				<tr>
					
				</tr>
				<tr>
					<td>开始日期：</td>
					<td><input type="date" style="width: 100%; height: 100%" id="starttime" readonly="readonly"/></td>
					<td>结束日期：</td>
					<td><input type="date" style="width: 100%; height: 100%" id="endtime" readonly="readonly"/></td>
				</tr>
				
				<tr>	
					<td>系统：</td>
				    <td colspan="4">			
					<input id="system1" type="radio" value="windows" name="system" disabled>windows</input>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="system2" type="radio" value="ubuntu" name="system" disabled>ubuntu</input> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="system3" type="radio" value="centos" name="system" disabled>centos</input>
					</td>
				</tr>
				<tr>	
					<td>软件：</td>			
					<td colspan="3">
					<input id="software1" type="checkbox" name="software" value="apache" disabled>apache&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="software2" type="checkbox" name="software" value="ngins" disabled>ngins&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="software3" type="checkbox" name="software" value="tomcat" disabled>tomcat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="software4" type="checkbox" name="software" value="no" disabled>无
					</td>
				</tr>
				<tr>
					<td style="height:50px ">备注：</td>
					<td colspan="3"><textarea style="width:100%;height:100%;" id="applicantnote" readonly="readonly"> </textarea></td>
				</tr>
				<tr>				
					<td colspan="4">管理者信息</td>
				</tr>
				<tr>
					<td style="height:80px ">管理员审核意见：</td>
					<td colspan="3"><textarea style="width:100%;height:100%;" id="opinion" readonly="readonly"> </textarea></td>
				</tr>
				<tr>
					<td style="height:50px ">备注：</td>
					<td colspan="3"><textarea style="width:100%;height:100%;" id="managernote" readonly="readonly"> </textarea></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div>
		<p id="button1" class="button" onClick="edit()">
			<a>修改</a>
		</p>
		<p id="button2" class="button" onClick="save()">
			<a>提交</a>
		</p>
		<p id="button3" class="button" onClick="javascript :history.back(-1);" >
			<a>返回</a>
		</p>
	</div>
	
</div>
</body>
</html>