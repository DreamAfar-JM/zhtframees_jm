<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/resources/meta/taglib.jsp" %>
<%@ include file="/resources/meta/meta.jsp" %>
<%@ include file="/resources/meta/jquery.jsp" %>
<%@ include file="/resources/meta/easyui.jsp" %>
<%@ include file="/resources/meta/easyui-selfdefine.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
</head>
<body style="overflow: hidden;">
<div id="queryFormDiv" class="easyui-panel" style="margin:1px;padding:0px;width:100%; overflow-x:sroll;overflow-y:hidden; " >
	<form name="searchform" method="post" action="" id ="searchform">
<table class="easyuiqueryform" id="easyuiqueryform">
	<tr>
		<th>用户名:</th>
	<td><input type="text"  name="webParams[name]"    class="easyui-textbox validatebox"  /></td>
	<th>性别:</th>
	<td>	<select  name="webParams[sex]"  class="easyui-combobox" style="width: 170px;">
	<option value="">------------请选择-----------</option>	<option value="1" <c:if test="${duser.sex eq '1' }">selected='selected' </c:if> >男</option>	<option value="0" <c:if test="${duser.sex eq '0' }">selected='selected' </c:if> >女</option>	</select>	</td>
	<th>住址:</th>
	<td><input type="text"  name="webParams[address]"    class="easyui-textbox validatebox"  /></td>
	</tr>	
	<tr>
	<td><zht:authButton text="查询" onclick="reload('load');;" iconCls="icon-search" /></td>
	</tr>
</table>
  	</form>
</div>

<table id="duserDataGrid" style="margin-bottom: 0px;vertical-align: bottom;" ></table>

<div id="toolbarDiv" class="easyui-toolbar" style="padding:4px;height:auto">
<zht:authButton text="添 加" onclick="openAddDialog();" iconCls="icon-add" />
<zht:authButton text="编 辑" onclick="openeditDialog();" iconCls="icon-edit" />
<zht:authButton text="删 除" onclick="doDelete();" iconCls="icon-remove" />
</div>
<!----------------------------------------------------->
<script>
$(function(){
	var h1=$(this).height();
	var loadurl="${ctx}//common/demo/duser/loadDuserGridView";
   $("#duserDataGrid").datagrid({
				title:"",
				width:'100%',
				height:(h1-(($("#easyuiqueryformTable").height()+$("#queryDivButton").height()))-28 ),
				nowrap: true,//设置为true，当数据长度超出列宽时将会自动截取
				rownumbers: true,
				fitColumns: false,//滚动条
				animate:true,
				collapsible:true,//显示可折叠按钮
				striped:true,//设置为true将交替显示行背景。
				singleSelect:false,//为true时只能选择单行
				pagination : true,//分页
				rownumbers : true,//行数
				pageSize: 10,
				pageList: [10, 20, 50, 100, 200, 500],
				queryParams: ZHTPUBUtil.form2Json($("#searchform").serializeArray()),
				url:loadurl,
				checkbox:true,
				idField:'id',
				toolbar:"#toolbarDiv",
				columns:[[
				{field:'id',width:20,checkbox:true},
					{field:'name',title:'用户名',width:100,},
					{field:'sex',title:'性别',width:50,formatter: function(value,row){
  if('1'==value){
   return '男'; 
  }else if('0'==value){
   return '女'; 
  }
 }},
					{field:'mobile',title:'联系方式',width:150,},
					{field:'address',title:'住址',width:200,},
				]], onBeforeLoad:function(){ 
					//去掉分页后之前页仍选中 选中
		        	$(this).datagrid("clearSelections");
				},loadFilter:function(data,parentId){
					return ZHT.ajaxDoneForServerError(data);
				}
			});
});

 
function reload(reload) {  
	var queryParams =$("#duserDataGrid").datagrid("options").queryParams;
	ZHTEASYUtil.genQueryParams(queryParams, $("#searchform").form().serializeArray());
	$("#duserDataGrid").datagrid(reload);
	$("#duserDataGrid").datagrid("clearSelections");
}
function openAddDialog(){
	var url="${ctx}//common/demo/duser/enterAddDuser";
	var options={title:"添加",width:'600',height:'400', url:url,onClosed:function(){reload('reload');}};
	editDialog.open(options);
}
function openeditDialog(){
	 var rows = $("#duserDataGrid").datagrid("getSelections");
	 if(rows.length == 0){
		alertMsg.warn("请选择要编辑的数据");return;
	 }
	 if(rows.length>1){
		alertMsg.warn("请选择一条数据");return;
	}
   var url="${ctx}//common/demo/duser/enterUpdateDuser";
   var params={id:rows[0].id};
   var options={title:"编辑",width:600,height:400, url:url,params:params,onClosed:function(){reload('reload');}};
   editDialog.open(options);
}
function doDelete() {
	var rows = $("#duserDataGrid").datagrid("getSelections");
	if (rows.length == 0) {
		alertMsg.warn("请选择要删除的数据");
		return;
	}
	var idArray =ZHTEASYUtil.selectRowsToArray(rows);
	alertMsg.confirm("确定要删除该数据？", {
		cancelCall : function() {alertMsg.close();},
		okCall : function() {alertMsg.close();
				var ajaxUrl = "${ctx}//common/demo/duser/simpleBatchDeleteDuser";
				var param = {"ids" : idArray};
				ZHTAJAX.ajaxTodo(ajaxUrl, param, function(data) {
					ZHT.ajaxDone(data);
					reload('reload');
				});
			}
		});
}
</script>
</body>
</html>