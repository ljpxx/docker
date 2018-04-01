package com.dao;

import java.util.List;

import org.hibernate.*;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.domain.Resource;
import com.utils.HibernateUtil;

public class Resourcedaoimpl extends HibernateDaoSupport implements Resourcedao{

	@Override
	public void save(Resource resource) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().save(resource);
	}

	@Override
	public Resource findById(String id) {
		// TODO Auto-generated method stub
		Resource resource=(Resource)this.getHibernateTemplate().get(Resource.class, id);
		return resource;
	}

	@Override
	public List<Resource> findByUserId(String userid) {
		// TODO Auto-generated method stub
		String queryString = "from Resource r where r.userid=?";
		List<Resource> list =this.getHibernateTemplate().find(queryString,userid);
		return list;
	}

	@Override
	public List<Resource> findCurrentPage(String userid, int currentindex,String searchtype,String searchword,String result) {
		// TODO Auto-generated method stub
		
		DetachedCriteria criteria = DetachedCriteria.forClass(Resource.class); 
		if(userid!=null) {
			criteria.add(Restrictions.eq("userid", userid));
		}
		if(!searchtype.equals("")) {
			criteria.add(Restrictions.like(searchtype, "%"+searchword+"%"));
		}
		if(result!=null) {
			criteria.add(Restrictions.eq("result", result));
		}
		List<Resource> list = this.getHibernateTemplate().findByCriteria(criteria, currentindex, 10);
//		String queryString = "from Resource r where r.userid=? limit "+currentindex+",10";
//		List<Resource> list = null;
//		try{
//			list =this.getHibernateTemplate().find(queryString,userid);
//		}catch(Exception e){
//			System.out.println(e);
//		}
		return list;
	}

	@Override
	public List<Resource> findByMySubmit(String userid, String searchtype,String searchword,String result) {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(Resource.class); 
		if(userid!=null) {
			criteria.add(Restrictions.eq("userid", userid));
		}
		if(!searchtype.equals("")) {
			criteria.add(Restrictions.like(searchtype, "%"+searchword+"%"));
		}
		if(result!=null) {
			criteria.add(Restrictions.eq("result", result));
		}
		List<Resource> list = this.getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

	@Override
	public void update(Resource resource) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().update(resource);
	}

	@Override
	public void delete(String id) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(findById(id));
	}

	@Override
	public List<Resource> findByresult() {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(Resource.class); 
		criteria.add(Restrictions.eq("result", "“—Ã·Ωª"));
		List<Resource> list = this.getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

}
