package com.sabpaisa.qforms.job;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;

import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleTransBean;

public class QCTransactionDaoImpl
{
  public static SessionFactory factory ;
  static Logger log = Logger.getLogger(QCTransactionDaoImpl.class.getName());
  
  public QCTransactionDaoImpl() {}
  
  public void updateTransactionStatus(String qcTxnId, String status, String paymentMode, String respCode, String sabPaisaTxnId, String Job, 
		  String pgTransId)
  {
	  log.info("called updateTransaction status cases other then success,pending and new");
	 log.info("called updateTransaction status "+qcTxnId+ " "+status+" "+paymentMode+" "+respCode+ " "+sabPaisaTxnId+ " "+Job+" "+pgTransId); 
    Session session ;
    factory = new Configuration().configure().buildSessionFactory();
	session = factory.openSession();
	log.info("session has been created in updatetransaction");
    try {
      Transaction tx = session.beginTransaction();
      SampleTransBean sTransDetails = 
        (SampleTransBean)session.createCriteria(SampleTransBean.class).add(Restrictions.eq("transId", qcTxnId)).list().iterator().next();
    
      log.info("sTransDetaails are "+sTransDetails.toString());
      if (sTransDetails != null) {
        if ((status != null) && (!status.isEmpty())) {
        	log.info("set status");
          sTransDetails.setTransStatus(status);
        }
        
        if ((sabPaisaTxnId != null) && (!sabPaisaTxnId.isEmpty())) {
        	log.info("set sabPaisaTxnId");
          sTransDetails.setSpTransId(sabPaisaTxnId);
        }
        

        if ((Job != null) && (!Job.isEmpty())) {
        	log.info("set Job");
          sTransDetails.setRefundJob("Y");
        }
        
        if ((paymentMode != null) && (!paymentMode.isEmpty())) {
        	log.info("set paymentMode");
          sTransDetails.setTransPaymode(paymentMode);
        }
        

        if ((respCode != null) && (!respCode.isEmpty())) {
        	log.info("set respCode");
          sTransDetails.setSpRespCode(respCode);
        }
        

        if ((pgTransId != null) && (!pgTransId.isEmpty())) {
          log.info("pgTransId:" + pgTransId);
          sTransDetails.setPgTransId(pgTransId);
        }
        

        session.merge(sTransDetails);
        tx.commit();
      }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    finally {
      session.close();
    }
  }
  

  public void updateTransTable(String qcTxnId, String respCode, String paymentMode, String sabPaisaTxnId, String Job, String status, String pgTransId)
  {
	  log.info("called updateTraansTable in case of success");
	  log.info("called update trans table "+qcTxnId+ " "+respCode+" "+paymentMode +" "+sabPaisaTxnId+ "  "+Job + " "+status+ " "+pgTransId);
	  Session session = null;
	  //  Session session = factory.openSession();
   
    try
    {
    	log.info("called factory config ");
		factory = new Configuration().configure().buildSessionFactory();
		session = factory.openSession();	
      Transaction tx = session.beginTransaction();
      log.info("Forming query ");
      SampleTransBean sTransDetails = 
        (SampleTransBean)session.createCriteria(SampleTransBean.class).add(Restrictions.eq("transId", qcTxnId)).list().iterator().next();
      	log.info("fetched sampleTrans "+sTransDetails.toString());
      
      if (sTransDetails != null) {
        if ((status != null) && (!status.isEmpty())) {
          log.info("Status:" + status);
          sTransDetails.setTransStatus(status);
        }
        
        if ((sabPaisaTxnId != null) && (!sabPaisaTxnId.isEmpty())) {
          log.info("sabPaisaTxnId:" + sabPaisaTxnId);
          sTransDetails.setSpTransId(sabPaisaTxnId);
        }
        

        if ((Job != null) && (!Job.isEmpty())) {
          log.info("Job" + Job);
          sTransDetails.setRefundJob("Y");
        }
        
        if ((paymentMode != null) && (!paymentMode.isEmpty())) {
          log.info("paymentMode:" + paymentMode);
          sTransDetails.setTransPaymode(paymentMode);
        }
        

        if ((respCode != null) && (!respCode.isEmpty())) {
          log.info("paymentMode:" + respCode);
          sTransDetails.setSpRespCode(respCode);
        }
        

        if ((pgTransId != null) && (!pgTransId.isEmpty())) {
          log.info("pgTransId:" + pgTransId);
          sTransDetails.setPgTransId(pgTransId);
        }
        

        session.merge(sTransDetails);
        tx.commit();
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    finally {
      session.close();
    }
  }
  

  public void updateAllTransationDetails(String qcTxnId, String sabPaisaTxnId, Double sabPaisaActAmount, String status, String respCode, String paymentMode, String pgTransId, String Job)
  {
    Session session = factory.openSession();
    try {
      Transaction tx = session.beginTransaction();
      SampleTransBean sTransDetails = 
        (SampleTransBean)session.createCriteria(SampleTransBean.class).add(Restrictions.eq("transId", qcTxnId)).list().iterator().next();
      if (sTransDetails != null)
      {
        if (sabPaisaActAmount != null) {
          log.info("sabPaisaActAmount:" + sabPaisaActAmount);
          sTransDetails.setActAmount(sabPaisaActAmount);
        }
        

        if ((status != null) && (!status.isEmpty())) {
          log.info("Status:" + status);
          sTransDetails.setTransStatus(status);
        }
        
        if ((sabPaisaTxnId != null) && (!sabPaisaTxnId.isEmpty())) {
          log.info("sabPaisaTxnId:" + sabPaisaTxnId);
          sTransDetails.setSpTransId(sabPaisaTxnId);
        }
        

        if ((Job != null) && (!Job.isEmpty())) {
          log.info("Job" + Job);
          sTransDetails.setRefundJob("Y");
        }
        
        if ((paymentMode != null) && (!paymentMode.isEmpty())) {
          log.info("paymentMode:" + paymentMode);
          sTransDetails.setTransPaymode(paymentMode);
        }
        

        if ((respCode != null) && (!respCode.isEmpty())) {
          log.info("paymentMode:" + respCode);
          sTransDetails.setSpRespCode(respCode);
        }
        

        if ((pgTransId != null) && (!pgTransId.isEmpty())) {
          log.info("pgTransId:" + pgTransId);
          sTransDetails.setPgTransId(pgTransId);
        }
        

        session.merge(sTransDetails);
        tx.commit();
      }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    finally {
      session.close();
    }
  }
  
  public String getFormId(String qcTxnId)
  {
	 log.info("Inside getFormId method "+qcTxnId); 
    SampleFormBean sTransDetails = null;
    Session session = factory.openSession();
    try {
      Transaction tx = session.beginTransaction();
      sTransDetails = 
        (SampleFormBean)session.createCriteria(SampleFormBean.class).add(Restrictions.eq("formTransId", qcTxnId)).list().iterator().next();
    }
    catch (Exception e) {
      e.printStackTrace();
    } finally {
      session.close();
    }
    log.info("Before existing getFormID ");
    return sTransDetails.getFormFeeId().toString();
  }
}
