<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
 <style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
	   alert("Inside Else Success");
       top.location = self.location;
   }
</script> 
</head>
<!-- <body onload="refreshParentWindow()"> -->
<body>

	<%
		String msg =(String)session.getAttribute("msgData") ;
		if(msg==null){
			msg =(String)request.getAttribute("msgData") ;
		}
	
	
	/* (String) request.getAttribute("msg"); */
	%>
	<%
		if (msg != null)

		{
	%>

	<div
		style="color: green; text-align: center; font-weight: bold; font-size: medium;">
		<%=msg%>
	</div>

	<%
		}else{
	%>
		
		<div
		style="color: green; text-align: center; font-weight: bold; font-size: medium;">
			<c:choose>
				<c:when test="${msgData!=null}">
					<h3><c:out value="${msgData}"/></h3>
				</c:when>
				<c:otherwise>
						<h2>	SuccessFull </h2>	
				</c:otherwise>
			</c:choose>
			
		
		</div>
	<%
		}
	%>
	<center>
		<button onclick="window.close()" class="btn btn-info">Close</button>
	</center>
	<script type="text/javascript">
		function refreshParentWindow() {
			window.opener.location.reload(true);
		}
	</script>
</body>
</html>