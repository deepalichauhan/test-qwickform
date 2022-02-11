package com.sabpaisa.qforms.daoImpl;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.BeanSubjectLookup;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SheetFillingBeanForBu;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.controller.FormBuilderController;
import com.sabpaisa.qforms.dao.BurdDao;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.util.DBConnection;

@Repository
public class BurdDaoImpl implements BurdDao{

	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
    private DaoFieldLookupService daoFieldLookupService;
	
	private static final Logger log = LogManager.getLogger("BurdDaoImpl.class");
	DBConnection connection = new DBConnection();
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String dbName = properties.getProperty("dbName");
	String clientTempTableName = properties.getProperty("clientTempTableName");
	
	private List<SampleFormBean> formsList = new ArrayList<SampleFormBean>();
	
	@Override
    public BeanFormDetails getFormDetails(int id) {
    	log.debug("Start getFormDetails() method and searching in data_form_details "+id);
        Session session = factory.openSession();
        BeanFormDetails formDetails = new BeanFormDetails();
        try {
            Criteria cr = session.createCriteria(BeanFormDetails.class);
            cr.add((Criterion)Restrictions.eq((String)"id", (Object)id));
            BeanFormDetails beanFormDetails = formDetails = (BeanFormDetails)cr.list().get(0);
            log.debug("returning form name is "+beanFormDetails.getFormName());
            log.debug("End getFormDetails() method");
            return beanFormDetails;
        }
        catch (Exception e) {
            e.printStackTrace();
            BeanFormDetails beanFormDetails = formDetails;
            return beanFormDetails;
        }
        finally {
            session.close();
        }
    }
	
	@Override
    public BeanSubjectLookup getSubjectData(Integer id) {
		log.debug("Start getFormData() method in SampleFormDaoImpl.");
		BeanSubjectLookup subjectData= new BeanSubjectLookup();
        Session session = factory.openSession();
        
        try {
        	subjectData = (BeanSubjectLookup)session.get(BeanSubjectLookup.class, (Serializable)id);
        }
        finally {
            session.close();
        }
        log.debug("End getFormData() method in SampleFormDaoImpl.");
        return subjectData;
    }
	
	@Override
	public List<Map<String, Object>> colNameColValue(ArrayList<String> nameOfFields, Integer formTempId,
			HttpSession ses) {
		log.debug("Start of colNameColValue() method");
    	FormBuilderController formBuilder = new FormBuilderController();
    	BeanFormDetails form = new BeanFormDetails();
    	
    	List<BeanFormStructure> structureList=null;
    	Map<String, Object> mappingForResult=new HashMap<String, Object>();
    	ArrayList<String> columnNameList=new ArrayList<String>();
    	ArrayList<String> columnNameList1=new ArrayList<String>();
    	Map<String, String> mapForDataForm=new HashMap<String, String>();
    	List<Map<String, Object>> aliasToValueMapList=null;
    	 List<Object> list=new ArrayList<Object>();
    	String sqlQuery="";
    	Boolean flag=false;
    	try {
        	Session session = factory.openSession();
        	String fieldNames = String.join(" && ", nameOfFields);
            log.debug("fieldNames in form of string Field Value is" + fieldNames);
            
			form = daoFieldLookupService.getFormDetails(formTempId);
			
			formBuilder.SetOptionsMap(form,ses);
			form = formBuilder.orderStructure(form);
			structureList = form.getStructureList();
			log.debug("Now structure list for this form is ::::::::: "+structureList.toString());
			
			Iterator<BeanFormStructure> iterator = structureList.iterator();
			String dynSQL = "";
			int k = 0;
			while (iterator.hasNext()) {
				BeanFormStructure beanFormStructure = (BeanFormStructure) iterator.next();
				String string2 = beanFormStructure.getFormField().getLookup_name();
				String lookupId = beanFormStructure.getFormField().getLookup_id().toString();
				string2 = string2.replaceAll("\\s", "_");
				string2 = string2.replaceAll("'", "apos");
				string2 = string2.replaceAll("/", "fslsh");
				string2 = string2.replaceAll("\\\\", "bslsh");
				string2 = string2.replaceAll("\\*", "astrk");
				string2 = string2.replaceAll("\\(", "obkt");
				string2 = string2.replaceAll("\\)", "cbkt");
				string2 = string2.replaceAll("\\-", "hphn");
				//string2 = string2.replaceAll("hphn", "\\-");
				string2 = string2.replaceAll("\\:", "cln");
				string2 = string2.replaceAll("\\.", "dot");
				string2 = StringUtils.removeEnd(string2, "_");
				log.debug("generate column names ::" + string2);

				
				
				/*if(!string2.equals("Category") && !string2.equals("Page_Title") && !string2.equals("Notification"))*/
				if(!string2.equals("Page_Title") && !string2.equals("Notification"))
				{
					log.debug("in If String2 value is :::::::::: "+string2+" lookup id is for this field :: "+lookupId);
					columnNameList.add(string2);
					columnNameList1.add(lookupId+"~"+string2);
				}else{
					log.debug("in else String2 value is :::::::::: "+string2);
					
					
				}
				
			}
			
			log.debug("generate column names ::" + columnNameList.toString());
			String columnNames = String.join(",", columnNameList);
			log.debug("column names in string formate ::" + columnNames);
			
			
            
            sqlQuery = "select "+columnNames+" from zz_client_user_data_"+formTempId + " where "+fieldNames+";";
            log.debug("sqlQuery is ::::: "+sqlQuery);
            
         // Transaction tx = session.beginTransaction();

         			Query query = session.createSQLQuery(sqlQuery);

         			log.debug("query is " + query);

         			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

         			log.debug("query is " + query.list());

         			aliasToValueMapList = query.list();
         			
         			
         			
         			for(Map<String, Object> i:aliasToValueMapList){
         					
         					log.debug("each value of list as in map :: "+i.values().toString());
         					flag=true;
         		          list.addAll(i.values());
         		      }
         			log.debug("value of list of zz_client_user_data_" + formTempId
         					+ " by the var name list is >> " + list.toString());
         			log.debug("generate column names ::" + columnNameList.toString());
         			
         			
         			log.debug("value of list of zz_client_user_data_" + formTempId
         					+ " by the var name aliasToValueMapList is >> {" + aliasToValueMapList + "}");
			
			
			
        }catch(Exception e) {
        	log.debug("Exception Occoured "+e);
        	flag=false;
        }
    	ses.setAttribute("clientDisplayFieldsList", columnNameList);
    	ses.setAttribute("clientDisplayField", columnNameList1);
    	ses.setAttribute("listValueofMap", flag);
    	log.debug("End of colNameColValue() method");
    	return aliasToValueMapList;
	}
	
