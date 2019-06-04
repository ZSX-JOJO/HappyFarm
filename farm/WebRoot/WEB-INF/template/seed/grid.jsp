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
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/plugins/jquery.edatagrid.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript+" src="<%=basePath%>ext/farm/helper.js"></script>
</head>
<body>
<div id="controlBox">
	<span style="color:white">名字:</span>
    <input id="genderSearch" type="text" class="easyui-textbox">
    <a href="#" class="easyui-linkbutton c1" iconCls="icon-search" 
    	onclick="doSearch()">查询</a>
    <a href="#" class="easyui-linkbutton c2" iconCls="icon-add" 
    	onclick="newRecord()">添加</a>
    <a href="#" class="easyui-linkbutton c4" iconCls="icon-edit" 
    	onclick="loadForm()">编辑</a>
    <a href="#" class="easyui-linkbutton c3" iconCls="icon-remove" 
    	onclick="javascript:grid.edatagrid('cancelRow')">取消</a>
    <a href="#" class="easyui-linkbutton c5" iconCls="icon-cancel" 
    	onclick="javascript:grid.edatagrid('destroyRow')">删除</a>
</div>
<table id="grid"></table>  
<div id="formSeedContainer" class="easyui-dialog" style="width:700px;height:350px;padding:10px 10px" closed="true" buttons="#formSeedButtons">
    <form id="formSeed" method="POST" novalidate>
        <table>
            <tr>
                <td>ID：</td>
                <td><input name="id" required="true" class="w200" value="0"></td>
                <td>种子ID：</td>
                <td><input name="seedId" required="true" class="easyui-validatebox w50"></td>
            </tr>
            <tr>
                <td>名称：</td>
                <td><input name="name" required="true" class="easyui-textbox"></td>
                <td>季度：</td>
                <td><input name="season" required="true" class="easyui-numberbox">&nbsp;季作物</td>
            </tr>
            <tr>
                <td>等级：</td>
                <td><input name="level" required="true" class="easyui-numberbox"></td>
                <td>分类：</td>
                <td><input name=categoryId required="true" class="easyui-combobox" panelHeight="auto"
                           data-options="editable:false,
                                    valueField:'id',
                                    textField:'name',
                                    url:'<%=basePath%>/category/listCategory'"></td>
            </tr>
            <tr>
                <td>经验：</td>
                <td><input name="experience" required="true" class="easyui-numberbox"></td>
                <td>收获时间：</td>
                <td><input name=harvestTime required="true" class="easyui-numberbox">&nbsp;ms</td>
            </tr>
            <tr>
                <td>果实收获数量：</td>
                <td><input name=harvestNum required="true" class="easyui-numberbox">&nbsp;个</td>
                <td>种子购价：</td>
                <td><input name=seedPurPrice required="true" class="easyui-numberbox">&nbsp;金币</td>
            </tr>
            <tr>
                <td>果实售价：</td>
                <td><input name=fruitPrice required="true" class="easyui-numberbox">&nbsp;金币&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>土地：</td>
                <td><input name=landId required="true" class="easyui-combobox" panelHeight="auto"
                           data-options="editable:false,
                                    valueField:'id',
                                    textField:'name',
                                    url:'<%=basePath%>/land/listLand'"></td>
            </tr>
            <tr>
                <td>积分：</td>
                <td><input name=integral required="true" class="easyui-numberbox"></td>
                <td>提示信息：</td>
                <td><input name=tip required="true" class="easyui-textbox"></td>
            </tr>
        </table>
    </form>
</div>

<div id="formSeedButtons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveForm()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#formSeedContainer').dialog('close')">取消</a>
</div>

<div id="win" class="easyui-window" title="My Window" style="width:820px;height:500px;" closed="true"
    data-options="iconCls:'icon-save',modal:true">
	<jsp:include page="/WEB-INF/template/cropsGrow/grid.jsp"></jsp:include>
</div>

<script>
	var catmap = new Map();
	var landmap = new Map();
	var stamap = new Map();
	var params = {
	        id: '',
	        mode: 'insert'
	    };
	var grid;
	var currentSeedId;
	var currentPhase;
</script>

<c:forEach items="${categories}" var="category">
	<script>catmap.set("${category.id}","${category.name}")</script>
</c:forEach>

<c:forEach items="${lands}" var="land">
	<script>landmap.set("${land.id}","${land.name}")</script>
</c:forEach>

<c:forEach items="${statuslist}" var="status">
	<script>stamap.set("${status.id}","${status.name}")</script>
</c:forEach>

