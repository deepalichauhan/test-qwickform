<%@page import="java.util.Properties"%>
<%@page	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>

	<%
		LoginBean loginUser = new LoginBean();
	String profile=null;
	Integer collegeID=null;
	CollegeBean collegeBean = new CollegeBean();
		try
		{
			loginUser = (LoginBean) session.getAttribute("loginUserBean");
			 profile = (String) session.getAttribute("sesProfile");
			 collegeID = (Integer) session.getAttribute("CollegeId");
			 collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		}catch(NullPointerException e)
		{
			System.out.print("Nullpointer Exception in JSP...");
			response.sendRedirect("sessionTerminated");
		}
		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String clientLogoLink = properties.getProperty("clientLogoLink");

		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
		String cidForMaxFilledSeat1 = properties.getProperty("cidForMaxFilledSeat1"); 
%>

<div class="nav nav-stacked"></div>
<form name="AdminMenu" action="" method="post" id="menuFormId">

<ul class="nav nav-pills nav-stacked main-menu">
	<li class="nav-header">Main</li><!-- adminDash.jsp -->
	<li><a class="ajax-link" href="<spring:url value="/adminDashForBUClien"/>"><i
			class="fa fa-building"></i><span> Home</span></a></li>
	<li><a class="ajax-link" href="#" onclick="submitFunction('getFormsBasedOnClientReportForBUClient')"><i
			class="fa fa-building"></i><span> Subject Details</span></a></li>
	<!-- <li><a class="ajax-link" href="#" onclick="submitFunction('getAllOperatorList')"><i
			class="fa fa-building"></i><span> Operators</span></a></li> 
	<li><a class="ajax-link" href="#" onclick="submitFunction('adminReportConsolidated')" ><i
			class="fa fa-building"></i><span>Reports</span></a></li>
	<li><a class="ajax-link" href="#" onclick="submitFunction('getFormsBasedOnClientReport')"><i
			class="fa fa-building"></i><span>Applicant Reports</span></a></li>  -->
	<%-- <%if(loginUser.getUserName().toString().equals("dimmlykterp")){ %> --%>
										
			<!-- <li><a class="ajax-link" href="#" onclick="submitFunction('refundPages')" ><i
			class="fa fa-building"></i><span> Refund</span></a></li>  -->
		
		<%-- <%} %>
		
	<%if(collegeBean.getCollegeId().toString().equals(cidForMaxFilledSeat1)){ %> --%>
										
			<!-- <li><a class="ajax-link" href="#" onclick="submitFunction('getFormsBasedOnClientReportForBURD')" ><i
			class="fa fa-building"></i><span> Subject Report</span></a></li>  -->
		
		<%-- <%}else{ %>
			
		<%} %> --%>
</ul>
</form>

<script type="text/javascript">

function makeGetRequestedReports(id){
	if(id==1){
		window.location="getTransactions"
	}else if(id==2){
		window.location="getFormsBasedOnClient"
	}else{
		window.location="ImportFile.jsp"
	}
}
function addNewFormTargetToPayer() {
	window.open("addNewFormTarget", "Preview",
			"width=640,height=480");
}



function callingReport() {
	  
	    window.location="getFormsBasedOnClientReport";
	  }
	  
function submitFunction(actionName) {

	//alert(actionName);
	document.AdminMenu.action=actionName;
	document.getElementById("menuFormId").submit();
  }	  
	  
</script>
