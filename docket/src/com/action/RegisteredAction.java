package com.action;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.domain.User;
import com.domain.User_info;
import com.opensymphony.xwork2.ActionSupport;
import com.utils.RanDom;

import net.sf.json.JSONObject;

import com.dao.Userdao;
import com.dao.UserInfoDao;

public class RegisteredAction extends ActionSupport{
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
	private UserInfoDao userDAOinfo;
	private Map<String,Object> data = new HashMap<String,Object>();
	private String result;	
	
	public UserInfoDao getUserDAOinfo() {
		return userDAOinfo;
	}
	public void setUserDAOinfo(UserInfoDao userDAOinfo) {
		this.userDAOinfo = userDAOinfo;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }
	public void setUserDAO(Userdao userDAO) {
		this.userDAO = userDAO;
	}
	
	
	public String execute() {
		
		return SUCCESS;
	}
 
	public String f(){  
		Map<String,Object> map = new HashMap<String,Object>();  
        
        //System.out.println("接收到参数: "+username+password);
        User user = userDAO.findbyusername(username);
		if(user != null) {
			map.put("result", 0);  //用户已存在
		}else {
			User new_user= new User();
			User_info user_info = new User_info();
			String str ;
			boolean t=true;
			do{
				str = RanDom.getRandom();
				User user_index = userDAO.findById(str);
				if(user_index==null) {
					t=false;
				}else {
					t=true;
				}
			} while (t);
			
			new_user.setId(str);
			new_user.setName(username);
			new_user.setPassword(password);
			new_user.setType("1");
			userDAO.save(new_user);
			user_info.setUser_id(str);
			user_info.setNumber("");
			user_info.setTelphone(username);
			user_info.setNickname(username);
			user_info.setEmail("");
			user_info.setAddress("");
			java.util.Date  date=new java.util.Date();
			java.sql.Date  data1=new java.sql.Date(date.getTime());
			user_info.setCreatetime(data1);
			user_info.setLastedittime(data1);
			user_info.setType("1");
			userDAOinfo.save(user_info);
			map.put("result", 1);  //注册成功
		}
		
        result = JSONObject.fromObject(map).toString(); 
         
        return "ajax";  
    }  
	
}

