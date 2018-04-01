package com.action;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.domain.User;
import com.opensymphony.xwork2.ActionSupport;
import com.utils.RanDom;

import net.sf.json.JSONObject;

import com.dao.Userdao;

public class LoginAction extends ActionSupport{
	String username;
	String password;
	String usertype;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	
	
	private Userdao userDAO;
	private String result;	
	
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	
	public void setUserDAO(Userdao userDAO) {
		this.userDAO = userDAO;
	}
	
	
	public String execute() {
		return SUCCESS;
	}
	
	public String f(){  
		Map<String,Object> map = new HashMap<String,Object>();
		List<User> list = userDAO.findAll();
		
		User u=new User();
		Iterator<User> it=list.iterator();
		while(it.hasNext()) {
			u=(User)it.next();
			if(username.trim().equals(u.getName())&&password.trim().equals(u.getPassword())&&usertype.trim().equals(u.getType())) {
				map.put("result", 1);  //用户存在，可登陆
				map.put("userid", u.getId());  //用户存在，可登陆
				break;
				//return "success";
			}else {
				map.put("result", 0);  //用户不存在
			}
		}
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
    }  
	
}
