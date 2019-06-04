<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>我的农场</title>
</head>
	<frameset rows="60,*,50" border="0">
		<frame id="menu" name = "menu" src="menu.jsp" scrolling="no">
		<frame id="workspace" name="workspace" src="welcome.jsp" scrolling="no">
		<frame src="tools.jsp" scrolling="no"> 	
	</frameset>
</html>
