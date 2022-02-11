package com.sabpaisa.qforms.communication;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.logging.Logger;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

import com.sabpaisa.qforms.config.AppPropertiesConfig;

public class SendSMS {
    Logger log = Logger.getLogger("SMS");

    AppPropertiesConfig appPropertiesConfig=new AppPropertiesConfig();
    
    
    public String sendSMS(String recepient, String message) {
        String user = "spectra";
        String password = "research1";
        String senderId = "EventD";
        String msg = "Welcome To FeeDesk ";
        String detail = String.valueOf(msg) + message;
        this.log.info("Recepient is ::" + recepient);
        this.log.info("Message is ::" + detail);
        URLConnection connection = null;
        String turl = "http://bhashsms.com/api/sendmsg.php?user=" + user + "&pass=" + password + "&sender=" + senderId + "&phone=" + recepient + "&text=" + detail + "&priority=ndnd&stype=normal";
        try {
            String line;
            URL url = new URL(turl);
            connection = url.openConnection();
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            connection.setRequestProperty("Content-Length", Integer.toString(turl.getBytes().length));
            connection.setRequestProperty("Content-Language", "en-US");
            connection.setUseCaches(false);
            connection.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
            wr.writeBytes(turl);
            wr.close();
            InputStream is = connection.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(is));
            StringBuilder response = new StringBuilder();
            while ((line = rd.readLine()) != null) {
                response.append(line);
                response.append('\r');
            }
            this.log.info("Response COde is " + response);
            rd.close();
            String string = response.toString();
            return string;
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String sendSMSIPD(String recepient, String message) {
        String user = "spectra";
        String password = "research1";
        String senderId = "EventD";
        String msg = "Link for IPD form";
        String detail = String.valueOf(msg) + message;
        this.log.info("Recepient is ::" + recepient);
        this.log.info("Message is ::" + detail);
        URLConnection connection = null;
        String turl = "http://bhashsms.com/api/sendmsg.php?user=" + user + "&pass=" + password + "&sender=" + senderId + "&phone=" + recepient + "&text=" + detail + "&priority=ndnd&stype=normal";
        try {
            String line;
            URL url = new URL(turl);
            connection = url.openConnection();
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            connection.setRequestProperty("Content-Length", Integer.toString(turl.getBytes().length));
            connection.setRequestProperty("Content-Language", "en-US");
            connection.setUseCaches(false);
            connection.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
            wr.writeBytes(turl);
            wr.close();
            InputStream is = connection.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(is));
            StringBuilder response = new StringBuilder();
            while ((line = rd.readLine()) != null) {
                response.append(line);
                response.append('\r');
            }
            this.log.info("Response COde is " + response);
            rd.close();
            String string = response.toString();
            return string;
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String sendOTPToSMS(String recepient, String message) {
        String user = "spectra";
        String password = "research1";
        String senderId = "EventD";
        String msg = "QCollect OTP to login to your Account:";
        String detail = String.valueOf(msg) + message;
        this.log.info("Recepient is ::" + recepient);
        this.log.info("Message is ::" + detail);
        URLConnection connection = null;
        String turl = "http://bhashsms.com/api/sendmsg.php?user=" + user + "&pass=" + password + "&sender=" + senderId + "&phone=" + recepient + "&text=" + detail + "&priority=ndnd&stype=normal";
        try {
            String line;
            URL url = new URL(turl);
            connection = url.openConnection();
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            connection.setRequestProperty("Content-Length", Integer.toString(turl.getBytes().length));
            connection.setRequestProperty("Content-Language", "en-US");
            connection.setUseCaches(false);
            connection.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
            wr.writeBytes(turl);
            wr.close();
            InputStream is = connection.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(is));
            StringBuilder response = new StringBuilder();
            while ((line = rd.readLine()) != null) {
                response.append(line);
                response.append('\r');
            }
            this.log.info("Response COde is " + response);
            rd.close();
            String string = response.toString();
            return string;
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public String sendSmsUsingLinkPaisaTinyUrl(String mobile, String msg, String appUrl) {

		String tinyUrl = appPropertiesConfig.getPropValues().getProperty("tiny_link");
		String loginId = appPropertiesConfig.getPropValues().getProperty("tinyUrl_loginId");
		String password= appPropertiesConfig.getPropValues().getProperty("tinyUrl_password");
		tinyUrl+= "?loginId="+loginId+"&ReqUrlValue="+appUrl+"&password=no&manyEmail=null&manyMob=null&mailId&contactNum="+mobile+"&msgContent="+URLEncoder.encode(msg)+"&emailContent=null&urlName=wwww&mainUrlId=1&tinyValue=dDTx";

		log.info(tinyUrl);
//			URLConnection connection = null;
		HttpURLConnection connection = null;
		URL mainUrl = null;
		msg=msg.trim().replace(" ", "%20");
		BufferedReader reader=null;

		HttpClient client = HttpClientBuilder.create().build();
		HttpPost con = new HttpPost(tinyUrl);
		//con.addHeader(CodeConstants.CONTENT_TYPE, CodeConstants.CONTENT_TYPE_JSON);
		//con.addHeader(CodeConstants.ACCEPT, CodeConstants.CONTENT_TYPE_JSON);
		try {
		HttpResponse response = client.execute(con);
		String str = EntityUtils.toString(response.getEntity());
		log.info("Response String : "+str);
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

}