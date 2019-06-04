<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
    .pagination{
       	padding-bottom:30px;
       }
       </style>    

<div id="phaseControlBox">
    <a href="#" class="easyui-linkbutton c2" iconCls="icon-add"
    	onclick="addRow()">添加</a>
    <a href="#" class="easyui-linkbutton c4" iconCls="icon-edit"
    	onclick="phaseLoadForm()">编辑</a>
    <a href="#" class="easyui-linkbutton c3" iconCls="icon-remove"
    	onclick="javascript:phaseGrid.edatagrid('cancelRow')">取消</a>
    <a href="#" class="easyui-linkbutton c5" iconCls="icon-cancel"
    	onclick="javascript:phaseGrid.edatagrid('destroyRow')">删除</a>
</div>

<table id="phaseGrid"></table>
<div id="formPhaseContainer" class="easyui-dialog" style="width:700px;height:350px;padding:10px 10px" closed="true" buttons="#formPhaseButtons">
    <form id="formPhase" method="POST" novalidate>
        <table>
            <tr>
                <td>ID：</td>
                <td><input name="id" required="true" class="w200" value="0"></td>
                <td>种子ID：</td>
                <td><input name="seedId" required="true" class="easyui-validatebox" readonly="true"></td>
            </tr>
            <tr>
                <td>生长阶段：</td>
                <td><input id="phase" name="phase" required="true" class="easyui-numberbox"></td>
                <td>生长小标题：</td>
                <td><input name="title" required="true" class="easyui-textbox"></td>
            </tr>
            <tr>
                <td>阶段生长时间：</td>
                <td><input name="growthTime" required="true" class="easyui-numberbox">&nbsp;s</td>
                <td>生虫概率：</td>
                <td><input name="chance" required="true" class="easyui-textbox"></td>
            </tr>
            <tr>
                <td>图片高度：</td>
                <td><input id="height" name="width" required="true" class="easyui-textbox" readonly="true" vlaue="100">&nbsp;px&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>图片宽度：</td>
                <td><input id="width" name="height" required="true" class="easyui-textbox" readonly="true" vlaue="100">&nbsp;px</td>
            </tr>
            <tr>
                <td>offsetX：</td>
                <td><input id="offsetX" name="offsetX" required="true" class="easyui-textbox" readonly="true" vlaue="0">&nbsp;px</td>
                <td>offsetY：</td>
                <td><input id="offsetY" name="offsetY" required="true" class="easyui-textbox" readonly="true" vlaue="0">&nbsp;px</td>
            </tr>
            <tr>
                <td>作物状态：</td>
                <td><input name="statusId" required="true" class="easyui-combobox" panelHeight="auto"
                           data-options="editable:false,
                                    valueField:'id',
                                    textField:'name',
                                    url:'<%=basePath%>/status/listStatus'"></td>
                <td></td>
            	<td><input type="button" onClick="editPic()" value="编辑图片位置"></td>           
            </tr>
        </table>
    </form>
</div>

<div id="positionDialog" class="easyui-dialog" style="width:240px;height:420px;padding:10px 10px;" closed=true buttons="#positionDialogButtons">
    <div id="tools-imagePositioner-display"
    	class="tools-imagePositioner-display"
    	style="position:relative;width:100%;height:100%;background-image:url(<%=basePath%>images/positioning.png);">
       <img class="easyui-draggable easyui-resizable" data-options="onResize:onResize,onDrag:onDrag"
       			style="border:1px solid #FF3300"
       			src="">
    </div>
</div>

<div id="formPhaseButtons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="phaseSaveForm()">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#formPhaseContainer').dialog('close')">取消</a>
</div>

<div id="positionDialogButtons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="gainPostion()">确定</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#positionDialog').dialog('close')">取消</a>
</div>

