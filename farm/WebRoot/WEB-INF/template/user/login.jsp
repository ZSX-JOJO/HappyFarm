<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/color.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>ext/farm/farm.css">
<script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>ext/easyui/plugins/jquery.edatagrid.js"></script>
<script type="text/javascript" src="<%=basePath%>ext/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>ext/farm/helper.js"></script>
<style>
.userinf {
	display: block;
	float: left;
	padding-left: 10px;
}

#boxspan {
	height: 20px;
}
</style>
</head>
<body>
	<div id="loginDialog" class="easyui-dialog"
		style="width: 400px; height: 220px; padding: 10px 10px;" title="选择用户"
		closed=false buttons="#loginDialogButtons">
		<p>请选择用户登录</p>
		<input id="com" class="easyui-combobox" name="language"
			data-options="
				url: '<%=basePath %>user/listUser',
				method: 'get',
				valueField: 'id',
				textField: 'username',
				panelWidth: 340,
				width : 340,
				panelHeight: 'auto',
				formatter: formatItem
			">
			<p style="color:gray">请在下拉框中选择用户,点击登录！</p>
	</div>
	<div id="loginDialogButtons">
		<a href="javascript:confirm()" class="easyui-linkbutton">确认</a>
	</div>
	<div style="display: none;" id="infTemplate">
		<div id="boxspan">
			<span class="userinf"><img id="head" style="max-width: 25px;"
				src="<%=basePath %>images/nologin.png"></span> 
			<span id="username" class="userinf">xx</span> <span class="userinf">|</span>
			<span id="experience" class="userinf">经验:0</span> <span class="userinf">|</span> 
			<span id="money" class="userinf">金币:0</span><span class="userinf">|</span> 
			<span id="integral" class="userinf">积分:0</span>
		</div>
	</div>
	<script type="text/javascript">
		function formatItem(row){
			var infTemplate = $("#infTemplate").clone();
			infTemplate.show();
			infTemplate.find("#head").attr("src","<%=basePath %>images/headImages/"+row.head);
			infTemplate.find("#username").text(row.username);
			infTemplate.find("#experience").text("经验:"+row.experience);
			infTemplate.find("#money").text("金币:"+row.money);
			infTemplate.find("#integral").text("积分:"+row.integral);
			return infTemplate.html();
		}
		function confirm(){
			var myform = $('#com').combobox('getValue');
			 $.ajax({
					url: '<%=basePath %>user/getUserInfoById',
					type: "GET",
					data: {id:myform},
					async: true,
					success: successLogin,
					error: function (data) {
					}
				});
		}
		function successLogin(result){
			$.messager.show({
                title: "消息",
                msg: result.username+"["+result.nickname+"]登录成功"
            });
			freshUserInfo(result);
		}
	</script>
</body>
</html>