	@Override
	public String getFormTransId(String fieldNames, Integer formTempId) {
		Session session = factory.openSession();
		String sqlQuery="",transId="";
    	List<Object> list=new ArrayList<Object>();
    	
    	List<Map<String, Object>> aliasToValueMapList=null;
		try {
			sqlQuery = "select transId from zz_client_user_data_"+formTempId + " where "+fieldNames+";";
            log.debug("sqlQuery is ::::: "+sqlQuery);
            
            Query query = session.createSQLQuery(sqlQuery);

 			log.debug("query is " + query);
            
 			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

 			log.debug("query is " + query.list());

 			aliasToValueMapList = query.list();
            
 			for(Map<String, Object> i:aliasToValueMapList){
					log.debug("each value of list as in map :: "+i.values().toString());
					list.add(i.values());
					transId=i.values().toString();
		    }
		}catch (Exception e) {
			e.printStackTrace();
			session.close();
		}
        finally {
            session.close();
        }
		return transId;
	}
	
	@Override
	public String getFormTransStatus(String fieldNames, Integer formTempId) {
		Session session = factory.openSession();
		String sqlQuery="",transStatus="";
    	List<Object> list=new ArrayList<Object>();
    	
    	List<Map<String, Object>> aliasToValueMapList=null;
		try {
			sqlQuery = "select transStatus from zz_client_user_data_"+formTempId + " where "+fieldNames+";";
            log.debug("sqlQuery is ::::: "+sqlQuery);
            
            Query query = session.createSQLQuery(sqlQuery);

 			log.debug("query is " + query);
            
 			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

 			log.debug("query is " + query.list());

 			aliasToValueMapList = query.list();
            
 			for(Map<String, Object> i:aliasToValueMapList){
					log.debug("each value of list as in map :: "+i.values().toString());
					list.add(i.values());
					transStatus=i.values().toString();
		    }
 			if(null!=transStatus || ""!=transStatus) {
 				log.debug("End of getFormTransStatus() method and status is ::::: "+transStatus.toString());
 			}
		}catch (Exception e) {
			e.printStackTrace();
			session.close();
		}
        finally {
            session.close();
        }
		
		return transStatus;
	}
	
	@Override
    public SampleFormBean saveFormData(SampleFormBean saveData) {
        Session session = factory.openSession();
        SampleFormBean sBean=new SampleFormBean();
        Transaction tx = session.beginTransaction();
        try {
            session.beginTransaction();
            sBean=(SampleFormBean) session.merge((Object)saveData);
            tx.commit();
            SampleFormBean sampleFormBean = sBean;
            return sampleFormBean;
        }
        catch (Exception e) {
            e.printStackTrace();
            SampleFormBean sampleFormBean = sBean;
            return sampleFormBean;
        }
        finally {
            session.close();
        }
    }
	
