package com.sabpaisa.qforms.job;

import java.util.TimerTask;

import org.apache.log4j.Logger;

public class QCRefundJob extends TimerTask {
	 static Logger log = Logger.getLogger(QCRefundJob.class);
  public QCRefundJob() {}
  
  public void run() {
    try {
      QCFollowUP followup = new QCFollowUP();
      log.info("----------------------------------------------------------------------->");
      followup.updateTrans();
      log.info("----------------------------------------------------------------------->>>>>>>>");
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }
}
