package com.sabpaisa.qforms.job;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;

public class QCJobDAO {
	Logger log = Logger.getLogger(QCJobDAO.class);
	public static SessionFactory factory;

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String dbName = properties.getProperty("dbName");
	String user = properties.getProperty("userName");
	String portNo = properties.getProperty("port");
	String pass = properties.getProperty("password");

	public QCJobDAO() {
	}

	public String[] getSabPaistxnId(String fdTxnId) throws ClassNotFoundException, SQLException {
		log.info("Inside the Dao Class of QCJOBDAO " + fdTxnId);
		Connection con = QCJDBCConnection.getConnection();

	//	String spTxnId = null;
		String spDetail[] = new String[5];
		Statement stmt = null;
		ResultSet rs = null;
		try {
			log.info("In side The QC Job Dao:::");
			log.info("FD Txn Id is ::" + fdTxnId);
			/*String query = "select txnId,status,sabPaisaRespCode,paymentMode,PGTxnId from sabpaisa.transaction_detail where clientTxnId='" + fdTxnId + "'";*/
			String query = "select txnId,status,sabPaisaRespCode,paymentMode,PGTxnId from sabpaisauat.transaction_detail where clientTxnId='" + fdTxnId + "'";
			log.info("query is " + query);
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			
			log.info("Before fetching-------->>>  "+spDetail[0]);

			while (rs.next()) {
		//		log.info("Before fetching-------->>>  "+spDetail[0]);
			//	spTxnId = rs.getString("txnID");
				spDetail[0] = rs.getString("txnId");
				spDetail[1] = rs.getString("status");
				spDetail[2] = rs.getString("sabPaisaRespCode");
				spDetail[3] = rs.getString("paymentMode");
				spDetail[4] = rs.getString("PGTxnId");
				log.info("SabPaisa TransactionID:: " + spDetail[0] + " "+spDetail[1]+ " "+spDetail[2]+ " "+spDetail[3]+ " "+spDetail[4]);
			}
			return spDetail;
		} catch (Exception e) {
			String str1;
			e.printStackTrace();
			return spDetail;
		} finally {
			log.info("closing  the previous connection ");
			con.close();
		}
	}

