package com.sabpaisa.qforms.communication;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sabpaisa.qforms.controller.SampleTransActionController;



public class ElasticSendMailer {
	
	private static Logger log = LogManager.getLogger(ElasticSendMailer.class.getName());
	final static String FROM = "noreply@sabpaisa.in";
	static String  spMsg = "Thank you for transacting with Sabpaisa";
	static String spMsg1 = "Your Transaction details are as follows";
	static String apiKey = "c96c20a2-cecc-4105-920f-49924681e355";
	static String from ="noreply@sabpaisa.com";
	//static String subject ="Welcome to QForms";
	static String lastData = "<br><h4>For any support or queries please mail us on <b>support@sabpaisa.in</b> or you may visit us at <a href='http://sabpaisa.in/'>www.sabpaisa.in</a> and <a href='http://www.srslive.in/'>SRS LIVE TECHNOLOGIES PVT. LTD.</a></h4>";
   /* static AppPropertiesConfig appPropertiesConfig = new AppPropertiesConfig();
    static String cobBaseUrl = appPropertiesConfig.getPropValues().getProperty("clientOnBoarding.baseUrl");
	*/
	public static void main(String[] args) {
		String str = Send("praveen.kumar@srslive.in" , "welcome" ,"www.google.com" , "nitin", "28/05/1991","8744872768");
		System.out.println("str:::"+str);
	}
	
	/* public static String Send(String name,String to,String clientUserName,String clientPassword) {*/
	 public static String Send(String to, String subject, String URL, String Name, String dob,
				String contact) {
		 
		 String result = "";
		 try {
			 log.info("send sms "+to +" sub "+subject+" url "+URL+ " name "+Name+ " email "+dob+ " linkPass "+contact);
/*			 spMsg = "Welcome to SabPaisa ClientOnBoard Portal";
				spMsg1 = "Please use following detail to login in COB";*/

				StringBuffer bodyData = new StringBuffer();
				
				StringBuffer userName = new StringBuffer();
				String form1 = "";
				String isTransactional ="true";
				

				userName.append("<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append("Subscription Link")
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append(URL).append("</td></tr>")
				.append("<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append("password")
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append(contact).append("</td></tr>");
				
				/*password.append(
						"<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
						.append("Password")
						.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
						.append(clientPassword).append("</td></tr>");*/

				

				bodyData.append(userName);

				/*String initialEle = "<strong><h2>Hello " + name + ",<br></h2></strong>" + "<h3>" + spMsg
						+ "<br>" + spMsg1 + " " +"<a href='"+cobBaseUrl+"login'>Login Here</a></h3>";
				String tableInitial = "<table style='border: 1px solid black;border-collapse:collapse;width:100%;'>";
*/
				
				String initialEle = "<h2>Dear  " + Name + ",</h2>";
				/*String tableInitial = "<p><b>Please click on the link to go to your pending form:</b></p><p><b>Please use the following URL to access your pending forms, you will need to provide your Date of Birth and Contact Number for authenticaton as below:</b></p></b><table style='border: 1px solid black;border-collapse:collapse;width:100%;'>";*/
				String tableInitial = "<p><b>Please find your credentials:</b></p>";
				
				// form.field("html", "<img src=\"cid:" + image + "\">");
				
				form1= initialEle + tableInitial + bodyData + "</table>";

				String endTable = "<table style='border-collapse: collapse;width:100%;background-color: #f2f2f2;margin-top: 2%;'>";

				form1=form1+endTable + lastData + "</table>";

		 String encoding = "UTF-8";
		 
		 String data = "apikey=" + URLEncoder.encode(apiKey, encoding);
		 data += "&from=" + URLEncoder.encode(from, encoding);
		 data += "&fromName=" + URLEncoder.encode("Sabpaisa", encoding);
		 data += "&subject=" + URLEncoder.encode(subject, encoding);
		 data += "&bodyHtml=" + URLEncoder.encode(form1, encoding);
		 data += "&to=" + URLEncoder.encode(to, encoding);
	//	 data += "&isTransactional=" + URLEncoder.encode(isTransactional, encoding);
		 
		 URL url = new URL("https://api.elasticemail.com/v2/email/send");
		 URLConnection conn = url.openConnection();
		 conn.setDoOutput(true);
		 OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		 wr.write(data);
		 wr.flush();
		 BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream())); 
		 result= rd.readLine();
		 wr.close();
		 rd.close();	
		 /*
		 System.out.println("sending sms ");
		 String msg = "You have pending forms to complete! " +URL; 
         SendSMSs.sendSMS(contact, msg);*/
		 }
		 
		
		 
		 catch(Exception e) {
		 
		 e.printStackTrace();
		 }
		 return result;
		 }

		}