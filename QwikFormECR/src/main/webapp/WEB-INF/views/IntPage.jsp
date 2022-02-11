<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Please Wait</title>
<style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
       top.location = self.location;
   }
</script>
</head>
<body onload=SPRedirect()>
	<h2>Please Wait</h2>
	<%
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String qFormsIP = properties.getProperty("qFormsIP");
		%>
	
	<input type="hidden" value='<c:out value="fd.studentName" />'
		id="name">
	<input type="hidden" value='<c:out value="fd.txnAmount" />'
		id="amt">
	<input type="hidden" value='<c:out value="fd.mobile" />' id="mob">
	<input type="hidden" value='<c:out value="fd.transId" />'
		id="transNo">

	<input type="hidden" value='<c:out value="fd.semester" />'
		id="semester">
	<input type="hidden" value='<c:out value="fd.rollNo" />'
		id="rollNo">
	<input type="hidden" value='<c:out value="fd.branch" />'
		id="branch">
    
	<script>
function SPRedirect()
{
	var ip="<%=qFormsIP%>";
	var name=document.getElementById("name").value;
	var amount=document.getElementById("amt").value;
	var cont=document.getElementById("mob").value;
	var transid=document.getElementById("transNo").value;
	var semester=document.getElementById("semester").value;
	var brnch=document.getElementById("branch").value;
	var rollNo=document.getElementById("rollNo").value;
	
	window.location=ip+"index.jsp?client=NITJ&Name="+name+"&Contact="+cont+"&amt="+amount+"&txnId="+transid+"&roll="+rollNo+"&sem="+semester+"&branch="+brnch;

}
</script>
</body>

</html>