package com.zht.common.demo.web;

import javax.validation.Valid;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zht.framework.web.controller.BaseController;
import org.zht.framework.web.utils.FastjsonUtil;
import org.zht.framework.data.ParamObject;
import org.zht.framework.data.ParamItem;
import org.zht.framework.data.DataSet;
import org.zht.framework.data.RowMap;
import org.zht.framework.data.Querylogic;
import com.zht.common.demo.model.Duser;
import com.zht.common.demo.service.IDuserService;
@Controller 
@RequestMapping("/common/demo/duser")
public class DuserController extends BaseController {

	private String jspPrefix="/common/demo/duser/";
	@Autowired
	private IDuserService duserService;
/*--------------------------------------------------------------------------------*/ 	
	@RequiresPermissions("Duser:enterDuserPage")
	@RequestMapping(value="/enterDuserPage")
	public String enterDuserPage() throws Exception {
		return jspPrefix+"duserDataGrid";	
	}
/*--------------------------------------------------------------------------------*/  	
	
	private static final  RowMap rowMap=new RowMap( 
	"name","name",
	"sex","sex",
	"mobile","mobile",
	"address","address",
	"id","id");
/*--------------------------------------------------------------------------------*/  		
	@RequiresPermissions("Duser:loadDuserGridView")
    @RequestMapping(value="/loadDuserGridView")
    @ResponseBody 
    public Object loadDuserGridView(@ModelAttribute("paramObject") ParamObject paramObject){
    
		paramObject.addParamItem("key_name", new ParamItem("name","%??%",paramObject.getReqParam("name"),"LIKE"));
		paramObject.addParamItem("key_sex", new ParamItem("sex",paramObject.getReqParam("sex"),"="));
		paramObject.addParamItem("key_address", new ParamItem("address","%??%",paramObject.getReqParam("address"),"LIKE"));
		
	    DataSet grid= duserService.$base_loadDataSetFromOneEntity(paramObject, rowMap);
	    return FastjsonUtil.convert(grid);
    }
/*--------------------------------Detail------------------------------------------------*/  
	@RequiresPermissions("Duser:enterDuserDetail")
	@RequestMapping(value="/enterDuserDetail")
	public String enterDuserDetail(Model model , Long id) throws Exception {	
		Duser duser=duserService.$base_find(id);
		setDataAttribute(model,duser,"duser");
		return jspPrefix+"duserDetail";
	}	
/*-------------------------Add-------------------------------------------------------*/   	
	@RequiresPermissions("Duser:enterAddDuser")
	@RequestMapping(value="/enterAddDuser")
	public String enterAddDuser() throws Exception {	
		return jspPrefix+"duserAdd";
	}	   
	@RequiresPermissions("Duser:addDuser")
    @ResponseBody
    @RequestMapping(value="/addDuser") 
    public Object addDuser(@Valid @ModelAttribute("duser")Duser duser,BindingResult bindingResult){
    	processValidateResult(bindingResult);
    	duserService.$base_save(duser);
    	return ajaxDoneSuccess("数据添加成功 ");
    }
    
/*---------------------------Update-----------------------------------------------------*/    
	@RequiresPermissions("Duser:enterUpdateDuser")
	@RequestMapping(value="/enterUpdateDuser") 
 	public String enterUpdateDuser(Model model , Long id) throws Exception {
		Duser duser=duserService.$base_find(id);
		setDataAttribute(model,duser,"duser");
		return jspPrefix+"duserUpdate";
	}       
	@RequiresPermissions("Duser:updateDuser")
    @ResponseBody
    @RequestMapping(value="/updateDuser") 
    public Object updateDuser(@Valid @ModelAttribute("duser")Duser duser,BindingResult bindingResult) throws Exception{
    	processValidateResult(bindingResult);
    	duserService.$base_update(duser);
    	return ajaxDoneSuccess("数据修改成功 ");
    }
/*------------------------------simpleDelete--------------------------------------------------*/    
	@RequiresPermissions("Duser:simpleDeleteDuser")
	@ResponseBody 
	@RequestMapping(value="/simpleDeleteDuser")
    public Object simpleDeleteDuser(Long id) throws Exception {
    	duserService.$base_delete$Just(id);
    	return ajaxDoneSuccess("数据删除成功 ");
    }
    @RequiresPermissions("Duser:simpleBatchDeleteDuser")
	@ResponseBody 
	@RequestMapping(value="/simpleBatchDeleteDuser")
    public Object simpleBatchDeleteRbacUserSession(Long[] ids) throws Exception {
    	duserService.$base_deleteByIdsInCase$Just(ids);
    	return ajaxDoneSuccess("数据删除成功 ");
    }
    
/*-------------------------------------------------------------------------------------------------------*/
}
