package com.sabpaisa.qforms.daoImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.dao.UtilityTxnDao;
import com.sabpaisa.qforms.util.DBConnection;

@Repository
public class UtilityTxnDaoImpl implements UtilityTxnDao {

	@Autowired
	SessionFactory factory;

	@Autowired
	DataSource dataSource;

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("UtilityTxnDaoImpl.class");
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String dbName = properties.getProperty("dbName");
	DBConnection connection = new DBConnection();
	
	
//	@Override
//	public List<Map<String, Object>> fetchWACOEClientData(String PRNNum) {
//		
//		List<Map<String, Object>> mapForFindValues = null;
//		List<Object> list = new ArrayList<Object>();
//		String sqlQuery = "";
//		Boolean flag = false;
//		Session session = factory.openSession();
//		try {
////			sqlQuery = "select unique_Key," + columnNames + " from zz_"+clientCode+"_"+payerType+"_"+formTempId + " where " + fieldNames+ ";";
//			
//			sqlQuery = "SELECT t.transId,t.cid "+
//					"FROM zz_client_user_data_42 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.transStatus="+"'"+PRNNum+"'"
//					+" UNION "+
//					"SELECT t.transId,t.cid "+
//					"FROM zz_client_user_data_135 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.transStatus="+"'"+PRNNum+"'"
//					+" UNION "+
//					"SELECT t.transId,t.cid "+
//					"FROM zz_client_user_data_484 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.transStatus="+"'"+PRNNum+"'"
//					+" UNION "+
//					"SELECT t.transId,t.cid "+
//					"FROM zz_client_user_data_485 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.transStatus="+"'"+PRNNum+"'"
//					+" UNION "+
//					"SELECT t.transId,t.cid "+
//					"FROM zz_client_user_data_486 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.transStatus="+"'"+PRNNum+"'";
//					log.info("sqlQuery is : -> "+sqlQuery.toString());
//					
//					Query query = session.createSQLQuery(sqlQuery);
//
//					log.info("query is " + query);
//
//					query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//
//					log.info("query is " + query.list());
//
//					mapForFindValues = query.list();
//					
//					for (Map<String, Object> i : mapForFindValues) {
//
//						// log.debug("each value of list as in map :: "+i.values().toString());
//						flag = true;
//
//						list.addAll(i.values());
//					}
////					return aliasToValueMapList;
//					
//		}catch(Exception e) {
//			session.close();
//		}
//		return mapForFindValues;
//	}
	
	
	@Override
	public List<Map<String, Object>> fetchWACOEClientData(String PRNNum) {
		
		List<Map<String, Object>> mapForFindValues = null;
		List<Object> list = new ArrayList<Object>();
		String sqlQuery = "";
		Boolean flag = false;
		Session session = factory.openSession();
		try {
//			sqlQuery = "select unique_Key," + columnNames + " from zz_"+clientCode+"_"+payerType+"_"+formTempId + " where " + fieldNames+ ";";
			
			sqlQuery = "SELECT t.transId, t.cid, t.transAmount, t.transPaymode, t.transStatus, t.spRespCode, t.spTransId, t.formId," 
					+" c.PRN_No,c.Student_Name,c.Category,c.Class,c.Branch,c.Development_Fee,c.Other_Fee,c.College_Fee"+
					" FROM zz_client_user_data_749 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.PRN_No="+"'"+PRNNum+"'"
					+" UNION "+
					"SELECT t.transId, t.cid, t.transAmount, t.transPaymode, t.transStatus, t.spRespCode, t.spTransId, t.formId,"
					+" c.PRN_No,c.Student_Name,c.Category,c.Class,c.Branch,c.Development_Fee,c.Other_Fee,c.College_Fee"+
					" FROM zz_client_user_data_750 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.PRN_No="+"'"+PRNNum+"'"
					+" UNION "+
					"SELECT t.transId, t.cid, t.transAmount, t.transPaymode, t.transStatus, t.spRespCode, t.spTransId, t.formId," 
					+" c.PRN_No,c.Student_Name,c.Category,c.Class,c.Branch,c.Development_Fee,c.Other_Fee,c.College_Fee"+
					" FROM zz_client_user_data_754 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.PRN_No="+"'"+PRNNum+"'"
					+" UNION "+
					"SELECT t.transId, t.cid, t.transAmount, t.transPaymode, t.transStatus, t.spRespCode, t.spTransId, t.formId," 
					+" c.PRN_No,c.Student_Name,c.Category,c.Class,c.Branch,c.Development_Fee,c.Other_Fee,c.College_Fee"+
					" FROM zz_client_user_data_773 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.PRN_No="+"'"+PRNNum+"'"
					+" UNION "+
					"SELECT t.transId, t.cid, t.transAmount, t.transPaymode, t.transStatus, t.spRespCode, t.spTransId, t.formId," 
					+" c.PRN_No,c.Student_Name,c.Category,c.Class,c.Branch,c.Development_Fee,c.Other_Fee,c.College_Fee"+
					" FROM zz_client_user_data_774 c Inner Join data_transactions t ON c.transId=t.transId WHERE c.PRN_No="+"'"+PRNNum+"'";
					log.info("sqlQuery is : -> "+sqlQuery.toString());
					
					Query query = session.createSQLQuery(sqlQuery);

					log.info("query is " + query);

					query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

					log.info("query is " + query.list());

					mapForFindValues = query.list();
					
					for (Map<String, Object> i : mapForFindValues) {

						// log.debug("each value of list as in map :: "+i.values().toString());
						flag = true;

						list.addAll(i.values());
					}
//					return aliasToValueMapList;
					
		}catch(Exception e) {
			session.close();
		}
		return mapForFindValues;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
}
