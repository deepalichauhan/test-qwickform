<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="java.util.Base64"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
	LoginBean loginBean = new LoginBean();
	CollegeBean collegeBean = new CollegeBean();
	String profile = null;
	String clientLogoLink = null;
	Integer collegeID = null;
	String filePath = "null", fileName = "";
	try {
		loginBean = (LoginBean) session.getAttribute("loginUserBean");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		profile = (String) session.getAttribute("sesProfile");
		clientLogoLink = collegeBean.getCollegeURL();
		collegeID = (Integer) collegeBean.getCollegeId();

		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();
		clientLogoLink = properties.getProperty("clientLogoLink");
		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");

		String imageFileURL = properties.getProperty("cobImage");

		if (null != collegeBean.getClientImagePath()) {
			filePath = imageFileURL + collegeBean.getClientImagePath();
			fileName = collegeBean.getClientImagePath().substring(
					collegeBean.getClientImagePath().lastIndexOf("/") + 1,
					collegeBean.getClientImagePath().length());
		}

	} catch (NullPointerException e) {
		//response.sendRedirect("TimeIntervalPage");
%>
<script type="text/javascript">
	window.location = "timeIntervalPage";
</script>
<%
	}
%>

<button type="button" class="navbar-toggle pull-left">
	<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
	<span class="icon-bar"></span> <span class="icon-bar"></span>
</button>


<%
	if (null != collegeBean.getCollegeImage()) {
%><a class="navbar-brand" href="<%=clientLogoLink%>"><img
	src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
	height="40" width="40"><br> <span> <%=collegeBean.getCollegeName()%>,<%=collegeBean.getStateBean().getStateName()%>
</span><span style="margin-left: 10%;"></span></a>

<%
	} else if (null != collegeBean.getClientImagePath()) {
%>
<a class="navbar-brand" href="<%=clientLogoLink%>"><img height="40"
	width="80" src='<c:out value="<%=filePath%>" />'><br> <span>
		<%=collegeBean.getCollegeName()%>,<%=collegeBean.getStateBean().getStateName()%>
</span><span style="margin-left: 10%;"></span></a>

<%
	} else {
%>
<a class="navbar-brand" href="<%=clientLogoLink%>"><img
	src="img\No-logo.jpg" height="40" width="80"><br> <span>
		<%=collegeBean.getCollegeName()%>,<%=collegeBean.getStateBean().getStateName()%>
</span><span style="margin-left: 10%;"></span></a>

<%
	}
%>
<div class="btn-group pull-right">
	<table>
		<tr>
			<td>
				<%
					if (null != collegeBean.getBankDetailsOTM().getBankImage()) {
				%> <span><img
					src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
					alt="" title="<%=collegeBean.getBankDetailsOTM().getBankname()%>"
					height="50" width="100"></span> <%
 	} else {
 %> <img src="img\No-logo.jpg" alt="" title="" height="40" width="80">
				<%
					}
				%>
			</td>

			<td><button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown"><%=loginBean.getUserName()%><span
						class="hidden-sm hidden-xs"></span>
				</button>


				<ul class="dropdown-menu">

					<li class="divider"></li>
					<li><a href="<spring:url value="/loginProcess"/>">Logout</a></li>
				</ul></td>

		</tr>
	</table>

</div>
<div class="container bg-img-x" style="margin: 15px auto;">
	<div style="padding-left: 200px">

		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 bg-colors">
			<ul id="main" class="nav nav-tabs">
				<li role="presentation"
					class="wizard-step-indicator not-allowed active" id="13"><a
					href="addNewFormTarget">Add Form Payer</a></li>

				<li role="presentation" class="wizard-step-indicator active" id="11"><a
					href="initBuilder" onclick="return goToStart()">Form Builder</a></li>

				<li role="presentation"
					class="wizard-step-indicator not-allowed active" id="12"><a
					href="viewSavedFormInDashBoardPendingConfig"
					onclick="return showFormDataOnTabClick()">Forms Pending for
						Configuration</a></li>

				<li role="presentation"
					class="wizard-step-indicator not-allowed active " id="14"><a
					href="getClientActors">getClientActors</a></li>

				<li role="presentation"
					class="wizard-step-indicator not-allowed active " id="14"><a
					href="formUpdationProcess">Previous Form Update</a></li>
					
			</ul>
		</div>



	</div>
</div>
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

	function submitFunction(actionName) {
		//alert(actionName);
		document.menuClientDetails.action = actionName;
		document.getElementById("menuClientFormId").submit();
	}

	function addNewForm(actionName) {
		// alert(actionName);
		document.menuClientDetails.action = actionName;
		document.getElementById("menuClientFormId").submit();
	}
</script>

