package com.sabpaisa.qforms.controller;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sabpaisa.qforms.beans.FormData;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.util.PasswordEncryption;
import com.sabpaisa.requestprocessing.Encryptor;

@CrossOrigin
@Controller
@RequestMapping
public class PayActionController {
	
	@Autowired
	public SessionFactory factory;
	
	private static final long serialVersionUID = 545455799825524368L;
	public FormData fd;
	private static Logger log = LogManager.getLogger(PayActionController.class.getName());
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String SabPaisaURL = properties.getProperty("sabpaisaUrl");
	String returnUrl = properties.getProperty("returnUrl");
	String clientFailureUrl = properties.getProperty("failureUrl");

	@RequestMapping(value="/ResponseAction",method = RequestMethod.POST)
	public String responseHandelling() {

		log.info("responce Has Come");

		return "index";
	}
	
	@RequestMapping(value="/redirectToSb",method = RequestMethod.POST)
	public void redirectToSabPaisa(HttpServletRequest request, HttpServletResponse response, HttpSession ses) throws InvalidKeyException, IllegalBlockSizeException, BadPaddingException,
			InvalidAlgorithmParameterException, NoSuchAlgorithmException, NoSuchPaddingException, IOException {
		

		 	String queryString;
	        String bid = (String)ses.getAttribute("bid");
	        log.debug((Object)("bid is =" + bid));
	        Boolean auth = true;
	        String username = "komal_1";
	        String password = "QC_SP1";
	        String clientCode = "QC";
	        String authKey = "Ax5AsfXxdq94wsqY";
	        String authIV = "529ytaWu079HaML8";
	        String name = request.getParameter("firstName");
	        log.debug((Object)("name is........." + name));
	        String RollNo = request.getParameter("RollNo");
	        String name2 = request.getParameter("lstName");
	        String amount = request.getParameter("amt");
	        String mobNum = request.getParameter("Contact");
	        String email = request.getParameter("Email");
	        String tranId = request.getParameter("txnId");
	        String clientId = request.getParameter("client");
	        String sem = request.getParameter("sem");
	        String course = request.getParameter("course");
	        String qccid = request.getParameter("cid");
	        String qcbid = request.getParameter("bid");
	        log.debug((Object)("bid is=" + qcbid));
	        String feeDetails = request.getParameter("feeDetails");
	        String url = queryString = "?firstName=" + name + "&RollNo=" + RollNo + "&lstName=" + name2 + "&amt=" + amount + "&Contact=" + mobNum + "&Email=" + email + "&txnId=" + tranId + "&client=" + clientId + "&sem=" + sem + "&course=" + course + "&cid=" + qccid + "&bid=" + qcbid + "&feeDetails=" + feeDetails + "&returnUrl=" + returnUrl + "&usern=" + username + "&pass=" + password;
	        log.debug((Object)("query String is" + queryString));
	        if (auth.booleanValue()) {
	            url = Encryptor.encrypt((String)authKey, (String)authIV, (String)url);
	            url = url.replaceAll("\\+", "%2B");
	            url = "?query=" + url + "&clientName=" + clientCode + "&clientId=" + bid;
	        }
	        url = String.valueOf(SabPaisaURL) + url;
	        url = url.replace(" ", "%20");
	        response.sendRedirect(url);
	}

	@RequestMapping(value="/payForm",method = RequestMethod.POST)
	public String PayFee(HttpSession ses) {
		
		 fd.setTxnDate(new Date());
	        fd.setTxnStatus("NA");
	        Integer rowCount = getRowCount();
	        int fillercount = 10 - rowCount.toString().length();
	        String txnStr = rowCount.toString();
	        int i = 0;
	        while (i < fillercount) {
	            txnStr = txnStr.concat("0");
	            ++i;
	        }
	        fd.setTransId(Long.valueOf(Long.parseLong(txnStr.trim())));
	        Session session = factory.openSession();
	        try {
	            session.beginTransaction();
	            session.saveOrUpdate((Object)fd);
	            session.getTransaction().commit();
	            String password = "%nit15$#@";
	            PasswordEncryption.encrypt((String)password);
	            String encryptedPwd = PasswordEncryption.encStr;
	            ses.setAttribute("encPwd", (Object)encryptedPwd);
	            return "success";
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	            return "error";
	        }
	        finally {
	            session.close();
	        }

	}

	public Integer getRowCount() {
	      Session session = factory.openSession();
	        try {
	            Criteria c = session.createCriteria(FormData.class);
	            c.addOrder(Order.desc((String)"id"));
	            c.setMaxResults(1);
	            FormData temp = (FormData)c.uniqueResult();
	            try {
	                Integer n = temp.getId() + 1;
	                return n;
	            }
	            catch (NullPointerException e) {
	                Integer n = 0;
	                session.close();
	                return n;
	            }
	        }
	        finally {
	            session.close();
	        }

	}

	public FormData getFd() {
		return fd;
	}

	public void setFd(FormData fd) {
		this.fd = fd;
	}
	
	
}
