package com.sabpaisa.qforms.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.cert.X509Certificate;
import java.util.HashMap;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.parser.JSONParser;
import org.springframework.boot.configurationprocessor.json.JSONObject;

import com.google.gson.Gson;

public class PushApiForClient {

	private static Logger log = LogManager.getLogger(PushApiForClient.class.getName());

	public boolean updateSubscriptionToClients(String url, String urlParameters) {
		log.info("\nSending 'POST' request to URL : " + url);
		log.info("Post parameters : " + urlParameters);
		try {
			BufferedReader bufferedreader=null;
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			// add reuqest header
			con.setRequestMethod("GET");
			/* con.setRequestProperty("User-Agent", USER_AGENT); */
			con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

			/* String urlParameters = "sn=C02G8416DRJM&cn=&locale=&caller=&num=12345"; */

			// Send post request
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(urlParameters);
			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			log.info("\nSending 'POST' request to URL : " + url);
			log.info("Post parameters : " + urlParameters);
			log.info("Response Code : " + responseCode);
						
			if (responseCode == HttpURLConnection.HTTP_OK) { // success
				log.info("data send successfully to client :" + responseCode);
				
				String decodedString;
				String InitialResponse = "";
				bufferedreader = new BufferedReader(new InputStreamReader(con.getInputStream()));				
				while ((decodedString = bufferedreader.readLine()) != null) {
					InitialResponse = InitialResponse + decodedString; // response recieved from PG is stored in
																		// variable
					log.info("response from client :" + InitialResponse);
				}
				bufferedreader.close();
				return true;
			} else {
				return false;
			}

		} catch (ConnectException e) {
			log.info("exception :" + e);
			return false;
		} catch (MalformedURLException e) {
			log.info("exception :" + e);
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			log.info("exception :" + e);
			e.printStackTrace();
			return false;
		}catch (Exception e) {
			log.info("exception :" + e);
			return false;
		}

	}

