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
<link rel="stylesheet" href="css/rm.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
	*{margin:0;padding:0} 
</style>
<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
var userid=sessionStorage.getItem("userid");//登陆用户id
var currentpage=0;//当前页数，从0开始
var sumpage;//总页数
var searchtype="";//查询类型
var searchkeyword;//查询关键字
my_submit();
function my_submit(){
	
	$.ajax({
		type:"Post",
		url:"getmyinfo_getalluser.action",
		dataType:"json",
		data: {"currentpage":currentpage,"searchtype":searchtype,"searchkeyword":searchkeyword},
		async: true,
		success: function(data){
			console.log(data);
			var member = eval("("+data+")");
			if(member.result=="1"){
				inittable();
				var map_list=member.map_list;
				sumpage=member.allpage;
				show(member.currentnum,map_list);
				page();
// 				var ind=index[0];
// 				var id=ind.id;
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
//首页
function firstPage(){
	currentpage=0;
	my_submit();
}
//上一页
function previousPage(){
	if(currentpage!=0){
		currentpage=currentpage-1;
		my_submit();
	}else{
		alert("这已经是首页了。");
	}
	
}
//下一页
function nextPage(){
	if((currentpage+1)!=sumpage){
		currentpage=currentpage+1;
		my_submit();
	}else{
		alert("这已经是末页了。");
	}
}
//末页
function lastPage(){
	currentpage=sumpage-1;
	my_submit();
}
//跳转到第几页
function goPage(){
	var temppage=document.getElementById('goPage').value;
	var reg=/^[1-9]\d*$|^0$/;
	if(reg.test(temppage)==false||temppage*1>sumpage*1||temppage*1<1){
	    alert("请输入有效页数。。");
	    return;
	}else{
		currentpage=temppage*1-1;
		my_submit();
		document.getElementById('goPage').value="";
	}
}
function show(currentnum,map_list){
	var datalist = document.getElementById("datalist");
	for(var i=0;i<currentnum;i++){
		var data=map_list[i];
		datalist.rows[i+1].cells[0].innerHTML = data.id;
		datalist.rows[i+1].cells[1].innerHTML = data.nickname;
		datalist.rows[i+1].cells[2].innerHTML = data.telphone;
		if(data.type=="1"){
			datalist.rows[i+1].cells[3].innerHTML = "学生";
		}else{
			datalist.rows[i+1].cells[3].innerHTML = "管理员";
		}
		datalist.rows[i+1].cells[3].style.color = "red";
		datalist.rows[i+1].cells[4].innerHTML = "<span style='cursor:pointer;' onClick=\"manage('"+data.id+"','"+data.type+"')\">管理</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='cursor:pointer;' onClick=\"del('"+data.id+"','"+data.type+"')\">取消</span>";
		datalist.rows[i+1].cells[4].style.color = "blue";
		
		
	}
	
}

//显示页数
function page(){
	document.getElementById('pages').innerHTML = (currentpage+1)+"/"+sumpage+"页";
}
//查询
function search(type){
	searchtype=type;
	if(document.getElementById('search_id').value!=""){
		searchkeyword=document.getElementById('search_id').value;
	}else if(document.getElementById('search_nickname').value!=""){
		searchkeyword=document.getElementById('search_nickname').value;
	}else if(document.getElementById('search_telphone').value!=""){
		searchkeyword=document.getElementById('search_telphone').value;
	}else if(document.getElementById('search_type').value!=""){
		if(document.getElementById('search_type').value=="学生"){
			searchkeyword="1";
		}else if(document.getElementById('search_type').value=="管理员"){
			searchkeyword="2";
		}else{
			alert("用户类型关键字请输入完整。");return;
		}
		
	}else{
		return;
	}
	currentpage=0;
	my_submit();
	document.getElementById('search_id').value="";
	document.getElementById('search_nickname').value="";
	document.getElementById('search_telphone').value="";
	document.getElementById('search_type').value="";
}

function inittable(){
	for(var i=0;i<10;i++){
		datalist.rows[i+1].cells[0].innerHTML = "";
		datalist.rows[i+1].cells[1].innerHTML = "";
		datalist.rows[i+1].cells[2].innerHTML = "";
		datalist.rows[i+1].cells[3].innerHTML = "";
		datalist.rows[i+1].cells[4].innerHTML = "";
	}
}

function manage(id,type){
	if(type=="2"){
		alert("该生已经是管理员！");return;
	}
	if(confirm("是否将该学生成为管理员!")){
		$.ajax({
			type:"Post",
			url:"getmyinfo_manager.action",
			dataType:"json",
			data: {"userid":id},
			async: true,
			success: function(data){
				console.log(data);
				var member = eval("("+data+")");
				if(member.result=="1"){
					my_submit();
//	 				var ind=index[0];
//	 				var id=ind.id;
				}else{
					alert("失败，请检测网络。。");
				}
				
				//location.reload();
			},
			error: function(data){
				alert("失败，请检测网络。。");
			}
		});
	}else{
		return;
	}
}
function del(id,type){
	if(type=="1"){
		alert("该生已经是学生！");return;
	}
	if(confirm("是否取消该生管理员!")){
		$.ajax({
			type:"Post",
			url:"getmyinfo_delmanager.action",
			dataType:"json",
			data: {"userid":id},
			async: true,
			success: function(data){
				console.log(data);
				var member = eval("("+data+")");
				if(member.result=="1"){
					my_submit();
//	 				var ind=index[0];
//	 				var id=ind.id;
				}else{
					alert("失败，请检测网络。。");
				}
				
				//location.reload();
			},
			error: function(data){
				alert("失败，请检测网络。。");
			}
		});
	}else{
		return;
	}
	  
}
</script>
</head>
<body>
<div id="maincontent">
		<div id="operation" style="text-align: center;">
			<fieldset>
				<legend style="font-size:20px;font-weight:bold;">查询</legend>
				用户ID:<input type="text" name="yuangongid" id="search_id" />
				<input type="submit" value="查询" onClick="search('id')">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称:<input type="text" name="yuangongid" id="search_nickname"/>
				<input type="submit" value="查询" onClick="search('nickname')"><br/>
				手机号&nbsp;:<input type="text" name="yuangongid" id="search_telphone"/>
				<input type="submit" value="查询" onClick="search('telphone')">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				用户类型:<input type="text" name="yuangongid" id="search_type"/>
				<input type="submit" value="查询" onClick="search('type')">
			</fieldset>
		</div><br/>
		<div>
			<table class="roleinfo" id="datalist">
				<tbody>
					<tr>				
						<th>用户ID</th>
						<th>昵称</th>
						<th>手机号</th>
						<th>用户类型</th>
						<th>权限操作</th>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div>
			<p class="button" onClick="firstPage()">
				<a target="_blank">首页</a>
			</p>
			<p class="button" onClick="previousPage()">
				<a>上一页</a>
			</p>
			<p class="button" onClick="nextPage()">
				<a>下一页</a>
			</p>
			<p class="button" onClick="lastPage()">
				<a>末页</a>
			</p>
			<p>转到</p>
			<input type="text" name="pagenumber" id="goPage">
			<p>页</p>
			<p class="button" onClick="goPage()">
				<a>GO</a>
			</p>
            <p  onClick="go()" id="pages">
				0/0页
			</p>
		</div>
	</div>
</body>
</html>