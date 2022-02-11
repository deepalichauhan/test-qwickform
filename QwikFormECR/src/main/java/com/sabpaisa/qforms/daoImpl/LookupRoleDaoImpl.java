package com.sabpaisa.qforms.daoImpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.LookupRoleBean;
import com.sabpaisa.qforms.dao.LookupRoleDao;

@Repository
public class LookupRoleDaoImpl implements LookupRoleDao{

	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("RoleDaoImpl.class");
	
	private Map<Integer, String> roleDisplayMap = new LinkedHashMap<Integer, String>();
	
	@Override
	public Map<Integer, String> getRoleMap() {
		log.info("Start of getcompanyList() in RoleDaoImpl" ); 
		
		try {
			String sql = "SELECT * FROM lookup_role";

		    List<LookupRoleBean> lookupRole = jdbcTemplate.query(sql, new LookupRoleMapper());

		    Iterator<LookupRoleBean> it=lookupRole.iterator();
			
			while (it.hasNext()) {
				LookupRoleBean roleBean = it.next();
				log.debug("Next field fetched is by name:: "+roleBean.getRoleName()+" and by id is:: "+roleBean.getRoleId());
				
				roleDisplayMap.put(roleBean.getRoleId(), roleBean.getRoleName());
			}
			
			return roleDisplayMap;
			
		    //return lookupRole;
			
		}catch(Exception e) {
			
		}
		return null;
	}
	
	class LookupRoleMapper implements RowMapper<LookupRoleBean> {

		  public LookupRoleBean mapRow(ResultSet rs, int arg1) throws SQLException {

			  LookupRoleBean lBean = new LookupRoleBean();

			  lBean.setRoleId(rs.getInt("roleId"));
			  lBean.setRoleName(rs.getString("roleName"));
		   
		    return lBean;

		  }
	}

	@Override
	public List<LookupRoleBean> getRoleList() {
		// TODO Auto-generated method stub
		return null;
	}

}