<script>
var phaseGrid;
$(document).ready(function () {
	phaseGrid = $('#phaseGrid').edatagrid({
		title: '成长阶段定义',
        width: 800,
        height: 400,
        method:'post',
        url: '<%=basePath%>/phase/gridData',
        saveUrl: '<%=basePath%>/phase/save',
        updateUrl: '<%=basePath%>/phase/save',
        destroyUrl: '<%=basePath%>/phase/delete',
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
            {field: 'phase', title: '生长阶段', width: 30, sortable: true,
            	editor:{
            		type:'numberbox',
            		options: { required: true }
            	}
            },
            {field: 'title', title: '生长阶段标题', width: 50, align: 'left', sortable: true,
            	editor:{
            		type:'textbox',
            		options: { required: true }
            	}
            },
            {field: 'growthTime', title: '阶段生长时间', width: 50, sortable: true,
            	editor:{
            		type:'numberbox',
            		options: { required: true }
            	}
            },
            {field: 'chance', title: '生虫概率', width: 50, sortable: true,
            	editor:{
            		type:'textbox',
            		options: { required: true }
            	}
            },
            {field: 'width', title: '宽度', width: 50,
            	editor:{
            		type:'textbox',
            		options: {
            			editable:false
            		}
            	}
            },
            {field: 'height', title: '高度', width: 50,
            	editor:{
            		type:'textbox',
            		options: {
            			editable:false
            		}
            	}
            },
            {field: 'offsetX', title: 'offsetX', width: 50,
            	editor:{
            		type:'textbox',
            		options: {
            			editable:false
            		}
            	}
            },
            {field: 'offsetY', title: 'offsetY', width: 50,
            	editor:{
            		type:'textbox',
            		options: {
            			editable:false
            		}
            	}
            },
            {field: 'statusId', title: '作物状态', width: 50, sortable: true,
            	formatter:function(value,row){
               		return stamap.get(value+'');
                },
                editor:{
                    type:'combobox',
                    options:{
                    	editable:false,
                    	valueField:'id',
                        textField:'name',
                        url:'<%=basePath%>/status/listStatus',
                        panelHeight:'auto',
                    }
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
	phaseGrid.datagrid("getPager").pagination({
        pageSize: 5,
        pageList: [5,10,15,20]
    });
});
function gainPostion(){
	
}
var x = 0;
var y = 0;
function editPic(){
	var row = grid.datagrid('getSelected');
	var seedId = row.seedId;
	var phase = $('#phase').numberbox("getValue");
	var offsetX = $('#offsetX').textbox("getValue")-x;
	var offsetY = $('#offsetY').textbox("getValue")-y;
	var width =$('#width').textbox("getValue");
	var height =$('#height').textbox("getValue");
	var divOffset = {left:offsetX,top:offsetY};
	
	$('#positionDialog img').attr("src","<%=basePath%>/images/crops/"+seedId+"/"+phase+".png");
	if(width!=""&&height!=""){
		$('#positionDialog img').css("width",width);
		$('#positionDialog img').css("height",height);
	}else{
		$('#positionDialog img').css("width","100");
		$('#positionDialog img').css("height","100");
	}
	if(offsetX!=""&&offsetY!=""){
		$("#positionDialog img").offset(divOffset);
	}
	$('#positionDialog').dialog('open');
	x=$('#offsetX').textbox("getValue");
	y=$('#offsetY').textbox("getValue");
	
}

function onDrag(e){
	var d = e.data;
	if (d.left < 0){d.left = 0}
	if (d.top < 0){d.top = 0}
	if (d.left + $(d.target).outerWidth() > $(d.parent).width()){
		d.left = $(d.parent).width() - $(d.target).outerWidth();
	}
	if (d.top + $(d.target).outerHeight() > $(d.parent).height()){
		d.top = $(d.parent).height() - $(d.target).outerHeight();
	}   
	console.log(d.left);
	console.log(d.top);
	$('#offsetX').textbox('setValue',d.left);
	$('#offsetY').textbox('setValue',d.top);
	$('#width').textbox('setValue',d.width);
	$('#height').textbox('setValue',d.height);
	x=$('#offsetX').textbox("getValue");
	y=$('#offsetY').textbox("getValue");
}
function onResize(e){
	var d = e.data;
	$('#width').textbox('setValue',d.width);
	$('#height').textbox('setValue',d.height);
}

function phaseLoadForm() {
    var row = phaseGrid.datagrid('getSelected');
    if (row) {
    	phaseGrid.id = row.id;
    	phaseGrid.mode = 'edit';
        $('#formPhaseContainer').dialog('open').dialog('setTitle', '编辑数据');
        $('#formPhase').form('load', row);
    } else {
        alert("请先选择一行数据，然后再尝试点击操作按钮！");
    }
}
function phaseSaveForm() {
    $('#formPhase').form('submit', {
        url: '<%=basePath%>/phase/save',
        onSubmit: function (param) {
            param.id = params.id;
            param.mode = params.mode;
            return $(this).form('validate');
        },
        success: function (result) {
        	var data = grid.datagrid('getSelected');
        	$('#phaseGrid').datagrid('appendRow', {"seedId":data.seedId});
            var result = eval('(' + result + ')');
            if (result.code == 0) {
                $('#formPhaseContainer').dialog('close');
                phaseGrid.datagrid('reload');
            }
            $.messager.show({
                title: "消息",
                msg: result.msg
            });
        }
    });
}
function addRow(){
	
	var data = grid.datagrid('getSelected');
	$('#formPhase').form('clear');
	$('#formPhase').find("input[name='id']").val(0);
	$('#formPhase').find("input[name='seedId']").val(data.seedId);
	$('#formPhaseContainer').dialog('open').dialog('setTitle', '编辑数据');
   
}
function gainPostion(){
	x=$('#offsetX').textbox("getValue");
	y=$('#offsetY').textbox("getValue");
	$('#positionDialog').dialog('close');

}
</script>