	@SuppressWarnings("unchecked")
	public List getPendingTxnList() {
		log.info("calling pending txn list " + dbName + " " + user + " " + portNo + "  " + pass);
		// log.info("factory is "+factory);
		Session session;
		// for local testing
		try {
			log.info("called factory config ");
			factory = new Configuration().configure().buildSessionFactory();
			session = factory.openSession();
			log.info("session opened ");

		} catch (Throwable ex) {
			log.info("Failed to create sessionFactory object." + ex);
			throw new ExceptionInInitializerError(ex);
		}
		Transaction tx = null;

		log.info("QC pending Transaction");
		List<SampleTransBean> pendingTxnlist = new ArrayList();
		try {
			log.info("Forming query is " + dbName);
			/*
			 * String query = "select * from " + dbName +
			 * ".data_transactions where transStatus in('Incomplete','CHALLAN_GENERATED','Subject to realization of Payment','pending',null)  ORDER BY RAND() LIMIT 50"
			 * ; log.info("query is "+query);
			 */ 
			SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.HOUR, -16);
			cal.add(Calendar.MINUTE, -15);
			String currentDate = sdf.format(new Date());
			String dateFrom = sdf.format(cal.getTime());
			Date cDate = sdf.parse(currentDate);
			Date fDate = sdf.parse(dateFrom);			
			log.info("date is "+currentDate + " "+dateFrom+ " "+cDate+ " "+fDate);
			log.info("Hrs before "+currentDate);
			Query query1 = session.createQuery("from "
					 + "SampleTransBean where transStatus in('Incomplete','CHALLAN_GENERATED','Subject to realization of Payment','pending',null)"
					 + " and  transDate between :frmdate and :todate");
			

			 query1.setParameter("frmdate", fDate);
	         query1.setParameter("todate", cDate);
			query1.setMaxResults(50);
			log.info("Query is "+query1 );

			tx = session.beginTransaction();
			/*
			 * SQLQuery sqlQuery = session.createSQLQuery(query);
			 * sqlQuery.addEntity(SampleTransBean.class); pendingTxnlist = sqlQuery.list();
			 */
			log.info("Transaction begin " + pendingTxnlist);
			pendingTxnlist = query1.list();
			log.info("pending txn list " + pendingTxnlist.size());
			tx.commit();
			log.info("pending txn list after" + pendingTxnlist.size());
			return pendingTxnlist;
		} catch (Exception e) {
		//	List<SampleTransBean> localList1;
			e.printStackTrace();
			return pendingTxnlist;
		} finally {
			session.close();
		}
	}

	public String getsabPaisaTxnStatus(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {
		Connection con = QCJDBCConnection.getConnection();

		String status = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			/*String query = "select status from sabpaisa.transaction_detail where txnId='" + sabPaisaTxnId + "'";*/
			String query = "select status from sabpaisauat.transaction_detail where txnId='" + sabPaisaTxnId + "'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {

				status = rs.getString("status");
			}

			return status;
		} catch (Exception e) {
			String str1;
			e.printStackTrace();
			return status;
		} finally {
			con.close();
		}
	}

	public String getsabPaisaTxnRespCode(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {
		Connection con = QCJDBCConnection.getConnection();

		Statement stmt = null;
		ResultSet rs = null;
		String code = null;
		try {
			/*String query = "select sabPaisaRespCode from sabpaisa.transaction_detail where txnId='" + sabPaisaTxnId
					+ "'";*/
			
			String query = "select sabPaisaRespCode from sabpaisauat.transaction_detail where txnId='" + sabPaisaTxnId
					+ "'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				log.info("SabPaisa Response Code is::" + code);
				code = rs.getString("sabPaisaRespCode");
			}

			return code;
		} catch (Exception e) {
			String str1;
			e.printStackTrace();
			return code;
		} finally {
			con.close();
		}
	}

	public String getsabPaisaPayMode(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {
		Connection con = QCJDBCConnection.getConnection();

		Statement stmt = null;
		ResultSet rs = null;
		String paymode = null;
		try {
			/*String query = "select paymentMode from sabpaisa.transaction_detail where txnId='" + sabPaisaTxnId + "'";*/
			String query = "select paymentMode from sabpaisauat.transaction_detail where txnId='" + sabPaisaTxnId + "'";
			
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {

				paymode = rs.getString("paymentMode");
				log.info("Payment Mode is::" + paymode);
			}

			return paymode;
		} catch (Exception e) {
			String str1;
			e.printStackTrace();
			return paymode;
		} finally {
			con.close();
		}
	}

	public String getsabPaisaPGTransId(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {
		Connection con = QCJDBCConnection.getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		String pgTransId = null;
		try {
			/*String query = "select PGTxnId from sabpaisa.transaction_detail where txnId='" + sabPaisaTxnId + "'";*/
			String query = "select PGTxnId from sabpaisauat.transaction_detail where txnId='" + sabPaisaTxnId + "'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				log.info("PGTxnID is::" + pgTransId);
				pgTransId = rs.getString("PGTxnId");
			}

			return pgTransId;
		} catch (Exception e) {
			String str1;
			e.printStackTrace();
			return pgTransId;
		} finally {
			con.close();
		}
	}

	public Double getsabPaisaActAmount(String sabPaisaTxnId) throws ClassNotFoundException, SQLException {
		Connection con = QCJDBCConnection.getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		Double actAmount = Double.valueOf(0.0D);
		try {
			/*String query = "select actAmount from sabpaisa.transaction_detail where txnId='" + sabPaisaTxnId + "'";*/
			String query = "select actAmount from sabpaisauat.transaction_detail where txnId='" + sabPaisaTxnId + "'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				log.info("Amount is::" + actAmount);
				actAmount = Double.valueOf(rs.getDouble("actAmount"));
			}

			return actAmount;
		} catch (Exception e) {
			Double localDouble1;
			e.printStackTrace();
			return actAmount;
		} finally {
			con.close();
		}
	}

	public List<SampleTransBean> getTxnList() {
		Session session = factory.openSession();

		List<SampleTransBean> allTxnLst = null;
		try {
			allTxnLst = session.createCriteria(SampleTransBean.class).list();
		} catch (NullPointerException ex) {
			ex.printStackTrace();
			return allTxnLst;
		}finally {
			session.close();
		}

		return allTxnLst;
	}
}