	@Override
    public List<SampleFormBean> getFormList(String id, String idType) {
		log.debug("Start getformList() method in SampleformdaoImpl.");
        Session session = factory.openSession();
        try {
            Criteria cr = session.createCriteria(SampleFormBean.class);
            if (idType.equals("userid")) {
                cr.add((Criterion)Restrictions.eq((String)"formApplicantId", (Object)Integer.parseInt(id)));
            } else {
                cr.add((Criterion)Restrictions.eq((String)"formId", (Object)Integer.parseInt(id)));
            }
            this.formsList = cr.list();
            List<SampleFormBean> list = this.formsList;
            log.debug("End getformList() method in SampleformdaoImpl.");
            return list;
        }
        catch (Exception e) {
            e.printStackTrace();
            List<SampleFormBean> list = this.formsList;
            return list;
        }
        finally {
            session.close();
        }
    }

	@Override
	public Integer getApprovedCollegeCode(String collegeName) throws SQLException {
		Session session = factory.openSession();
		Integer approvedCid=null;
		
		Connection con=connection.getConnectionApp();
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			// SELECT * FROM qwikForms1.college_master where collegeName Like 'VISION  INTERNATIONAL%';
			String query = "select * from "+dbName+".college_master where collegeName LIKE '"+collegeName+"%';";
			log.info("query for finding max value of filledseat ::::: "+query);
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				approvedCid = rs.getInt("collegeId");
			}

