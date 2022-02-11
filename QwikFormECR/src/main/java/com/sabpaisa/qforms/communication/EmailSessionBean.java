package com.sabpaisa.qforms.communication;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.ws.rs.core.MediaType;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;
import com.sun.jersey.multipart.FormDataMultiPart;

public class EmailSessionBean {

	private int port = 587;
	private String host = "smtp.gmail.com";
	private String from = "praveen.kumar@srslive.in";
	private boolean auth = true;
	private String username = "praveen.kumar@srslive.in";
	private String password = "qwikcollect@sabpaisa";
	private Protocol protocol = Protocol.TLS;
	private boolean debug = true;
	String lastData = "<br><h4>for further queries please mailed us on <b>sabpaisa@srslive.in</b> or you may visit us at <a href='http://sabpaisa.in/'>www.sabpaisa.in</a> and <a href='http://www.srslive.in/'>Spectra Research Services</a></h4>";
	private static final Logger log = LogManager.getLogger("EmailSessionBean.class");
	
	public void sendEEmail(String to, String subject, String Username, String Password, String Name) {
		log.info("Open sendEEmail() in EmailSessionBean");
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		switch (protocol) {
		case SMTPS:
			props.put("mail.smtp.ssl.enable", true);
			break;
		case TLS:
			props.put("mail.smtp.starttls.enable", true);
			break;
		}

		Authenticator authenticator = null;
		if (auth) {
			props.put("mail.smtp.auth", true);
			authenticator = new Authenticator() {
				private PasswordAuthentication pa = new PasswordAuthentication(username, password);

				@Override
				public PasswordAuthentication getPasswordAuthentication() {
					return pa;
				}
			};
		}

		Session session = Session.getInstance(props, authenticator);

		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress(from));
			InternetAddress[] address = { new InternetAddress(to) };
			message.setRecipients(Message.RecipientType.TO, address);
			message.setSubject(subject);
			message.setSentDate(new Date());
			/* message.setText(body); */
			Multipart multipart = new MimeMultipart("alternative");

			MimeBodyPart textPart = new MimeBodyPart();
			// If email client does not support html-------------------------
			String textContent = "Username: " + Username + " Password:" + Password;
			// -----------------------------------------------------------------
			textPart.setText(textContent);
			MimeBodyPart htmlPart = new MimeBodyPart();
			String htmlContent = "<html><h1>Welcome to the QForms   " + Name

