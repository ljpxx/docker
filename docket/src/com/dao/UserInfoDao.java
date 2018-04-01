package com.dao;

import java.util.List;

import com.domain.User;
import com.domain.User_info;

public interface UserInfoDao {
	void save(User_info user_info);
	User_info findById(String id);
	void update(User_info user_info);
	List<User_info> findall(String userid,String searchtype,String searchword,String result);
	List<User_info> findCurrentPage(String userid,int currentindex,String searchtype,String searchword,String result);
}
