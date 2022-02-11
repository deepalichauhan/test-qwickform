package com.sabpaisa.qforms.daoImpl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.controller.FormBuilderController;
import com.sabpaisa.qforms.dao.TesmToDeleteDao;
import com.sabpaisa.qforms.services.DaoFieldLookupService;

@Repository
public class tempToDeleteDaoImpl implements TesmToDeleteDao {

	@Autowired
	SessionFactory factory;

	@Autowired
	DataSource dataSource;

	@Autowired
	JdbcTemplate jdbcTemplate;

	@Autowired
	private DaoFieldLookupService daoFieldLookupService;

	private static final Logger log = LogManager.getLogger("tempToDeleteDaoImpl.class");

	private List<SampleFormBean> formsList = new ArrayList<SampleFormBean>();

	@Override
	public List<Map<String, Object>> colNameColValue1(ArrayList<String> nameOfFields, Integer formTempId, HttpSession ses) {
		log.debug("Start of colNameColValue() method");
		FormBuilderController formBuilder = new FormBuilderController();
		BeanFormDetails form = new BeanFormDetails();

		List<BeanFormStructure> structureList = null;
		Map<String, Object> mappingForResult = new HashMap<String, Object>();
		ArrayList<String> columnNameList = new ArrayList<String>();
		ArrayList<String> columnNameList1 = new ArrayList<String>();
		Map<String, String> mapForDataForm = new HashMap<String, String>();
		List<Map<String, Object>> aliasToValueMapList = null;
		List<Object> list = new ArrayList<Object>();
		String sqlQuery = "";
		Boolean flag = false;
		try {
			Session session = factory.openSession();
			String fieldNames = String.join(" && ", nameOfFields);
			log.debug("fieldNames in form of string Field Value is" + fieldNames);

			form = daoFieldLookupService.getFormDetails(formTempId);

			formBuilder.SetOptionsMap(form, ses);
			form = formBuilder.orderStructure(form);
			structureList = form.getStructureList();
			log.debug("Now structure list for this form is ::::::::: " + structureList.toString());

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
				string2 = string2.replaceAll("\\:", "cln");
				string2 = string2.replaceAll("\\.", "dot");
				string2 = StringUtils.removeEnd(string2, "_");
				log.debug("generate column names ::" + string2);

				if (!string2.equals("Category") && !string2.equals("Page_Title") && !string2.equals("Notification")) {
					log.debug("in If String2 value is :::::::::: " + string2 + " lookup id is for this field :: "
							+ lookupId);
					columnNameList.add(string2);
					columnNameList1.add(lookupId + "~" + string2);
				} else {
					log.debug("in else String2 value is :::::::::: " + string2);

				}

			}

			log.debug("generate column names ::" + columnNameList.toString());
			String columnNames = String.join(",", columnNameList);
			log.debug("column names in string formate ::" + columnNames);

			sqlQuery = "select " + columnNames + " from zz_client_user_data_" + formTempId + " where " + fieldNames
					+ ";";
			log.debug("sqlQuery is ::::: " + sqlQuery);

			// Transaction tx = session.beginTransaction();

			Query query = session.createSQLQuery(sqlQuery);

			log.debug("query is " + query);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			log.debug("query is " + query.list());

			aliasToValueMapList = query.list();

			for (Map<String, Object> i : aliasToValueMapList) {

				log.debug("each value of list as in map :: " + i.values().toString());
				flag = true;
				list.addAll(i.values());
			}
			log.debug("value of list of zz_client_user_data_" + formTempId + " by the var name list is >> "
					+ list.toString());
			log.debug("generate column names ::" + columnNameList.toString());

			log.debug("value of list of zz_client_user_data_" + formTempId
					+ " by the var name aliasToValueMapList is >> {" + aliasToValueMapList + "}");

		} catch (Exception e) {
			log.debug("Exception Occoured " + e);
			flag = false;
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
		String sqlQuery = "", transId = "";
		List<Object> list = new ArrayList<Object>();

		List<Map<String, Object>> aliasToValueMapList = null;
		try {
			sqlQuery = "select transId from zz_client_user_data_" + formTempId + " where " + fieldNames + ";";
			log.debug("sqlQuery is ::::: " + sqlQuery);

			Query query = session.createSQLQuery(sqlQuery);

			log.debug("query is " + query);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			log.debug("query is " + query.list());

			aliasToValueMapList = query.list();

			for (Map<String, Object> i : aliasToValueMapList) {
				log.debug("each value of list as in map :: " + i.values().toString());
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
	public SampleFormBean saveFormData(SampleFormBean saveData) {
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate((Object) saveData);
			session.getTransaction().commit();
			SampleFormBean sampleFormBean = saveData;
			return sampleFormBean;
		} catch (Exception e) {
			e.printStackTrace();
			SampleFormBean sampleFormBean = saveData;
			return sampleFormBean;
		} finally {
			session.close();
		}
	}

	@Override
	public SampleFormBean getFormData(Integer id) {
		log.debug("Start getFormData() method in SampleFormDaoImpl.");
		SampleFormBean beanFormData;
		Session session = factory.openSession();
		beanFormData = new SampleFormBean();
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
		Session session = factory.openSession();
		try {
			Criteria cr = session.createCriteria(SampleFormBean.class);
			if (idType.equals("userid")) {
				cr.add((Criterion) Restrictions.eq((String) "formApplicantId", (Object) Integer.parseInt(id)));
			} else {
				cr.add((Criterion) Restrictions.eq((String) "formId", (Object) Integer.parseInt(id)));
			}
			this.formsList = cr.list();
			List<SampleFormBean> list = this.formsList;
			log.debug("End getformList() method in SampleformdaoImpl.");
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			List<SampleFormBean> list = this.formsList;
			return list;
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
			log.debug("returning form name is " + beanFormDetails.getFormName());
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

}
