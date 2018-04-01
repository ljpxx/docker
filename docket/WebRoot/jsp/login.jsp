<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录界面</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />

<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#login').click(function() {
		var name_state = $('#name');
		var psd_state = $('#psd');
		var name = $('#name').val();
		var psd = $('#psd').val();
		if (name == '') {
			name_state.parent().next().next().css("display", "block");
			return false;
		} else if (psd == '') {
			name_state.parent().next().next().css("display", "none");
			psd_state.parent().next().next().css("display", "block");
			return false;
		} else {
			name_state.parent().next().next().css("display", "none");
			psd_state.parent().next().next().css("display", "none");
			$('.login').submit();
		}
	});
	$('#register').click(function() {
		var name_r_state = $('#name_r');
		var psd_r_state = $('#psd_r');
		var affirm_psd_state = $('#affirm_psd');
		var name_r = $('#name_r').val();
		var psd_r = $('#psd_r').val();
		var affirm_psd = $('#affirm_psd').val();
		
		if (name_r == '') {
			name_r_state.parent().next().next().css("display", "block");
			return false;
		} else if (psd_r == '') {
			psd_r_state.parent().next().next().css("display", "block");
			return false;
		} else if (affirm_psd == '') {
			affirm_psd_state.parent().next().next().css("display", "block");
			return false;
		} else if (psd_r != affirm_psd) {
			return false;
		} else {
			$('.register').submit();
		}
	})
})
function isPoneAvailable(phone) {
	
    var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;  
    if (myreg.test(phone)) {  
        return false;  
    } else {  
        return true;  
    }  
} 
function ok_or_errorBylogin(l) {
	var content = $(l).val();
	if (content != "") {
		$(l).parent().next().next().css("display", "none");
	}
}

function ok_or_errorByRegister(r) {
	var affirm_psd = $("#affirm_psd");
	var psd_r = $("#psd_r");
	var affirm_psd_v = $("#affirm_psd").val();
	var psd_r_v = $("#psd_r").val();
	var content = $(r).val();
	if (content == "") {
		$(r).parent().next().next().css("display", "block");
		return false;
	} else {
		if($(r).attr("id")=="name_r"){
			if(isPoneAvailable(content)){
				$(r).parent().next().next().css("display", "block");
				return false;
			}
		}
		
		$(r).parent().next().css("display", "block");
		$(r).parent().next().next().css("display", "none");
		if (psd_r_v == "") {
			$(psd_r).parent().next().css("display", "none");
			$(psd_r).parent().next().next().css("display", "none");
			$(psd_r).parent().next().next().css("display", "block");
			return false;
		}
		if (affirm_psd_v == "") {
			$(affirm_psd_v).parent().next().css("display", "none");
			$(affirm_psd_v).parent().next().next().css("display", "none");
			$(affirm_psd_v).parent().next().next().css("display", "block");
			return false;
		}
		if (psd_r_v == affirm_psd_v) {
			$(affirm_psd).parent().next().css("display", "none");
			$(affirm_psd).parent().next().next().css("display", "none");
			$(psd_r).parent().next().css("display", "none");
			$(psd_r).parent().next().next().css("display", "none");
			$(affirm_psd).parent().next().css("display", "block");
			$(psd_r).parent().next().css("display", "block");
		} else {
			$(affirm_psd).parent().next().css("display", "none");
			$(affirm_psd).parent().next().next().css("display", "none");
			$(psd_r).parent().next().css("display", "none");
			$(psd_r).parent().next().next().css("display", "none");
			$(psd_r).parent().next().css("display", "block");
			$(affirm_psd).parent().next().next().css("display", "block");
			return false;
		}
	}
}
function register()
{
	var username = document.getElementById("name_r");
    var password = document.getElementById("psd_r");
	
	$.ajax({
			type:"Post",
			url:"registered.action",
			dataType:"json",
			data: {"username": username.value, "password": password.value},
			async: true,
			success: function(data){
				console.log(data);
				var member = eval("("+data+")");
				if(member.result=="1"){
					alert("注册成功。");
					location.reload();
				}else{
					alert("手机号已存在，请直接登陆。。");
				}
				
				//location.reload();
			},
			error: function(data){
				alert("注册失败，请检测网络。。");
			}
		});
}

