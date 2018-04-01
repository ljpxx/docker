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
var userid=sessionStorage.getItem("userid");
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
			    
			    if(member.result1=="同意"||member.result1=="不同意"){
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




function manageedit(type)
{ 
	var result1;
	if(type==1){
		result1="同意";
	}else{
		result1="不同意";
	}
	var opinion = document.getElementById("opinion").value;
	if(opinion==""){
		alert("审核意见不能为空！");return ;
	}
	var managernote = document.getElementById("managernote").value;
	
	$.ajax({
		type:"Post",
		url:"resource_manageresult.action",
		dataType:"json",
		data: {"id": id,"result1": result1,"userid":userid,"opinion":opinion,"managernote":managernote},
		async: true,
		success: function(data){
			console.log(data);
			var member = eval("("+data+")");
			if(member.result=="1"){
				window.history.go(-1);
				//parent.location.reload();
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
					<td colspan="3"><textarea style="width:100%;height:100%;" id="opinion" > </textarea></td>
				</tr>
				<tr>
					<td style="height:50px ">备注：</td>
					<td colspan="3"><textarea style="width:100%;height:100%;" id="managernote" > </textarea></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div>
		<p id="button1" class="button" onClick="manageedit(1)">
			<a>同意</a>
		</p>
		<p id="button2" class="button" onClick="manageedit(2)">
			<a>不同意</a>
		</p>
		<p id="button3" class="button" onClick="javascript :history.back(-1);" >
			<a>返回</a>
		</p>
	</div>
	
</div>
</body>
</html>