<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>QwikForms Please Wait</title>
<style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
       top.location = self.location;
   }
</script>
<% 
		String Query="";
		Logger log = LogManager.getLogger("ClientResponse.jsp");
		try{
			Query=(String)request.getParameter("query");
			log.info("Upcoming query is :::::: "+Query.toString());
			/* log.info("request.getParameter PayeeProfile is :::::: "+request.getParameter("payeeProfile").toString()); */
			log.info("request.getParameter clientCode is :::::: "+request.getParameter("clientCode").toString());
		}catch(Exception e){
			e.printStackTrace();
		}
%>
</head>
<body onload=submitForm()>
	<form action="DecryptQuery" method="get" id="decryptform" style="display:hidden">
		
				
			<input name="query" id="query" type="hidden"
					value='<%=request.getParameter("query")%>'>
			
		
		<%-- <input name="payeeProfile" type="hidden" id=profile value='<%=request.getParameter("payeeProfile")%>'> --%>
			
			
		<input name="cliencode" type="hidden" id=code value='<%=request.getParameter("clientCode")%>'>
	
			
	</form>




	<script>
	
	function submitForm()
	{
		var query=document.getElementById("query").value;
		//alert(query);
		query=query.replace(/ /g,'+');
		//alert("new query is ::: "+query);
		document.getElementById("query").value=query;
		document.getElementById("decryptform").submit();
	}
	</script>
</body>
</html>