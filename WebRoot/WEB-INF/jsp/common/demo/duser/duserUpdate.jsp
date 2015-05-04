<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/resources/meta/taglib.jsp" %>
<script type="text/javascript">
	function doSubmit(){
		if(!ZHTAJAX.validateFromCallback($("#formss"),ZHT.ajaxDoneAndCloseDialog)){
			alertMsg.info("请确认校验不通过数据");
		}
	}
	function cancel(){
		editDialog.close(100);
	}
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false ," title="" style="overflow: hidden;padding: 10px;">
		<form id="formss" method="post" action="${ctx}/common/demo/duser/updateDuser">
			<input type="hidden" name="id" value="${duser.id}" />
			<fieldset>
				<legend><img src="resources/images/fromedit.png" style="margin-bottom: -3px;"/>测试用例1添加</legend>
				 <table>
					<tr>
						<th>用户名:</th>
						<td><input type="text" name="name" value="${duser.name}" class="easyui-textbox validatebox"  data-options="  validType:'length[0,50]'"/></td>
						<th>性别:</th>
						<td>	<select  name="sex" class="easyui-combobox" style="width: 170px;" >	<option value="1" <c:if test="${duser.sex eq '1' }">selected='selected' </c:if> >男</option>	<option value="0" <c:if test="${duser.sex eq '0' }">selected='selected' </c:if> >女</option>	</select>	</td>
						<th>联系方式:</th>
						<td><input type="text" name="mobile" value="${duser.mobile}" class="easyui-textbox validatebox"  data-options="  validType:'mobile'"/></td>
					</tr>
					<tr>
						<th>住址:</th>
						<td><input type="text" name="address" value="${duser.address}" class="easyui-textbox validatebox"  data-options="  validType:'length[0,200]'"/></td>
				 	</tr>
				 </table>
			</fieldset>
			<div style="position: absolute;bottom: 5px;right: 10px;"  >
				<zht:authButton text="保存" onclick="doSubmit();" iconCls="icon-ok" />
				<zht:authButton text="取消" onclick="cancel();" iconCls="icon-cancel" />
			</div>
			
		</form>
	</div>
</div>