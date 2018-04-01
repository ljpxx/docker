package com.dao;

import java.util.List;

import org.hibernate.*;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.domain.User;
import com.utils.HibernateUtil;

public class Userdaoimpl extends HibernateDaoSupport implements Userdao{

	@Override
	public void save(User user) {
		this.getHibernateTemplate().save(user);
	}

	@Override
	public User findById(String id) {
		// TODO Auto-generated method stub
		User user=(User)this.getHibernateTemplate().get(User.class, id);
		return user;
	}

	@Override
	public User findbyusername(String name) {
		// TODO Auto-generated method stub
		String hsql="from User u where u.name ='"+name+"'";
		List<User> result = this.getHibernateTemplate().find(hsql);
		if(result.size()==0) {
			return null;
		}
		return result.get(0);
	}

	@Override
	public void delete(String id) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(findById(id));
	}

	@Override
	public void update(User user) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().update(user);
	}

	@Override
	public List<User> findAll() {
		// TODO Auto-generated method stub
		String queryString = "from User";
		List<User> list =this.getHibernateTemplate().find(queryString);
		return list;
	}

	@Override
	public User savefindsame(String id, String name) {
		// TODO Auto-generated method stub
		String hsql="from User u where u.name ='"+name+"'";
		List<User> result = this.getHibernateTemplate().find(hsql);
		if(result.size()==0) {
			return null;
		}
		User user = result.get(0);
		if(user.getId().equals(id)) {
			return null;
		}else {
			return user;
		}
		//return result.get(0);
	}


	
}
