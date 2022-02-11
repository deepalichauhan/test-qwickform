package com.sabpaisa.qforms.communication;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sabpaisa.qforms.config.AppPropertiesConfig;

public class SendSMSs {

	private static Logger log = LogManager.getLogger(SendSMSs.class.getName());

	static AppPropertiesConfig appPropertiesConfig = new AppPropertiesConfig();

	public static String sendSMS(String recepient, String msg) {
		String authkey = "177009ASboH8XM59ce18cb";
		String senderId = "sabpsa";
		String route = "4";
		// Prepare Url
		URLConnection myURLConnection = null;
		URL myURL = null;
		BufferedReader reader = null;
		// Send SMS API
		String mainUrl = "http://api.msg91.com/api/sendhttp.php?sender=sabpsa&route=4";
		log.info("main url 1 " + mainUrl);
		mainUrl = mainUrl + "&mobiles=" + recepient + "&authkey=" + authkey + "&country=91&message=" + msg;
		log.info("main url 2 " + mainUrl);
		try {
			// prepare connection
			myURL = new URL(mainUrl);
			myURLConnection = myURL.openConnection();
			myURLConnection.connect();
			log.info("myURL" + myURL);
			reader = new BufferedReader(new InputStreamReader(myURLConnection.getInputStream()));
			String response;
			StringBuilder str1 = new StringBuilder();
			while ((response = reader.readLine()) != null) {
				// print response
				log.info("response1 " + response);
				str1.append(response);
			}

			// SendMessageResponse messageResponse = ((Object)
			// mapper).readValue(str1.toString().trim(), SendMessageResponse.class);

			// finally close connection
			// str1 = response;

			reader.close();
			// log.info("Str1 send OTP "+ str1 + "Response message :
			// "+messageResponse.getMessage());
			// str1 = messageResponse.getMessage().toString();
			// return str1;
			return "success";
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
				}
			}
			if (myURLConnection != null) {
				((HttpURLConnection) myURLConnection).disconnect();
			}
		}
	}

	public static String sendSmsUsingLinkPaisaTinyUrl(String mobile, String msg, String appUrl, String getEmail) {

		/* private static Logger log =Logger.getLogger(SendSMSs.class); */
		// private static ObjectMapper mapper = new ObjectMapper();

		String tinyUrl = appPropertiesConfig.getPropValues().getProperty("tiny_link");
		String loginId = appPropertiesConfig.getPropValues().getProperty("tinyUrl_loginId");
		String password = appPropertiesConfig.getPropValues().getProperty("tinyUrl_password");
		String urlName = appPropertiesConfig.getPropValues().getProperty("qwickform");
		String mainUrlId = appPropertiesConfig.getPropValues().getProperty("tiny_mainUrlId");
		String tinyValue = appPropertiesConfig.getPropValues().getProperty("tinyValue");
		//appUrl="http://localhost:8081/QwikForms/validateFieldForMB?formid=4%26bid=32%26cid=2107%26PayeeProfile=TestPayer9Feb";
		log.info("tinyUrl {" + tinyUrl + "}, loginId {" + loginId + "}, password {no}");
		log.info("mobile: "+mobile+" : msg : "+msg+" : appUrl : "+appUrl+" : getEmail : "+getEmail);
		// tinyUrl+= https://linkpaisa.in/convertTinyUrl?loginId=2&
		// ReqUrlValue=http://qwikforms.in/QwikForms/validateFieldForMB?formid=62%26bid=0%26cid=2370%26PayeeProfile=Payer&password=no
		// &manyEmail=null&manyMob=null&mailId=shivam.singh@srslive.in&contactNum=9759982724&msgContent=hiiii
		// dev
		// &emailContent=hiii
		// sehrawat&urlName=qwickform&mainUrl=null&mainUrlId=17&tinyValue=grW8
		tinyUrl += "?loginId=" + loginId + "&ReqUrlValue=" + appUrl + "&password=" + password
				+ "&manyEmail=null&manyMob=null&mailId=" + getEmail + "&contactNum=" + mobile + "&msgContent="
				+ URLEncoder.encode(msg) + "&emailContent=" + URLEncoder.encode(msg) + "&urlName=" + urlName
				+ "&mainUrl=null&mainUrlId=" + mainUrlId + "&tinyValue=" + tinyValue;

		log.info(tinyUrl);
		HttpURLConnection connection = null;
		msg = msg.trim().replace(" ", "%20");
		BufferedReader reader = null;

		HttpClient client = HttpClientBuilder.create().build();
		HttpPost con = new HttpPost(tinyUrl);
		// con.addHeader(CodeConstants.CONTENT_TYPE, CodeConstants.CONTENT_TYPE_JSON);
		// con.addHeader(CodeConstants.ACCEPT, CodeConstants.CONTENT_TYPE_JSON);
		try {
			HttpResponse response = client.execute(con);
			String str = EntityUtils.toString(response.getEntity());
			log.info("Response String : " + str);
			return str;
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		log.info("Unable to Send Invite");
		return "Unable to Send Invite";

	}

	public static void main(String args[]) {
		SendSMSs ss = new SendSMSs();
		log.info("send sms ");
		String sendresponse;
		sendresponse = ss.sendSMS("8744872768", "Hshsxgsvccnbcnbcnbi");
	}
}
