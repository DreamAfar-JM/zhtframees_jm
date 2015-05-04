package com.zht.common.demo.model;
@javax.persistence.Entity()
@javax.persistence.Table(name = "demo_duser")
public class Duser extends org.zht.framework.zhtdao.identity.PKBaseEntity{

	private static final long serialVersionUID = 1L;
	
	public Duser() {}
	public Duser(Long id) {
		this.setId(id);
	}
	@org.hibernate.validator.constraints.Length(min=0,max=50)	@javax.persistence.Column(name = "name",unique = false,nullable = true,length = 50)
	private java.lang.String name;
	
	@org.hibernate.validator.constraints.Length(min=0,max=4)	@javax.persistence.Column(name = "sex",unique = false,nullable = true,length = 4)
	private java.lang.String sex;
	
	@org.hibernate.validator.constraints.Length(min=0,max=15)	@javax.persistence.Column(name = "mobile",unique = false,nullable = true,length = 15)
	private java.lang.String mobile;
	
	@org.hibernate.validator.constraints.Length(min=0,max=200)	@javax.persistence.Column(name = "address",unique = false,nullable = true,length = 200)
	private java.lang.String address;
	
	//<-------------------------------------------->
	public void setName(java.lang.String name){
		this.name=name;
	}
	public java.lang.String getName(){
		return this.name;
	}
	
	public void setSex(java.lang.String sex){
		this.sex=sex;
	}
	public java.lang.String getSex(){
		return this.sex;
	}
	
	public void setMobile(java.lang.String mobile){
		this.mobile=mobile;
	}
	public java.lang.String getMobile(){
		return this.mobile;
	}
	
	public void setAddress(java.lang.String address){
		this.address=address;
	}
	public java.lang.String getAddress(){
		return this.address;
	}
	
	

}
