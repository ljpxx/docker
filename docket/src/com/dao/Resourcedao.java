package com.dao;

import java.util.List;

import com.domain.Resource;

public interface Resourcedao {
	void save(Resource resource);
	Resource findById(String id);
	List<Resource> findByUserId(String userid);
	List<Resource> findCurrentPage(String userid,int currentindex,String searchtype,String searchword,String result);
	List<Resource> findByMySubmit(String userid,String searchtype,String searchword,String result);
	void update(Resource resource);
	void delete(String id);
	List<Resource> findByresult();
}
