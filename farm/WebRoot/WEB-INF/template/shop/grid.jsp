<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/reset.css">
	<link rel="stylesheet" href="<%=basePath%>css/shop.css" />
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/plugins/jquery.edatagrid.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/farm/helper.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/purchased.css" />
</head>
	<body>
		<div class="easyui-accordion buy-seed" style="width:70%;height:75%;">
			<div title="种子购买" data-options="" style="overflow:hidden;padding:20px;">
				<div class="tableBox">
					<table id="seed-list">
						<thead>
							<tr>
								<th field="name" width="25%" align="center" sortable="true">种子名称</th>
								<th field="level" width="25%" align="center" sortable="true">种子等级</th>
								<th field="categoryId" width="25%" align="center"  sortable="true">种子类型</th>
								<th field="landId" width="25%" align="center" sortable="true">土地需求</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div title="收纳袋" data-options="" style="padding:10px;">
				<div class="bagArea">
					<jsp:include page="/WEB-INF/template/shop/purchasedSeeds.jsp"></jsp:include>
					<%-- <iframe id="seedBag" frameborder="0" width="665px" height="175px" src="<%=basePath%>shop/repository"></iframe> --%>
				</div>
				<div class="seedArea">
					<div class="showArea">请将卡片拖动至此</div>
					<div class="hideArea">
						<div class="purchasedSeedsOfInfo">
							<div class="imgDiv">
								<img src="<%=basePath%>images/crops/1/5.png"/>
							</div>
							<div class="numberOfSeed">32</div>
						</div>
						<div class="seedAreaRight">
							<div>名称</div>
							<div>金币</div>
							<div>描述信息</div>
							<input type="hidden">
							<button style="cursor:pointer;" onClick="sell()">出售</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="cardTemplate" class="cardTemplate" onClick="javascript:fillDialog($(this))" title="" style="display: none;">
			<div class="seedTip">
				&nbsp;&nbsp;&nbsp;&nbsp;   
				<span id="cardTip">
					源与英语谐音"small tips",
					大意为小知识或者作为补充说明时使用。 
					小贴士的意思是小费，给餐馆，旅馆等服务员的。
				</span>
			</div>
			<div class="seedPic">
				<img id="cardPic" src="<%=basePath%>images/crops/1/5.png"/>
			</div>
			<input id="seedId" type="hidden">
			<input id="seedName" type="hidden">
			<input id="seedPrice" type="hidden">
		</div>
		<div id="purDialog" class="easyui-dialog" 
			closed=true title="种子购买" 
			style="width:350px;height:210px;padding:10px"
			data-options="buttons: '#purDialog-buttons'">
			<img width="100px" style="float:left;" src="">
			<div style="float:left;padding:15px;">
				名称:<span style="display:inline-block;">食人花</span><br>
				售价:<span style="display:inline-block;margin-top:10px;">0</span>金币<br>
				<input style="margin-top:10px;" type="text" placeholder="购买数量">
				<input type="hidden">
			</div>
		</div>
		<div id="purDialog-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="buy()">购买</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#purDialog').dialog('close')">关闭</a>
		</div>
	</body>
	<script>
		var catmap = new Map();
		var landmap = new Map();
	</script>
	<c:forEach items="${categories}" var="category">
		<script>
			catmap.set("${category.id}","${category.name}")
		</script>
	</c:forEach>
	<c:forEach items="${lands}" var="land">
		<script>landmap.set("${land.id}","${land.name}")</script>
	</c:forEach>
	<script>
		var cardview = $.extend({},$.fn.datagrid.defaults.view, {
			renderRow: function(target, fields, frozen, rowIndex, rowData){
				if (!frozen){
					var descript="名称:"+rowData.name
					+"\n级别:"+rowData.level
					+"\n价格:"+rowData.seedPurPrice+"个金币"
					+"\n类别:"+catmap.get(rowData.categoryId+'')
					+"\n土地:"+landmap.get(rowData.landId+'')
					+"\n可收获季:"+rowData.season+"季"
					+"\n成熟时间:"+rowData.harvestTime+"秒"
					+"\n单季收获:"+rowData.harvestNum+"个果实"
					+"\n经验收获:"+rowData.experience
					+"\n单个果实可获金币:"+rowData.fruitPrice
					+"\n积分收获:"+rowData.integral;
					
					var cardTemplate = $("#cardTemplate").clone();
					cardTemplate.show();
					cardTemplate.attr("title",descript);
					cardTemplate.find("#cardTip").html(rowData.tip);
					cardTemplate.find("#cardPic").attr("src","<%=basePath%>images/crops/"+rowData.seedId+"/5.png");
					cardTemplate.find("#seedPrice").val(rowData.seedPurPrice);
					cardTemplate.find("#seedName").val(rowData.name);
					cardTemplate.find("#seedId").val(rowData.id);
					return cardTemplate.prop("outerHTML");
				}
			}
		});
		$('#seed-list').datagrid({
			title:"种子仓库  <font color='red'>点击购买<font>",
			height: 410, 
			url: '<%=basePath%>seed/gridData',
			method:'post',
			border: false,
			rownumbers: true,
			remoteSort: true,
			nowrap: false,
			singleSelect: true,
			fit: true,
			fitColumns: true,
			pagination: true,
			striped: true,
			autoSave:true,
			view: cardview
		});
		var page = $('#seed-list').datagrid('getPager'); 
		page.pagination({
		    pageSize: 4,
		    pageList: [4,8,12,16],
		    beforePageText: '第', 
		    afterPageText: '页    共 {pages} 页', 
		    displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
		});
		function fillDialog(card){//填充对话框
			$("#purDialog").dialog("open");
			var imgsrc = card.find("#cardPic").attr("src");
			var seedName = card.find("#seedName").val();
			var seedId = card.find("#seedId").val();
			var seedPrice = card.find("#seedPrice").val();
			$("#purDialog img").attr("src",imgsrc);
			$("#purDialog span:first").html(seedName);
			$("#purDialog span:last").html(seedPrice);
			$("#purDialog input[type='hidden']").val(seedId);
		}
		function buy(){
			var userId = parseInt("${currentUser.id}");//将string类型转换为number类型
			var seedId = $("#purDialog input[type='hidden']").val();
			var num = $("#purDialog input[type='text']").val();
			var data = {"user.id":userId,"seed.id":seedId,"num":num};
			request(data,"post","<%=basePath%>repository/buy",successBuy);
		}
		
		function sell(){
			if(confirm('每次出售10个，将会以八折出售，确认出售?')){
				var userId = parseInt("${currentUser.id}");//将string类型转换为number类型
				var seedId = $(".seedAreaRight input[type='hidden']").val();
				var data = {"user.id":userId,"seed.id":seedId,"num":10};
				request(data,"post","<%=basePath%>repository/sell",successSell);
			}
		}
		
		function successBuy(result){
			$.messager.show({
                title: "消息",
                msg: result.msg
            });
			$("#purDialog input[type='text']").val("");
			$("#purDialog").dialog("close");
			var moneyMenu= window.parent.document
					.getElementById("menu")
					.contentWindow.document
					.getElementById("moneyMenu");
			moneyMenu.innerHTML=result.data.money;
			/* var freshBag = document.getElementById("seedBag").contentWindow.freshBag; 这段代码用于iframe导入，但是现在改变了方案*/
			freshBag();
		}
		
		function successSell(result){
			$.messager.show({
                title: "消息",
                msg: result.msg
            });
			$("#purDialog input[type='text']").val("");
			$("#purDialog").dialog("close");
			var moneyMenu= window.parent.document
				.getElementById("menu")
				.contentWindow.document
				.getElementById("moneyMenu");
			moneyMenu.innerHTML=result.data.money;
			freshBag();
		}
		
		$('.seedArea').droppable({
			onDragEnter:function(e,source){
				$(".showArea").hide();
				$(".hideArea").show();
				$(".hideArea .imgDiv img").attr("src",$(source).find("#cardPicc").attr("src"));
				$(".seedAreaRight div:nth-child(1)").html($(source).find("#nameOfSeed").val());
				$(".seedAreaRight div:nth-child(2)").html($(source).find("#priceOfSeed").val()+"金币");
				$(".seedAreaRight div:nth-child(3)").html($(source).find("#tipOfSeed").val());
				$(".hideArea div.numberOfSeed").html($(source).find("#numberOfSeed").html()); 
				$(".seedAreaRight input[type='hidden']").val($(source).find("#idOfSeed").val());
			},
			onDragLeave:function(e,source){
				$(".hideArea").hide();
				$(".showArea").show();
			},
			onDrop:function(e,source){
				
			}
		});
	</script>
</html>