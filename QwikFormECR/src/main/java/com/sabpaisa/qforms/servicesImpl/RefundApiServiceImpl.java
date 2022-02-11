package com.sabpaisa.qforms.servicesImpl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.dao.CollegeDao;
import com.sabpaisa.qforms.dao.RefundApiDao;
import com.sabpaisa.qforms.dao.SampleTransDao;
import com.sabpaisa.qforms.exception.BusinessException;
import com.sabpaisa.qforms.services.RefundApiService;
import com.sabpaisa.qforms.util.RefundCodeConstant;
import com.sabpaisa.requestprocessing.Encryptor;

@Service("refundApiService")
public class RefundApiServiceImpl implements RefundApiService	{
	
	@Autowired
	private RefundApiDao refundApiDao;
	@Autowired
	private CollegeDao collegeDao;
	@Autowired
	private SampleTransDao sampleTransDao;
	
	private static Logger log = LogManager.getLogger(RefundApiServiceImpl.class.getName());
	
	@Override
	public String refundApiRequest(Integer clientId, String txnId, String spTxnId,
			String transAmount, String transPaymode, String transStatus, String message) throws BusinessException {
		log.info("Start of refundApiRequest() method, ClientId is >> "+clientId+", txnId >> "+txnId);
		
		CollegeBean collegeBean=null;
		
		collegeBean = collegeDao.viewInstDetail(clientId);
		
		if("true".equalsIgnoreCase(collegeBean.getIsRefundEnabled())) {
			String encryptedData = null;
			String dataForEncryption = "amount="+transAmount+"&clientTxnId="+txnId 
					+"&spTxnId="+ spTxnId+"&message="+ message;
			log.info("dataForEncryption for clienttxnid >> {"+txnId+"},is >> {"+dataForEncryption+"}");
			
			String sabPaisaRefundRespoonse = null;		

			try {
				encryptedData = Encryptor.encrypt(collegeBean.getAuthKey(), collegeBean.getAuthIV(), dataForEncryption);
				log.info("encryptedData " + encryptedData);
				encryptedData = encode(encryptedData); /*
														 * to convert any special character to // its UTF-8 encoding
														 */
				log.info("calling api ");
				sabPaisaRefundRespoonse = sabPaisaRefundResponseSender(encryptedData, collegeBean.getCollegeCode(), txnId);
					
			} catch (Exception e) {
				log.info("Apologies !! Exception arises during encryption of data");
				e.printStackTrace();
			}			
			// print result
			log.info("Returned from refund for QCTxnId >> {"+txnId+"}, is >> {"+sabPaisaRefundRespoonse+"}");
			
			
			
			SampleTransBean upateSampleTransBean;
			upateSampleTransBean = null;
			try {				
				if(null != sabPaisaRefundRespoonse) {
					SampleTransBean sampleTransBean = new SampleTransBean();
					upateSampleTransBean = new SampleTransBean();
					
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
					String currentDate = df.format(new Date(System.currentTimeMillis()));
					sampleTransBean = sampleTransDao.getTransactions(txnId);
					
					log.info("Status of "+txnId+", is "+sampleTransBean.getTransStatus());
					sampleTransBean.setTransStatus(RefundCodeConstant.REFUND_SUBMITED);
					sampleTransBean.setRefundAmount(transAmount);
					sampleTransBean.setRefundSubmitDate(currentDate);
					
					upateSampleTransBean=sampleTransDao.saveTransaction(sampleTransBean);
					log.info("Status of "+txnId+"after refund Process initiate is "+upateSampleTransBean.getTransStatus());
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return upateSampleTransBean.getTransStatus().toString();
		}else {
			log.info("Refund Is Not Enabled for "+collegeBean.getCollegeName()+", Please contact to SabPaisa Admin");
			return RefundCodeConstant.REFUND_NOT_ENABLE;
		}
		
		
	}
	
	public static String encode(String url) {
		log.info("Start of encode() method, url for encoding is >> "+url);
		try {
			String encodeURL = URLEncoder.encode(url, "UTF-8");
			log.info("End of encode() method, url for encoding is >> "+encodeURL);
			return encodeURL;
		} catch (UnsupportedEncodingException e) {
			return "Issue while encoding" + e.getMessage();
		}
	}
	
	// HTTP GET request
		private String sabPaisaRefundResponseSender(String encrptedString, String clientCode, String qcTxnId) throws Exception {
			log.info("Start of sabPaisaRefundResponseSender() method,  encrptedString >> "+encrptedString+", ClientCode >> "+clientCode);
			
			AppPropertiesConfig appProperties = new AppPropertiesConfig();
			Properties properties = appProperties.getPropValues();
			
			String url = properties.getProperty("refundUrl");
			
			log.info("sabPaisa url for refund is >> " + url);
			url = url + clientCode + "&refundQuery=" + encrptedString;
			log.info("final refund Url for qcTxInd >> "+qcTxnId+", is {"+url+"}");

			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			// optional default is GET
			con.setRequestMethod("GET");

			// add request header
			// con.setRequestProperty("User-Agent", USER_AGENT);

			int responseCode = con.getResponseCode();
			log.info("Sending 'GET' request to URL : " + url);
			log.info("Response Code return from SabPaisa for qcTxInd >> "+qcTxnId+" is " + responseCode);

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			// JSONObject jo = (JSONObject) response.toString();

			return response.toString();

		}

}
