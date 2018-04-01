<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	*{margin:0;padding:0} 
	body{
		background: #f5f5f5;
	}
	#left{
		width: 70%;
		height: auto;
		float: left;
		
		
	}
	#right{
		width: 30%;
		height:150px;
		margin:0px;
		float: right;
		
		
	}
</style>
<script type="text/javascript">


</script>
<title>Insert title here</title>
</head>
<body>
<div style="width:100%;height:140px">
	<div id="left">
		<div><h1>Docker</h1></div><br/>
		<div><P style="text-indent:2em;"><span style="color:red">Docker</span> 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口。</P></div>
	</div>
	<div  id="right"><img  src="images/docker.png" width="100%" height="100%" ></div>
</div>
<br/>
<div>
	<div><h3>docker特性：</h3></div>
	<div>
		<ul >
		  <li>1. Automating the packaging and deployment of applications（使应用的打包与部署自动化）</li>
		  <li>2. Creation of lightweight, private PAAS environments（创建轻量、私密的PAAS环境）</li>
          <li>3. Automated testing and continuous integration/deployment（实现自动化测试和持续的集成/部署）</li>
          <li>4. Deploying and scaling web apps, databases and backend services（部署与扩展webapp、数据库和后台服务）</li>
         
        </ul>
	</div>
</div>
<br/>
  
 <div>
	<div><h3>docker意义：</h3></div>
	<div>
		<ul >
		  <li>1.To开发者——得益于Docker，让他们有可能在一条或者几条命令内搭建完环境</li>
		  <li><p style="text-indent:2em;">对开发者来说，每天都会催生出各式各样的新技术需要尝试，然而在如此短暂且宝贵的时间内，开发者却不太可能逐一搭建好环境并进行测试。Docker之所以能够实现以上功能，是因为它有一个“傻瓜化”的获取软件的方法，能够在后台自动获得环境镜像并且运行环境。</p></li><br/>
          <li>2.To运维者——Docker把整个开发环境打包成一个Dockerimage交给运维团队直接运行</li>
          <li><p style="text-indent:2em;">对运维人员来说，大概最困惑的就是“应用程序明明在我的环境里运行是正常的，怎么到别人的环境里就不行了呢？”其实，这个bug的原因很可能是因为在搭建环境中，由于两个环境的细微不同而导致应用程序的部署失败了。而通过上文的阐述，我们都知道，Docker能够不管用户的应用程序是什么的，做什么的，它依然能提供一个统一的环境资源，从而从根源上解决运维人员的烦恼，运维人员只需直接运行即可，十分简单便捷。</p></li>
         
        </ul>
	</div>
</div>
</body>
</html>