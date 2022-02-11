package com.sabpaisa.qforms.job;

import java.util.Properties;
import java.util.Timer;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;

import com.sabpaisa.qforms.config.AppPropertiesConfig;

public class JobStarter extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  private static final ServletConfig ServletConfig = null;
  
  public JobStarter() {}
  
  static Logger log = Logger.getLogger(JobStarter.class);
  AppPropertiesConfig appProperties = new AppPropertiesConfig();
  Properties properties = appProperties.getPropValues();
  String jobFlagSataus = properties.getProperty("isJobActivate");
  String delay = properties.getProperty("delayForJob");
  String schedule = properties.getProperty("scheduleForJob");
  

  public void init(ServletConfig cofig) {
    log.info("JOB for QForms Enquiry Flag is = " + jobFlagSataus+ "  "+delay+ "  "+schedule);
    log.info("properties file "+ " status "+jobFlagSataus);
    try
    {
      if (jobFlagSataus.equals("Yes")) {
        Timer time = new Timer();
        QCRefundJob rf = new QCRefundJob();
        time.schedule(rf, Long.valueOf(delay),  Long.valueOf(schedule));
      } else {
        log.info("Job is disabled");
      }
    } catch (Exception e) {
      log.info("Job is disabled "+e);
      /*log.info(" q "+e.printStackTrace());*/
    }
  }
  
 public static void main(String args[]) throws ServletException {
	  JobStarter js = new JobStarter();
	  log.info("starting job");
	  js.init(ServletConfig );
	  
  }
}
