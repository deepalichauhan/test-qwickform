package com.sabpaisa.qforms.util;

import java.util.Date;

import javax.ws.rs.core.MediaType;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sabpaisa.qforms.controller.TempToDeleteController;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;
import com.sun.jersey.multipart.FormDataMultiPart;

public class SendMail {
	private static Logger log = LogManager.getLogger(TempToDeleteController.class.getName());
	final String image = "QwikCollect.png";
	final String FROM = "praveen.kumar@srslive.in";
	final String fdMsg = "Thank you for transacting with QForms";
	final String fdMsg1 = "Your Transaction details are as follows";

	String sabpaisaTxnLabel = "Sabpaisa Reference No";
	String clientTxnIdLabel = "QForms Transaction ID";
	String grNoLabel = "Student GR Number";
	String paymentModeLabel = "Payment Mode";
	String amountLabel = "Paid Amount";
	String dateLabel = "Transaction Date";
	String uinLabel = "Student UIN";
	String clientNameLabel = "Client Name";
	String statusLabel = "Payment Status";

	public static void main(String[] args) {
		SendMail m = new SendMail();
		m.sendMail("SLIP", "praveen.kumar@srslive.in", "SP1122", 100.0, "", "JVM", "FD4654654", "PC", "NB",
				"success", new Date(), "", "");
	}

