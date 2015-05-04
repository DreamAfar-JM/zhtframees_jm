package com.zht.common.demo.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import com.zht.common.demo.service.IDuserService;
import org.zht.framework.service.impl.BaseServiceImpl;
import com.zht.common.demo.dao.IDuserDao;
import com.zht.common.demo.model.Duser;

@Service
@Transactional(rollbackFor=Exception.class)
public class DuserServiceImpl extends BaseServiceImpl<Duser> implements IDuserService{
 	@Autowired
	private IDuserDao duserDao;
	
 
}