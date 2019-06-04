<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String wsBasePath = "ws://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/bootstrap/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/farm/farm.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/purchased.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/plant.css" />
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/plugins/jquery.edatagrid.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/farm/helper.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/farm/sockjs.js"></script>
</head>

<body>
	<audio id="sound"></audio>
	<div id="farmbox"><img src="<%=basePath %>images/bj.png"></div>
	<div id="farm"></div>
	<div class="easyui-draggable bagArea" style="display:none;">
		<jsp:include page="/WEB-INF/template/shop/purchasedSeeds.jsp"></jsp:include>
	</div>
	<div id="landTemplate" class="solidland" style="display:none;" onClick="javascript:openWasteland($(this))">
			<img class="cropstyle" src="">
			<img class="wormstyle" src="<%=basePath %>images/cong.png">
			<img class="landstyle" src="<%=basePath%>images/land.png">
			<input type="hidden" name="landId">
			<input type="hidden" name="landIndex">
			<input type="hidden" name="plantId">
			<input type="hidden" name="seedId">
	</div>
	<script type="text/javascript">
		var stamap = new Map();
	</script>
	<c:forEach items="${statuslist}" var="status">
		<script>stamap.set("${status.id}","${status.name}")</script>
	</c:forEach>
	<script type="text/javascript">
		const rows = 4;
		const cols = 6;
		$(function(){
			for(i=0;i<cols;i++){
				for(j=0;j<rows;j++){
					var cardTemplate = $("#landTemplate").clone();
					var landIndex = i*rows+j;
					cardTemplate.css("cursor","url(<%=basePath%>images/cursors/chan.png),default");
					cardTemplate.find("input[name='landIndex']").val(landIndex);
					cardTemplate.find("input[name='landId']").val(j+1);//landId和数据库中的land.id对应
					cardTemplate.attr("id","solidland"+String(landIndex));
					cardTemplate.css("display","block");
					cardTemplate.css("top",(7+(j*44)+(i*42))+"px");
					cardTemplate.css("left",(316-(j*82)+(i*84))+"px");
					cardTemplate.droppable({
						onDragEnter:function(e,source){
						},
						onDragLeave:function(e,source){
						},
						onDrop:function(e,source){
							var plantId = $(this).find("input[name='plantId']").val();
							var seedId = $(this).find("input[name='seedId']").val();
							if(plantId == ''){
								$.messager.show({
						            title: "提醒",
						            msg: "<center>需要先开荒才能种植!</center>"
						        });
								playAudio("warn");
								return;
							}
							if(seedId != ''){
								$.messager.show({
						            title: "提醒",
						            msg: "<center>土地已经有作物，请重新选择土地!</center>"
						        });
								playAudio("warn");
								return;
							}
							var seedId = $(source).find("#idOfSeed").val();//种子的Id
							$(this).find("input[name='seedId']").val(seedId);
							var target = $(this);
							var success = function(result){
								sowCallBack(result);
								if(result.code == 0){
									playAudio("sow");
									cropTitle(result.data.plant);
									var num = Number($(source).find("#numberOfSeed").html())-1;
									$(source).find("#numberOfSeed").html(num);
									$(target).css("cursor","url(<%=basePath%>images/cursors/alarm.png),default");
								}
								
								if(result.code == -10){
									target.find("input[name='seedId']").val("");
									playAudio("warn");
								}
							}
							sow($(this),success);
						}
					});
					$("#farm").append(cardTemplate);
				}
			}
			$(".bagArea").css("display","block");
			var windWid = $(document.body).outerWidth(true)*0.35;
			var divOffset = {left:windWid,top:25};
			$(".bagArea").offset(divOffset);
			initWebSocket();
			initLands();
		})
		
		//初始化土地
		function initLands(){
			request({},"post","<%=basePath%>plant/initLands",initLandsCallBack);
		}
		
		function initLandsCallBack(result){
			for(var i=0;i<result.length;i++){
				var data = result[i];
				var landIndex = data.landIndex;
				var landId = data.landId;
				var plantId = data.plantId;
				
				$("#solidland"+landIndex).css("cursor","default");
				$("#solidland"+landIndex).find("input[name='landIndex']").val(landIndex);
				$("#solidland"+landIndex).find("input[name='landId']").val(landId);
				$("#solidland"+landIndex).find("input[name='plantId']").val(plantId);
				$("#solidland"+landIndex).find(".landstyle").attr("src","<%=basePath %>images/lands/"+landId+".png")
				$("#solidland"+landIndex).removeAttr("onclick");
				if(typeof(data.phase) != "undefined"){
					var phase = data.phase;
					$("#solidland"+landIndex).find("input[name='seedId']").val(phase.seed.id);
					$("#solidland"+landIndex).find(".cropstyle").attr("src","<%=basePath%>images/crops/"+phase.seedId+"/"+phase.phase+".png").show();
					$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/alarm.png),default");
					toNextPhase(data);
				}
			}
		}
		
		//开荒
		function openWasteland(contain){
			var landId = contain.find("input[name='landId']").val();
			var landIndex = contain.find("input[name='landIndex']").val();
			var data = {
				"land.id":landId,
				"landIndex":landIndex
			}
			var success = function(result){
				openWastelandCallBack(result);
				contain.removeAttr("onclick");//解除绑定
			}
			
			request(data,"post","<%=basePath%>plant/wasteland",success);
		}
		
		function openWastelandCallBack(result){
			if(result.code == 0){
				playAudio("shovel");
				callBack(result);
				var plantId = result.data.plantId;
				var landIndex = result.data.landIndex;
				var landId = result.data.landId;
				$("#solidland"+landIndex).find(".landstyle").attr("src","<%=basePath %>images/lands/"+landId+".png")
				$("#solidland"+landIndex).find("input[name='plantId']").val(plantId);
			}
			
			if(result.code == -10){
				callBack(result);
			}
		}
		
		//播种
		function sow(contain,success){
			var seedId = contain.find("input[name='seedId']").val();
			var plantId = contain.find("input[name='plantId']").val();
			var data={
					"id":plantId,
					"seed.id":seedId
			};
			request(data,"post","<%=basePath%>plant/actionPlant",success);
		}
		
		function sowCallBack(result){
			if(result.code == 0){
				callBack(result);
				var landIndex = result.data.plant.landIndex;
				var seed = result.data.plant.phase.seedId;
				$("#solidland"+landIndex).find(".cropstyle").attr("src","<%=basePath%>images/crops/"+seed+"/0.png").show();
			}
			if(result.code == -10){
				callBack(result);
			}
		}
		
		//清除枯草
		function cleanLand(contain,success){
	    	var plantId = contain.find("input[name='plantId']").val();
	    	request({id:plantId},"post","<%=basePath%>plant/actionCleanLand",success);
	    }
		
		//除虫
		function killWorm(contain,success){
			var plantId = contain.find("input[name='plantId']").val();
	    	request({id:plantId},"post","<%=basePath%>plant/actionKillWorm",success);
		}
		
		function toNextPhase(plant){
			
			cropTitle(plant);
	    	var seed = plant.phase.seed;
			var landIndex = plant.landIndex;
			
			if(plant.worm == false){
				$("#solidland"+landIndex).find(".wormstyle").hide();
				$("#solidland"+landIndex).unbind("click");
				if(plant.phase.phase < 5){
					$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/alarm.png),default");
				}
				if(plant.phase.phase == 5){
					$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/hand.png),default");
				}
				if(plant.phase.phase == 6){
					$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/chan.png),default");
				}
			}
			
			if(plant.phase.phase == 5){
				isHarvest(plant);
			}
			
			if(plant.phase.phase != 6 && plant.worm == true){//最后一阶段虽然生虫概率为0，但是不能排除前5个阶段没有除虫的情况
				playAudio("worm");
				$("#solidland"+landIndex).unbind("click");
				$("#solidland"+landIndex).find(".wormstyle").show();
				$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/chu.png),default");
				$("#solidland"+landIndex).click(function(){
					var success = function(result){
						$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/alarm.png),default");
						$("#solidland"+landIndex).find(".wormstyle").hide();
						$("#solidland"+landIndex).unbind("click");
						playAudio("killWorm");
						rewardForKill();
						if(plant.phase.phase == 5){
							isHarvest(plant);
						}
					}
					killWorm($(this),success);
				})
			}
			
			if(plant.phase.phase == 6){	//	最后一阶段
				$("#solidland"+landIndex).unbind("click");
				$("#solidland"+landIndex).find(".wormstyle").hide();
				$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/chan.png),default");
				if(plant.nowSeason>=seed.season){
					$("#solidland"+landIndex).click(function(){
						var success = function(result){
							$("#solidland"+landIndex).css("cursor","default");
							$("#solidland"+landIndex).find(".cropstyle").hide();
							$("#solidland"+landIndex).find("input[name='seedId']").val("");
							$("#solidland"+landIndex).unbind("click");
							playAudio("shovel");
							rewardForClean();
						}
						cleanLand($(this),success);
					})
				}
				
				if(plant.nowSeason<seed.season){//播种却不消耗种子
					$("#solidland"+landIndex).click(function(){
						var success = function(result){
							playAudio("sow");
							$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/alarm.png),default");
							$("#solidland"+landIndex).unbind("click");
							rewardForClean();
							sowCallBack(result);
						}
						sow($(this),success);
					})
				}
			}
	    }
	    
		function cropTitle(plant){
			var landIndex = plant.landIndex;
			var phase = plant.phase;
			var time = new Date();
			time.setSeconds(time.getSeconds()+phase.growthTime);
			var title = "\n\n名称: "+phase.seed.name+
						"\n状态: "+stamap.get(phase.statusId+'')+
						"\n产量: "+phase.seed.harvestNum+
						"\n时间:  "+time.toLocaleString();
			$("#solidland"+landIndex).attr("title",title);
		}
		
		function isHarvest(plant){
			playAudio("mature");
			var seed = plant.phase.seed;
			var landIndex = plant.landIndex;
			$("#solidland"+landIndex).unbind("click");
			$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/shou.png),default");
			$("#solidland"+landIndex).click(function(){
				var plantId = $(this).find("input[name='plantId']").val();
				var success = function(result){
					playAudio("sell");
					rewardCallBack(result);
					$("#solidland"+landIndex).unbind("click");
					$("#solidland"+landIndex).css("cursor","url(<%=basePath%>images/cursors/alarm.png),default");
				}
				var data = {
					"id":plantId
				}
				request(data,"post","<%=basePath%>plant/actionHarvest",success);
			})
		}
		
		function rewardForClean(){
			request({},"post","<%=basePath%>user/rewardForClean",rewardCallBack);
		}
		
		function rewardForKill(){
			request({},"post","<%=basePath%>user/rewardForKill",rewardCallBack);
		}
		
		function rewardCallBack(result){
			freshUserInfo(result.data.user);
			callBack(result);
		}
		
		//刷新作物状态
		function freshCropStatus(plant){
	    	var landIndex = plant.landIndex;
			var phase = plant.phase;
			var seed = phase.seedId;
			var ph = phase.phase;
			$("#solidland"+landIndex).find(".cropstyle").attr("src","<%=basePath%>images/crops/"+seed+"/"+ph+".png");
	    }
		
		//WebSocket
		var websocket = null; 
	    function initWebSocket(){	    	     
		    if ('WebSocket' in window) {  
		        //Websocket的连接  
		        websocket = new WebSocket("<%=wsBasePath%>fuck/action");//WebSocket对应的地址  
		    }  
		    else if ('MozWebSocket' in window) {  
		        //Websocket的连接  
		        websocket = new MozWebSocket("<%=wsBasePath%>fuck/action");//SockJS对应的地址  
		    }  
		    else {  
		        //SockJS的连接  
		        websocket = new SockJS("<%=wsBasePath%>fuck/action");//SockJS对应的地址    
		    }  
		    websocket.onopen = onOpen;  
		    websocket.onmessage = onMessage;  
		    websocket.onerror = onError;  
		    websocket.onclose = onClose;
	    }
	  
	    function onOpen(evt) {  
	        console.log("连接打开：",evt);  
	    }  
	  
	    function onMessage(evt) {
			var jsonstr = evt.data;
			var plant = $.parseJSON(jsonstr);//传来的是JSONString，转换为JSON对象
			toNextPhase(plant);
			freshCropStatus(plant);
	    }  
	    
	    function onError(evt) {  
	    	console.log("出现错误：",evt);
	    }  
	    function onClose(evt) {  
	    	console.log("连接关闭：",evt);
	    }  
	  
	    window.close = function () {  
	        websocket.onclose();  
	    } 
	    
	    function callBack(result){
			 $.messager.show({
		            title: "消息",
		            msg: "<center>"+result.msg+"</center>"
		        });
		}
	    function playAudio(target){
	    	var audios=new Array(
				"<%=basePath%>audio/alarm.mp3",
				"<%=basePath%>audio/warn.mp3",
				"<%=basePath%>audio/killWorm.mp3",
				"<%=basePath%>audio/worm.mp3",
				"<%=basePath%>audio/mature.mp3",
				"<%=basePath%>audio/shovel.mp3",
				"<%=basePath%>audio/sell.mp3",
				"<%=basePath%>audio/sow.mp3"
			);
	    	var sound = $("#sound")[0];
	    	
	    	switch (target){
	    		case "alarm": sound.src=audios[0];break;
	    		case "warn": sound.src=audios[1];break;
	    		case "killWorm": sound.src=audios[2];break;
	    		case "worm": sound.src=audios[3];break;
	    		case "mature": sound.src=audios[4];break;
	    		case "shovel": sound.src=audios[5];break;
	    		case "sell": sound.src=audios[6];break;
	    		case "sow": sound.src=audios[7];break;
	    	}
	    	
	    	sound.play();
	    }
	</script>
</body>
</html>