<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>

<%
	LoginBean loginUser = new LoginBean();
	String profile = null;
	Integer collegeID = null;
	CollegeBean collegeBean = new CollegeBean();
	try {
		loginUser = (LoginBean) session.getAttribute("loginUserBean");
		profile = (String) session.getAttribute("sesProfile");
		collegeID = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
	} catch (NullPointerException e) {
		System.out.print("Nullpointer Exception in JSP...");
		response.sendRedirect("sessionTerminated");
	}
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();

	String clientLogoLink = properties.getProperty("clientLogoLink");

	String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	String cCodeForApproval = properties.getProperty("cCodeForApproval");
	String cIdForApproval = properties.getProperty("cIdForApproval");
	String useableFormId = properties.getProperty("useableFormId");

%>

<div class="nav nav-stacked"></div>
<form name="AdminMenu" action="" method="post" id="menuFormId">

	<ul class="nav nav-pills nav-stacked main-menu">
		<li class="nav-header">Main</li>
		<!-- adminDash.jsp -->
		<li><a class="ajax-link" href="<spring:url value="/adminDash"/>"><i
				class="fa fa-building"></i><span> Home</span></a></li>
		<%
			if (!collegeBean.getCollegeCode().equalsIgnoreCase(cCodeForApproval)
					|| !collegeBean.getCollegeId().toString().equalsIgnoreCase(cIdForApproval)) {
		%>		
		<li><a class="ajax-link" href="#"
			onclick="submitFunction('viewSavedFormInDashBoard')"><i
				class="fa fa-building"></i><span> Saved Forms</span></a></li>
		<li><a class="ajax-link" href="#"
			onclick="submitFunction('getAllOperatorList')"><i
				class="fa fa-building"></i><span> Operators</span></a></li>
		<%
			}
		%>
		
		<li><a class="ajax-link" href="#"
			onclick="submitFunction('adminReportConsolidated')"><i
				class="fa fa-building"></i><span>Reports</span></a></li>
		<%
			if (collegeBean.getCollegeCode().equalsIgnoreCase(cCodeForApproval)
					&& collegeBean.getCollegeId().toString().equalsIgnoreCase(cIdForApproval)) {
		%>

		<li><a class="ajax-link" href="#"
			onclick="submitFunction('ApplicantReportsForApprovalProcess?flag=pending&approveFlag=no&course=BA_BCOM')"><i
				class="fa fa-building"></i><span>Pending BA And BCOM Applicants List For Approval</span></a></li>
		<li><a class="ajax-link" href="#"
			onclick="submitFunction('ApplicantReportsForApprovalProcess?flag=pending&approveFlag=no&course=BPharma_Bed')"><i
				class="fa fa-building"></i><span>Pending BPh. Dph. BED Applicants List For Approval</span></a></li>
		<li><a class="ajax-link" href="#"
			onclick="submitFunction('ApplicantReportsForApprovalProcess?flag=pending&approveFlag=no&course=BSC')"><i
				class="fa fa-building"></i><span>Pending BSC All Applicants List For Approval</span></a></li>
		<li><a class="ajax-link" href="#"
			onclick="submitFunction('ApplicantReportsForApprovalProcess?flag=pending&approveFlag=no&course=MSC_MA')"><i
				class="fa fa-building"></i><span>Pending MSC MA All Applicants List For Approval</span></a></li>
		<li><a class="ajax-link" href="#"
			onclick="submitFunction('ApplicantReportsForApprovalProcess?flag=pending&approveFlag=no&course=Others')"><i
				class="fa fa-building"></i><span>Pending Others Applicants List For Approval</span></a></li>
		<li><a class="ajax-link" href="#"
			onclick="submitFunction('ApplicantReportsForApprovalProcess?flag=approve&approveFlag=no')"><i
				class="fa fa-building"></i><span>Approved Applicants List</span></a></li>

		<%
			} else {
		%>
		<li><a class="ajax-link" href="#"
			onclick="submitFunction('getFormsBasedOnClientReport')"><i
				class="fa fa-building"></i><span>Applicant Reports</span></a></li>
		<%
			}
		%>

		<%
			if (loginUser.getUserName().toString().equals("dimmlykterp")) {
		%>

		<li><a class="ajax-link" href="#"
			onclick="submitFunction('refundPages')"><i
				class="fa fa-building"></i><span> Refund</span></a></li>

		<%
			}
		%>
	</ul>
</form>

<script type="text/javascript">
	function makeGetRequestedReports(id) {
		if (id == 1) {
			window.location = "getTransactions"
		} else if (id == 2) {
			window.location = "getFormsBasedOnClient"
		} else {
			window.location = "ImportFile.jsp"
		}
	}
	function addNewFormTargetToPayer() {
		window.open("addNewFormTarget", "Preview", "width=640,height=480");
	}

	function callingReport() {

		window.location = "getFormsBasedOnClientReport";
	}

	function submitFunction(actionName) {

		//alert(actionName);
		document.AdminMenu.action = actionName;
		document.getElementById("menuFormId").submit();
	}
</script>
