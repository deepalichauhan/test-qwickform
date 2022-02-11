<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.sabpaisa.qforms.beans.SuperAdminBean"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@page import="java.util.Properties"%>

<%@page	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%
	LoginBean loginUser = new LoginBean();
	String profile = null;
	Integer collegeID = null;
	CollegeBean collegeBean = new CollegeBean();
	SuperAdminBean sAdmin = new SuperAdminBean();
	Integer comId = null;
	try {

		sAdmin = (SuperAdminBean) session.getAttribute("sABean");
		comId = sAdmin.getCompanyBean().getId();
		
	/* 	loginUser = (LoginBean) session.getAttribute("loginUserBean"); */
		profile = (String) session.getAttribute("sesProfile");
		collegeID = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
	} catch (NullPointerException e) {
		System.out.print("Nullpointer Exception in JSP...SA");
		response.sendRedirect("sessionTerminated");
%>
<!-- <script type="text/javascript">
			
			window.location="timeIntervalPage";
			</script> -->

<%
	}
	AppPropertiesConfig formLinkProperties = new AppPropertiesConfig();
	Properties properties = formLinkProperties.getPropValues();

	String clientLogoLink = properties.getProperty("clientLogoLink");

	String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	/* if (loginUser == null) {
	 response.sendRedirect("Login.jsp");
	
	 return;
	
	 } */
%>

<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>

<form name="SAMenu" action="" method="post" id="menuFormId">
<div class="nav nav-stacked"></div>
<ul class="nav nav-pills nav-stacked main-menu">
	<li class="nav-header">Main</li>
	
	<%-- <c:url value="/getSingleBulletin/${bulletin.id}" /> --%>
	<!-- <li><a class="ajax-link" href="WEB-INF/views/saPortalhome.jsp" onclick="submitFunction()"><i -->
	<li><a class="ajax-link" href="<spring:url value="/loginProcess"/>" onclick="submitFunction()"><i
			class="fa fa-building"></i><span> Home</span></a></li>
			
			
			
	<li><a class="ajax-link" href="<spring:url value="/GetPendingForms"/>" onclick="submitFunction()"><i
			class="fa fa-building"></i><span> Pending Forms</span></a></li>
	
	<li><a class="ajax-link" href="#" onclick="submitFunction('getAllForms')"><i
			class="fa fa-building"></i><span> All Forms</span></a></li>
	<li><a class="ajax-link" href="<spring:url value="/saClientFlow"/>" onclick="submitFunction()"><i
			class="fa fa-building"></i><span>Client</span></a></li>
	<li><a class="ajax-link" href="#" onclick="submitFunction('GetBankDetails')"><i
			class="fa fa-building"></i><span>Bank</span></a> </li>
	<li><a class="ajax-link" href="#" onclick="submitFunction('fetchAdmitCardLists')"><i
			class="fa fa-building"></i><span>Admit Card</span></a> </li>
	<%-- <li><a class="ajax-link" href="<spring:url value="/uploadData"/>"><span>
						Update Photo & Sig </span></a></li> --%>
<!-- /saClientFlow -->
	<%-- <li><a class="ajax-link" href="<spring:url value="/saPayersReport"/>"><i
			class="fa fa-building"></i><span>Payer Reports</span></a></li>
	<li><a class="ajax-link" onclick='openPopup("SuperAdmin.jsp")'><i
			class="fa fa-building" ></i><span>Add New SuperAdmin</span></a></li> --%>

	   <% 
		if (sAdmin.getId().equals(1)) { 
			%>
	
	<%-- <li><a class="ajax-link"
		href="#" onclick="submitFunction('GetSuperAdminDetails/<%=comId%>')"> <i
			class="fa fa-building"></i><span> SuperAdmin Details</span></a></li> --%>
	
	<li><a class="ajax-link"
		href="#" onclick="submitFunction('GetSuperAdminDetails?comid=<%=comId%>')"> <i
			class="fa fa-building"></i><span> SuperAdmin Details</span></a></li>
<%
		 }
	   %>
	   
</ul>

</form>
<script>
function submitFunction(actionName)
{
	 //alert(actionName);
	document.SAMenu.action=actionName;
	document.getElementById("menuFormId").submit();
}
</script>