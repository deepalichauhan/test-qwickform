<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
		String msg =(String)session.getAttribute("msg") ;
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
			<h2>	SuccessFull </h2>
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