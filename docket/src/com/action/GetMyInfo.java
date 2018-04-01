package com.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.dao.Resourcedao;
import com.dao.UserInfoDao;
import com.dao.Userdao;
import com.domain.Resource;
import com.domain.User;
import com.domain.User_info;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONObject;

public class GetMyInfo extends ActionSupport{
	String userid;
	String nickname;
	String number;
	String telphone;
	String email;
	String address;
	String searchtype;
	String searchkeyword;
	int currentpage;

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getTelphone() {
		return telphone;
	}

	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSearchtype() {
		return searchtype;
	}

	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}

	public String getSearchkeyword() {
		return searchkeyword;
	}

	public void setSearchkeyword(String searchkeyword) {
		this.searchkeyword = searchkeyword;
	}
	public int getCurrentpage() {
		return currentpage;
	}

	public void setCurrentpage(int currentpage) {
		this.currentpage = currentpage;
	}

	public String execute() {
		return SUCCESS;
	}
	private UserInfoDao userDAOinfo;
	private Resourcedao resourcedao;
	private Userdao userDAO;
	private String result;
	
	
	
	public Userdao getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(Userdao userDAO) {
		this.userDAO = userDAO;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public UserInfoDao getUserDAOinfo() {
		return userDAOinfo;
	}

	public void setUserDAOinfo(UserInfoDao userDAOinfo) {
		this.userDAOinfo = userDAOinfo;
	}
	public Resourcedao getResourcedao() {
		return resourcedao;
	}

	public void setResourcedao(Resourcedao resourcedao) {
		this.resourcedao = resourcedao;
	}

	public String f(){  
		Map<String,Object> map = new HashMap<String,Object>();
		
		User_info user_info = userDAOinfo.findById(userid);
		
		if(user_info!=null) {
			map.put("result", 1);
			map.put("telphone", user_info.getTelphone());
			map.put("nickname", user_info.getNickname());
			map.put("email", user_info.getEmail());
			map.put("number", user_info.getNumber());
			map.put("address", user_info.getAddress());
			String sdate1=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(user_info.getCreatetime());
			map.put("createtime", sdate1);
			String sdate2=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(user_info.getLastedittime());
			map.put("lastedittime", sdate2);
		}else {
			map.put("result", 0);
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
    }  
	
	public String save(){  
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		User user = userDAO.savefindsame(userid, telphone);
		if(user != null) {
			map.put("result", 0);
		}else {
			User user1 = userDAO.findById(userid);
			user1.setName(telphone);
			userDAO.update(user1);
			User_info user_info = userDAOinfo.findById(userid);
			
			if(user_info!=null) {
				user_info.setNickname(nickname);
				user_info.setNumber(number);
				user_info.setTelphone(telphone);
				user_info.setEmail(email);
				user_info.setAddress(address);
				java.util.Date  date=new java.util.Date();
				java.sql.Date  data1=new java.sql.Date(date.getTime());
				user_info.setLastedittime(data1);
				userDAOinfo.update(user_info);
				map.put("result", 1);
				String sdate2=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(data1);
				map.put("lastedittime", sdate2);
				
			}else {
				map.put("result", 0);
			}
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
    }
	
	public String getnickname(){  
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		User_info user_info = userDAOinfo.findById(userid);
		if(user_info != null) {
			map.put("result", 1);
			User user = userDAO.findById(userid);
			List<Resource> alllist = resourcedao.findByresult();
			map.put("nickname", user_info.getNickname());
			map.put("usertype", user.getType());
			map.put("resultnum", alllist.size());
			map.put("email", user_info.getEmail());
		}else {
			map.put("result", 0);
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
    } 
	
	public String getalluser(){  
		Map<String,Object> map = new HashMap<String,Object>();
		List<Map<String,Object>> map_list=new ArrayList<Map<String, Object>>();
		Map<String,Object> map_index;
		List<User_info> alllist = userDAOinfo.findall(null, searchtype, searchkeyword,null);
		if(alllist==null) {
			map.put("result", 0);
		}else {
			map.put("result", 1);
			//×ÜÊý
			int allpage=(alllist.size()/10)+1;
			map.put("allpage", allpage);
			List<User_info> userinfolist = userDAOinfo.findCurrentPage(null, currentpage*10,searchtype, searchkeyword,null);
			User_info user_info;
			for(int i=0;i<userinfolist.size();i++) {
				user_info=userinfolist.get(i);
				map_index = new HashMap<String,Object>();
				map_index.put("id", user_info.getUser_id());
				map_index.put("nickname", user_info.getNickname());
				map_index.put("telphone", user_info.getTelphone());
				User user = userDAO.findById(user_info.getUser_id());
				map_index.put("type", user.getType());
				map_list.add(map_index);
			}
			map.put("map_list", map_list);
			map.put("currentnum", userinfolist.size());
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";
	}
	
	public String manager(){  
		Map<String,Object> map = new HashMap<String,Object>();
		
		User_info user_info = userDAOinfo.findById(userid);
		if(user_info != null) {
			map.put("result", 1);
			user_info.setType("2");
			userDAOinfo.update(user_info);
			User user = userDAO.findById(userid);
			user.setType("2");
			userDAO.update(user);
		}else {
			map.put("result", 0);
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
	}
	
	public String delmanager(){  
		Map<String,Object> map = new HashMap<String,Object>();
		
		User_info user_info = userDAOinfo.findById(userid);
		if(user_info != null) {
			map.put("result", 1);
			user_info.setType("1");
			userDAOinfo.update(user_info);
			User user = userDAO.findById(userid);
			user.setType("1");
			userDAO.update(user);
		}else {
			map.put("result", 0);
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
	}
	
	public String getinfo(){  
		Map<String,Object> map = new HashMap<String,Object>();
		
		User_info user_info = userDAOinfo.findById(userid);
		if(user_info != null) {
			map.put("result", 1);
			map.put("nickname", user_info.getNickname());
			map.put("telphone", user_info.getTelphone());
			map.put("email", user_info.getEmail());
			map.put("number", user_info.getNumber());
		}else {
			map.put("result", 0);
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
	}
}
