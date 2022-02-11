package com.sabpaisa.qforms.job;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.sabpaisa.qforms.beans.SampleTransBean;

public class QCFollowUP {
	public QCFollowUP() {
	}

	public static SessionFactory factory;
	Logger log = Logger.getLogger(QCFollowUP.class);

	QCTransactionDaoImpl qcTransDetails = new QCTransactionDaoImpl();

	public void updateTrans() {
		QCJobDAO jobDAO = new QCJobDAO();
		log.info("Fetching the pending status from QC_dataTransaction table");
		List<SampleTransBean> pendingTxnlist = new ArrayList();

		try {
			pendingTxnlist = jobDAO.getPendingTxnList();
			log.info("Pending Txn List is ::" + pendingTxnlist.size());
			if (!pendingTxnlist.isEmpty()) {
				Integer counter = Integer.valueOf(0);
				for (SampleTransBean transactionBean : pendingTxnlist) {
					counter = Integer.valueOf(counter.intValue() + 1);
					log.info("counter is ::" + counter);
					String qcTxnId = transactionBean.getTransId();

					log.info("GOT Pending Txn in FD ::" + qcTxnId);

					Thread.sleep(10000);
					String sabPaisaTxnId[] = jobDAO.getSabPaistxnId(qcTxnId);
					Thread.sleep(10000);
					if ((sabPaisaTxnId[0] != null) && (!sabPaisaTxnId[0].isEmpty())) {
//						log.info("sabpaisa Txn Is not NULL OR EMPTY");
						/*String status = jobDAO.getsabPaisaTxnStatus(sabPaisaTxnId);
						log.info("Status getting " + status);

						String respCode = jobDAO.getsabPaisaTxnRespCode(sabPaisaTxnId);
						String paymentMode = jobDAO.getsabPaisaPayMode(sabPaisaTxnId);
						String pgTransId = jobDAO.getsabPaisaPGTransId(sabPaisaTxnId);

						if ("success".equalsIgnoreCase(status)) {
							log.info("In SUCCESS Loop");
							try {
								qcTransDetails.updateTransTable(qcTxnId, respCode, paymentMode, sabPaisaTxnId, "JOB",
										status, pgTransId);
							} catch (Exception e) {
								e.printStackTrace();
							}							
*/
							
							String status = sabPaisaTxnId[1];
							String respCode = sabPaisaTxnId[2];
							String paymentMode = sabPaisaTxnId[3];
							String pgTransId = sabPaisaTxnId[4];
							log.info("before updating "+status+" "+respCode+ "  "+paymentMode+ " "+pgTransId);
							if ("success".equalsIgnoreCase(status)) {
								log.info("In SUCCESS Loop ");
								try {
									log.info("updating transaction is "+qcTxnId);
									qcTransDetails.updateTransTable(qcTxnId, respCode, paymentMode, sabPaisaTxnId[0], "JOB",
											status, pgTransId);
								} catch (Exception e) {
									e.printStackTrace();
								}	
							String formId = qcTransDetails.getFormId(qcTxnId);
							log.info("form id retrieved from transaction bean is::" + formId);
							Session session = null;
							
							log.info("called factory config ");
							factory = new Configuration().configure().buildSessionFactory();
							session = factory.openSession();
							try {
								Transaction tx = session.beginTransaction();
								log.info("before updating the zz table "+formId);
								session.createSQLQuery("update zz_client_user_data_" + formId + " set transStatus='" + status
										+ "',transPaymode='" + paymentMode + "',spTransId='" + sabPaisaTxnId[0]
										+ "',pgTransId='" + pgTransId + "' where  transId='" + qcTxnId + "'")
										.executeUpdate();
								tx.commit();
							} catch (Exception e) {
								log.info("perhaps form dynamic table not exists");
							} finally {
								session.close();
							}

							log.info("successfully dues updated :: fd txn Id ::" + qcTxnId);

						} else if ("Pending".equalsIgnoreCase(status)) {
							log.info(" pending so not updating anything "+qcTxnId);

						} else if ("new".equalsIgnoreCase(status)) {
							log.info("In NEW Loop "+qcTxnId);

						} else {
							try {
								log.info("Before calling upddatingtransaction status is "+status);
								qcTransDetails.updateTransactionStatus(qcTxnId, status, paymentMode, respCode,
										sabPaisaTxnId[0], "JOB", pgTransId);
							} catch (Exception e) {
								log.info("exception while updating transaction status");
								e.printStackTrace();
							}
						}
					}else {
						log.info("SabPaisa txn not found in QC DB");

					}

				}

			} else {

				log.info("Pending transaction not found, will come back again in next iteration");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateTransAmt() {
		QCJobDAO jobDAO = new QCJobDAO();

		List<SampleTransBean> allTxnlist = new ArrayList();
		try {
			allTxnlist = jobDAO.getTxnList();
			log.info("Pending Txn List is ::" + allTxnlist.size());
			if (!allTxnlist.isEmpty()) {
				Integer counter = Integer.valueOf(0);
				for (SampleTransBean transactionBean : allTxnlist) {
					counter = Integer.valueOf(counter.intValue() + 1);
					log.info("counter is ::" + counter);
					String qcTxnId = transactionBean.getTransId();

					log.info("GOT Pending Txn in FD ::" + qcTxnId);

					/*String sabPaisaTxnId = jobDAO.getSabPaistxnId(qcTxnId);

					if ((sabPaisaTxnId != null) && (!sabPaisaTxnId.isEmpty())) {
						log.info("sabpaisa Txn Is not NULL OR EMPTY");
						Double sabPaisaActAmount = jobDAO.getsabPaisaActAmount(sabPaisaTxnId);
						String status = jobDAO.getsabPaisaTxnStatus(sabPaisaTxnId);
						log.info("Status getting " + status);

						String respCode = jobDAO.getsabPaisaTxnRespCode(sabPaisaTxnId);
						String paymentMode = jobDAO.getsabPaisaPayMode(sabPaisaTxnId);
						String pgTransId = jobDAO.getsabPaisaPGTransId(sabPaisaTxnId);

						qcTransDetails.updateAllTransationDetails(qcTxnId, sabPaisaTxnId, sabPaisaActAmount, status,
								respCode, paymentMode, pgTransId, "JOB");
					}*/
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
