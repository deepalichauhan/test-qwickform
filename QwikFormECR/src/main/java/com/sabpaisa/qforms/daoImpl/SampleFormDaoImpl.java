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
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.controller.FormBuilderController;
import com.sabpaisa.qforms.dao.SampleFormDao;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.util.DBConnection;

@Repository
public class SampleFormDaoImpl implements SampleFormDao {

	@Autowired
	SessionFactory factory;

	@Autowired
	DataSource dataSource;

	@Autowired
	JdbcTemplate jdbcTemplate;

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;

	private static final Logger log = LogManager.getLogger("SampleFormDaoImpl.class");
	DBConnection connection = new DBConnection();
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String dbName = properties.getProperty("dbName");
	String cCodeForMagicBricks = properties.getProperty("cCodeForMagicBricks");
	String cIdForMagicBricks = properties.getProperty("cIdForMagicBricks");

	private List<SampleFormBean> formsList = new ArrayList<SampleFormBean>();

	@Override
	public BeanPayerType saveTargetPayerDao(BeanPayerType beanPayerType) {
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			session.save((Object) beanPayerType);
			session.getTransaction().commit();
			BeanPayerType beanPayerType2 = beanPayerType;
			return beanPayerType2;
		} catch (Exception e) {
			e.printStackTrace();
			BeanPayerType beanPayerType3 = beanPayerType;
			return beanPayerType3;
		} finally {
			session.close();
		}
	}

	@Override
	public ArrayList<BeanPayerType> getAllPayersTargetData(Integer cid, Integer bid) {
		Session session = factory.openSession();
		ArrayList<BeanPayerType> payers = new ArrayList<BeanPayerType>();
		try {
			payers = (ArrayList) session.createCriteria(BeanPayerType.class)
					.add((Criterion) Restrictions.eq((String) "cid", (Object) cid.toString()))
					.add((Criterion) Restrictions.eq((String) "bid", (Object) bid.toString())).list();
		} catch (Exception e) {
			return payers;
		} finally {
			session.close();
		}
		return payers;
	}

	@Override
	public SampleFormBean saveFormData(SampleFormBean saveData) {
		Session session = factory.openSession();
		SampleFormBean sBean = new SampleFormBean();
		Transaction tx = session.beginTransaction();
		try {
			session.beginTransaction();
			sBean = (SampleFormBean) session.merge((Object) saveData);
			tx.commit();
			SampleFormBean sampleFormBean = sBean;
			return sampleFormBean;
		} catch (Exception e) {
			e.printStackTrace();
			SampleFormBean sampleFormBean = sBean;
			return sampleFormBean;
		} finally {
			session.close();
		}
	}

	@Override
	public SampleFormBean saveFormDataForLp(SampleFormBean saveData) {
		Session session = factory.openSession();
		SampleFormBean sBean = new SampleFormBean();
		Transaction tx = session.beginTransaction();
		try {
			session.beginTransaction();
			sBean = (SampleFormBean) session.merge((Object) saveData);
			tx.commit();
			SampleFormBean sampleFormBean = sBean;
			return sampleFormBean;
		} catch (Exception e) {
			e.printStackTrace();
			SampleFormBean sampleFormBean = sBean;
			return sampleFormBean;
		} finally {
			session.close();
		}
	}

	@Override
	public SampleFormBean fetchEndUserData(int id) {
		log.info("Start fetchEndUserData() method and searching in data_form_details " + id);
		Session session = factory.openSession();
		SampleFormBean formDetails = new SampleFormBean();
		try {
			Criteria cr = session.createCriteria(SampleFormBean.class);
			cr.add((Criterion) Restrictions.eq("formId", id));
			SampleFormBean beanFormDetails = formDetails = (SampleFormBean) cr.list().get(0);
			log.info("End getFormDetails() method");
			return beanFormDetails;
		} catch (Exception e) {
			e.printStackTrace();
			SampleFormBean beanFormDetails = formDetails;
			return beanFormDetails;
		} finally {
			session.close();
		}
	}

	@Override
	public SampleFormBean getFormData(Integer id) {
		log.debug("Start getFormData() method in SampleFormDaoImpl.");
		SampleFormBean beanFormData = new SampleFormBean();
		Session session = factory.openSession();
		try {
			beanFormData = (SampleFormBean) session.get(SampleFormBean.class, (Serializable) id);
		} finally {
			session.close();
		}
		log.debug("End getFormData() method in SampleFormDaoImpl.");
		return beanFormData;
	}

	@Override
	public List<SampleFormBean> getFormList(String id, String idType) {
		log.debug("Start getformList() method in SampleformdaoImpl.");
		List<SampleFormBean> formsList = new ArrayList<SampleFormBean>();
		Session session = factory.openSession();
		try {
			Criteria cr = session.createCriteria(SampleFormBean.class);
//			if (idType.equals("userid")) {
//				cr.add((Criterion) Restrictions.eq((String) "formApplicantId", (Object) Integer.parseInt(id)));
//			} else {
				cr.add((Criterion) Restrictions.eq("formId", Integer.parseInt(id)));
//			}
			formsList = cr.list();
			log.debug("End getformList() method in SampleformdaoImpl.");
			return formsList;
		} catch (Exception e) {
			e.printStackTrace();
			return formsList;
		} finally {
			session.close();
		}
	}

	@Override
	public BeanFormDetails getFormDetails(int id) {
		log.debug("Start getFormDetails() method and searching in data_form_details " + id);
		Session session = factory.openSession();
		BeanFormDetails formDetails = new BeanFormDetails();
		try {
			Criteria cr = session.createCriteria(BeanFormDetails.class);
			cr.add((Criterion) Restrictions.eq((String) "id", (Object) id));
			BeanFormDetails beanFormDetails = formDetails = (BeanFormDetails) cr.list().get(0);
			// log.debug("returning form name is "+beanFormDetails.getFormName());
			log.debug("End getFormDetails() method");
			return beanFormDetails;
		} catch (Exception e) {
			e.printStackTrace();
			BeanFormDetails beanFormDetails = formDetails;
			return beanFormDetails;
		} finally {
			session.close();
		}
	}

	@Override
	public void deleteFormData(SampleFormBean beanFormData) {
		// log.debug((Object)("form instance is is::" + beanFormData.getFormId()));
		log.debug(
				(Object) "payer vital info changes..going to delete the old form data since a fresh record will be created...");
		Session session = factory.openSession();
		try {
			try {
				session.beginTransaction();
				session.delete((Object) beanFormData);
				session.getTransaction().commit();
			} catch (Exception e) {
				e.printStackTrace();
				session.close();
			}
		} finally {
			session.close();
		}
	}

	@Override
	public String getFormNameByFormId(Integer id) {
		log.debug("Start getFormNameByFormId() method for finding formName");

		return "";
	}

	@Override
	public BeanFormDetails getFormTempId(Integer id) {
		log.debug("Start getFormTempId() method and searching in data_form_details " + id);
		Session session = factory.openSession();
		SampleFormBean beanDataForm = new SampleFormBean();
		BeanFormDetails beanFormDetails = new BeanFormDetails();
		try {
			Criteria cr = session.createCriteria(SampleFormBean.class);
			cr.add((Criterion) Restrictions.eq((String) "formId", (Object) id));
			beanDataForm = (SampleFormBean) cr.list().get(0);
			// log.debug("returning form name is "+beanDataForm.getFormTemplateId());
			beanFormDetails = getFormDetails(beanDataForm.getFormTemplateId());
			// log.debug("returning form name is
			// "+beanFormDetails.getValidateFieldOfExcel().toString());
			log.debug("End getFormTempId() method");
			return beanFormDetails;
		} catch (Exception e) {
			e.printStackTrace();
			return beanFormDetails;
		} finally {
			session.close();
		}
	}

	@Override
	public List<Map<String, Object>> colNameColValue(ArrayList<String> nameOfFields, Integer formTempId,
			String clientCode, String payerType, HttpSession ses) {

		log.debug("Start of colNameColValue() method");
		FormBuilderController formBuilder = new FormBuilderController();
		BeanFormDetails form = new BeanFormDetails();
		List<BeanFormStructure> structureList = null;
		//Map<String, Object> mappingForResult = new HashMap<String, Object>();
		ArrayList<String> columnNameList = new ArrayList<String>();
		ArrayList<String> columnNameList1 = new ArrayList<String>();
		//Map<String, String> mapForDataForm = new HashMap<String, String>();
		List<Map<String, Object>> aliasToValueMapList = null;
		List<Object> list = new ArrayList<Object>();
		String sqlQuery = "";
		Boolean flag = false;
		
		if(null!=payerType) {
			//payerType=payerTypeBean.getPayer_type();
			payerType = payerType.replaceAll("\\s", "_");
			payerType = payerType.replaceAll("'", "apos");
			payerType = payerType.replaceAll("/", "fslsh");
			payerType = payerType.replaceAll("\\\\", "bslsh");
			payerType = payerType.replaceAll("\\*", "astrk");
			payerType = payerType.replaceAll("\\(", "obkt");
			payerType = payerType.replaceAll("\\)", "cbkt");
			payerType = payerType.replaceAll("\\-", "hphn");
			payerType = payerType.replaceAll("\\:", "cln");
			payerType = payerType.replaceAll("\\.", "dot");
		}
		
		try {
			Session session = factory.openSession();
			String fieldNames = String.join(" && ", nameOfFields);
			log.info("fieldNames in form of string Field Value is" + fieldNames);

			form = daoFieldLookupService.getFormDetails(formTempId);

			formBuilder.SetOptionsMap(form, ses);
			form = formBuilder.orderStructure(form);
			structureList = form.getStructureList();
			log.info("Now structure list for this form is ::::::::: " + structureList.toString());

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
				// string2 = string2.replaceAll("hphn", "\\-");
				string2 = string2.replaceAll("\\:", "cln");
				string2 = string2.replaceAll("\\.", "dot");
				string2 = StringUtils.removeEnd(string2, "_");
				log.info("generate column names ::" + string2);

				/*
				 * if(!string2.equals("Category") && !string2.equals("Page_Title") &&
				 * !string2.equals("Notification"))
				 */
				if (!string2.equals("Page_Title") && !string2.equals("Notification")) {
					// log.debug("in If String2 value is :::::::::: "+string2+" lookup id is for
					// this field :: "+lookupId);
					if(string2.length()>64) {
						log.info("String size is greater than 64 so it use substring of it : "+string2);
						String string3=string2.substring(0,64);
						columnNameList.add(string3);
						columnNameList1.add(lookupId + "~" + string3);
					}else {
						columnNameList.add(string2);
						columnNameList1.add(lookupId + "~" + string2);
					}
					
				} else {
					log.info("in else String2 value is :::::::::: " + string2);

				}

			}

			log.info("generate column names ::" + columnNameList.toString());
			String columnNames = String.join(",", columnNameList);
			// log.info("column names in string formate ::" + columnNames);

			//sqlQuery = "select " + columnNames + " from zz_client_user_data_" + formTempId + " where " + fieldNames+ ";";
			//"zz_"+formOwnerName+"_"+payerTypeBean.getPayer_type()+"_"+form.getId();
			log.info("clientCode is : {"+clientCode+"}, cCodeForMagicBricks as ENach : {"+cCodeForMagicBricks+"}, form.getFormOwnerName() : {"+form.getFormOwnerName()+"}");
			
			if( !clientCode.equalsIgnoreCase(cCodeForMagicBricks) ||
					!form.getFormOwnerName().equalsIgnoreCase(cCodeForMagicBricks)) {
				
				sqlQuery = "select unique_Key," + columnNames + " from zz_"+clientCode+"_"+payerType+"_"+formTempId + " where " + fieldNames+ ";";
				log.info("sqlQuery is : -> "+sqlQuery.toString());
			}else {
				log.info("It is in MagicBricks formate checking at the time of fetching data as per given Link password.");
				sqlQuery = "select " + columnNames + " from zz_client_user_data_" + formTempId + " where " + fieldNames+ ";";
			}
			log.info("sqlQuery is ::::: " + sqlQuery);

			// Transaction tx = session.beginTransaction();

			Query query = session.createSQLQuery(sqlQuery);

			log.info("query is " + query);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			log.info("query is " + query.list());

			aliasToValueMapList = query.list();

			for (Map<String, Object> i : aliasToValueMapList) {

				// log.debug("each value of list as in map :: "+i.values().toString());
				flag = true;

				list.addAll(i.values());
			}
			/*
			 * log.debug("value of list of zz_client_user_data_" + formTempId +
			 * " by the var name list is >> " + list.toString());
			 * log.info("generate column names ::" + columnNameList.toString());
			 * 
			 * 
			 * log.info("value of list of zz_client_user_data_" + formTempId +
			 * " by the var name aliasToValueMapList is >> {" + aliasToValueMapList + "}");
			 */

		} catch (Exception e) {
			log.info("Exception Occoured " + e);
			flag = false;
		}
		ses.setAttribute("clientDisplayFieldsList", columnNameList);
		ses.setAttribute("clientDisplayField", columnNameList1);
		ses.setAttribute("listValueofMap", flag);
		log.info("End of colNameColValue() method");
		return aliasToValueMapList;
	}

	@Override
	public Integer updateFormData(String listData, String transId, Integer formId, Integer cid) {
		Session session = factory.openSession();
		int i = 0;
		try {

			Transaction tx = session.beginTransaction();

			session.createSQLQuery("UPDATE  data_form SET formData='" + listData + "'" + ", formTransId=" + "'"
					+ transId + "'" + ", formClientId=" + "'" + cid + "' where formId=" + formId).executeUpdate();

			tx.commit();
			return i + 2;
		} catch (Exception e) {
			e.printStackTrace();
			session.close();
			return i + 1;
		} finally {
			session.close();
		}
	}

	@Override
	public String getFormTransStatus(String fieldNames, Integer formTempId) {
		Session session = factory.openSession();
		String sqlQuery = "", transStatus = "";
		List<Object> list = new ArrayList<Object>();

		List<Map<String, Object>> aliasToValueMapList = null;
		try {
			sqlQuery = "select transStatus from zz_client_user_data_" + formTempId + " where " + fieldNames + ";";
			log.debug("sqlQuery is ::::: " + sqlQuery);

			Query query = session.createSQLQuery(sqlQuery);

			// log.debug("query is " + query);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			// log.info("query is " + query.list());

			aliasToValueMapList = query.list();

			for (Map<String, Object> i : aliasToValueMapList) {
				// log.info("each value of list as in map :: "+i.values().toString());
				list.add(i.values());
				transStatus = i.values().toString();
			}
			if (null != transStatus || "" != transStatus) {
				log.info("End of getFormTransStatus() method and status is ::::: " + transStatus.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.close();
		} finally {
			session.close();
		}

		return transStatus;
	}

	@Override
	public String getFormTransId(String fieldNames, Integer formTempId) {
		Session session = factory.openSession();
		String sqlQuery = "", transId = "";
		List<Object> list = new ArrayList<Object>();

		List<Map<String, Object>> aliasToValueMapList = null;
		try {
			sqlQuery = "select transId from zz_client_user_data_" + formTempId + " where " + fieldNames + ";";
			log.debug("sqlQuery is ::::: " + sqlQuery);

			Query query = session.createSQLQuery(sqlQuery);

			// log.info("query is " + query);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			// log.info("query is " + query.list());

			aliasToValueMapList = query.list();

			for (Map<String, Object> i : aliasToValueMapList) {
				// log.info("each value of list as in map :: "+i.values().toString());
				list.add(i.values());
				transId = i.values().toString();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.close();
		} finally {
			session.close();
		}
		return transId;
	}

	@Override
	public ArrayList<String> getFormMobileNumber(Integer formTempId) {

		ArrayList<String> list = new ArrayList<String>();
		Session session = factory.openSession();
		String sqlQuery = "", mobile = "";
		try {
			DBConnection dbc = new DBConnection();
			Connection con = dbc.getConnectionApp();
			Statement stmt = con.createStatement();
			sqlQuery = "select CONTACT_NUMBER from zz_client_user_data_" + formTempId + ";";
			ResultSet rs = stmt.executeQuery(sqlQuery);
			// int g =0;
			while (rs.next()) {
				mobile = rs.getString("CONTACT_NUMBER");
				// log.info("new email add to list is ::: "+mobile);
				list.add(mobile);
			}
			// log.info("list for emails is ::: "+list);
		}

		catch (Exception e) {
			e.printStackTrace();
			session.close();
		} finally {
			session.close();
		}
		return list;

	}

	@Override
	public ArrayList<String> getFormEmail(Integer formTempId) {

		ArrayList<String> list = new ArrayList<String>();
		Session session = factory.openSession();
		String sqlQuery = "", email = "";
		String emailId = "";
		try {
			DBConnection dbc = new DBConnection();
			Connection con = dbc.getConnectionApp();
			Statement stmt = con.createStatement();
			sqlQuery = "select EMAIL_ID from zz_client_user_data_" + formTempId + ";";
			ResultSet rs = stmt.executeQuery(sqlQuery);
			// int g =0;
			while (rs.next()) {
				email = rs.getString("EMAIL_ID");
				// log.info("new email add to list is ::: "+email);
				list.add(email);
			}
			// log.info("list for emails is ::: "+list);
		}

		catch (Exception e) {
			e.printStackTrace();
			session.close();
		} finally {
			session.close();
		}
		return list;

	}

	/*
	 * 
	 * val1.add(maximumSeat); val1.add(filledSeat);
	 * log.info("val1 Arraylist is for subject seats :::::::: "+val1.toString());
	 * return val1;
	 */

	@Override
	public SampleFormBean getFormDetailsByQfId(String qcId) throws Exception {
		SampleFormBean sBean = new SampleFormBean();
		Connection con = connection.getConnectionApp();
		String qfID = qcId;
		Statement stmt = null;
		ResultSet rs = null;
		String fQuery = "";
		try {
			log.debug("qcId is " + qfID);
			// select * from qwikforms1.dataform where formTransId=qcid
			fQuery = " SELECT * FROM " + dbName + ".data_form where formTransId='" + qcId + "'";

			// log.debug("query for finding max value of filledseat ::::: "+fQuery);

			stmt = con.createStatement();
			rs = stmt.executeQuery(fQuery);

			while (rs.next()) {
				sBean.setFormId(rs.getInt("formId"));
				sBean.setFormData(rs.getString("formData"));
				sBean.setFormFeeId(rs.getInt("formFeeId"));
				sBean.setFormDate(rs.getDate("formDate"));
				sBean.setFormInstId(rs.getInt("formInstId"));
				sBean.setFormTemplateId(rs.getInt("formTemplateId"));
				sBean.setFormTransId(qcId);
				sBean.setFormClientId(rs.getString("formClientId"));
				sBean.setContact(rs.getString("contact"));
				sBean.setDobDate(rs.getDate("dobDate"));
				sBean.setEmail(rs.getString("email"));
				sBean.setName(rs.getString("name"));
				sBean.setTransAmount(rs.getDouble("transAmount"));
				sBean.setFormNumber(rs.getString("formNumber"));
				sBean.setPayerID(rs.getString("payerID"));
				sBean.setPhotograph(rs.getBytes("photograph"));
				sBean.setSignature(rs.getBytes("signature"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			con.close();
			stmt.close();
			rs.close();
		}

		// log.debug("sampleformbean is ::: "+sBean+ " and id is :::
		// "+sBean.getFormId());
		return sBean;
	}

	@Override
	public String getQfId(String linkPass, Integer formTempId) throws Exception {
		String qfID = "null";
		Connection con = connection.getConnectionApp();
		Statement stmt = null;
		ResultSet rs = null;
		String fQuery = "";
		try {
			log.debug("qcId is " + qfID);
			// select * from qwikforms1.dataform where formTransId=qcid
			fQuery = " SELECT * FROM " + dbName + ".zz_client_user_data_" + formTempId + " where linkPassword='"
					+ linkPass + "'";
			log.debug("query for finding max value of filledseat ::::: " + fQuery);
			stmt = con.createStatement();
			rs = stmt.executeQuery(fQuery);
			// log.info("resultSet is ::::: "+rs.toString());

			while (rs.next()) {
				qfID = rs.getString("transId");
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			con.close();
			stmt.close();
			rs.close();
		}
		log.debug("sampleformbean and id is ::: " + qfID);
		return qfID;
	}

	@Override
	public String getFileUploadLink(String fieldKey, Integer formId) throws Exception {
		String fileLink = "null";
		log.info("formid for available file is ::: " + formId);
		log.info("field Id for available file is ::: " + fieldKey);
		Connection con = connection.getConnectionApp();
		Integer fId = formId - 1;
		log.info("f Id for available file is ::: " + fId);
		Integer fieldId = Integer.parseInt(fieldKey);
		Statement stmt = null;
		ResultSet rs = null;
		String fQuery = "";
		try {
			// fQuery = " SELECT * FROM "+dbName+".file_uploads where field_id="+fieldId+"
			// ORDER BY file_id DESC LIMIT 1";
			fQuery = " SELECT * FROM " + dbName + ".file_uploads where file_id=" + "(SELECT uploadedFiles_file_id FROM "
					+ dbName + ".data_form_file_uploads WHERE data_form_formId=" + fId + ");";
			log.info("query for finding max value of filledseat ::::: " + fQuery);
			stmt = con.createStatement();
			rs = stmt.executeQuery(fQuery);
			// log.info("resultSet is ::::: "+rs.toString());

			while (rs.next()) {
				fileLink = rs.getString("file_path");
			}
			log.info("fileLink is ::::: " + fileLink);

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			con.close();
			stmt.close();
			rs.close();
		}
		return fileLink;
	}

	@Override
	public String getFileUploadLink1(String fieldKey, Integer formId) throws Exception {
		String fileLink = "null";
		log.info("formid for available file is ::: " + formId);
		log.info("field Id for available file is ::: " + fieldKey);
		Connection con = connection.getConnectionApp();
		Integer fId = formId + 1;
		log.info("f Id for available file is ::: " + fId);
		Integer fieldId = Integer.parseInt(fieldKey);
		Statement stmt = null;
		ResultSet rs = null;
		String fQuery = "";
		try {
			// fQuery = " SELECT * FROM "+dbName+".file_uploads where field_id="+fieldId+"
			// ORDER BY file_id DESC LIMIT 1";
			fQuery = " SELECT * FROM " + dbName + ".file_uploads where file_id=" + "(SELECT uploadedFiles_file_id FROM "
					+ dbName + ".data_form_file_uploads WHERE data_form_formId=" + fId + ");";
			log.info("query for finding max value of filledseat ::::: " + fQuery);
			stmt = con.createStatement();
			rs = stmt.executeQuery(fQuery);
			// log.info("resultSet is ::::: "+rs.toString());

			while (rs.next()) {
				fileLink = rs.getString("file_path");
			}
			log.info("fileLink is ::::: " + fileLink);

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			con.close();
			stmt.close();
			rs.close();
		}
		return fileLink;
	}

}