	public synchronized boolean updateChallanDataToClient(String url, String parameter) {

		log.info(url + "   url and parameters are              " + parameter);
		System.out.println(url + "   url and parameters are              " + parameter);
		try {
			TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
				public java.security.cert.X509Certificate[] getAcceptedIssuers() {
					return null;
				}

				public void checkClientTrusted(X509Certificate[] certs, String authType) {
				}

				public void checkServerTrusted(X509Certificate[] certs, String authType) {
				}
			} };

			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, trustAllCerts, new java.security.SecureRandom());
			HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

			// Create all-trusting host name verifier
			HostnameVerifier allHostsValid = new HostnameVerifier() {
				public boolean verify(String hostname, SSLSession session) {
					return true;
				}
			};
			HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
			System.out.println("url is :" + url);
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			log.info("After SSSl Verifirer method");
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			con.setDoOutput(true);
			OutputStream os = con.getOutputStream();
			log.info("parameter is :" + parameter + "  byte :" + parameter.getBytes());
			os.write(parameter.getBytes());
			// For POST only - END
			os.flush();
			os.close();
			log.info("After write of OutputStream");
			int responseCode = con.getResponseCode();
			log.info("POST Response Codeeeeee :: " + responseCode);
			BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(con.getInputStream()));
			if (responseCode == HttpURLConnection.HTTP_OK) { // success
				log.info("data send successfully to client :" + responseCode);
				String decodedString;
				String InitialResponse = "";
				while ((decodedString = bufferedreader.readLine()) != null) {
					InitialResponse = InitialResponse + decodedString; // response recieved from PG is stored in
																		// variable
					log.info("response from client :" + InitialResponse);
				}
				return true;

			} else {

				String decodedString;
				String InitialResponse = "";
				while ((decodedString = bufferedreader.readLine()) != null) {
					InitialResponse = InitialResponse + decodedString; // response recieved from PG is stored in
																		// variable
				}
				log.info("response from client :" + InitialResponse);

				log.info("data send unsuccessfully to client :" + responseCode);
				return false;
			}

		} catch (ConnectException e) {

			log.info("exception is thrown :" + e);
			return false;
		} catch (Exception e) {
			log.info("exception is thrown :" + e);
			return false;
		}

	}

	public synchronized boolean updateChallanDataToJb(String url, String parameter) {

		log.info(url + "   url and parameters are              " + parameter);
		System.out.println(url + "   url and parameters are              " + parameter);
		try {
			TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
				public java.security.cert.X509Certificate[] getAcceptedIssuers() {
					return null;
				}

				public void checkClientTrusted(X509Certificate[] certs, String authType) {
				}

				public void checkServerTrusted(X509Certificate[] certs, String authType) {
				}
			} };

			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, trustAllCerts, new java.security.SecureRandom());
			HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

			// Create all-trusting host name verifier
			HostnameVerifier allHostsValid = new HostnameVerifier() {
				public boolean verify(String hostname, SSLSession session) {
					return true;
				}
			};
			HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
			System.out.println("url is :" + url);
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			log.info("After SSSl Verifirer method");
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			con.setDoOutput(true);
			OutputStream os = con.getOutputStream();
			log.info("parameter is :" + parameter + "  byte :" + parameter.getBytes());
			os.write(parameter.getBytes());
			// For POST only - END
			os.flush();
			os.close();
			log.info("After write of OutputStream");
			int responseCode = con.getResponseCode();
			log.info("POST Response Codeeeeee :: " + responseCode);
			BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(con.getInputStream()));
			if (responseCode == HttpURLConnection.HTTP_OK) { // success
				log.info("data send successfully to client :" + responseCode);
				String decodedString;
				String InitialResponse = "";
				while ((decodedString = bufferedreader.readLine()) != null) {
					InitialResponse = InitialResponse + decodedString; // response recieved from PG is stored in
																		// variable
					log.info("response from client :" + InitialResponse);
				}
				JSONParser parser = new JSONParser();
				JSONObject json = (JSONObject) parser.parse(InitialResponse);

				HashMap<String, String> yourHashMap = new Gson().fromJson(json.toString(), HashMap.class);

				String successStatus = yourHashMap.get("successStatus");
				System.out.println("successStatus :" + successStatus);
				if (successStatus.equalsIgnoreCase("yes")) {
					return true;
				} else {
					return false;
				}

			} else {

				String decodedString;
				String InitialResponse = "";
				while ((decodedString = bufferedreader.readLine()) != null) {
					InitialResponse = InitialResponse + decodedString; // response recieved from PG is stored in
																		// variable
				}
				log.info("response from client :" + InitialResponse);

				log.info("data send unsuccessfully to client :" + responseCode);
				return false;
			}

		} catch (ConnectException e) {

			log.info("exception is thrown :" + e);
			return false;
		} catch (Exception e) {
			log.info("exception is thrown :" + e);
			return false;
		}

	}

	public synchronized String getTransactionStatus(String url, String parameter) {

		log.info(url + "   getTransactionStatus              " + parameter);
		System.out.println(url + "  getTransactionStatus           " + parameter);
		try {
			TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
				public java.security.cert.X509Certificate[] getAcceptedIssuers() {
					return null;
				}

				public void checkClientTrusted(X509Certificate[] certs, String authType) {
				}

				public void checkServerTrusted(X509Certificate[] certs, String authType) {
				}
			} };

			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, trustAllCerts, new java.security.SecureRandom());
			HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

			// Create all-trusting host name verifier
			HostnameVerifier allHostsValid = new HostnameVerifier() {
				public boolean verify(String hostname, SSLSession session) {
					return true;
				}
			};
			HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
			System.out.println("url is :" + url);
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			log.info("After SSSl Verifirer method");
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			con.setDoOutput(true);
			OutputStream os = con.getOutputStream();
			log.info("parameter is :" + parameter + "  byte :" + parameter.getBytes());
			os.write(parameter.getBytes());
			// For POST only - END
			os.flush();
			os.close();
			log.info("After write of OutputStream");
			int responseCode = con.getResponseCode();
			log.info("POST Response Codeeeeee :: " + responseCode);
			BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(con.getInputStream()));
			if (responseCode == HttpURLConnection.HTTP_OK) { // success
				log.info("data send successfully to client :" + responseCode);
				String decodedString;
				String InitialResponse = "";
				while ((decodedString = bufferedreader.readLine()) != null) {
					InitialResponse = InitialResponse + decodedString; // response recieved from PG is stored in
																		// variable
					System.out.println("response from client :" + InitialResponse);
				}
				JSONParser parser = new JSONParser();
				JSONObject json = (JSONObject) parser.parse(InitialResponse);

				HashMap<String, String> yourHashMap = new Gson().fromJson(json.toString(), HashMap.class);

				String successStatus = yourHashMap.get("paymentStatus");
				System.out.println("successStatus :" + successStatus);
				return successStatus;

			} else {

				String decodedString;
				String InitialResponse = "";
				while ((decodedString = bufferedreader.readLine()) != null) {
					InitialResponse = InitialResponse + decodedString; // response recieved from PG is stored in
																		// variable
				}
				JSONParser parser = new JSONParser();
				JSONObject json = (JSONObject) parser.parse(InitialResponse);

				HashMap<String, String> yourHashMap = new Gson().fromJson(json.toString(), HashMap.class);

				String successStatus = yourHashMap.get("paymentStatus");
				System.out.println("successStatus :" + successStatus);
				return successStatus;
			}

		} catch (ConnectException e) {

			log.info("exception is thrown :" + e);
			return null;
		} catch (Exception e) {
			log.info("exception is thrown :" + e);
			return null;
		}

	}

	public static void main(String[] args) {
		PushApiForClient apiForClient = new PushApiForClient();
		//http://localhost:8080/sabpaisaEnach/redirectToSubscription?getData=
		String url = "http://localhost:8080/sabpaisaEnach/redirectToSubscription?";
		String encData = "laxmikanta+sdsd+sdsd sdsd";
		encData = encData.replaceAll("\\+", "%2B");
		System.out.println("encData :" + encData);
		String parameter = "MD=V&encData=" + encData;
		System.out.println("parameter :" + parameter);
		apiForClient.updateChallanDataToClient(url, parameter);// (url, parameter);
	}
}

