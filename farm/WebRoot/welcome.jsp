<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎首页</title>
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/welcome.css" />
<script type="text/javascript" src="ext/easyui/jquery-1.6.1.min.js" ></script>
</head>
<body>
	<div class="fly-box">
		<img src="images/fox.png" />
	</div>
	<div class="fly-title">
		<span>开心农场</span>
	</div>
	<script>
        function timer() {
        	var top = 0;
        	var max = 460;
            window.setInterval(function () {
				$(".fly-title span:first-child").css("margin-top",top+"px");
				if(top < max){
					top = top + 13;
				}else{
					clearInterval(timer);
				}
					
            }, 100);
        }
		$(function () {
		    timer();
		});
	</script>
</body>
</html>