function login()
{
	var username = document.getElementById("name");
    var password = document.getElementById("psd");
    var usertype ;
    var obj=document.getElementsByName("usertype")
    for (var i=0;i<obj.length;i++){ //遍历Radio 
	    if(obj[i].checked){ 
	    	usertype=obj[i].value; 
	    } 	
    } 
    
	$.ajax({
			type:"Post",
			url:"login.action",
			dataType:"json",
			data: {"username": username.value, "password": password.value, "usertype": usertype},
			async: true,
			success: function(data){
				console.log(data);
				var member = eval("("+data+")");
				if(member.result=="1"){
					document.cookie="username="+member.userid;
					var x = document.cookie;
					sessionStorage.setItem("userid",member.userid);
					//alert(x);
					//location.reload();
					window.location.href='jsp/index.jsp';
				}else{
					alert("用户名或密码或登陆类型错误。。");
				}
				
				//location.reload();
			},
			error: function(data){
				alert("登陆失败，请检测网络。。");
			}
		});
}

function barter_btn(bb) {
	$(bb).parent().parent().fadeOut(1000);
	$(bb).parent().parent().siblings().fadeIn(2000);
}
</script>
</head>

<body class="login_body">

<div class="login_div">
	<div class="col-xs-12 login_title">登录</div>
	
		<div class="nav">
			<div class="nav login_nav">
				<div class="col-xs-4 login_username">
					用户名:
				</div>
				<div class="col-xs-6 login_usernameInput">
					<input type="text" name="username" id="name" value="" placeholder="&nbsp;&nbsp;手机号"  onblur="javascript:ok_or_errorBylogin(this)" />
				</div>
				<div class="col-xs-1 ok_gou">
					√
				</div>
				<div class="col-xs-1 error_cuo">
					×
				</div>
			</div>
			<div class="nav login_psdNav">
				<div class="col-xs-4">
					密&nbsp;&nbsp;&nbsp;码:
				</div>
				<div class="col-xs-6">
					<input type="password" name="password" id="psd" value="" placeholder="&nbsp;&nbsp;密码" onBlur="javascript:ok_or_errorBylogin(this)" />
				</div>
				<div class="col-xs-1 ok_gou">
					√
				</div>
				<div class="col-xs-1 error_cuo">
					×
				</div>
			</div>
			<div class="nav login_psdNav">
				<div style="text-align:center">
				<input type="radio" name="usertype" value="1" style="width:20px;height:20px;"><label style="font-size:20px;">学生</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="usertype" value="2" style="width:20px;height:20px;"><label style="font-size:20px;">管理员</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="usertype" value="3" style="width:20px;height:20px;"><label style="font-size:20px;">超级管理员</label>
				</div>
			</div>
			<div class="col-xs-12 login_btn_div">
				<input type="submit" class="sub_btn" value="登录" id="login" onclick="login()"/>
			</div>
		</div>
	

	<div class="col-xs-12 barter_btnDiv">
		<button class="barter_btn" onClick="javascript:barter_btn(this)">没有账号?前往注册</button>
	</div>
</div>

<div class="register_body">
	<div class="col-xs-12 register_title">注册</div>
	
		<div class="nav">
			<div class="nav register_nav">
				<div class="col-xs-4">
					用户名:
				</div>
				<div class="col-xs-6">
					<input type="text" name="id" id="name_r" value="" placeholder="&nbsp;&nbsp;手机号" onBlur="javascript:ok_or_errorByRegister(this)" autocomplete="off"/>
				</div>
				<div class="col-xs-1 ok_gou">
					√
				</div>
				<div class="col-xs-1 error_cuo">
					×
				</div>
			</div>
			<div class="nav register_psdnav">
				<div class="col-xs-4">
					密&nbsp;&nbsp;&nbsp;码:
				</div>
				<div class="col-xs-6">
					<input type="password" name="password" id="psd_r" value="" placeholder="&nbsp;&nbsp;密码" onBlur="javascript:ok_or_errorByRegister(this)" />
				</div>
				<div class="col-xs-1 ok_gou">
					√
				</div>
				<div class="col-xs-1 error_cuo">
					×
				</div>
			</div>
			<div class="nav register_affirm">
				<div class="col-xs-4">
					确认密码:
				</div>
				<div class="col-xs-6">
					<input type="password" name="" id="affirm_psd" value="" placeholder="&nbsp;&nbsp;确认密码" onBlur="javascript:ok_or_errorByRegister(this)" />
				</div>
				<div class="col-xs-1 ok_gou">
					√
				</div>
				<div class="col-xs-1 error_cuo">
					×
				</div>
			</div>
			<div class="col-xs-12 register_btn_div">
				<input type="submit" class="sub_btn" value="注册" id="register" onclick="register()"/>
			</div>
		</div>
	
	<div class="col-xs-12 barter_register">
		<button class="barter_registerBtn" onClick="javascript:barter_btn(this)" style="">已有账号?返回登录</button>
	</div>
</div>


</body>
</html>