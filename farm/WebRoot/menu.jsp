<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.jxufe.entity.User" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/bootstrap-3.3.4.css" />
<link rel="stylesheet" href="css/menu.css" />
<title>菜单</title>  
</head>
<body>
	<% 
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		String username = "未知用户";
		int money = 0;
		int experience = 0;
		int integral = 0;
		String head = "images/nologin.png";
		if(currentUser != null){
			username = currentUser.getUsername();
			money = currentUser.getMoney();
			experience = currentUser.getExperience();
			integral = currentUser.getIntegral();
			head = basePath+"images/headImages/"+currentUser.getHead();
		}
	%>
	<div align="left" class="menu-left">
		<img id="headMenu" src=<%=head %>>
		<div class="userinf">
			<div class="username" id="usernameMenu"><%=username %></div>
			<div class="usermoney">
				金币:<span id="moneyMenu" style="display: inline-block;margin-right: 10px;"><%=money %></span>
				经验:<span id="experienceMenu" style="display: inline-block;margin-right: 10px;"><%=experience %></span>
				积分:<span id="integralMenu"><%=integral %></span>
			</div>
		</div>
	</div>
	<div align="right" id="mainNav" class="menu-right">
		<ul id="navBox" class="nav navbar-nav navbar-right hc-navbox">
			<li>
				<a class="nav-on" target="workspace" href="welcome.jsp"><img src="images/index.png"></a>
				<a class="nav-off" target="workspace" href="welcome.jsp">首页</a>
			</li>
			<li>
				<a class="nav-on" target="workspace" href="plant/page"><img src="images/farmer.png"></a>
				<a class="nav-off" target="workspace" href="plant/page">种植</a>
			</li>
			<li>
				<a class="nav-on" target="workspace" href="shop/grid"><img src="images/shop.png"></a>
				<a class="nav-off" target="workspace" href="shop/grid">商店</a>
			</li>
			<li>
				<a class="nav-on" target="workspace" href="user/login"><img src="images/login.png"></a>
				<a class="nav-off" target="workspace" href="user/login">登录</a>
			</li>
			<li>
				<a class="nav-on" target="workspace" href="user/grid"><img src="images/user.png"></a>
				<a class="nav-off" target="workspace" href="user/grid">用户</a>
			</li>
			<li>
				<a class="nav-on" style="margin-top:7px;" target="workspace" href="seed/grid"><img src="images/seed.png"></a>
				<a class="nav-off" target="workspace" href="seed/grid">种子</a>
			</li>
		</ul>
	</div>
</body>
</html>