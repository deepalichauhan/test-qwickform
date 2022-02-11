package com.sabpaisa.qforms.daoImpl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanFormStructure;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.dao.SampleTransDao;
import com.sabpaisa.qforms.job.QCJDBCConnection;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.util.ApplicationStatus;
import com.sabpaisa.qforms.util.CommonsUtil;
import com.sabpaisa.qforms.util.DBConnection;
import com.sabpaisa.qforms.util.SendMail;

@Repository
public class SampleTransDaoImpl implements SampleTransDao {

	@Autowired
	SessionFactory factory;

	@Autowired
	DataSource dataSource;

	@Autowired
	JdbcTemplate jdbcTemplate;

	@Autowired
	private SampleFormService sampleFormService;

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String dbName = properties.getProperty("dbName");
	DBConnection connection = new DBConnection();
	String cCodeForMagicBricks = properties.getProperty("cCodeForMagicBricks");
	String cCodeForTVS = properties.getProperty("cCodeForTVS");
	String cCodeForNPCI = properties.getProperty("cCodeForNPCI");
	SendMail mail = new SendMail();
	private static final Logger log = LogManager.getLogger("SampleTransDaoImpl.class");

	@Override
	public SampleTransBean saveTransaction(SampleTransBean beanTransData) {
		// Declarations

		// Open session from session factory
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(beanTransData);
			session.getTransaction().commit();

			log.debug("setting transCreationErrorFlag to success");
			beanTransData.setTransCreationErrorFlag(ApplicationStatus.SUCCESS.toString());
			return beanTransData;

		} catch (Exception e) {
			e.printStackTrace();

			log.debug("setting transCreationErrorFlag to error");
			beanTransData.setTransCreationErrorFlag("error");
			return beanTransData;
		} finally {
			// close session
			session.close();
		}
	}

	@Override
	public SampleTransBean updateChalanTransaction(SampleTransBean beanTransData) {
		// Declarations

		// Open session from session factory
		Session session = factory.openSession();
		try {
			session.beginTransaction();
			session.update(beanTransData);
			session.getTransaction().commit();

			log.debug("setting transCreationErrorFlag to success");
			beanTransData.setTransCreationErrorFlag(ApplicationStatus.SUCCESS.toString());
			return beanTransData;

		} catch (Exception e) {
			e.printStackTrace();

			log.debug("setting transCreationErrorFlag to error");
			beanTransData.setTransCreationErrorFlag("error");
			return beanTransData;
		} finally {
			// close session
			session.close();
		}
	}

	@Override
	public ArrayList<SampleTransBean> getTransactions() {
		// Declarations
		ArrayList<SampleTransBean> resultList = new ArrayList<SampleTransBean>();
		// Open session from session factory
		Session session = factory.openSession();
		try {

			Criteria cr = session.createCriteria(SampleTransBean.class);
			resultList = new ArrayList<SampleTransBean>(cr.list());
			return resultList;

		} catch (Exception e) {
			e.printStackTrace();
			return resultList;
		} finally {
			// close session
			session.close();
		}
	}

	@Override
	public SampleTransBean getTransactions(Integer transId) {
		// Declarations
		SampleTransBean resultList = new SampleTransBean();

		// Open session from session factory
		Session session = factory.openSession();
		try {

			Criteria cr = session.createCriteria(SampleTransBean.class);
			cr.add(Restrictions.eq("id", transId));
			resultList = (SampleTransBean) cr.list().get(0);
			return resultList;

		} catch (Exception e) {
			e.printStackTrace();
			return resultList;
		} finally {
			// close session
			session.close();
		}
	}

	@Override
	public SampleTransBean getLastTransactions() {
		// Declarations
		SampleTransBean resultList = new SampleTransBean();

		// Open session from session factory
		Session session = factory.openSession();
		try {

			Criteria cr = session.createCriteria(SampleTransBean.class);
			cr.addOrder(Order.desc("transId"));
			cr.setMaxResults(1);
			resultList = (SampleTransBean) cr.list().get(0);

		} catch (IndexOutOfBoundsException e) {
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return resultList;
		} finally {
			// close session
			session.close();
		}
		return resultList;
	}

	@Override
	public SampleTransBean getTransactions(String transId) {
		SampleTransBean resultList = new SampleTransBean();
		log.info("Open getTransaction() method");
		log.info("transId:" + transId);
		// Open session from session factory
		Session session = factory.openSession();
		try {
			Criteria cr = session.createCriteria(SampleTransBean.class);
			cr.add(Restrictions.eq("transId", transId));
			resultList = (SampleTransBean) cr.list().get(0);
			return resultList;
		} catch (IndexOutOfBoundsException e) {
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return resultList;
		} finally {
			// close session
			log.info("End getTransaction() method");
			session.close();
		}
	}

	@Override
	public SampleTransBean getTransactionsBySabPaisaTxnId(String transId) {
		SampleTransBean resultList = new SampleTransBean();
		log.info("Start of getTransactionsBySabPaisaTxnId() method");
		// log.info("Sp transId:" + transId);
		// Open session from session factory
		Session session = factory.openSession();
		try {
			Criteria cr = session.createCriteria(SampleTransBean.class);
			cr.add(Restrictions.eq("spTransId", transId));
			resultList = (SampleTransBean) cr.list().get(0);
			log.info("size of result list " + resultList.getSpTransId() + " " + resultList.getName());
			log.info("End of getTransactionsBySabPaisaTxnId() method");
			return resultList;
		} catch (IndexOutOfBoundsException e) {
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return resultList = null;
		} finally {
			// close session
			session.close();
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public ArrayList<SampleTransBean> getTransactionsOfCollege(Integer collegeId) {

		log.info("Start getTransactionsOfCollege() inside dao class method");
		// Declarations
		ArrayList<SampleTransBean> resultList = new ArrayList<SampleTransBean>();
		// Open session from session factory
		Session session = factory.openSession();
		try {

			Criteria cr = session.createCriteria(SampleTransBean.class);
			cr.add(Restrictions.eq("cid", collegeId.toString()));
			cr.add(Restrictions.eq("transStatus", ApplicationStatus.SUCCESS.toString()));
			// cr.addOrder(Order.desc("transDate"));

			/* String transStatus="Successful"; */
			log.debug("before executing query");

			/*
			 * resultList=(ArrayList<SampleTransBean>)session.createCriteria(
			 * SampleTransBean.class).add(Restrictions.eq("cid",
			 * collegeId.toString())).add(Restrictions.eq("transStatus",
			 * "Successful")).addOrder(Order.desc("transDate")).list();
			 */
			/**/

			/*
			 * resultList = (ArrayList<SampleTransBean>)
			 * session.createCriteria(SampleTransBean.class) .add(Restrictions.eq("cid",
			 * collegeId.toString())).add(Restrictions.eq("transStatus", "SUCCESS"))
			 * .addOrder(Order.desc("transDate")).setMaxResults(50).list();
			 */

			resultList = (ArrayList<SampleTransBean>) cr.list();
			Set<SampleTransBean> resultLists = new LinkedHashSet<SampleTransBean>(resultList);
			resultList.clear();
			// log.debug("after clearing the list "+resultList.size());
			resultList.addAll(resultLists);

			/*
			 * String query =
			 * "SELECT * FROM qcollect.data_transactions where college_Id_fk=:collegeId and transStatus=:transStatus  order by transDate desc"
			 * ; SQLQuery sqlQuery = session.createSQLQuery(query);
			 * sqlQuery.setParameter("collegeId", collegeId);
			 * sqlQuery.addEntity(SampleTransBean.class); resultList = new
			 * ArrayList<SampleTransBean>(sqlQuery.list());
			 */
			// log.debug("after executing query "+resultList.size()+ "
			// "+resultLists.size());
			return resultList;

		} catch (Exception e) {
			e.printStackTrace();
			return resultList;
		} finally {
			// close session
			session.close();
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public ArrayList<SampleTransBean> getTransactionsForCash(Integer collegeId) {

		log.debug("Start getTransactionsForCash() inside dao class method");
		// Declarations
		ArrayList<SampleTransBean> resultList = new ArrayList<SampleTransBean>();
		// Open session from session factory
		Session session = factory.openSession();
		try {

			resultList = (ArrayList<SampleTransBean>) session.createCriteria(SampleTransBean.class)
					.add(Restrictions.eq("transPaymode", "Cash")).add(Restrictions.eq("cid", collegeId.toString()))
					.add(Restrictions.eq("transStatus", "Subject to realization of Payment"))
					.addOrder(Order.desc("transDate")).list();

			// log.info("after executing query Size of List=" + resultList.size());

			// getsabPaisaChallanNo
			for (SampleTransBean sampleTransBean : resultList) {
				try {
					sampleTransBean.setTransPaymode(getsabPaisaChallanNo(sampleTransBean.getSpTransId()));

					log.debug(sampleTransBean.getChallanNo() + ": challan number");
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

			return resultList;

		} catch (Exception e) {
			e.printStackTrace();
			return resultList;
		} finally {
			// close session
			session.close();
		}
	}

	// get challan number by using sabpaisa transId
	@Override
	public String getsabPaisaChallanNo(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {
		Connection con = QCJDBCConnection.getConnection();

		String challanNo = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			// log.info("sabpaisa Txn in :: " + sabPaisaTxnId);
			String query = "select challanNo from sabpaisa.challan_detail where Transaction_id_fk='" + sabPaisaTxnId
					+ "'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {

				challanNo = rs.getString("challanNo");

			}

			return challanNo;
		} catch (Exception e) {
			e.printStackTrace();
			return challanNo;
		} finally {

			con.close();
		}

	}

	@Override
	public String updateSabPaisaChallan(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {
		Connection con = QCJDBCConnection.getConnection();

		Statement stmt = null;
		Statement stmt1 = null;

		try {
			// log.info("sabpaisa Txn in :: " + sabPaisaTxnId);
			String query = "update  sabpaisa.challan_detail set challan_status='SUCCESS' where Transaction_id_fk='"
					+ sabPaisaTxnId + "'";
			stmt = con.createStatement();
			stmt.executeUpdate(query);
			return sabPaisaTxnId;
		} catch (Exception e) {
			e.printStackTrace();
			return sabPaisaTxnId;
		} finally {

			con.close();
		}

	}

	@Override
	public String updateSabPaisaTransactionDetail(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {
		Connection con = QCJDBCConnection.getConnection();

		Statement stmt = null;
		Statement stmt1 = null;

		try {
			// log.debug("sabpaisa Txn in :: " + sabPaisaTxnId);
			String queryforUpdatingSPTransTable = "update  sabpaisa.transaction_detail set status='SUCCESS' where txnId='"
					+ sabPaisaTxnId + "'";

			stmt1 = con.createStatement();
			stmt1.executeUpdate(queryforUpdatingSPTransTable);

			return sabPaisaTxnId;
		} catch (Exception e) {
			e.printStackTrace();
			return sabPaisaTxnId;
		} finally {

			con.close();
		}

	}

	@Override
	public List<SampleTransBean> getTransactionsDetails(String formId, String fromDate, String toDate, String payMode,
			Integer clientId) throws ParseException {
		Session session = factory.openSession();

		List<SampleTransBean> formBeanList = new ArrayList<SampleTransBean>();
		Integer idForForm = Integer.parseInt(formId);
		Date dateFrom = null;
		Date dateTo = null;

		if (fromDate == "" || toDate == "") {
			log.debug("date null val");
			String pattern = "dd-MM-yyyy";
			toDate = new SimpleDateFormat(pattern).format(new Date());
			fromDate = new SimpleDateFormat(pattern).format(new DateTime(dateTo).minusDays(3).toDate());
		}

		Integer feeId = null;
		try {
			Criteria criteria = session.createCriteria(SampleTransBean.class);
			if (idForForm != null) {
				criteria.add(Restrictions.eq("formId", idForForm));
			}
			if ((fromDate != null && !fromDate.isEmpty()) && (toDate != null && !toDate.isEmpty())) {
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				dateFrom = sdf.parse(fromDate);
				dateTo = sdf.parse(toDate);
				dateTo.setDate(dateTo.getDate() + 1);
				criteria.add(Restrictions.between("transDate", dateFrom, dateTo));
			}
			if ((payMode != null && !payMode.isEmpty())) {

				criteria.add(Restrictions.eq("transPaymode", payMode));
			}
			// log.info("fetching data trans "+dateFrom+" "+dateTo+" "+clientId+ "
			// "+idForForm);
			criteria.addOrder(Order.desc("transDate"));
			criteria.add(Restrictions.eq("cid", clientId.toString()));
			// criteria.add(Restrictions.eq("transStatus", "success") );
			// criteria.add(Restrictions.eq("transStatus", "cancelled") );
			// criteria.add(Restrictions.or(Restrictions.eq("transStatus",
			// "pending"),Restrictions.eq("transStatus", "cancelled")) );
			criteria.add(Restrictions.in("transStatus", new String[] { "cancelled",
					ApplicationStatus.SUCCESS.toString(), ApplicationStatus.FAILED.toString() }));
			formBeanList = criteria.list();
		} catch (java.lang.NumberFormatException e) {
			return formBeanList;
		} finally {
			// close session
			session.close();

		}
		return formBeanList;

	}

	@Override
	public SampleTransBean getTransactionDetailsBasedOnTransactionId(String txnId) {
		Session session = factory.openSession();
		SampleTransBean transationDetails = null;

		try {
			/* .add(Restrictions.eq("transStatus", "success")) */
			transationDetails = (SampleTransBean) session.createCriteria(SampleTransBean.class)
					.add(Restrictions.eq("transId", txnId.trim())).list().get(0);
		} catch (Exception ex) {

			ex.printStackTrace();
			return transationDetails;
		} finally {
			session.close();
		}

		return transationDetails;

	}

	@Override
	public List<SampleTransBean> getOldTransacionDetail(String transId, String birthDate, String contactNo,
			String fromDate, String toDate, String clientId) throws ParseException {

		Session session = factory.openSession();
		List<SampleTransBean> list = new ArrayList<SampleTransBean>();
		try {

			Criteria criteria = session.createCriteria(SampleTransBean.class);

			if (fromDate.equals("") && toDate.equals("")) {

				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

				Date bd = sdf.parse(birthDate);

				criteria.add(Restrictions.eq("contact", contactNo)).add(Restrictions.eq("dob", bd))
						.add(Restrictions.eq("transId", transId));
			} else {
				log.debug("Inside Else");
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

				Date bd = sdf.parse(birthDate);
				Date fromDT = sdf.parse(fromDate);
				Date toDT = sdf.parse(toDate);
				toDT.setDate(toDT.getDate() + 1);

				criteria.add(Restrictions.eq("contact", contactNo)).add(Restrictions.eq("dob", bd))
						.add(Restrictions.between("transDate", fromDT, toDT)).addOrder(Order.desc("transDate"));

			}
			criteria.add(Restrictions.eq("cid", clientId));
			criteria.add(Restrictions.eq("transStatus", ApplicationStatus.SUCCESS.toString()));
			list = criteria.list();

			// log.info("List SIze ::" + list.size());

			return list;

		} finally {
			// close session
			session.close();
		}

	}

	@Override
	public String getFormDetail(Integer id) {
		Session session = factory.openSession();

		BeanFormDetails beanFormDetails = new BeanFormDetails();
		// log.info("id Value is:" + id);
		try {
			beanFormDetails = (BeanFormDetails) session.get(BeanFormDetails.class, id);
			// log.info("form Name is ::" + beanFormDetails.getFormName());
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return beanFormDetails.getFormName();
	}

	@Override
	public SampleFormBean getFormDetailByUsingTransId(String id) {
		Session session = factory.openSession();
		SampleFormBean beanFormDetails = new SampleFormBean();
		// log.info("id Value is:" + id);
		try {
			beanFormDetails = (SampleFormBean) session.createCriteria(SampleFormBean.class)
					.add(Restrictions.eq("formTransId", id)).list().iterator().next();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return beanFormDetails;
	}

	// for testing
	@Override
	@SuppressWarnings("unchecked")
	public List<SampleFormBean> getFormDetailByUsingTransIds(Integer clientId) {
		Session session = factory.openSession();
		// log.info("fetching form data details for form idd is "+clientId);
		List<SampleFormBean> beanFormDetails = new ArrayList<SampleFormBean>();
		// log.info("id Value is:" + clientId);
		try {
			beanFormDetails = (List<SampleFormBean>) session.createCriteria(SampleFormBean.class)
					.add(Restrictions.eq("formInstId", clientId)).list();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		// log.info("list sssize "+beanFormDetails.size());
		return beanFormDetails;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<SampleTransBean> getSuccessTransactionDetails(Integer collegeId, String feeType) {
		Session session = factory.openSession();
		List<SampleTransBean> successfulTransationDetails = null;
		// log.info(feeType + " : " + collegeId);
		try {
			/* .add(Restrictions.eq("transStatus", "success")) */
			successfulTransationDetails = (List<SampleTransBean>) session.createCriteria(SampleTransBean.class)
					.add(Restrictions.eq("cid", collegeId.toString().trim()))
					.add(Restrictions.eq("transStatus", ApplicationStatus.SUCCESS.toString())).list();
		} catch (Exception ex) {

			ex.printStackTrace();
			return successfulTransationDetails;
		} finally {
			// close session
			session.close();
		}
		log.debug(successfulTransationDetails.size() + ":---: list size is");
		return successfulTransationDetails;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<SampleTransBean> getTransactionDetailsForChallanMIS(Integer collegeId, String feeType) {
		Session session = factory.openSession();
		List<SampleTransBean> successfulTransationDetails = null;
		log.debug(feeType + " : " + collegeId);
		try {
			/* .add(Restrictions.eq("transStatus", "success")) */
			successfulTransationDetails = (List<SampleTransBean>) session.createCriteria(SampleTransBean.class)
					.add(Restrictions.eq("cid", collegeId.toString().trim()))
					.add(Restrictions.eq("transPaymode", "Cash")).list();
		} catch (Exception ex) {

			ex.printStackTrace();
			return successfulTransationDetails;
		} finally {
			// close session
			session.close();
		}
		log.debug(successfulTransationDetails.size() + ":---: list size is");
		return successfulTransationDetails;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<SampleTransBean> getSuccessTransactionDetailsBasedOnDates(Integer collegeId, String feeType,
			String fromDate, String toDate) throws ParseException {
		Session session = factory.openSession();
		List<SampleTransBean> successfulTransationDetails = null;
		log.debug(feeType + " : " + collegeId);
		Date fromDT = null;
		Date toDT = null;

		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			/* .add(Restrictions.eq("transStatus", "success")) */
			Criteria criteria = session.createCriteria(SampleTransBean.class);
			criteria.add(Restrictions.eq("cid", collegeId.toString().trim()))
					.add(Restrictions.eq("transStatus", ApplicationStatus.SUCCESS.toString()));
			if (fromDate != null || toDate != null) {

				fromDT = sdf.parse(fromDate);
				toDT = sdf.parse(toDate);
				criteria.add(Restrictions.between("transDate", fromDT, toDT));
			} else {

				toDT = new Date();
				fromDT = new DateTime(toDT).minusDays(3).toDate();
			}
			successfulTransationDetails = (List<SampleTransBean>) criteria.list();
		} catch (Exception ex) {

			ex.printStackTrace();
			return successfulTransationDetails;
		} finally {
			// close session
			session.close();
		}
		log.debug(successfulTransationDetails.size() + ":---: list size is");
		return successfulTransationDetails;
	}

	@Override
	public ArrayList<String> filterTheRecordBasedOnFormName(String formId, String fromDate, String toDate,
			String paymentMode, String transStatus) throws ParseException {
		Session session = factory.openSession();
		String fQuery = "";
		Date fromDT = null;
		Date toDT = null;
		ArrayList<String> val1 = new ArrayList<String>();
		List<ArrayList<String>> val = new ArrayList<ArrayList<String>>();
		log.info("fromDate:toDate:paymentMode= " + fromDate + ":" + toDate + ":" + paymentMode + ":" + transStatus);
		if (fromDate == "" || toDate == "") {
			log.debug("date null val");
			String pattern = "dd-MM-yyyy";
			toDate = new SimpleDateFormat(pattern).format(new Date());
			fromDate = new SimpleDateFormat(pattern).format(new DateTime(toDT).minusDays(3).toDate());
			// log.debug("fromDate:toDate= " + fromDate + ":" + toDate);
		}
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			if ((transStatus == "" || transStatus == null) && (paymentMode == "" || paymentMode == null)) {
				log.info("trans Status & paymentMode is null");

				fQuery = "select * from zz_client_user_data_" + formId
						+ " where transDate >=:fromDat and  transDate <=:toDat order by transDate";
				SQLQuery query1 = session.createSQLQuery(fQuery);
				try {
					if ((fromDate != null || fromDate != "") || (toDate != null || toDate != "")) {
						fromDT = sdf.parse(fromDate);
						toDT = sdf.parse(toDate);
						log.info("from Date : {" + fromDT + "} : toDate 1 : {" + toDT + "}");
						toDT.setTime(toDT.getTime() + 0 * 24 * 60 * 60 * 1000);
						fromDT.setTime(fromDT.getTime() - 1 * 24 * 60 * 60 * 1000);
						log.info("from Date : {" + fromDT + "} : toDate 2 : {" + toDT + "}");
						query1.setParameter("fromDat", fromDT);
						query1.setParameter("toDat", toDT);
					}
					if (fromDate == "" || toDate == "") {
						log.debug("date null val");
						toDT = new Date();
						fromDT = new DateTime(toDT).minusDays(3).toDate();
						query1.setParameter("fromDat", fromDT);
						query1.setParameter("toDat", toDT);
					}
				} catch (Exception ex) {

				}
				List<Object[]> rows = query1.list();
				for (Object[] objects : rows) {
					// log.debug("records === " + Arrays.toString(objects));
					val1.add(Arrays.toString(objects));
				}
				return val1;
			}
			if (paymentMode == null || paymentMode == "") {
				log.info("paymentMode is null");
				fQuery = "select * from zz_client_user_data_" + formId
						+ " where transStatus=:transStatus and  transDate >=:fromDat and  transDate <=:toDat order by transDate";
				SQLQuery query1 = session.createSQLQuery(fQuery);
				query1.setParameter("transStatus", transStatus);
				try {
					if ((fromDate != null || fromDate != "") || (toDate != null || toDate != "")) {
						fromDT = sdf.parse(fromDate);
						toDT = sdf.parse(toDate);
						log.info("from Date : {" + fromDT + "} : toDate 1 : {" + toDT + "}");
						toDT.setTime(toDT.getTime() + 0 * 24 * 60 * 60 * 1000);
						fromDT.setTime(fromDT.getTime() - 1 * 24 * 60 * 60 * 1000);
						log.info("from Date : {" + fromDT + "} : toDate 2 : {" + toDT + "}");
						query1.setParameter("fromDat", fromDT);
						query1.setParameter("toDat", toDT);
					}
				} catch (Exception ex) {

				}
				List<Object[]> rows = query1.list();
				for (Object[] objects : rows) {
					// log.debug("records === " + Arrays.toString(objects));
					val1.add(Arrays.toString(objects));
				}
				return val1;
			}
			if (transStatus == null || transStatus == "") {
				log.info("transStatus is null");
				fQuery = "select * from zz_client_user_data_" + formId
						+ " where transPaymode=:paymentMode  and  transDate >=:fromDat and  transDate <=:toDat order by transDate";
				SQLQuery query1 = session.createSQLQuery(fQuery);
				query1.setParameter("paymentMode", paymentMode);
				try {
					if ((fromDate != null || fromDate != "") || (toDate != null || toDate != "")) {
						fromDT = sdf.parse(fromDate);
						toDT = sdf.parse(toDate);
						log.info("from Date : {" + fromDT + "} : toDate 1 : {" + toDT + "}");
						toDT.setTime(toDT.getTime() + 0 * 24 * 60 * 60 * 1000);
						fromDT.setTime(fromDT.getTime() - 1 * 24 * 60 * 60 * 1000);
						log.info("from Date : {" + fromDT + "} : toDate 2 : {" + toDT + "}");
						query1.setParameter("fromDat", fromDT);
						query1.setParameter("toDat", toDT);
					}
				} catch (Exception ex) {

				}
				List<Object[]> rows = query1.list();
				for (Object[] objects : rows) {
					// log.debug("records === " + Arrays.toString(objects));
					val1.add(Arrays.toString(objects));
				}
				return val1;
			}

			if ((transStatus != null || transStatus != "") && (paymentMode != null || paymentMode != "")) {
				log.info("all filters used for fetching data");
				fQuery = "select * from zz_client_user_data_" + formId
						+ " where transPaymode=:status and transStatus=:transStatus and  transDate >=:fromDat and  transDate <=:toDat order by transDate";
				SQLQuery query1 = session.createSQLQuery(fQuery);
				query1.setParameter("status", paymentMode);
				query1.setParameter("transStatus", transStatus);
				try {
					if ((fromDate != null || fromDate != "") || (toDate != null || toDate != "")) {
						fromDT = sdf.parse(fromDate);
						toDT = sdf.parse(toDate);
						log.info("from Date : {" + fromDT + "} : toDate 1 : {" + toDT + "}");
						toDT.setTime(toDT.getTime() + 0 * 24 * 60 * 60 * 1000);
						fromDT.setTime(fromDT.getTime() - 1 * 24 * 60 * 60 * 1000);
						log.info("from Date : {" + fromDT + "} : toDate 2 : {" + toDT + "}");
						query1.setParameter("fromDat", fromDT);
						query1.setParameter("toDat", toDT);
					}

				} catch (Exception ex) {

				}
				List<Object[]> rows = query1.list();
				for (Object[] objects : rows) {
					// log.debug("records === " + Arrays.toString(objects));
					val1.add(Arrays.toString(objects));
				}
				return val1;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return val1;
		} finally {
			session.close();
		}
		return val1;

	}

	@Override
	public ArrayList<String> fetchTheRecordBasedOnFormName(String formId, String cCode, String payer)
			throws ParseException {
		Session session = factory.openSession();
		String fQuery = "";
		ArrayList<String> val1 = new ArrayList<String>();
		List<ArrayList<String>> val = new ArrayList<ArrayList<String>>();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			fQuery = "select * from zz_" + cCode + "_" + payer + "_" + formId + " where 1";
			SQLQuery query1 = session.createSQLQuery(fQuery);

			List<Object[]> rows = query1.list();
			for (Object[] objects : rows) {
				// log.debug("records === " + Arrays.toString(objects));
				val1.add(Arrays.toString(objects));
			}
			return val1;
		} catch (Exception ex) {
			ex.printStackTrace();
			return val1;
		} finally {
			session.close();
		}
//		return val1;
	}

	@Override
	public ArrayList<String> fetchTeRecordBasedOnFormName(String formId, String cCode, String payer, String stre,
			String cousreFlag) throws ParseException {
		Session session = factory.openSession();
		String fQuery = "";
		ArrayList<String> val1 = new ArrayList<String>();
		List<ArrayList<String>> val = new ArrayList<ArrayList<String>>();
		try {
			if (null != cousreFlag && cousreFlag.equalsIgnoreCase("Others")) {
				fQuery = "select " + stre + " from zz_" + cCode + "_" + payer + "_" + formId + " where Course IN ('BLIB', 'BPED', 'BSW', 'MCA', 'MCOMMED', 'MLIB', 'MPED', 'MSW')";
			} else if (null != cousreFlag && cousreFlag.equalsIgnoreCase("BA_BCOM")) {
				fQuery = "select " + stre + " from zz_" + cCode + "_" + payer + "_" + formId + " where Course IN ('BA ANTHROPOLOGY', 'BA ECONOMICS', 'BA ENGLISH', 'BA HINDI', 'BA HISTORY', 'BA POLITICAL SCIENCE', 'BALLB','Bcom', 'BCOM LLB')";
			} else if (null != cousreFlag && cousreFlag.equalsIgnoreCase("BPharma_Bed")) {
				fQuery = "select " + stre + " from zz_" + cCode + "_" + payer + "_" + formId + " where Course IN ('B Pharma', 'DPHARMA', 'BED', 'BED SP HI', 'BED SP LD')";
			} else if (null != cousreFlag && cousreFlag.equalsIgnoreCase("BSC")) {
				fQuery = "select " + stre + " from zz_" + cCode + "_" + payer + "_" + formId + " where Course IN ('BSC Anthropology', 'BSC BIOTECHNOLOGY', 'BSC BOTANY', 'BSC CHEMESTRY', 'BSC COMPUTER SCIENCE', 'BSC ELECTRONICS', 'BSC FORENSIC SCIENCE', "+ 
						"'BSC FORESTRY', 'BSC MATHEMATICS', 'BSC PHYSICS', 'BSC RURAL TECHNOLOGY', 'BSC ZOOLOGY')";
			} else if (null != cousreFlag && cousreFlag.equalsIgnoreCase("MSC_MA")) {
				fQuery = "select " + stre + " from zz_" + cCode + "_" + payer + "_" + formId + " where Course IN ('MSC BIOTECHNOLOGY', 'MSC BOTANY', 'MSC CHEMESTRY', 'MSC COMPUTER SCIENCE', 'MSC ELECTRONICS', 'MSC FORENSIC SCIENCE', 'MSC FORESTRY', 'MSC MATHEMATICS', " + 
						" 'MSC PHYSICS', 'MSC RURAL TECHNOLOGY', 'MSC ZOOLOGY', 'MA ECONOMICS', 'MA ENGLISH', 'MA HINDI', 'MA HISTORY', 'MA JMC', 'MA MSC ANTHROPOLOGY', 'MA POLYTICAL SCIENCE')";
			}else {
				fQuery = "select " + stre + " from zz_" + cCode + "_" + payer + "_" + formId + " where 1";
			}

			SQLQuery query1 = session.createSQLQuery(fQuery);

			List<Object[]> rows = query1.list();
			for (Object[] objects : rows) {
				// log.debug("records === " + Arrays.toString(objects));
				val1.add(Arrays.toString(objects));
			}
			return val1;
		} catch (Exception ex) {
			ex.printStackTrace();
			return val1;
		} finally {
			session.close();
		}
//		return val1;
	}

//	@Override
//	public ArrayList<String> fetchTeRecordBasedOnFormName(String formId, String cCode, String payer, String stre,
//			String cousreFlag) throws ParseException {
//		Session session = factory.openSession();
//		String fQuery = "";
//		ArrayList<String> val1 = new ArrayList<String>();
//		List<ArrayList<String>> val = new ArrayList<ArrayList<String>>();
//		try {
//			fQuery = "select " + stre + " from zz_" + cCode + "_" + payer + "_" + formId + " where 1";
////				fQuery = "select "+stre+" from zz_"+cCode+"_"+payer+"_"+formId+" where id between 21 and 40";
//			SQLQuery query1 = session.createSQLQuery(fQuery);
//
//			List<Object[]> rows = query1.list();
//			for (Object[] objects : rows) {
//				// log.debug("records === " + Arrays.toString(objects));
//				val1.add(Arrays.toString(objects));
//			}
//			return val1;
//		} catch (Exception ex) {
//			ex.printStackTrace();
//			return val1;
//		} finally {
//			session.close();
//		}
////		return val1;
//	}

	@Override
	public ArrayList<String> getTableHeaderNames(String formId) {
		Session session = factory.openSession();
		ArrayList<String> val1 = new ArrayList<String>();
		ArrayList<String> val2 = new ArrayList<String>();
		log.debug("i am in header section.");
		try {
			SQLQuery query1 = session.createSQLQuery("DESCRIBE zz_client_user_data_" + formId);
			/* query1.setParameter("", arg1) */
			List<Object[]> rows = query1.list();

			for (Object[] objects : rows) {

				// log.debug(" header vals=== " + Arrays.toString(objects));
				val1.add(Arrays.toString(objects));
				// log.info(" header vals in first for loop === " + val1.toString());

			}
			for (String headerVal : val1) {
				String[] hVal = headerVal.split(",");
				// log.info(" header vals second for loop === " + hVal[0]);

				// MySQl Column names
				String transformedHeaderName = transformHeaderName(hVal[0].substring(1));
				val2.add(transformedHeaderName);

			}
			log.debug("Return values in outer second for loop ===  " + val2.toString());
			return val2;
		} catch (Exception ex) {
			ex.printStackTrace();
			return val2;
		} finally {
			session.close();
		}
	}

	@Override
	public ArrayList<String> getTabHeaderNames(String formId, String cCode, String payer) {
		Session session = factory.openSession();
		ArrayList<String> val1 = new ArrayList<String>();
		ArrayList<String> val2 = new ArrayList<String>();
		log.debug("i am in header section.");
		try {
			SQLQuery query1 = session.createSQLQuery("DESCRIBE zz_" + cCode + "_" + payer + "_" + formId);
			/* query1.setParameter("", arg1) zz_lnm01_applicant_567 */
			List<Object[]> rows = query1.list();

			for (Object[] objects : rows) {

				// log.debug(" header vals=== " + Arrays.toString(objects));
				val1.add(Arrays.toString(objects));
				// log.info(" header vals in first for loop === " + val1.toString());

			}
			for (String headerVal : val1) {
				String[] hVal = headerVal.split(",");
				// log.info(" header vals second for loop === " + hVal[0]);

				// MySQl Column names
				String transformedHeaderName = transformHeaderName(hVal[0].substring(1));
				val2.add(transformedHeaderName);

			}
			log.debug("Return values in outer second for loop ===  " + val2.toString());
			return val2;
		} catch (Exception ex) {
			ex.printStackTrace();
			return val2;
		} finally {
			session.close();
		}
	}

	@Override
	public String transformHeaderName(String originalHeaderName) {
		log.debug("originalHeaderName here is.." + originalHeaderName);

		String revisedHeaderName = "";
		String deconvertedLiteral = "";
		;
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

	@Override
	public void updateSpotChallanTransactionDao(String spTransId) {

		log.debug("inside dao class method:" + spTransId);
		// Declarations
		SampleTransBean resultList = new SampleTransBean();
		// Open session from session factory
		Session session = factory.openSession();

		try {

			resultList = (SampleTransBean) session.createCriteria(SampleTransBean.class)
					.add(Restrictions.eq("spTransId", spTransId)).list().get(0);
			session.beginTransaction();
			updateSabPaisaChallan(spTransId);
			updateSabPaisaTransactionDetail(spTransId);
			resultList.setTransStatus(ApplicationStatus.SUCCESS.toString());
			session.merge(resultList);
			session.getTransaction().commit();
			log.debug("after executing query Size of List=");

			// getsabPaisaChallanNo

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			// close session
			session.close();
		}
	}

	@Override
	public void updateApplicantTransDataToReportingDB(HttpSession ses, ArrayList<String> nameOfFields, String transId,
			double transAmount, BeanFormDetails beanDataForm) {

		log.info("Start updateApplicantTransDataToReportingDB() method in SampleTransDaoImpl");
		BeanFormDetails formBean = new BeanFormDetails();
		formBean = beanDataForm;
		// log.info(formBean.getId().toString() + " :::::::Form Name for this FormId :::
		// " + formBean.getFormName().toString());

		ArrayList<String> validateFieldsName = (ArrayList<String>) ses.getAttribute("validateFieldNames");
		// log.info("validate field names for where clouse :::::::
		// "+validateFieldsName.toString());

		// log.info("nameOfFields field names for where clouse :::::::
		// "+nameOfFields.toString());
		String setResultValues = String.join(", ", nameOfFields);
		// log.info("setResultValues field names for where clouse :::::::
		// "+setResultValues.toString());

		String fieldNames = String.join(" && ", validateFieldsName);
		// log.info("fieldNames field names for where clouse :::::::
		// "+fieldNames.toString());

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
		String currentDate = df.format(new Date(System.currentTimeMillis()));
		if (!nameOfFields.isEmpty()) {
			Session session = factory.openSession();
			try {
				try {
					Transaction tx = session.beginTransaction();
					// UPDATE tablename SET online_status=0 WHERE 1=1;
					session.createSQLQuery("UPDATE  zz_client_user_data_" + formBean.getId() + " SET transId='"
							+ transId + "' ,transStatus='pending',transPaymode='N/A'," + " transDate='" + currentDate
							+ "' ,transAmount='" + transAmount + "' ,challanNo='N/A',"
							+ " spTransId=null, pgTransId='N/A', modifiedDate=CURRENT_TIMESTAMP(), updateByJob='N',"
							+ setResultValues + ", form_Name=" + "'" + formBean.getFormName() + "' where " + fieldNames)
							.executeUpdate();

					tx.commit();
				} catch (Exception e) {
					e.printStackTrace();
					session.close();
				}
			} finally {
				session.close();
			}
		}

	}

	public void updateApplicantReportForMB(String cid, String transId, Integer formid) {
		log.info("Start updateApplicantReportForMB() method in SampleTransDaoImpl");
		log.debug(cid + " :::::::transId ::: " + transId + " ::::::formid::::: " + formid);

		Session session = factory.openSession();
		try {
			try {
				Transaction tx = session.beginTransaction();
				// UPDATE tablename SET online_status=0 WHERE 1=1;
				session.createSQLQuery("UPDATE " + dbName + ".data_form SET formTransId='" + transId
						+ "', formClientId='" + cid + "' where formId=" + formid).executeUpdate();

				tx.commit();
			} catch (Exception e) {
				e.printStackTrace();
				session.close();
			}
		} finally {
			session.close();
		}
	}

	@Override
	public void updateTransDataToReportingDB(HttpSession ses, String transStatus, SampleFormBean beanCurrentForm,
			String transId, double transAmount) {

		log.info("calling insertApplicantTransDataToReportingDB ");

		ses.setAttribute("formId", beanCurrentForm.getFormFeeId());

		Integer form_Id = beanCurrentForm.getFormFeeId();
		BeanFormDetails formBean = new BeanFormDetails();
		formBean.setId(form_Id);
		String finalVal = "", strCheckVal = "";
		// log.info("formId is in beanformdetails ::::::::::: " + formBean.getId());
		formBean = sampleFormService.getFormDetails(form_Id);
		// log.info(formBean.getId() + " :::::::Form Name for this FormId ::: " +
		// formBean.getFormName());

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
		String currentDate = df.format(new Date(System.currentTimeMillis()));
		HashMap finalmap = new HashMap();
		// log.info((Object) ("form id is.." + beanCurrentForm.getFormId()));
		// log.info((Object) ("form data is.." + beanCurrentForm.getFormData()));

		if (null != formBean.getValidateFieldOfExcel() || !formBean.getValidateFieldOfExcel().equals("")) {

			String formDataForLP = beanCurrentForm.getFormData();
			String[] formFields = formDataForLP.split(",");
			// log.info("formFields data length is--->>>> " + formFields.length);
			ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
			/*
			 * log.info((Object) ("formFieldsList is " + formFieldsList.toString() +
			 * "  formFieldsList.size() " + formFieldsList.size()));
			 */
			int i = 0;
			// log.debug("Form Field list size is " + formFieldsList.size() + " form " +
			// formFields.length);

			while (i < formFieldsList.size()) {
				log.debug("while loop and value of i is :: " + i);
				String[] formFieldData = formFieldsList.get(i).split(",");
				log.debug("form field data length is .... " + formFieldData.length);
				if (formFieldData.length != 1) {
					log.debug((Object) "if loop");
					log.debug((Object) ("Form Field at index " + i + " is corrupt or unreadable " + formFieldData[i]));
				} else {
					log.info("before form field ddata is " + formFieldData[0]);
					String temp = formFieldData[0];
					String[] b = temp.split("$");
					// log.info("b[0] :: "+b[0]);
					String c[] = b[0].split("~");
					// log.info("c[1] :: "+c[1]);
					int k = c[1].indexOf("=");
					String col = c[1].substring(0, k);
					col = col.replaceAll("\\s", "_");
					// log.info("c[1] for col :: "+col);
					String val = c[1].substring(k + 1, c[1].indexOf("$"));
					// log.info("c[1] for val :: "+val);
					finalVal = finalVal + col + "='" + val + "',";
					// log.info("c[1] for finalVal :: "+finalVal);
					if (formBean.getValidateFieldOfExcel().equalsIgnoreCase(col)) {
						strCheckVal = col + "='" + val + "'";
					}
				}
				++i;
			}
			finalVal = finalVal.substring(0, finalVal.lastIndexOf(","));
			log.info("out side of loop for finalVal :: " + finalVal);
		}

		if (!finalVal.isEmpty() && !strCheckVal.isEmpty()) {
			Session session = factory.openSession();
			try {
				try {
					Transaction tx = session.beginTransaction();

					session.createSQLQuery("UPDATE  zz_client_user_data_" + beanCurrentForm.getFormFeeId()
							+ "  SET transId='" + transId + "' ,transStatus='pending',transPaymode='N/A',"
							+ " transDate='" + currentDate + "' ,transAmount='" + transAmount + "' ,challanNo='N/A',"
							+ " spTransId=null, pgTransId='N/A', modifiedDate=CURRENT_TIMESTAMP(), updateByJob='N',"
							+ finalVal + ", form_Name='" + formBean.getFormName() + "' where " + strCheckVal + ";")
							.executeUpdate();

					tx.commit();
				} catch (Exception e) {
					e.printStackTrace();
					/*
					 * this.mail.sendConflictMail( "Record Not Updated into zz_client_user_data_" +
					 * beanCurrentForm.getFormFeeId() + " while going to SabPaisa",
					 * "praveen.kumar@srslive.in", beanCurrentForm.getEmail(),
					 * beanCurrentForm.getContact(), beanCurrentForm.getName(), e.getMessage());
					 */
					session.close();
				}
			} finally {
				session.close();
			}
		}
	}

	@Override
	public void insertApplicantTransDataToReportingDB(HttpSession ses, String transStatus,
			SampleFormBean beanCurrentForm, String transId, double transAmount) {

		log.info("calling insertApplicantTransDataToReportingDB ");

		ses.setAttribute("formId", beanCurrentForm.getFormFeeId());

		Integer form_Id = beanCurrentForm.getFormFeeId();
		BeanFormDetails formBean = new BeanFormDetails();
		formBean.setId(form_Id);

		// log.info("formId is in beanformdetails ::::::::::: " + formBean.getId());
		formBean = sampleFormService.getFormDetails(form_Id);
		// log.info(formBean.getId() + " :::::::Form Name for this FormId ::: " +
		// formBean.getFormName());

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
		String currentDate = df.format(new Date(System.currentTimeMillis()));
		HashMap finalmap = new HashMap();
		// log.info((Object) ("form id is.." + beanCurrentForm.getFormId()));
		// log.info((Object) ("form data is.." + beanCurrentForm.getFormData()));
		finalmap = getFormDataInSequence(beanCurrentForm, ses);
		// log.info((Object) ("finalmap data is.." + finalmap));
		boolean k = false;
		StringBuilder splVals = new StringBuilder();
		Set setOfKeys = finalmap.keySet();
		Iterator iterator = setOfKeys.iterator();
		while (iterator.hasNext()) {
			Integer key = (Integer) iterator.next();
			String value = (String) finalmap.get(key);
			log.info("Key: " + key + ", Value: " + value);

			if (value.indexOf('*') != -1) {
				log.debug("* found, case of dropdown or radio, so removing asterisk");
				value = value.substring(value.lastIndexOf("*") + 1);
			}

			/* ------------------------ */

			if (null != beanCurrentForm) {

				if (value.equalsIgnoreCase("File Upload1") && beanCurrentForm.getFile_Path1() != null) {
					String nameValue = beanCurrentForm.getFile_Path1();
					value = getGeneratedStringValue(nameValue);

				}
				if (value.equalsIgnoreCase("File Upload2") && beanCurrentForm.getFile_Path2() != null) {
					String nameValue = beanCurrentForm.getFile_Path2();
					value = getGeneratedStringValue(nameValue);

				}
				if (value.equalsIgnoreCase("File Upload3") && beanCurrentForm.getFile_Path3() != null) {
					String nameValue = beanCurrentForm.getFile_Path3();
					value = getGeneratedStringValue(nameValue);

				}
				if (value.equalsIgnoreCase("File Upload4") && beanCurrentForm.getFile_Path4() != null) {
					String nameValue = beanCurrentForm.getFile_Path4();
					value = getGeneratedStringValue(nameValue);

				}
				if (value.equalsIgnoreCase("File Upload5") && beanCurrentForm.getFile_Path5() != null) {
					String nameValue = beanCurrentForm.getFile_Path5();
					value = getGeneratedStringValue(nameValue);

				}
				if (value.equalsIgnoreCase("File Upload6") && beanCurrentForm.getFile_Path6() != null) {
					String nameValue = beanCurrentForm.getFile_Path6();
					value = getGeneratedStringValue(nameValue);

				}
				if (value.equalsIgnoreCase("File Upload7") && beanCurrentForm.getFile_Path7() != null) {
					String nameValue = beanCurrentForm.getFile_Path7();
					value = getGeneratedStringValue(nameValue);

				}
				if (value.equalsIgnoreCase("File Upload8") && beanCurrentForm.getFile_Path8() != null) {
					String nameValue = beanCurrentForm.getFile_Path8();
					value = getGeneratedStringValue(nameValue);

				}
				if (value.equalsIgnoreCase("File Upload9") && beanCurrentForm.getFile_Path9() != null) {
					String nameValue = beanCurrentForm.getFile_Path9();
					value = getGeneratedStringValue(nameValue);

				}
				if (value.equalsIgnoreCase("File Upload10") && beanCurrentForm.getFile_Path10() != null) {
					String nameValue = beanCurrentForm.getFile_Path10();
					value = getGeneratedStringValue(nameValue);

				}

//				if(value.equalsIgnoreCase("File Upload1")) {
//					 value=beanCurrentForm.getFile_Path1();
//					
//				}
//				if(value.equalsIgnoreCase("File Upload2")) {
//					 value=beanCurrentForm.getFile_Path2();
//					
//				}
//				if(value.equalsIgnoreCase("File Upload3")) {
//					 value=beanCurrentForm.getFile_Path3();
//					
//				}
//				if(value.equalsIgnoreCase("File Upload4")) {
//					 value=beanCurrentForm.getFile_Path4();
//					
//				}
//				if(value.equalsIgnoreCase("File Upload5")) {
//					 value=beanCurrentForm.getFile_Path5();
//					
//				}
//				if(value.equalsIgnoreCase("File Upload6")) {
//					 value=beanCurrentForm.getFile_Path6();
//					
//				}
//				if(value.equalsIgnoreCase("File Upload7")) {
//					 value=beanCurrentForm.getFile_Path7();
//					
//				}
//				if(value.equalsIgnoreCase("File Upload8")) {
//					 value=beanCurrentForm.getFile_Path8();
//					
//				}
//				if(value.equalsIgnoreCase("File Upload9")) {
//					 value=beanCurrentForm.getFile_Path9();
//					
//				}
//				if(value.equalsIgnoreCase("File Upload10")) {
//					 value=beanCurrentForm.getFile_Path10();
//					
//				}
			}

			/*----------------------------*/

			splVals.append("'" + value + "',");
			log.debug("Revised Value is: " + splVals);

		}

		String linkPass = "";
		String subscriptionId = "";
		if (null != ses.getAttribute("linkPass")) {
			linkPass = (String) ses.getAttribute("linkPass");
			log.info("linkPass for saveing in tem table is :::: " + linkPass);
		}

		// ses.setAttribute("subscriptionId"
		if (null != ses.getAttribute("subscriptionId")) {
			subscriptionId = (String) ses.getAttribute("subscriptionId");
			log.info("subscriptionId for saveing in tem table is :::: " + subscriptionId);
		}

		String strSplVals = splVals.toString();
		log.debug((Object) ("splVals at Start:" + splVals));
		strSplVals = StringUtils.removeStart((String) strSplVals, (String) ",");
		strSplVals = StringUtils.removeEnd((String) strSplVals, (String) ",");
		// log.info((Object) ("splVals at End:" + splVals) + " form id " +
		// beanCurrentForm.getFormFeeId());
		if (!strSplVals.isEmpty()) {
			Session session = factory.openSession();
			try {
				try {
					Transaction tx = session.beginTransaction();
					if (formBean.getFormOwnerName().equalsIgnoreCase(cCodeForMagicBricks)
							|| formBean.getFormOwnerName().equalsIgnoreCase(cCodeForTVS)) {
						session.createSQLQuery("Insert into  zz_client_user_data_" + beanCurrentForm.getFormFeeId()
								+ " values(null,'" + transId + "','" + transStatus + "','N/A', '" + currentDate + "','"
								+ transAmount + "','N/A',null,'N/A',CURRENT_TIMESTAMP(),'N'," + strSplVals + "," + "'"
								+ formBean.getFormName() + "','null'" + ",'" + linkPass + "'" + ")").executeUpdate();

					} else if (formBean.getFormOwnerName().equalsIgnoreCase(cCodeForNPCI)) {
						session.createSQLQuery("Insert into  zz_client_user_data_" + beanCurrentForm.getFormFeeId()
								+ " values(null,'" + transId + "','" + transStatus + "','N/A', '" + currentDate + "','"
								+ transAmount + "','N/A',null,'N/A',CURRENT_TIMESTAMP(),'N'," + strSplVals + "," + "'"
								+ formBean.getFormName() + "','" + subscriptionId + "','" + linkPass + "'" + ")")
								.executeUpdate();

					} else {
						session.createSQLQuery("Insert into  zz_client_user_data_" + beanCurrentForm.getFormFeeId()
								+ " values(null,'" + transId + "','" + transStatus + "','N/A', '" + currentDate + "','"
								+ transAmount + "','N/A',null,'N/A',CURRENT_TIMESTAMP(),'N'," + strSplVals + "," + "'"
								+ formBean.getFormName() + "'" + ")").executeUpdate();
					}

					tx.commit();
				} catch (Exception e) {
					mail.sendConflictMail(
							"Record Not Inserting into zz_client_user_data_" + beanCurrentForm.getFormFeeId()
									+ " while going to SabPaisa",
							"praveen.kumar@srslive.in", beanCurrentForm.getEmail(), beanCurrentForm.getContact(),
							beanCurrentForm.getName(), e.getMessage());
					// session.close();
				}
			} finally {
				session.close();
			}
		}

	}

	public String getGeneratedStringValue(String oName) {
		String reGenerateValue = "";
		reGenerateValue = oName.substring(oName.lastIndexOf("/") + 1, oName.length());
		int i = reGenerateValue.lastIndexOf("_");
		int j = reGenerateValue.lastIndexOf(".");
		String fname = reGenerateValue.substring(0, i);
		String ext = reGenerateValue.substring(j + 1, reGenerateValue.length());
		reGenerateValue = fname + "." + ext;
		return reGenerateValue;
	}

	public HashMap<Integer, String> getFormDataInSequence(SampleFormBean formdata, HttpSession ses) {
		HashMap<Integer, String> finalmap = new HashMap<Integer, String>();
		HashMap<Integer, String> formdataMapRaw = new HashMap<Integer, String>();
		String formDataRaw = formdata.getFormData();
		Integer formTemplateId = formdata.getFormTemplateId();
		try {
			BeanFormDetails formdetails = sampleFormService.getFormDetails(formTemplateId.intValue());
			ArrayList formsStructure = new ArrayList(formdetails.getFormStructure());
			Collections.sort(formsStructure);
			formdataMapRaw = processFormData(formDataRaw, ses);
			String finalFieldValue = "";
			int i = 0;
			while (i < formsStructure.size()) {

				Integer fieldId = ((BeanFormStructure) formsStructure.get(i)).getId();
				Integer fieldLookupId = ((BeanFormStructure) formsStructure.get(i)).getFormField().getLookup_id();

				String fieldValue = (String) formdataMapRaw.get(fieldId);

				finalFieldValue = fieldLookupId >= 0 ? (-1 != fieldValue.indexOf("=") && -1 != fieldValue.indexOf("$")
						? fieldValue.substring(fieldValue.indexOf("=") + 1, fieldValue.indexOf("$"))
						: "") : "Page Break";
				finalmap.put(((BeanFormStructure) formsStructure.get(i)).getFieldOrder(), finalFieldValue);
				++i;
			}
			return finalmap;
		} catch (Exception e) {
			e.printStackTrace();
			return finalmap;
		}
	}

	public HashMap<Integer, String> processFormData(String formDataRaw, HttpSession ses) {

		String[] remValOfequal = null;
		String[] remVal = null;
		String remtst = null;
		CollegeBean nitjbean = (CollegeBean) ses.getAttribute("CollegeBean");
		HashMap<Integer, String> formDataMap = new HashMap<Integer, String>();
		String[] formFields = formDataRaw.split(",");
		ArrayList<String> formFieldsList = new ArrayList<String>(Arrays.asList(formFields));
		int i = 0;
		while (i < formFieldsList.size()) {
			String[] formFieldData = formFieldsList.get(i).split(",");
			log.debug("form field data length is .... " + formFieldData.length);
			if (formFieldData.length != 1) {
				log.debug((Object) ("Form Field at index " + i + " is corrupt or unreadable " + formFieldData[i]));
			} else {
				String test = formFieldData[0];
				formDataMap.put(Integer.valueOf(test.substring(0, test.indexOf("~"))),
						test.substring((test.indexOf("~")) + 1, test.indexOf("$") + 1));
			}
			++i;
		}
		return formDataMap;
	}

	public String findFilledSheetForBU(String fotmID) throws SQLException {
		log.info("Start findFilledSheetForBU() method.");
		Connection con = connection.getConnectionApp();
		Integer formId = Integer.parseInt(fotmID);
		String filledSeat = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			// SELECT max(CAST(Filled_Seat AS UNSIGNED)) AS MaxFilledSeat FROM
			// qwikForms.zz_client_user_data_28;
			String query = "select max(CAST(Filled_Seat AS UNSIGNED)) AS FilledSeat from " + dbName
					+ ".zz_client_user_data_" + formId;
			// log.info("query for finding max value of filledseat ::::: "+query);
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {

				filledSeat = rs.getString("FilledSeat");

			}

			return filledSeat;
		} catch (Exception e) {
			e.printStackTrace();
			return filledSeat;
		} finally {
			log.info("End findFilledSheetForBU() method. and filled seat is :: " + filledSeat);
			con.close();
		}
	}

	@Override
	public ArrayList<String> filterTheRecordBasedOnFormNameForBURD(String formId) throws ParseException, SQLException {

		Connection con = connection.getConnectionApp();
		Integer formID = Integer.parseInt(formId);
		String filledSeat = null;
		String maximumSeat = null;
		Statement stmt = null;
		ResultSet rs = null;

		// Session session = factory.openSession();
		String fQuery = "";

		ArrayList<String> val1 = new ArrayList<String>();
		List<ArrayList<String>> val = new ArrayList<ArrayList<String>>();

		try {
			log.info("trans Status & paymentMode");
			// SELECT max(CAST(Maximum_Seat AS UNSIGNED)),max(CAST(Filled_Seat AS UNSIGNED))
			// FROM qwikForms.zz_client_user_data_28;
			fQuery = " SELECT max(CAST(Maximum_Seat AS UNSIGNED)) AS MaxFilledSeat,max(CAST(Filled_Seat AS UNSIGNED)) AS FilledSeat FROM "
					+ dbName + ".zz_client_user_data_" + formID;
			log.debug("query for finding max value of filledseat ::::: " + fQuery);
			stmt = con.createStatement();
			rs = stmt.executeQuery(fQuery);

			while (rs.next()) {
				maximumSeat = rs.getString("MaxFilledSeat");
				filledSeat = rs.getString("FilledSeat");

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			con.close();
			stmt.close();
			rs.close();
		}

		val1.add(maximumSeat);
		val1.add(filledSeat);
		log.debug("val1 Arraylist is for subject seats :::::::: " + val1.toString());
		return val1;
	}

	@Override
	public List<Map<String, Object>> getClientSpecificDataFromClientTable(String formId, String txnQfId) {
		log.debug("Start of getClientSpecificDataFromClientTable() method");

		Session session = factory.openSession();
		String sqlQuery = "", transStatus = "";
		List<Object> list = new ArrayList<Object>();

		List<Map<String, Object>> aliasToValueMapList = null;
		try {
			sqlQuery = "select transId, Type_of_Fee, Bidding_Firm_Name, NIT_No, Item_No, Name_of_Bank, IFSC_Code, CBS_Account_No from zz_client_user_data_"
					+ formId + " where transId=" + "'" + txnQfId + "';";
			log.info("sqlQuery is ::::: " + sqlQuery);

			Query query = session.createSQLQuery(sqlQuery);

			// log.debug("query is " + query);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			// log.info("query is " + query.list());

			aliasToValueMapList = query.list();
			log.info("aliasToValueMapList size :: " + aliasToValueMapList.size());

			/*
			 * for(Map<String, Object> i:aliasToValueMapList){
			 * //log.info("each value of list as in map :: "+i.values().toString());
			 * list.add(i.values()); transStatus=i.values().toString(); }
			 * if(null!=transStatus || ""!=transStatus) {
			 * log.info("End of getFormTransStatus() method and status is ::::: "
			 * +transStatus.toString()); }
			 */
		} catch (Exception e) {
			e.printStackTrace();
			session.close();
		} finally {
			session.close();
		}

		return aliasToValueMapList;
	}

	@Override
	public List<SampleTransBean> fetchTxnDetailsAsFormId(String formId) {
		List<SampleTransBean> resultList = new ArrayList<SampleTransBean>();
		log.info("Open fetchTxnDetailsAsGivenFormId() method");
		log.info("formId:" + formId);
		// Open session from session factory
		Session session = factory.openSession();
		try {
			Criteria cr = session.createCriteria(SampleTransBean.class);
			resultList = cr.add(Restrictions.eq("formId", Integer.parseInt(formId))).list();
			return resultList;
		} catch (IndexOutOfBoundsException e) {
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return resultList;
		} finally {
			// close session
			log.info("End fetchTxnDetailsAsGivenFormId() method");
			session.close();
		}
	}

	@Override
	public String updateClientTableWithApproveUserData(String cCode, String payerType, String formId, String uniqueKey,
			String approvalKey) {

		Session session = factory.openSession();
		CommonsUtil cu = new CommonsUtil();
		String tableName = "zz_" + cCode + "_" + payerType + "_" + formId;
//		String approvalKey=uniqueKey;
		String flag = "false";
		log.info("updateable table name is + " + tableName);

		try {
			Transaction tx = session.beginTransaction();
			// UPDATE tablename SET online_status=0 WHERE 1=1;
			session.createSQLQuery("UPDATE  " + tableName + " SET Approval_Key='" + approvalKey.trim()
					+ "' where unique_Key='" + uniqueKey.trim() + "'").executeUpdate();
			tx.commit();
			flag = "true";
			log.info("flag for updateing the approval value : :::::::::::::::::::::::: " + flag);
		} catch (Exception e) {
			e.printStackTrace();
			flag = "false";
			log.info("flag for updateing the approval value : :::::::::::::::::::::::: " + flag);
			session.close();
		} finally {
			session.close();
		}
		log.info("flag for updateing the approval value : :::::::::::::::::::::::: " + flag);
		return flag;
	}

	@Override
	public String getApprovalStatusForGGUClient(String fieldNames, Integer formTempId, String clientCode, String payer)
			throws SQLException {
		String approvalStatus = "";
		Connection con = connection.getConnectionApp();
		Statement stmt = null;
		ResultSet rs = null;
		String fQuery = "";
		try {
			fQuery = "select * from zz_" + clientCode + "_" + payer + "_" + formTempId + " where " + fieldNames + ";";
			stmt = con.createStatement();
			rs = stmt.executeQuery(fQuery);
			while (rs.next()) {
				approvalStatus = rs.getString("Approval_Key");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			con.close();
			stmt.close();
			rs.close();
		}
		log.info("approval status for this field :::::: " + fieldNames + " :::::::::: " + approvalStatus);
		return approvalStatus;
	}

}