<script>
    $(document).ready(function () {
        //配置表格
        grid = $('#grid').edatagrid({
            title: '种子清单',
            width: 1350,
            height: 600,
            method:'post',
            url: '<%=basePath%>/seed/gridData',
            saveUrl: '<%=basePath%>/seed/save',
            updateUrl: '<%=basePath%>/seed/save',
            destroyUrl: '<%=basePath%>/seed/delete',
            border: false,           
            rownumbers: true,
            remoteSort: true,
            nowrap: false,
            singleSelect: true,
            fitColumns: true,
            pagination: true,
            striped: true,
            autoSave:true,
            fit:true,
            idField: "id",            
            columns: [[
                {field: 'id', title: 'ID', width: 30, sortable: true},
                {field: 'seedId', title: '种子ID', width: 30, sortable: true,
                	editor:{
                		type:'numberbox',
                		options: { required: true }
                	}
                },
                {field: 'name', title: '种子名称', width: 50, align: 'left', sortable: true,
                    editor:{
                        type:'validatebox',
                        options: {                         
                            validType:'length[1,5]',                            
                            invalidMessage:'有效长度1-5',
                            required:true
                        }
                    }
                },
                {field: 'season', title: 'X季作物', width: 50, align: 'left', sortable: true,
                	editor:{
                		type:'numberbox',
                		options: { required: true }
                	},
	                formatter:function(value,row){
	               		return value + '季作物';
	                }
                },
                {field: 'level', title: '种子等级', width: 50, sortable: true,
                	formatter:function(value,row){
	               		return value+"级";
	                },
                	editor:{
                		type:'numberbox',
                		options: { required: true }
                	}
                },
                {field: 'categoryId', title: '种子类型', width: 50, sortable: true,
                	formatter:function(value,row){
	               		return catmap.get(value+'');
	                },
	                editor:{
                        type:'combobox',
                        options:{
                        	editable:false,
                        	valueField:'id',
                            textField:'name',
                            url:'<%=basePath%>/category/listCategory', 
                            panelHeight:'auto',
                        }
                 	}
     			},
                {field: 'experience', title: '可获经验', width: 50, sortable: true,
     				editor:{
                		type:'numberbox',
                		options: { required: true }
                	}
                },
                {field: 'harvestTime', title: '每季成熟所需时间', width: 50, sortable: true,
                	formatter:function(value,row){
	               		return value+"秒";
	                },
                	editor:{
                		type:'numberbox',
                		options: { required: true }
                	}
                },
                {field: 'seedPurPrice', title: '种子采购价', width: 50, sortable: true,
                	formatter:function(value,row){
	               		return value+"金币";
	                },
                	editor:{
                		type:'numberbox',
                		options: { required: true }
                	}	
               	},
                {field: 'fruitPrice', title: '果实售价', width: 50, sortable: true,
               		formatter:function(value,row){
	               		return value+"金币";
	                },
               		editor:{
                		type:'numberbox',
                		options: { required: true }
                	}
               	},
                {field: 'landId', title: '土地需求', width: 50, sortable: true ,
               		formatter:function(value,row){
	               		return landmap.get(value+'');
	                },
	                editor:{
                        type:'combobox',
                        options:{
                        	editable:false,
                        	valueField:'id',
                            textField:'name',
                            url:'<%=basePath%>/land/listLand', 
                            panelHeight:'auto',
                            required:true
                        }
                 	}
                },	
                {field: 'integral', title: '每季成熟所获积分', width: 50, sortable: true,
                	formatter:function(value,row){
	               		return value+"分";
	                },
                	editor:{
                		type:'numberbox',
                		options: { required: true }
                	}
                },
                {field: 'tip', title: '提示信息', width: 50, sortable: true,
                	editor:{
                		type:'textarea',
                		options: { required: true }
                	}
               	},
               	{field:'operate',title:'操作',align:'center',width:$(this).width()*0.03,
               		formatter:function(value, row, index){
               			var str = "<button onClick=\"getCropsGrow("+index+")\">成长阶段</button>";
               			return str;
               		}
               	}
            ]],
            destroyMsg:{
                norecord:{
                    title:'警告',
                    msg:'首先需要选中记录，然后在点击删除按钮'
                },
                confirm:{
                    title:'确认',
                    msg:'是否删除选中记录?'
                }
            },
            onSuccess:function(index,row){
            	$.messager.show({
                    title: "消息",
                    msg: row.msg
                });
            },
            onDestroy:function(index,row){
            	$.messager.show({
                    title: "消息",
                    msg: row.msg
                });
            }
        });        
        grid.datagrid("getPager").pagination({
            pageSize: 5,
            pageList: [5,10,15,20]
        });  
    }); 
    function doSearch(){
        grid.datagrid("load",{
            name: $("#genderSearch").val()
        });
    }
    function loadForm() {
        var row = grid.datagrid('getSelected');
        if (row) {
            params.id = row.id;
            params.mode = 'edit';
            $('#formSeedContainer').dialog('open').dialog('setTitle', '编辑数据');
            $('#formSeed').form('load', row);
        } else {
            alert("请先选择一行数据，然后再尝试点击操作按钮！");
        }
    }
    function saveForm() {
        $('#formSeed').form('submit', {
            url: '<%=basePath%>/seed/save',
            onSubmit: function (param) {
                param.id = params.id;
                param.mode = params.mode;
                return $(this).form('validate');
            },
            success: function (result) {
                var result = eval('(' + result + ')');
                if (result.code == 0) {
                    $('#formSeedContainer').dialog('close');
                    grid.datagrid('reload');
                }
                $.messager.show({
                    title: "消息",
                    msg: result.msg
                });
            }
        });
    }
    function getCropsGrow(index){
    	var row = $("#grid").datagrid('getRows');
  		currentSeedId = row[index].seedId;
  		$("#phaseGrid").datagrid('load', {
  		    seedId: currentSeedId
  		});  
    	$("#win").window("open");
    }
    function newRecord(){
        $('#formSeedContainer').dialog('open').dialog('center').dialog('setTitle','添加数据');     
        $('#formSeed').form('clear');
        $('#formSeed').find("input[name='id']").val(0);
    }
</script>
</body>
</html>