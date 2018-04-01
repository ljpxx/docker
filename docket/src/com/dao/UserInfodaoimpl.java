package com.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.domain.Resource;
import com.domain.User;
import com.domain.User_info;

public class UserInfodaoimpl extends HibernateDaoSupport implements UserInfoDao{

	@Override
	public void save(User_info user_info) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().save(user_info);
	}

	@Override
	public User_info findById(String id) {
		// TODO Auto-generated method stub
		User_info user_info=(User_info)this.getHibernateTemplate().get(User_info.class, id);
		return user_info;
		
	}

	@Override
	public void update(User_info user_info) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().update(user_info);
	}

	@Override
	public List<User_info> findall(String userid, String searchtype, String searchword, String result) {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(User_info.class); 
		if(userid!=null) {
			criteria.add(Restrictions.eq("userid", userid));
		}
		if(!searchtype.equals("")) {
			criteria.add(Restrictions.like(searchtype, "%"+searchword+"%"));
		}
		if(result!=null) {
			criteria.add(Restrictions.eq("result", result));
		}
		criteria.add(Restrictions.or(Restrictions.eq("type", "1"), Restrictions.eq("type", "2")));
		List<User_info> list = this.getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

	@Override
	public List<User_info> findCurrentPage(String userid, int currentindex, String searchtype, String searchword,
			String result) {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(User_info.class); 
		if(userid!=null) {
			criteria.add(Restrictions.eq("userid", userid));
		}
		if(!searchtype.equals("")) {
			criteria.add(Restrictions.like(searchtype, "%"+searchword+"%"));
		}
		if(result!=null) {
			criteria.add(Restrictions.eq("result", result));
		}
		criteria.add(Restrictions.or(Restrictions.eq("type", "1"), Restrictions.eq("type", "2")));
		List<User_info> list = this.getHibernateTemplate().findByCriteria(criteria, currentindex, 10);

		return list;
	}

	

}
