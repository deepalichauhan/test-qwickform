<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@ page import=" java.util.Properties, com.sabpaisa.qforms.config.AppPropertiesConfig" %>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success</title>
 <!-- <style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
	   alert("Inside Else Success");
       top.location = self.location;
   }
</script>  -->
</head>
<!-- <body onload="refreshParentWindow()"> -->
<!-- <body onclose="sendResponse();"> -->
<body >

	<%
		Logger log = LogManager.getLogger("Success cob ");
		String clientId = "";
		String appId = "";
		String configStatus = "";
		/* String msg ="Successful" ; */
		/* (String) request.getAttribute("msg"); */
		String msg =  (String) request.getAttribute("msg");
		clientId = (String) request.getAttribute("clientId");
		appId = (String) request.getAttribute("appId");
		configStatus = (String) request.getAttribute("configStatus");
		
		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();
		
		String cobUrl = properties.getProperty("cobUrl");
		log.info("cob url from jsp "+cobUrl);
		log.info("msg from jsp "+msg);
		log.info("clientId from jsp "+clientId);
		log.info("appId from jsp "+appId);
		log.info("configStatus from jsp "+configStatus);
		
		log.info("   Response Return to cob is >> "+cobUrl+"UpdateConfigStatus?clientId="+clientId+"&appId="+appId+"&configStatus="+configStatus);
		String urlForLink="https://qwikforms.in/clientOnBoarding/UpdateConfigStatus?clientId="+clientId+"&&appId=1&&configStatus=sucess";
		log.info("urlForLink "+urlForLink);
	%>
	<%
		if (msg != null)

		{
	%>

	<div
		style="color: green; text-align: center; font-weight: bold; font-size: medium;">
		<%=msg%>
		<a href=<%=urlForLink%>>Click for sending Success Status to COB</a>
	</div>

	<%
		}
	%>

	<center>
		<button onclick="window.close()" class="btn btn-info">Close</button>
	<!-- <a href="/qwikCollect/GetClientDetails" >	
	<button class="btn btn-info">Back</button></a> -->
		
	</center>
	<script type="text/javascript">
		function refreshParentWindow() {
			window.opener.location.reload(true);
		}
		
		function sendResponse()
		{
			alert("send response "+clientId+ " appid "+appId+ " status "+configStatus);
			var xhttp = new XMLHttpRequest();
			alert("http request "+xhttp.readyState);
			/* xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
				//	document.getElementById("FeeBox").innerHTML = xhttp.responseText;
				}
			} */
			var url=cobUrl+"UpdateConfigStatus?clientId="+clientId+"&appId="+appId+"&configStatus="+configStatus;
			alert("url is "+url);
			xhttp.open("GET", url, true);
			xhttp.send();
		}
	</script>
</body>
</html>
<!-- addBankDetailsUI.jsp -->
