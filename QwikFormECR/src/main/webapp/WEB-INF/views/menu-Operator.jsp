<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="nav nav-stacked"></div>
<ul class="nav nav-pills nav-stacked main-menu">
	<li class="nav-header">Main</li>
	<li><a class="ajax-link" href="<spring:url value="/operatorDash"/>" onclick="submitFunction()">
		<i class="fa fa-building"></i><span> Home</span></a></li>
	
	<%
LoginBean loginUser = new LoginBean();
loginUser = (LoginBean) session.getAttribute("loginUserBean");
%>
	
	 
		 <li><a class="ajax-link" href="<spring:url value="/viewSavedFormInDashBoard"/>" onclick="submitFunction()">
		  		<i class="fa fa-building"></i><span> Application Forms</span></a></li>
					
		<li><a class="ajax-link" href="<spring:url value="/operator_report"/>" onclick="submitFunction()">
				<i class="fa fa-list-alt"></i><span>Reports</span></a></li>
			

<%-- <li><a class="ajax-link" href="<spring:url value="/GetPendingForms"/>" onclick="submitFunction()"><i
			class="fa fa-building"></i><span> Pending Forms</span></a></li> --%>



<!-- <li><a class="ajax-link" href="index2.jsp"><i
			class="fa fa-building"></i><span> Form Builder</span></a></li>



	<li><a class="ajax-link" href="admin-Operators.jsp"><i
			class="fa fa-building"></i><span> Operators</span></a></li>
	
 -->	
 <!-- <li><a class="ajax-link" href="getTransactions1"><i
			class="fa fa-list-alt"></i><span>Reports</span></a></li> -->
			<!-- getFormsBasedOnClient --><!-- ApplicantReportsAllClientsforOp -->
			<!-- <li><a class="ajax-link" href="getFormsBasedOnClient"><i
			class="fa fa-list-alt"></i><span>Applicant Reports</span></a></li> -->
			

</ul>
<script>
function submitFunction(actionName)
{
	 //alert(actionName);
	document.SAMenu.action=actionName;
	document.getElementById("menuFormId").submit();
}
</script>