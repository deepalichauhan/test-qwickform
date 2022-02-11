<%@page import="com.sun.jersey.api.client.Client"%>
<%@page import="com.sun.jersey.api.client.ClientResponse"%>
<%@page import="com.sun.jersey.api.client.WebResource"%>
<%@page import="com.sun.jersey.api.client.filter.HTTPBasicAuthFilter"%>
<%@page import="com.sun.jersey.multipart.FormDataMultiPart"%>
<%@page import="javax.ws.rs.core.MediaType"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String to = "sabpaisa@srslive.in";
	String from = request.getParameter("fromMail");
	String name = request.getParameter("nameMail");
	String body = request.getParameter("bodyMail");
	System.out.println(from+name+body);
	Client client = Client.create();
	client.addFilter(new HTTPBasicAuthFilter("api", "key-473e89a80b5cb8acde3a810c9a18022a"));
	WebResource webResource = client.resource("https://api.mailgun.net/v3/sabpaisa.in" + "/messages");
	FormDataMultiPart form = new FormDataMultiPart();
	form.field("from", from);
	form.field("to", to);
	form.field("subject", "A User has reached out for SabPaisa");
	form.field("text", body);
	webResource.type(MediaType.MULTIPART_FORM_DATA_TYPE).post(ClientResponse.class, form);
	out.println("Mail Send !!!");
%>