			+ "</h1><p><h3>Please Use the following credentials to login to your Account</h3></p>"
					+ "<p><b>Username:</b> " + Username + "</p>" + "<p><b>Password:</b> " + Password + "</p></html>";
			htmlPart.setContent(htmlContent, "text/html");
			multipart.addBodyPart(textPart);
			multipart.addBodyPart(htmlPart);
			message.setContent(multipart);
			Transport.send(message);
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
		log.info("End sendEEmail() in EmailSessionBean");
	}

	public void sendOTPToEmail(String to, String subject, String Username, String Password) {
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		switch (protocol) {
		case SMTPS:
			props.put("mail.smtp.ssl.enable", true);
			break;
		case TLS:
			props.put("mail.smtp.starttls.enable", true);
			break;
		}

		Authenticator authenticator = null;
		if (auth) {
			props.put("mail.smtp.auth", true);
			authenticator = new Authenticator() {
				private PasswordAuthentication pa = new PasswordAuthentication(username, password);

				@Override
				public PasswordAuthentication getPasswordAuthentication() {
					return pa;
				}
			};
		}

		Session session = Session.getInstance(props, authenticator);

		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress(from));
			InternetAddress[] address = { new InternetAddress(to) };
			message.setRecipients(Message.RecipientType.TO, address);
			message.setSubject(subject);
			message.setSentDate(new Date());
			/* message.setText(body); */
			Multipart multipart = new MimeMultipart("alternative");

			MimeBodyPart textPart = new MimeBodyPart();
			// If email client does not support html-------------------------
			String textContent = "Username: " + Username + " Password:" + Password;
			// -----------------------------------------------------------------
			textPart.setText(textContent);
			MimeBodyPart htmlPart = new MimeBodyPart();
			String htmlContent = "<html><h1>QCollect "

			+ "</h1><p><h3>Please Use the following OTP to login to your Account</h3></p>" + Password + "</p></html>";
			htmlPart.setContent(htmlContent, "text/html");
			multipart.addBodyPart(textPart);
			multipart.addBodyPart(htmlPart);
			message.setContent(multipart);
			Transport.send(message);
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
	}

	public void sendEMailtoPayer(String to, String subject, String URL, String Name, String usern, String passw) {
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		switch (protocol) {
		case SMTPS:
			props.put("mail.smtp.ssl.enable", true);
			break;
		case TLS:
			props.put("mail.smtp.starttls.enable", true);
			break;
		}

		Authenticator authenticator = null;
		if (auth) {
			props.put("mail.smtp.auth", true);
			authenticator = new Authenticator() {
				private PasswordAuthentication pa = new PasswordAuthentication(username, password);

				@Override
				public PasswordAuthentication getPasswordAuthentication() {
					return pa;
				}
			};
		}

		Session session = Session.getInstance(props, authenticator);

		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress(from));
			InternetAddress[] address = { new InternetAddress(to) };
			message.setRecipients(Message.RecipientType.TO, address);
			message.setSubject(subject);
			message.setSentDate(new Date());
			/* message.setText(body); */
			Multipart multipart = new MimeMultipart("alternative");

			MimeBodyPart textPart = new MimeBodyPart();
			// If email client does not support html-------------------------
			String textContent = "Please use the following URL to access your pending forms, You will need to enter your last name in order to verify yourself before accessing the forms: "
					+ URL;
			// -----------------------------------------------------------------
			textPart.setText(textContent);
			MimeBodyPart htmlPart = new MimeBodyPart();
			String htmlContent = "<html><h1>Welcome to the QForms   " + Name

			+ "</h1><p><h3>Please Use the following credentials to login to your Account and see your pending forms:</h3></p>"
					+ "<p><b>Username:</b> " + usern + "</p>" + "<p><b>Password:</b> " + passw + "</p></html>"
					+ "<p><b>URL:</b> " + URL + "</p></html>";
			htmlPart.setContent(htmlContent, "text/html");
			multipart.addBodyPart(textPart);
			multipart.addBodyPart(htmlPart);
			message.setContent(multipart);
			Transport.send(message);
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
	}
	
	
	//send mail to reviewer
	public void sendEMailtoReviewer(String to, String subject, String Name, String usern, String passw) {
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		switch (protocol) {
		case SMTPS:
			props.put("mail.smtp.ssl.enable", true);
			break;
		case TLS:
			props.put("mail.smtp.starttls.enable", true);
			break;
		}

		Authenticator authenticator = null;
		if (auth) {
			props.put("mail.smtp.auth", true);
			authenticator = new Authenticator() {
				private PasswordAuthentication pa = new PasswordAuthentication(username, password);

				@Override
				public PasswordAuthentication getPasswordAuthentication() {
					return pa;
				}
			};
		}

		Session session = Session.getInstance(props, authenticator);

		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress(from));
			InternetAddress[] address = { new InternetAddress(to) };
			message.setRecipients(Message.RecipientType.TO, address);
			message.setSubject(subject);
			message.setSentDate(new Date());
			/* message.setText(body); */
			Multipart multipart = new MimeMultipart("alternative");

			MimeBodyPart textPart = new MimeBodyPart();
			// If email client does not support html-------------------------
			String textContent = "Please use the following URL to access your pending forms, You will need to enter your last name in order to verify yourself before accessing the forms: "
					/*+ URL*/;
			// -----------------------------------------------------------------
			textPart.setText(textContent);
			MimeBodyPart htmlPart = new MimeBodyPart();
			String htmlContent = "<html><h1>Welcome to the QForms   " + Name

			+ "</h1><p><h3>Please Use the following credentials to login to your Account and see your pending forms:</h3></p>"
					+ "<p><b>Username:</b> " + usern + "</p>" + "<p><b>Password:</b> " + passw + "</p></html>"
					/*+ "<p><b>URL:</b> " + URL + "</p></html>"*/;
			htmlPart.setContent(htmlContent, "text/html");
			multipart.addBodyPart(textPart);
			multipart.addBodyPart(htmlPart);
			message.setContent(multipart);
			Transport.send(message);
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
	}

	
	
	
	
	
	

	public ClientResponse sendEMailtoPayer(String to, String subject, String URL, String Name, String dob,
			String contact, boolean credsRequired) {
		
		System.out.println("sending email to payer finally "+to + " "+URL+ "  "+dob);
		Client client = Client.create();
	//	client.addFilter(new HTTPBasicAuthFilter("api", "key-473e89a80b5cb8acde3a810c9a18022a"));
		client.addFilter(new HTTPBasicAuthFilter("api", "key-0b34cd5b749afc6281003b1fe447eed7"));
		WebResource webResource = client.resource("https://api.mailgun.net/v3/sabpaisa.in" + "/messages");
		FormDataMultiPart form = new FormDataMultiPart();
		/*form.field("from", "qwik.collect@srslive.in");*/
		form.field("from", "noreply@sabpaisa.in");
		form.field("to", to);
		form.field("subject", subject);
	
		
		StringBuffer bodyData = new StringBuffer();

		StringBuffer linkBuffer = new StringBuffer();
		StringBuffer mobileDetailsBuffer = new StringBuffer();
		StringBuffer dobDetailsBuffer = new StringBuffer();

		System.out.println("url finally "+URL);
		linkBuffer
				.append("<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append("URL")
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append("<a href='" + URL + "' target='_blank'>" + "Click Here" + "</a>").append("</td></tr>");
		bodyData.append(linkBuffer);
	
		
		//bodyData.e
	/*	mobileDetailsBuffer
				.append("<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append("Mobile No.")
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append("" + contact + "").append("</td></tr>");
		bodyData.append(mobileDetailsBuffer);
		dobDetailsBuffer
				.append("<tr><td style='border: 1px solid black;border-collapse:collapse; padding: 10px;font-weight:bold;font-size:15px;width:40%;'>")
				.append("Date of Birth")
				.append("</td><td style='border: 1px solid black;border-collapse: collapse; padding: 10px;'>")
				.append("" + dob + "").append("</td></tr>");*/

	//	bodyData.append(dobDetailsBuffer);

		String initialEle = "<h1>Welcome to QForms</h1>  </br><h2>Dear  " + Name + ",</h2>";
		String tableInitial = "<p><b>Please click on the link to go to your pending form:</b></p><p><b>Please use the following URL to access your pending forms, you will need to provide your Date of Birth and Contact Number for authenticaton as below:</b></p></b><table style='border: 1px solid black;border-collapse:collapse;width:100%;'>";
		form.field("html", initialEle + tableInitial + bodyData + "</table>");
		String endTable = "<table style='border-collapse: collapse;width:100%;background-color: #f2f2f2'>";
		form.field("html", endTable + lastData + "</table>");
	//	form.bodyPart(new FileDataBodyPart("file", file, MediaType.APPLICATION_OCTET_STREAM_TYPE), null)
		
		System.out.println("Mail Sent...!!! ");
		return webResource.type(MediaType.MULTIPART_FORM_DATA_TYPE).post(ClientResponse.class, form);
	}

	// Mail to the payer of OPD Sule Hospital

	public void sendEMailtoPayerOPD(String to, String subject, String URL, String Name, String contact) {
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		switch (protocol) {
		case SMTPS:
			props.put("mail.smtp.ssl.enable", true);
			break;
		case TLS:
			props.put("mail.smtp.starttls.enable", true);
			break;
		}

		Authenticator authenticator = null;
		if (auth) {
			props.put("mail.smtp.auth", true);
			authenticator = new Authenticator() {
				private PasswordAuthentication pa = new PasswordAuthentication(username, password);

				@Override
				public PasswordAuthentication getPasswordAuthentication() {
					return pa;
				}
			};
		}

		Session session = Session.getInstance(props, authenticator);

		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress(from));
			InternetAddress[] address = { new InternetAddress(to) };
			message.setRecipients(Message.RecipientType.TO, address);
			message.setSubject(subject);
			message.setSentDate(new Date());
			/* message.setText(body); */
			Multipart multipart = new MimeMultipart("alternative");

			MimeBodyPart textPart = new MimeBodyPart();
			// If email client does not support html-------------------------
			String textContent = "Please use the following URL to fill your IPD form:" + URL;
			// -----------------------------------------------------------------
			textPart.setText(textContent);
			MimeBodyPart htmlPart = new MimeBodyPart();
			String htmlContent = "<html><h1>Welcome to QForms   " + Name

			+ "</h1><p><h3>Please click on the link to go to your IPD form:</h3></p>" + "<p><b>URL:</b> " + URL
					+ "</p></html>";
			htmlPart.setContent(htmlContent, "text/html");
			multipart.addBodyPart(textPart);
			multipart.addBodyPart(htmlPart);
			message.setContent(multipart);
			Transport.send(message);
		} catch (MessagingException ex) {
			ex.printStackTrace();
		}
	}
	
	public static void main(String args[]) {
		EmailSessionBean e = new EmailSessionBean();
		System.out.println("sending mail ");
		
		ClientResponse c = e.sendEMailtoPayer("praveen.kumar@srslive.in" , "welcome" ,"www.google.com" , "nitin", "28/05/1991","8744872768" , true);
		System.out.println("sent mail "+c.getStatus());
		
	}

}