			return approvedCid;
		} catch (Exception e) {
			e.printStackTrace();
			return approvedCid;
		} finally {
			log.info("End getApprovedCollegeCode() method. and filled seat is :: "+approvedCid);
			con.close();
		}
		
		//return approvedCid;
	}

	@Override
	public Integer getSelectSubjectId(String subjectName) throws SQLException {
		Session session = factory.openSession();
		Integer selectSubjectId=null;
		Connection con=connection.getConnectionApp();
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			// SELECT * FROM qwikForms1.lookup_subjects where subject_name Like 'VISION  INTERNATIONAL%';
			String query = "select * from "+dbName+".lookup_subjects where subject_name LIKE '"+subjectName+"';";
			log.info("query for finding max value of filledseat ::::: "+query);
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				selectSubjectId = rs.getInt("id");
			}

			return selectSubjectId;
		} catch (Exception e) {
			e.printStackTrace();
			return selectSubjectId;
		} finally {
			log.info("End getSelectSubjectId() method. and filled seat is :: "+selectSubjectId);
			con.close();
		}
	}

	@Override
	public SheetFillingBeanForBu getAllSubjectFilledSheetDetail(String college_category, Integer cid, Integer sid) throws SQLException {
		SheetFillingBeanForBu subjectBean=new SheetFillingBeanForBu();
		Connection con=connection.getConnectionApp();
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			// SELECT * FROM qwikForms1.subject_detail where client_id =2315 and subject_id=3;
			String query = "SELECT * FROM "+dbName+".subject_detail where College_Category ='"+college_category
																							+"' and client_id ="+cid+" and subject_id="+sid+";";
			log.debug("query for finding max value of filledseat ::::: "+query);
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				subjectBean.setSid(rs.getInt("sid"));
				subjectBean.setSubject_id(rs.getInt("subject_id"));
				subjectBean.setClient_id(rs.getInt("client_id"));
				subjectBean.setSubject_max_seat(rs.getInt("subject_max_seat"));
				subjectBean.setSubject_filled_seat(rs.getInt("subject_filled_seat"));
				subjectBean.setCollege_Category("College_Category");
				subjectBean.setPaymentUrl(rs.getString("paymentUrl"));
			}
			log.debug("SheetFillingBeanForBu is in daoimpl ::::: "+subjectBean.toString());
			return subjectBean;
		} catch (Exception e) {
			e.printStackTrace();
			return subjectBean;
		} finally {
			log.debug("End getSelectSubjectId() method. and filled seat is :: "+subjectBean);
			con.close();
		}
	}

	@Override
	public String getClientTableNameFromMainTable(String tableName,String qcTxnId,HttpSession ses) throws SQLException {
		
		String clientTableName=null;
		String formTransId=null;
		Connection con=connection.getConnectionApp();
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			// "SELECT * FROM "+tableName+" where transId='"+qcTxnId+"'"
			String query = "SELECT * FROM "+dbName+"."+tableName+" where transId ='"+qcTxnId+"'"+";";
			log.debug("query for finding max value of filledseat ::::: "+query);
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				clientTableName=rs.getString("clientTableName");
				formTransId=rs.getString("form_transId");
			}
			//clientTableName=clientTableName+"="+formTransId;
			//log.debug("SheetFillingBeanForBu is in daoimpl ::::: "+subjectBean.toString());
			ses.setAttribute("formTransId", formTransId);
			return clientTableName;
		} catch (Exception e) {
			e.printStackTrace();
			return clientTableName;
		} finally {
			con.close();
		}
	}

	@Override
	public List<BeanSubjectLookup> getAllSubjectNamesBasedOnClient() {
		log.debug("Start getformList() method in SampleformdaoImpl.");
        Session session = factory.openSession();
        List<BeanSubjectLookup> list = new ArrayList<BeanSubjectLookup>();
        try {
            Criteria cr = session.createCriteria(BeanSubjectLookup.class);
            
            list = cr.list();
            log.debug("End getformList() method in SampleformdaoImpl.");
            return list;
        }
        catch (Exception e) {
            e.printStackTrace();
            return list;
        }
        finally {
            session.close();
        }
	}
	
	@Override
	public Integer getSeatDetailAsSubjectWise(Integer sid,Integer cid, HttpSession ses) throws SQLException {
		
		if(null!=ses.getAttribute("maxSeat")){
			ses.removeAttribute("maxSeat");
		}
		Integer maxSeat=null;
		Integer filledSeat=null;
		Connection con=connection.getConnectionApp();
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String query = "SELECT * FROM "+dbName+".subject_detail where client_id ="+cid+" and subject_id="+sid+";";
			log.debug("query for finding max value of filledseat ::::: "+query);
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				maxSeat=rs.getInt("subject_max_seat");
				filledSeat=rs.getInt("subject_filled_seat");
			}
			ses.setAttribute("maxSeat", maxSeat);
			return filledSeat;
		} catch (Exception e) {
			e.printStackTrace();
			return filledSeat;
		} finally {
			con.close();
		}
	}
	
	@Override
    public List<SheetFillingBeanForBu> getSubjectDetailSeatList(Integer clientIdForBU) {
		log.debug("Start getSubjectDetailSeatList() method in SampleformdaoImpl.");
        Session session = factory.openSession();
        List<SheetFillingBeanForBu> seatFilled = new ArrayList<SheetFillingBeanForBu>();
        try {
            Criteria cr = session.createCriteria(SheetFillingBeanForBu.class);
                            cr.add((Criterion)Restrictions.eq("client_id", clientIdForBU));
            //cr.add((Criterion)Restrictions.eq((String)"client_id", (Object)clientIdForBU));
            seatFilled = cr.list();
            //List<SheetFillingBeanForBu> list = this.formsList;
            log.debug("End getformList() method in SampleformdaoImpl. :::::::::::::: "+seatFilled.toString());
            return seatFilled;
        }
        catch (Exception e) {
            e.printStackTrace();
            //List<SampleFormBean> list = this.formsList;
            return seatFilled;
        }
        finally {
            session.close();
        }
    }
	
	//SELECT distinct Approved_College_Name FROM qwikForms1.zz_client_user_data_34 ;
	@Override
	public List<String> getCollegeNameListByTempTable() {
		Session session = factory.openSession();
		String sqlQuery="",
				transStatus="";
    	List<String> list=new ArrayList<String>();
    	
    	//List<Map<String, Object>> aliasToValueMapList=null;
		try {
			sqlQuery = "SELECT distinct Approved_College_Name FROM "+clientTempTableName+";";
            log.debug("sqlQuery is ::::: "+sqlQuery);
            
            Query query = session.createSQLQuery(sqlQuery);

 			log.debug("query is " + query);
            
 			//query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

 			log.debug("query is " + query.list());

 			list = query.list();
            
 			log.debug("list value is ::::: "+list.toString());
 			
		}catch (Exception e) {
			e.printStackTrace();
			session.close();
		}
        finally {
            session.close();
        }
		
		return list;
	}

	@Override
	public String getCollegeCategoryForMain(ArrayList<String> nameOfFieldsForBU, Integer formTempId) throws SQLException {
		log.info("Strat of getCollegeCategoryForMain() method ");
    	Connection con=connection.getConnectionApp();
		Statement stmt = null;
		ResultSet rs = null;
    	String sqlQuery="", collegeCategory=null;
        String fieldNames = String.join(" && ", nameOfFieldsForBU);
        log.debug("fieldNames in form of string Field Value is" + fieldNames);
          
    		try {
    			sqlQuery = "select * from zz_client_user_data_"+formTempId + " where "+fieldNames+";";
                log.info("sqlQuery is ::::: "+sqlQuery);
                
                stmt = con.createStatement();
    			rs = stmt.executeQuery(sqlQuery);
    			while (rs.next()) {
    				collegeCategory=rs.getString("college_category");
    			}
    			//ses.setAttribute("maxSeat", maxSeat);
    			return collegeCategory;
    		} catch (Exception e) {
    			e.printStackTrace();
    			return collegeCategory;
    		} finally {
    			log.info("end of getCollegeCategoryForMain() method ");
    			con.close();
    		}
    	
	}
}