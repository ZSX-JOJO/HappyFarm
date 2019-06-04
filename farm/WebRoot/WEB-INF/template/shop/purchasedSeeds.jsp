<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="repositoryConatian">
	<div class="buttonleft">
		<img onclick="scrollToLeft()" src="<%=basePath%>images/left.png"/>
	</div>
	<div id="center" class="centerbox">
		<div id="purchasedSeeds">
			<div id="repTemplate" class="purchasedSeedsOfInfo" 
				style="display:none">
				<div class="imgDiv">
					<img id="cardPicc" src="<%=basePath%>images/crops/1/5.png"/>
				</div>
				<div id="numberOfSeed" class="numberOfSeed">32</div>
				<input id="idOfSeed" type="hidden">
				<input id="nameOfSeed" type="hidden">
				<input id="priceOfSeed" type="hidden">
				<input id="tipOfSeed" type="hidden">
			</div>
		</div>
	</div>
	<div class="buttonright">
		<img onclick="scrollToRight()" src="<%=basePath%>images/right.png"/>
	</div>
</div>
<script>
	var landmap = new Map();
</script>

<c:forEach items="${lands}" var="land">
	<script>landmap.set("${land.id}","${land.name}")</script>
</c:forEach>

<script type="text/javascript">
	$(function(){
		freshBag();
	})
	
	function freshBag(){//刷新收纳袋
		//先要清空收纳袋
		$(".purchasedSeedsOfInfo").not(".purchasedSeedsOfInfo:first-child").remove();
		request({},"post","<%=basePath%>repository/listUserRep",listUserRep);
	}
	
	function listUserRep(result){
		var width = 100*result.length;
		$("#purchasedSeeds").css("width",width.toString()+"px");
		var rep = $("#repTemplate");
		var contains = $("#purchasedSeeds");
		for(var i=0;i<result.length;i++){
			var seed = result[i].seed;
			
			var descript="\n"+seed.name
			+"\n单季产量: "+seed.harvestNum+"个果实"
			+"\n果实单价: "+seed.fruitPrice+"金币"
			+"\n季数: "+seed.season+"季作物"
			+"\n土地要求: "+landmap.get(seed.landId+'');
			
			var reptemp = rep.clone();
			reptemp.attr("title",descript);
			reptemp.draggable({
				cursor:"url(<%=basePath%>images/cursors/hand.png),pointer",
				revert:true,
				proxy:function(source){
					var p = $("<img width='100px'>");
					p.attr("src",$(source).find("#cardPicc").attr("src")).appendTo('body');
					return p;
				},
		    	onStartDrag:function(){
		    	},
		    	onStopDrag:function(){
		    	}
		    });
			reptemp.show();
			reptemp.find("#cardPicc").attr("src","<%=basePath%>images/crops/"+seed.seedId+"/5.png");
			reptemp.find("#numberOfSeed").html(result[i].num);
			reptemp.find("#idOfSeed").val(seed.id);
			reptemp.find("#priceOfSeed").val(seed.seedPurPrice);
			reptemp.find("#nameOfSeed").val(seed.name);
			reptemp.find("#tipOfSeed").val(seed.tip);
			contains.append(reptemp);
		}
	}
	
	var OpurchasedSeeds = document.getElementById("center");
	function scrollToLeft(){
		console.log($(".purchasedSeedsOfInfo").width());
		OpurchasedSeeds.scrollLeft -= ($(".purchasedSeedsOfInfo").width());
	}
	
	function scrollToRight(){
		console.log(OpurchasedSeeds.scrollLeft);
		OpurchasedSeeds.scrollLeft += ($(".purchasedSeedsOfInfo").width());
	}
</script>