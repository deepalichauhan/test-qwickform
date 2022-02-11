<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>QwikForms</title>
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
<body>
<div align="center">
		
		<h2 style="color: blue;"> 
		
		<%
		if(!request.getAttribute("errorMsg").equals("") && null!=request.getAttribute("errorMsg") ){
			%>
			<%= request.getAttribute("errorMsg") %>
		<% } else{ %>
		Please enter details in correct format</h2>
		<% } %> 
		<center>
		<button class="btn btn-warning btn-sm"
												onclick="window.close()">Close Preview</button>
	</center>
</div>
</body>
</html>