	public ClientResponse sendMail(String subject, String to, String sabpaisaTxnId, Double amount, String challanNo,
			String clientName, String clientTxnId, String name, String paymentMode, String status, Date txnDate,
			String grNumber, String uinNumber) {
		Client client = Client.create();
		client.addFilter(new HTTPBasicAuthFilter("api", "key-473e89a80b5cb8acde3a810c9a18022a"));
		WebResource webResource = client.resource("https://api.mailgun.net/v3/sabpaisa.in" + "/messages");
		FormDataMultiPart form = new FormDataMultiPart();
		form.field("from", FROM);
		form.field("to", to);
		form.field("subject", subject);
		StringBuffer bodyData = new StringBuffer();

		bodyData.append("<table style='border: 1px solid black;border-collapse:collapse;width:100%;'>")
				.append("<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append(sabpaisaTxnLabel)
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append(sabpaisaTxnId)
				.append("</td></tr>")

				.append("<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append(clientTxnIdLabel)
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append(clientTxnId).append("</td></tr>");
		StringBuffer gr = new StringBuffer();
		if (grNumber != null && !grNumber.equals("")) {

			gr.append(
					"<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
					.append(grNoLabel)
					.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
					.append(grNumber).append("</td></tr>");
			bodyData.append(gr);
		} else {
			gr.append("");

		}

		StringBuffer uin = new StringBuffer();
		if (uinNumber != null && !uinNumber.isEmpty()) {
			uin.append(
					"<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
					.append(uinLabel)
					.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
					.append(uinNumber).append("</td></tr>");
			bodyData.append(uin);
		} else {
			uin.append("");

		}

		bodyData.append(
				"<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append(clientNameLabel)
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append(clientName)
				.append("</td></tr>")

				.append("<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append(amountLabel)
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>Rs. ")
				.append(amount).append("</td></tr>");

		StringBuffer payMode = new StringBuffer();
		if (paymentMode != null && !paymentMode.isEmpty()) {
			payMode.append(
					"<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
					.append(paymentModeLabel)
					.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
					.append(paymentMode).append("</td></tr>");
			bodyData.append(payMode);
		} else {
			payMode.append("");

		}

		bodyData.append(
				"<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append(dateLabel)
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append(txnDate)
				.append("</td></tr>")

				.append("<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append(statusLabel)
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append(status).append("</td></tr>");

		form.field("html", "<img src=\"cid:" + image + "\">");
		form.field("html", "<strong><h2>Dear " + name + ",<br></h2></strong>" + "<h3>" + fdMsg + "<br>" + fdMsg1
				+ "</h3>");
		form.field("html", "<table style='border: 1px solid black;border-collapse:collapse;width:100%;'>" + bodyData);

		if (paymentMode.equals("Cash") || paymentMode.equals("Cheque")) {

			form.field(
					"html",
					"<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>"
							+ "Challan Number"
							+ "</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>"
							+ challanNo + "</td></tr>");
		}
		form.field("html", "</table>");
		form.field(
				"html",
				"<br><h4>for further queries please mailed us on <b>praveen.kumar@srslive.in</b> or you may visit us at <a href='http://www.srslive.in/'>Spectra Research Services</a></h4>");

		//File jpgFile = new File(IMAGE_PATH);
		//form.bodyPart(new FileDataBodyPart("inline", jpgFile, MediaType.APPLICATION_OCTET_STREAM_TYPE));
		System.out.println("Mail Sent...!!! ");
		return webResource.type(MediaType.MULTIPART_FORM_DATA_TYPE).post(ClientResponse.class, form);

	}

	public ClientResponse sendRegMail(String subject, String to, String username, String password, String content,
			String name) {

		String dearMsg = "Dear ";
		String loginMsg = "You can log in to view and pay your fees with the below credentials";
		Client client = Client.create();
		client.addFilter(new HTTPBasicAuthFilter("api", "key-473e89a80b5cb8acde3a810c9a18022a"));
		WebResource webResource = client.resource("https://api.mailgun.net/v3/sabpaisa.in" + "/messages");
		FormDataMultiPart form = new FormDataMultiPart();
		form.field("from", FROM);
		form.field("to", to);
		form.field("subject", subject);

		String htmlContent = "<table style='border: 1px solid black;border-collapse:collapse;width:100%;'>"
				+ "<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>"
				+ "Username"
				+ "</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>"
				+ username
				+ "</td>"

				+ "<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>"
				+ "Password" + "</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>"
				+ password + "</td></tr>";

		if (name == null || name.isEmpty()) {
			name = "";
			dearMsg = "";

		} else {
			dearMsg = dearMsg + " " + name + ",";
		}
		form.field("html", "<img src=\"cid:" + image + "\">");
		form.field("html", "<strong><h2>" + dearMsg + "</h2></strong><br><strong><h3>" + content
				+ ",<br></h3></strong>" + loginMsg);
		form.field("html", "<table style='border: 1px solid black;border-collapse:collapse;width:100%;'>" + htmlContent);

		form.field(
				"html",
				"</table>"
						+ "<br><h4>for further queries please mailed us on <strong>praveen.kumar@srslive.in </strong> or you may visit us at <a href='http://www.srslive.in/'>Spectra Research Services</a></h4>");

		//File jpgFile = new File(IMAGE_PATH);
		//form.bodyPart(new FileDataBodyPart("inline", jpgFile, MediaType.APPLICATION_OCTET_STREAM_TYPE));
		System.out.println("Mail Sent...!!! ");
		return webResource.type(MediaType.MULTIPART_FORM_DATA_TYPE).post(ClientResponse.class, form);

	}
	
	public ClientResponse sendConflictMail(String subject, String to, String email, String contact,
			String name,String msg) {
		log.info("subject for mail { "+subject+" }, to { "+to+" }, email { "+email+" }, contact { "+contact+" }, name { "+name
				+" }, msg { "+msg+" }");
		String dearMsg = "Dear ";
		String loginMsg = "You can log in to view and pay your fees with the below credentials";
		Client client = Client.create();
		client.addFilter(new HTTPBasicAuthFilter("api", "key-473e89a80b5cb8acde3a810c9a18022a"));
		WebResource webResource = client.resource("https://api.mailgun.net/v3/sabpaisa.in" + "/messages");
		FormDataMultiPart form = new FormDataMultiPart();
		form.field("from", FROM);
		form.field("to", to);
		form.field("subject", subject);

		String htmlContent = "<table style='border: 1px solid black;border-collapse:collapse;width:100%;'>"
				+ "<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>"
				+ "Email of Payer"
				+ "</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>"
				+ email
				+ "</td></tr>"

				+ "<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>"
				+ "Mobile No of Payer" + "</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>"
				+ contact + "</td></tr>"
				
				+ "<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>"
				+ "Error Message"
				+ "</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>"
				+ msg
				+ "</td></tr>";

		if (name == null || name.isEmpty()) {
			name = "";
			dearMsg = "";

		} else {
			dearMsg = dearMsg + " " + name + ",";
		}
		form.field("html", "<img src=\"cid:" + image + "\">");
		form.field("html", "<strong><h2>" + dearMsg + "</h2></strong>");
		form.field("html", "<table style='border: 1px solid black;border-collapse:collapse;width:100%;'>" + htmlContent);

		form.field(
				"html",
				"</table>"
						+ "<br><h4>for further queries please mailed us on <strong>praveen.kumar@srslive.in </strong> or you may visit us at <a href='http://www.srslive.in/'>Spectra Research Services</a></h4>");

		log.info("Mail Sent..for Conflict Case.!!! ");
		return webResource.type(MediaType.MULTIPART_FORM_DATA_TYPE).post(ClientResponse.class, form);

	}
}
