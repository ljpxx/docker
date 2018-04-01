package com.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dao.Resourcedao;
import com.dao.UserInfoDao;
import com.dao.Userdao;
import com.domain.Resource;
import com.domain.User;
import com.domain.User_info;
import com.opensymphony.xwork2.ActionSupport;
import com.utils.RanDom;

import net.sf.json.JSONObject;

public class ResourceAction  extends ActionSupport{
	String nickname;
	String telphone;
	String number;
	String email;
	String userid;
	String title;
	String original;
	Date starttime;
	Date endtime;
	String system;
	String software;
	String applicantnote;
	int currentpage;
	String searchtype;
	String searchkeyword;
	String id;
	String result1;
	String opinion;
	String managernote;
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getTelphone() {
		return telphone;
	}
	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getOriginal() {
		return original;
	}
	public void setOriginal(String original) {
		this.original = original;
	}
	public Date getStarttime() {
		return starttime;
	}
	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	public Date getEndtime() {
		return endtime;
	}
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	public String getSystem() {
		return system;
	}
	public void setSystem(String system) {
		this.system = system;
	}
	public String getSoftware() {
		return software;
	}
	public void setSoftware(String software) {
		this.software = software;
	}
	public String getApplicantnote() {
		return applicantnote;
	}
	public void setApplicantnote(String applicantnote) {
		this.applicantnote = applicantnote;
	}
	public int getCurrentpage() {
		return currentpage;
	}
	public void setCurrentpage(int currentpage) {
		this.currentpage = currentpage;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getResult1() {
		return result1;
	}
	public void setResult1(String result1) {
		this.result1 = result1;
	}
	public String getOpinion() {
		return opinion;
	}
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	public String getManagernote() {
		return managernote;
	}
	public void setManagernote(String managernote) {
		this.managernote = managernote;
	}



	private String result;
	private Resourcedao resourcedao;
	private UserInfoDao userDAOinfo;
	
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public Resourcedao getResourcedao() {
		return resourcedao;
	}
	public void setResourcedao(Resourcedao resourcedao) {
		this.resourcedao = resourcedao;
	}
	public UserInfoDao getUserDAOinfo() {
		return userDAOinfo;
	}
	public void setUserDAOinfo(UserInfoDao userDAOinfo) {
		this.userDAOinfo = userDAOinfo;
	}
	public String execute() {
		return SUCCESS;
	}
	public String submit(){  
		Map<String,Object> map = new HashMap<String,Object>();
		
		Resource resource = new Resource();
		String str ;
		boolean t=true;
		do{
			str = RanDom.getRandom_18();
			Resource resource_index = resourcedao.findById(str);
			if(resource_index==null) {
				t=false;
			}else {
				t=true;
			}
		} while (t);
		
		resource.setId(str);
		resource.setNickname(nickname);
		resource.setTelphone(telphone);
		resource.setEmail(email);
		resource.setNumber(number);
		resource.setUserid(userid);
		resource.setTitle(title);
		resource.setOriginal(original);
		resource.setStarttime(starttime);
		resource.setEndtime(endtime);
		resource.setSystem(system);
		resource.setSoftware(software);
		resource.setApplicantnote(applicantnote);
		resource.setOpinion("");
		resource.setManagernote("");
		java.util.Date  date=new java.util.Date();
		java.sql.Date  data1=new java.sql.Date(date.getTime());
		resource.setCreatetime(data1);
		resource.setLastedittime(data1);
		resource.setManagerid("");
		resource.setResult("已提交");
		
		resourcedao.save(resource);
		map.put("result", 1);
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
    }
	public String my_sumbit(){  
		Map<String,Object> map = new HashMap<String,Object>();
		List<Map<String,Object>> map_list=new ArrayList<Map<String, Object>>();
		Map<String,Object> map_index;
		List<Resource> alllist = resourcedao.findByMySubmit(userid, searchtype, searchkeyword,result1);
		if(alllist==null) {
			map.put("result", 0);
		}else {
			map.put("result", 1);
			//总数
			int allpage=(alllist.size()/10)+1;
			map.put("allpage", allpage);
			List<Resource> resourcelist = resourcedao.findCurrentPage(userid, currentpage*10,searchtype, searchkeyword,result1);
			Resource resource;
			for(int i=0;i<resourcelist.size();i++) {
				resource=resourcelist.get(i);
				map_index = new HashMap<String,Object>();
				map_index.put("id", resource.getId());
				map_index.put("title", resource.getTitle());
				map_index.put("managername", resource.getManagername());
				map_index.put("nickname", resource.getNickname());
				map_index.put("result", resource.getResult());
				map_list.add(map_index);
			}
			map.put("map_list", map_list);
			map.put("currentnum", resourcelist.size());
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";
	}
	
	public String getdetail(){  
		Map<String,Object> map = new HashMap<String,Object>();
		Resource resource = resourcedao.findById(id);
		if(resource==null) {
			map.put("result", 0);
		}else {
			map.put("result", 1);
			map.put("nickname", resource.getNickname());
			map.put("telphone", resource.getTelphone());
			map.put("email", resource.getEmail());
			map.put("number", resource.getNumber());
			map.put("title", resource.getTitle());
			map.put("original", resource.getOriginal());
			String sdate1=(new SimpleDateFormat("yyyy-MM-dd")).format(resource.getStarttime());
			map.put("starttime", sdate1);
			String sdate2=(new SimpleDateFormat("yyyy-MM-dd")).format(resource.getEndtime());
			map.put("endtime", sdate2);
			map.put("system", resource.getSystem());
			map.put("software", resource.getSoftware());
			map.put("applicantnote", resource.getApplicantnote());
			map.put("opinion", resource.getOpinion());
			map.put("managernote", resource.getManagernote());
			map.put("result1", resource.getResult());
		}
		result = JSONObject.fromObject(map).toString();
		return "ajax";
	}
	
	public String edit_save(){  
		Map<String,Object> map = new HashMap<String,Object>();
		
		Resource resource = resourcedao.findById(id);
		
		resource.setNickname(nickname);
		resource.setTelphone(telphone);
		resource.setEmail(email);
		resource.setNumber(number);
		resource.setTitle(title);
		resource.setOriginal(original);
		resource.setStarttime(starttime);
		resource.setEndtime(endtime);
		resource.setSystem(system);
		resource.setSoftware(software);
		resource.setApplicantnote(applicantnote);
		
		java.util.Date  date=new java.util.Date();
		java.sql.Date  data1=new java.sql.Date(date.getTime());
		resource.setLastedittime(data1);
		resource.setResult("已提交");
		resource.setOpinion("");
		resource.setManagernote("");
		
		resourcedao.update(resource);
		map.put("result", 1);
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
    }
	
	public String delete(){  
		Map<String,Object> map = new HashMap<String,Object>();
		
		Resource resource = resourcedao.findById(id);
		if(resource!=null) {
			resourcedao.delete(id);
			map.put("result", 1);
		}else {
			map.put("result", 0);
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
    }
	
	public String manageresult(){  
		Map<String,Object> map = new HashMap<String,Object>();
		
		Resource resource = resourcedao.findById(id);
		if(resource!=null) {
			resource.setManagerid(userid);
			User_info user_info = userDAOinfo.findById(userid);
			resource.setManagername(user_info.getNickname());
			resource.setResult(result1);
			resource.setOpinion(opinion);
			resource.setManagernote(managernote);
			java.util.Date  date=new java.util.Date();
			java.sql.Date  data1=new java.sql.Date(date.getTime());
			resource.setResulttime(data1);
			resourcedao.update(resource);
			map.put("result", 1);
		}else {
			map.put("result", 0);
		}
		
		result = JSONObject.fromObject(map).toString();
		return "ajax";  
    }
	
	
}
