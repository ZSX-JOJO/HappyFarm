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
    <script type="text/javascript" src="<%=basePath%>ext/farm/helper.js"></script>  
    <script type="text/javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>
</head>
<body>
	<div class="easyui-window" title="My Window" style="width:1024px;height:600px;">
		<div id="controlBox">
			<span style="color:white">用户名:</span>
		    <input id="genderSearch" type="text" class="easyui-textbox">
		    <a href="#" class="easyui-linkbutton c1" iconCls="icon-search" 
		    	onclick="doSearch()">查询</a>
		    <a href="#" class="easyui-linkbutton c2" iconCls="icon-add" 
		    	onclick="javascript:grid.edatagrid('addRow')">添加</a>
		    <a href="#" class="easyui-linkbutton c3" iconCls="icon-remove" 
		    	onclick="javascript:grid.edatagrid('cancelRow')">取消</a>
		    <a href="#" class="easyui-linkbutton c5" iconCls="icon-cancel" 
		    	onclick="javascript:grid.edatagrid('destroyRow')">删除</a>
		</div>
		<table id="grid"></table>
		<div id="upLoadDialog" class="easyui-dialog" style="width:400px;height:130px;padding:10px 10px;" title="上传头像" closed=true buttons="#upLoadDialogButtons">
			<div style="float:left;width:70px;height:26px;line-height:26px;margin-left:30px;">上传头像:</div>
			<input id="upLoadInput" name="filePathName" class="easyui-filebox" data-options="prompt:'选择上传文件'" style="width:220px">
		</div>
		<div id="upLoadDialogButtons">
		    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="upLoadImg()">开始上传</a>
		    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#upLoadDialog').dialog('close')">关闭窗口</a>
		</div>
	</div>
	<script>
		var currentRow;
		$(document).ready(function () {
		    //配置表格
		    grid = $('#grid').edatagrid({
		        title: '用户清单',
		        width: 1350,
		        height: 600,
		        method:'post',
		        url: '<%=basePath%>/user/gridData',
		        saveUrl: '<%=basePath%>/user/save',
		        updateUrl: '<%=basePath%>/user/save',
		        destroyUrl: '<%=basePath%>/user/delete',
		        border: false,           
		        rownumbers: true,
		        remoteSort: true,
		        nowrap: false,
		        singleSelect: true,
		        fitColumns: true,
		        pagination: true,
		        striped: true,
		        fit:true,
		        autoSave:true,
		        idField: "id",            
		        columns: [[
		            {field: 'id', title: 'ID', width: 30, sortable: true},
		            {field: 'head', title: '头像', width: 30, sortable: true,
		            	formatter:function(value, row, index){
							var img = "<img style='max-width:50px;' src='<%=basePath%>/images/headImages/"+value+"' />"
		            		return img;
	               		},
		            	editor:{
		            		type:'textbox',
		            		options: { required: true }
		            	}
		            },
		            {field: 'username', title: '用户名称', width: 50, align: 'left', sortable: true,
		                editor:{
		                    type:'textbox',
		                    options: { required:true }
		                }
		            },
		            {field: 'nickname', title: '用户昵称', width: 50, align: 'left', sortable: true,
		            	editor:{
		            		type:'textbox',
		            		options: { required: true }
		            	}
		            },
		            {field: 'experience', title: '经验', width: 50, sortable: true,
		            	formatter:function(value, row, index){
		 					var money = "<div style='float:left;line-height:30px;' width='30px' height='20px'>"+value+"</div>"+
		 						"<img style='margin-left:10px;' width='30px' src='<%=basePath%>/images/experience.png' />";
	               			return money;
	               		},
		            	editor:{
		            		type:'numberbox',
		            		options: { required: true }
		            	}
		            },
		            {field: 'integral', title: '积分', width: 50, sortable: true,
		            	formatter:function(value, row, index){
		 					var money = "<div style='float:left;line-height:30px;' width='30px' height='20px'>"+value+"</div>"+
		 						"<img style='margin-left:10px;' width='30px' src='<%=basePath%>/images/integral.png' />";
	               			return money;
	               		},
		                editor:{
		                    type:'numberbox',
		                    options:{editable:true}
		             	}
		 			},
		            {field: 'money', title: '金币', width: 50, sortable: true,
		 				formatter:function(value, row, index){
		 					var money = "<div style='float:left;line-height:30px;' width='30px' height='20px'>"+value+"</div>"+
		 						"<img style='margin-left:10px;' width='30px' src='<%=basePath%>/images/money.png' />";
	               			return money;
	               		},
		                editor:{
		                    type:'numberbox',
		                    options:{editable:true}
		             	}
		 			},
		 			{field: 'operate', title: '操作', width: 50,align:'center',
		 				formatter:function(value, row, index){
	               			var str = "<button style='margin-left:10px' onClick='openDialog("+index+")'>上传头像</button>"+
	               						"<button style='margin-left:10px' onClick=\"javascript:grid.edatagrid('saveRow')\">保存数据</button>";
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
		        	if(row.code == 2){
		        		freshUserInfo(row.data.newUserInf)
		        	}
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
		    $('#upLoadInput').filebox({
                buttonText: '选择文件'
            })
		}); 
	    function doSearch(){
	        grid.datagrid("load",{
	            username: $("#genderSearch").val()
	        });
	    }
	    function openDialog(index){
	    	currentRow = index;
	    	$("#upLoadDialog").dialog("open");
	    }
	    function upLoadImg(){
	    	var image_id= $("input[name='filePathName']").attr("id");
	    	$.ajaxFileUpload(
    			{
	    			url:'<%=basePath %>file/saveHeadImg',
	                secureuri:false,
	                dataType: 'json',
	                fileElementId: image_id,
	                type: 'post',
	                success:function(inf){
	                	$("#upLoadDialog").dialog("close");
	                	$("#grid").datagrid("beginEdit",currentRow);
	                	var ed = $('#grid').datagrid('getEditor', {index:currentRow,field:'head'});
	                	$(ed.target).textbox('setValue', inf.data.fileName);
	                	$("#grid").datagrid("endEdit",currentRow);
	                	$('#upLoadInput').val("");
	                },
	                error:function(err){
	                	$.messager.show({
		                    title: "消息",
		                    msg: err.msg
		                });
	                }
	         	}
	    	)
	    }
	</script>
</body>
</html>
