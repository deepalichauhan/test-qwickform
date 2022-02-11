package com.sabpaisa.qforms.daoImpl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.dao.ApiBotDao;
import com.sabpaisa.qforms.util.DBConnection;
import com.sabpaisa.qforms.util.SendMail;

@Repository
public class ApiBotDaoImpl implements ApiBotDao{

	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("ApiBotDaoImpl.class");
	
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String dbName = properties.getProperty("dbName");
	DBConnection connection = new DBConnection();
	String cCodeForMagicBricks=properties.getProperty("cCodeForMagicBricks");
	String cCodeForTVS = properties.getProperty("cCodeForTVS");
	
	SendMail mail = new SendMail();
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> getTempTableDataForSubscription1(String tableName,String qcTxnId, String status) throws ParseException {
		Session session = factory.openSession();
		String fQuery = "";
		String tempQcTxnId=qcTxnId.trim();
		String tempStatus=status.trim();
		String tempTable=tableName.trim();
		String param="transId='" + qcTxnId + "' and transStatus ='" + status + "' and  subscriptionId !=''";
		log.info("QFID is :: {"+qcTxnId+ "}, transStatus is ::: {"+status+"}");
		List<Map<String, Object>> aliasToValueMapList=null;
		try {
			//fQuery = "select "+headerName+" from zz_client_user_data_4 where transId='QF0509151338897451' and transStatus ='failure' and  subscriptionId !=''";
			fQuery = "select * from " + tempTable + " where transId='" + tempQcTxnId + "' and transStatus ='" + tempStatus + "' and  subscriptionId !='';";
			//fQuery = "select "+headerName+" from " + tableName + " where "+param+";";
			//fQuery = "select * from " + tableName + " where transId='" + qcTxnId + "';";
			
			Query query = session.createSQLQuery(fQuery);

 			log.info("query is " + query);

 			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

 			log.info("query is " + query.list());

 			aliasToValueMapList = query.list();
 			
 			log.info("value5646478 of list of "+ tableName+" by the var name aliasToValueMapList is >> " + aliasToValueMapList );
			
			return aliasToValueMapList;
		}catch(Exception ex) {
			ex.printStackTrace();
			return aliasToValueMapList;
		}finally {
			session.close();
		}
		//return val1;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<String> getTempTableDataForSubscription(String tableName,String qcTxnId, String status) throws ParseException {
		Session session = factory.openSession();
		String fQuery = "";
		ArrayList<String> val1 = new ArrayList<String>();
		try {
			fQuery = "select * from " + tableName + " where transId='" + qcTxnId + "' transStatus =" + status + "' and  subscriptionId !=''";
			SQLQuery query1 = session.createSQLQuery(fQuery);
			List<Object[]> rows = query1.list();
			for (Object[] objects : rows) {

				//log.debug("records ===  " + Arrays.toString(objects));
				val1.add(Arrays.toString(objects));

			}
			log.info("value of selected list is :: "+val1.toString());
			return val1;
		}catch(Exception ex) {
			ex.printStackTrace();
			return val1;
		}finally {
			session.close();
		}
		//return val1;
	}
	
	@Override
	public ArrayList<String> getTempTableHeaderNames(String tableName) {
		log.info("open getTempTableHeaderNames() method.");
		Session session = factory.openSession();
		ArrayList<String> val1 = new ArrayList<String>();
		ArrayList<String> val2 = new ArrayList<String>();
		log.info("i am in header section.");
		try {
			SQLQuery query1 = session.createSQLQuery("DESCRIBE " + tableName);
			/* query1.setParameter("", arg1) */
			List<Object[]> rows = query1.list();

			for (Object[] objects : rows) {

				//log.debug(" header vals===  " + Arrays.toString(objects));
				val1.add(Arrays.toString(objects));
				log.info(" header vals in first for loop ===  " + val1.toString());

			}
			for (String headerVal : val1) {
				String[] hVal = headerVal.split(",");
				log.info("  header vals second for loop ===  " + hVal[0]);
				
				// MySQl Column names
				/*String transformedHeaderName = formHeaderName(hVal[0].substring(1));
				val2.add(transformedHeaderName);*/
				val2.add(hVal[0].substring(1));

			}
			log.info("Return values in outer second for loop ===  " + val2.toString());
			return val2;
		} catch (Exception ex) {
			ex.printStackTrace();
			return val2;
		} finally {
			session.close();
		}
	}
	
	public String formHeaderName(String originalHeaderName) {
		log.debug("originalHeaderName here is.." + originalHeaderName);

		String revisedHeaderName = "";
		revisedHeaderName = originalHeaderName.replaceAll("wspc", " ");
		revisedHeaderName = revisedHeaderName.replaceAll("apos", "'");
		revisedHeaderName = revisedHeaderName.replaceAll("fslsh", "\\/");
		revisedHeaderName = revisedHeaderName.replaceAll("bslsh", "\\");
		revisedHeaderName = revisedHeaderName.replaceAll("astrk", "\\*");
		revisedHeaderName = revisedHeaderName.replaceAll("obkt", "\\(");
		revisedHeaderName = revisedHeaderName.replaceAll("cbkt", "\\)");
		revisedHeaderName = revisedHeaderName.replaceAll("hphn", "\\-");
		
		revisedHeaderName = revisedHeaderName.replaceAll("cln", "\\:");
		
		revisedHeaderName = revisedHeaderName.replaceAll("dot", "\\.");
		
		log.debug("revisedHeaderName is::" + revisedHeaderName);
		return revisedHeaderName;
	}
	
}

