<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.sabpaisa.qforms.beans.BeanFormDetails"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.util.Base64"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>QwikForms Form Requested Summary</title>

<link href="css/docs.min.css" rel="stylesheet" type="text/css">
<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="css/wizard.css" rel="stylesheet" />
<link href="css/style-tabbs.css" rel="stylesheet">
<link href="css/style-new.css" rel="stylesheet">
<link rel="shortcut icon" href="img/favicon.ico">
<!--<script src="js/gallery.js"></script> -->

<%
	Integer payeeformIdQC = (Integer) session.getAttribute("currentFormId");
	String PayeeProfile = "";
	CollegeBean collegeBean = null;
	Integer sesBid = null, sesCid = null;
	String formId=null;
	Integer currentFormId = null;
	String formInstanceId = null;
	Integer optionsFieldsCount = 0;
	BeanFormDetails formBean=new BeanFormDetails();
	String formName=null;
	Double paidAmount=null;
	//CollegeBean collegeBean = new CollegeBean();
	Logger log = LogManager.getLogger("Requested Summary for offline form");
	int pageCtr = 0;
	try {
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		formId=(String)request.getParameter("formid");
		sesBid = (Integer) session.getAttribute("bid");
		sesCid = (Integer) session.getAttribute("cid");
		currentFormId = (Integer) session.getAttribute("currentFormId");
		formInstanceId = (String) session.getAttribute("formInstanceId");
		formBean=(BeanFormDetails)session.getAttribute("formDetails");
		PayeeProfile = (String) session.getAttribute("PayeeProfile");
		paidAmount=(Double) session.getAttribute("paidAmount");
		formName=formBean.getFormName();
		if (null == PayeeProfile || "".equals(PayeeProfile)) {
			PayeeProfile = (String) request.getParameter("PayeeProfile");
		}

		Double amount = (Double) session.getAttribute("feeAmt");
		log.info("RequestedSummary.jsp payeeformIdQC ::: "+payeeformIdQC);
		log.info("RequestedSummary.jsp PayeeProfile ::: "+PayeeProfile);
		log.info("sesBid: Requestedsummary.jsp is:" + sesBid);
		log.info("sesCid: Requestedsummary.jsp is:" + sesCid);
		log.info("FormId: Requestedsummary.jsp is:" + formId);
		log.info("currentFormId: Requestedsummary.jsp is:" + currentFormId);
		log.info("newFormId in DataForm: Requestedsummary.jsp is:" + formInstanceId);
		log.info("Requestedsummary.jsp::FormName for upcoming FormBean is:"+formName);
		log.info("Requestedsummary.jsp::paidAmount for upcoming payment is:"+paidAmount);
		log.info("Winny PayeeProfile:" + PayeeProfile);
		log.info("Winny payeeformIdQC:" + payeeformIdQC);
		optionsFieldsCount = (Integer) request.getAttribute("feeFieldCount");
%>
<%
	} catch (java.lang.NullPointerException e) {
%>

<script type="text/javascript">
			window.location = "paySessionOut";
			</script>
<%
	}
%>
<%
	String usercookie = null;
	String sessionID = null;
	String dispchar = "display:none";
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("user"))
				usercookie = cookie.getValue();
			if (cookie.getName().equals("JSESSIONID"))
				sessionID = cookie.getValue();
		}
	} else {
		sessionID = session.getId();
	}
%>
<style id="antiClickjack">
body {
	display: none !important;
}
</style>
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
	<%
		SampleFormBean sfb = (SampleFormBean) session.getAttribute("sesCurrentFormData");
		if (null != sfb) {
			log.info("form bean in session found, invalidating it now");
			session.removeAttribute("sesCurrentFormData");
		} else {
			log.info("no form bean in session found");
		}
	%>

	<script type="text/javascript">

var values = {};

function AddToArray(value, name, id,order) {
	var l=value.length;
	var n=value.indexOf("*");
	value=value.substring(n+1, l)
	//alert('adding to array '+value+", name "+name+", id "+id+", order "+order );
	value = value.split(",").join("");
	value = value.split("`").join("");
	value = value.split("=").join("");
	//values[id] = id + " " + name + "=" + value+"$"+order;
	values[id] = id + "~" + name + "=" + value+"$"+order;
	//alert(JSON.stringify(values)); 

}			

</script>

	<!-- external javascript -->


	<script src="bower_components/jquery/jquery.min.js"></script>
	<script>var jq = jQuery.noConflict();</script>

	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>


	<!-- calender plugin -->
	<script src='bower_components/moment/min/moment.min.js'></script>
	<script src='bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
	<!-- data table plugin -->
	<script src='js/jquery.dataTables.min.js'></script>

	<!-- select or dropdown enhancer -->

	<!-- plugin for gallery image view -->
	<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
	<!-- notification plugin -->
	<script src="js/jquery.noty.js"></script>
	<!-- library for making tables responsive -->

	<!-- tour plugin -->


	<!-- star rating plugin -->

	<!-- for iOS style toggle switch -->

	<!-- autogrowing textarea plugin -->
	<script src="js/jquery.autogrow-textarea.js"></script>
	<!-- multiple file upload plugin -->

	<!-- history.js for cross-browser state change on ajax -->
	<script src="js/jquery.history.js"></script>
	<!-- application script for Charisma demo -->
	<!--<script src="js/charisma.js"></script> -->
	<!-- <s:if test='%{form.getJsEnabled().contentEquals("Y")}'>
		<script src="js/formjs/myScriptNew2468.js"></script>
		<script src="js/formjs/myScriptArts.js"></script>
		<script src="js/formjs/myScriptScience.js"></script>
	</s:if> -->
	<script language="javascript" type="text/javascript"
		src="js/datetimepicker_css.js">
	</script>

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>
	<script src="js/formjs/TNBCollege_Validation_V1.js"></script>
	


	<script>
 
 var captcha_match = false;
 var submitShotFlag = "fresh";
 var options = {};
 
 
//To get the substring before nth character in a string 
 function getPosition(str, m, i) {
 	   return str.split(m, i).join(m).length;
 	}
 
 function GetFee(x, id) {
		AddToOptionsArray(x, id)
		var dataArray = new Array;
		for ( var value in options) {
			dataArray.push(options[value]);
		}
		//alert(dataArray);
		var optionsFieldsCount = '<%=optionsFieldsCount%>';
		//alert('optionsFieldsCount is:'+optionsFieldsCount);
		if(dataArray.length==optionsFieldsCount){
			//alert('optionsFieldsCount is:'+optionsFieldsCount + 'so going ahead with ajax');
		
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				//alert("Fee is "+xhttp.responseText);
				//document.getElementById("FeeBox").innerHTML = xhttp.responseText;
			}
		}
		var appName = window.location.pathname;
		//alert(appName);
		var result = appName.substring(0,getPosition(appName,'/',2));	
		//alert('final url is:'+window.location.origin+result+'/getFee');		
		xhttp.open("GET", window.location.origin+result+"/getFee?optionArray=" + dataArray, true);
		xhttp.send();
		}
	}
 
 function AddToOptionsArray(value, id) {
		
		options[id] = value;
			
		//	alert(JSON.stringify(options));

		}
 </script>


	<div class="container" align="left">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
			style="background: grey;">

			<table width="100%">

				<tr>
					<td width="70%">
						<div class="size"
							style="font-size: 20px; text-transform: uppercase; padding: 12px; color: #fff;">
							<% if(null!=collegeBean.getCollegeImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
								alt="" title="" height="80" width="80"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
								height="60" />
							<%} %>

							<% if(null!=collegeBean.getCollegeName()){ %>
								<%-- <input name="feeDetails" id="feeDetails" value='<c:out value="${feeDetails}" />'/> --%>
							<%=collegeBean.getCollegeName() %>
							<%}else{ %>
							SRS Live Technologies

							<%} %>
						</div>
					</td>
					<td width="30%" align="right">

						<div class="size1"
							style="font-size: 18px; padding: 12px; color: #fff;">

							<h5
								style="font-size: 15px; font-weight: bold; padding: 12px; color: #fff;">
								For any Queries, contact us on:</br> sabpaisa@srslive.in |
								01141733223
							</h5>

						</div>
					</td>
				</tr>
			</table>

			<%-- <table align="center" width="100%">
				<tr>
					<td width="20%" align="center">
						<div class="university-logo- fl-logo">
							<% if(null!=collegeBean.getCollegeImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
								alt="" title="" height="60" width="80"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
								height="60" />
							<%} %>

							<!-- 	<img src="<c:out value="collegeBean.collegeLogo"/>" alt="" title="" class="border-img" width="120" height="100" /> -->
						</div>
					</td>
					<td width="60%" align="center">
						<% if(null!=collegeBean.getCollegeName()){ %> <img
							src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
							alt="" title="" height="60" width="80"></img>
						<h1><%=collegeBean.getCollegeName() %></h1> <%}else{ %>
						<h1>SRS Live Technologies</h1> <!-- <img src="images/sabpaisa-logo.png" alt="" title="" width="80" height="60" /> -->
						<%} %>
					</td>
					<td width="20%" align="center">
						<div class="university-logo- fr-logo">

							<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
								alt="" title="" height="60" width="80"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
								height="60" />
							<%} %>

						</div>
					</td>

				</tr>
			</table> --%>

		</div>
	</div>
	<div class="background-colour" style="background: #fff;" align="center">


		<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
		<img
			src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
			alt="" title="" height="60" width="80"></img>
		<%}else{ %>
		<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
			height="60" />
		<%} %>

	</div>
	<div class="container bg-img-x" style="margin: 15px auto;">
		<form id="QForm" method="post">
			<div name="currentFormId" id="currentFormId"
				value="<%=currentFormId%>"></div>
			<div name="formInstanceId" id="formInstanceId"
				value="<%=formInstanceId%>"></div>
			<input type="hidden" name="isFormBeingRevived" value="Y" />

			<div id="1" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

				<div class="pan-heading">
					<c:out value="${formDetails.formName}" />
				</div>


			</div>




			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off"
				id="formssection"">
				<ul class="accordion-tabs-minimal">
					<%-- <li class="tab-header-and-content"><a href="#"
						class="tab-link is-active" id="tab-10-1-1">Form Basic
							Information</a>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 "
							id="tab-10-1"
							style="border: 1px solid #0072bc; border-top: 4px solid #0072bc;">
							<!-- ><div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<label class="divider-label">Please enter your Name, Date of Birth & Mobile Number. This is required to reprint your e-receipt / remittance(PAP) form, if the need arises.</label>								
						</div> -->
							<%
								if (PayeeProfile.contentEquals("Institute")) {
							%>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Institute
										Code <span class="red">*</span>
									</label>
									<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
										<input type="text" id="rc_code" required="required"
											value="<%=insCode%>" class="form-control" readonly="readonly"
											placeholder="Code" title="0" />
									</div>
								</div>
							</div>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Institute
										Name <span class="red">*</span>
									</label>
									<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
										<input type="text" id="rc_name" required="required"
											value="<%=clgName%>" class="form-control" readonly="readonly"
											placeholder="Name" title="0" />
									</div>
								</div>
							</div>
							<%
								} else {
							%>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Payer
										Name <span class="red">*</span>
									</label>
									<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
										<input type="text" id="rc_name" required="required"
											class="form-control" placeholder="Enter Name"
											value='<c:out value="${form.name}"/>' title="0" />
									</div>
								</div>
							</div>

							<%
								}
							%>

							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Date
										of Birth <span class="red">*</span>
									</label>
									<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">

										<fmt:formatDate value="${form.dobDate}" pattern="dd-MM-yyyy"
											var="parsedDateTime" type="date" />

										<input type="text" class="form-control" id="demo1"
											required="required" placeholder="DD-MM-YYYY"
											value='<c:out value="${parsedDateTime}"/>' title="0" /> <img
											src="images/calendra.png"
											onclick="javascript:NewCssCal('demo1','ddmmyyyy')"
											alt="Calendra" title="Calendra" width="20" height="20"
											class="cal-endra">
									</div>
								</div>
							</div>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Mobile
										Number <span class="red">*</span>
									</label>
									<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
										<input name="Mobile Number" type="text" class="form-control"
											id="rc_contact" required="required" pattern="[0-9]{10}"
											placeholder="Mobile Number"
											value='<c:out value="${form.contact}"/>' title="0" />
									</div>
								</div>
							</div>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Email
										Id <span class="red">*</span>
									</label>
									<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
										<input type="text" name="Email" class="form-control"
											id="rc_email" required="required"
											placeholder="Enter Email Id" type="email"
											placeholder="Enter Your Email Id"
											value='<c:out value="${form.email}"/>' title="0">
									</div>
								</div>
							</div>
							<c:if test="${form.formStartDate!=''}">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="form-group">
										<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Form
											Start Date</label>
										<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
											<input name="${form.formStartDate}" class="form-control"
												id="rc_formStartDate" type="hidden"
												value="<c:out value="${form.formStartDate}"  />" title="0">
										</div>
									</div>
								</div>
							</c:if>
							<c:if test="${form.formEndDate!=''}">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="form-group">
										<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Form
											End Date</label>
										<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
											<input name="${form.formEndDate}" class="form-control"
												id="rc_formEndDate" type="hidden"
												value="<c:out value="${form.formEndDate}" />" title="0">
										</div>
									</div>
								</div>
							</c:if>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12 cap-toppad"
										id="captcha">
										<span class="captcha-txt"><%=session.getAttribute("genAlphaNum")%></span>&nbsp;
										<!-- <a href="#" onclick="refreshTheCaptch();"><img src="${pageContext.request.contextPath}/img/captcha_refresh1.gif"></a> -->
									</div>
									<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
										<label class="captcha-label">Captcha letters are case
											sensitive</label> <input type='hidden' id='captchaFromServer'
											value='<%=session.getAttribute("genAlphaNum")%>' /> <input
											type="text" class="form-control" id="captId"
											placeholder="Enter Captcha as it appears on the left">
									</div>

								</div>
							</div>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<div class="offset-sm-2 col-sm-12">
										<span><button type="button"
												class="wizard-prev btn btn-primary rht-gap"
												onClick="return confirmExit()">Exit</button></span> <span><button
												type="button" onClick="return goToFormPages()" value="Next"
												class="btn btn-primary">Next</button> </span>

									</div>
								</div>
							</div>
							<div class="col-md-12 labeling impt">
								<ul>
									<li>Mandatory fields are marked with an asterisk (*)</li>
									<li>QwikForms is a unique service powered by SabPaisa for
										paying fees, taxes, utility bill online to educational
										institutions, Online taxes, and/or any other
										corporates/institutions.</li>
								</ul>
							</div>
						</div></li> --%>


					<c:forEach items="${formDetails.structureList}" var="formStrList"
						varStatus="ind">

						<c:set var="fieldType">
							<c:out value="${formStrList.formField.lookup_type}" />
						</c:set>
						<c:set var="fieldSubtype">
							<c:out value="${formStrList.formField.lookup_subtype}" />
						</c:set>
						<c:set var="mandFlag">
							<c:out value="${formStrList.isMandatory}" />
						</c:set>
						<c:set var="fieldId">
							<c:out value="${formStrList.id}" />
						</c:set>
						<c:set var="fieldName">
							<c:out value="${formStrList.formField.lookup_name}" />
						</c:set>
						<c:set var="indexCtr">
							<c:out value="${ind.index}" />
						</c:set>
						<c:set var="dynaID">
							<c:out value="${winny.index}" />
						</c:set>
						<c:set var="fieldValue">
							<c:out value="${formStrList.fieldValues}" />
						</c:set>

						<%-- <c:set var="mapKey">
								<c:out value='${payerMap.key}'/>
							</c:set>
						</c:forEach> --%>

						<%-- <c:set var="setMapKey">
						<c:forEach items="${mapKey}" var="setMap">
							<c:out value='${setMap}'/>
						</c:forEach>
					</c:set> --%>




						<%-- <c:if test='${fieldName.contentEquals("SiblingDiscountHidden")}'>
						</c:if>


						<c:if
							test='${fieldType.contentEquals("PageBreak") && fieldName.contentEquals("Page Title") || indexCtr==0 && !fieldName.contentEquals("Page Title") }'>

							<%
								pageCtr = pageCtr + 1;
								System.out.println("pageCtr ::::::::::::: "+pageCtr);
							%>
							<c:if test='${indexCtr!=0}'>

								<% System.out.println("pageCtr in if block  ::::::::::::: "+pageCtr); %>
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="form-group">
										<div class="offset-sm-2 col-sm-12">
											<span><button type="button"
													class="wizard-prev btn btn-primary rht-gap"
													onClick="return formPageBackAction(<%=pageCtr%>)">Back</button></span>
											<span><button class="wizard-next btn btn-primary"
													type="button"
													onClick="return formPageNextAction(<%=pageCtr%>)">Next</button></span>
										</div>
									</div>
								</div>
								<div class="col-md-12 labeling impt">
									<ul>
										<li>Mandatory fields are marked with an asterisk (*)</li>
										<li>QwikForms is a unique service powered by SabPaisa for
											paying fees, taxes, utility bill online to educational
											institutions, Online taxes, and/or any other
											corporates/institutions.</li>
									</ul>
								</div>
							</c:if>
							<li class="tab-header-and-content"><a href="#"
								class="tab-link" id="tab-11-1-<%=pageCtr%>"> <c:out
										value="${formStrList.fieldValues}" />
							</a>
								<div id="tab-11-<%=pageCtr%>"
									class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tab-content"
									style="display: none;">
						</c:if> --%>

						<tr>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 ">
								<div class="form-group">
									<td style="width: 100px"><label
										class="col-lg-3 col-md-12 col-sm-12 col-xs-12"> <c:choose>
												<c:when
													test='${fieldType.contentEquals("E-ReceiptNotification")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														class="form-control"
														id='<c:out value="${formStrList.id}"/>'
														value='<c:out value="${formStrList.formField.notification_content}" />'
														type="hidden"></input>
												</c:when>

												<c:when
													test='${fieldType.contentEquals("Form Notification")}'>

												</c:when>



												<c:otherwise>
													<c:if test='${!fieldName.contentEquals("Page Title")}'>
														<c:choose>
															<c:when
																test='${fieldName.contentEquals("SiblingDiscountHidden")}'>
															</c:when>
															<c:when test='${fieldType.contentEquals("Section")}'>
															</c:when>
															<c:otherwise>
																<strong><c:out
																		value="${formStrList.formField.lookup_name}" /></strong>
															</c:otherwise>
														</c:choose>
													</c:if>
												</c:otherwise>
											</c:choose> <c:if test='${mandFlag==1}'>
												<font color="red">*</font>
											</c:if>
									</label></td>
									<td>
										<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
											<c:choose>
												<c:when
													test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Number")}'>

													<c:choose>
														<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
															<c:choose>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onchange")}'>

																	<input type="number"
																		id='<c:out value="${formStrList.id}"/>'
																		class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
																		title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'>
																			<c:if test='${!payerMap.value.isEmpty()}'>
																				readonly="readonly"
																			</c:if> 
																			value='<c:out value="${payerMap.value}"/>'
																			 
																		</c:if>
																	</c:forEach>
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onselect")}'>

																	<input type="number"
																		id='<c:out value="${formStrList.id}"/>'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
																		title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
															</c:choose>
														</c:when>
														<c:otherwise>
															<input type="number"
																id='<c:out value="${formStrList.id}"/>'
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
																title="<%=pageCtr%>"
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
														</c:otherwise>
													</c:choose>
												</c:when>
												<%-- <c:when
													test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Hidden")}'>
													<c:choose>
														<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
															<c:choose>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onchange")}'>

																	<input type="password"
																		id='<c:out value="${formStrList.id}"/>'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
																		title="<%=pageCtr%>"
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onselect")}'>

																	<input type="password"
																		id='<c:out value="${formStrList.id}"/>'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
																		title="<%=pageCtr%>"
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>

																</c:when>
															</c:choose>
														</c:when>
														<c:otherwise>

															<input type="password"
																id='<c:out value="${formStrList.id}"/>'
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
																title="<%=pageCtr%>"
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
														</c:otherwise>
													</c:choose>
												</c:when> --%>

												<c:when
													test='${fieldType.contentEquals("PageBreak") && fieldName.contentEquals("PageTitle")}'>

												</c:when>


												<c:when
													test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Text")}'>
													<c:choose>
														<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
															<c:choose>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onchange")}'>

																	<c:choose>
																		<c:when
																			test='${formStrList.formField.validation_expression==null || formStrList.formField.validation_expression.trim().contentEquals("")}'>

																			<input type="text"
																				id='<c:out value="${formStrList.id}"/>'
																				name='<c:out value="${formStrList.formField.lookup_name}"/>'
																				<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																				<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																				class="form-control" title="<%=pageCtr%>"
																				onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																		</c:when>
																		<c:otherwise>

																			<input type="text"
																				id='<c:out value="${formStrList.id}"/>'
																				pattern='<c:out default="{*}" value="${formStrList.formField.validation_expression}" />'
																				name='<c:out value="${formStrList.formField.lookup_name}"/>'
																				<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																				<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																				class="form-control" title="<%=pageCtr%>"
																				onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>

																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onselect")}'>
																	<c:choose>
																		<c:when
																			test='${formStrList.formField.validation_expression==null||formStrList.formField.validation_expression.trim().contentEquals("")}'>

																			<input type="text"
																				id='<c:out value="${formStrList.id}"/>'
																				class="form-control" title="<%=pageCtr%>"
																				<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																				<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																				onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																				name='<c:out value="${formStrList.formField.lookup_name}"/>'
																				onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																		</c:when>
																		<c:otherwise>

																			<input type="text"
																				id='<c:out value="${formStrList.id}"/>'
																				pattern='<c:out default="{*}" value="${formStrList.formField.validation_expression}" />'
																				name='<c:out value="${formStrList.formField.lookup_name}"/>'
																				value="this.id" class="form-control"
																				title="<%=pageCtr%>"
																				<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																				<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																				onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id)'
																				onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>

																		</c:otherwise>
																	</c:choose>




																</c:when>
															</c:choose>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when
																	test='${formStrList.formField.validation_expression==null || formStrList.formField.validation_expression.trim().contentEquals("")}'>

																	<input type="text"
																		id='<c:out value="${formStrList.id}"/>'
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		class="form-control" title="<%=pageCtr%>"
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
																<c:otherwise>

																	<input type="text"
																		id='<c:out value="${formStrList.id}"/>'
																		class="form-control" title="<%=pageCtr%>"
																		pattern='<c:out default="{*}" value="${formStrList.formField.validation_expression}" />'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>

																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</c:when>

												<c:when
													test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Alpha")}'>
													<c:choose>
														<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
															<c:choose>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onchange")}'>

																	<input type="text" pattern="[a-zA-Z]+$"
																		placeholder="Alphabets Only"
																		id='<c:out value="${formStrList.id}"/>'
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		class="form-control" title="<%=pageCtr%>"
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onselect")}'>

																	<input type="text" pattern="[a-zA-Z]+$"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		placeholder="Alphabets Only"
																		id='<c:out value="${formStrList.id}"/>'
																		class="form-control" title="<%=pageCtr%>" value=""
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>

																</c:when>
															</c:choose>

														</c:when>
														<c:otherwise>

															<input type="text" pattern="[a-zA-Z]+$"
																placeholder="Alphabets Only"
																id='<c:out value="${formStrList.id}"/>'
																class="form-control" title="<%=pageCtr%>"
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
														</c:otherwise>
													</c:choose>
												</c:when>

												<c:when
													test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Email")}'>
													<c:choose>
														<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
															<c:choose>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onchange")}'>
																	<input type="email"
																		id='<c:out value="${formStrList.id}"/>'
																		class="form-control" title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onselect")}'>

																	<input type="email"
																		id='<c:out value="${formStrList.id}"/>'
																		class="form-control" title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>


																</c:when>
															</c:choose>
														</c:when>

														<c:otherwise>

															<input type="email"
																id='<c:out value="${formStrList.id}"/>'
																class="form-control" title="<%=pageCtr%>"
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
														</c:otherwise>
													</c:choose>
												</c:when>

												<c:when
													test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Date")}'>
													<c:choose>
														<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
															<c:choose>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onchange")}'>


																	<input type="text"
																		id='<c:out value="${formStrList.id}"/>'
																		class="form-control" title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		name='<c:out value="${formStrList.formField.lookup_name} "/>'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																	<img src="images/cal.gif"
																		onclick="javascript:NewCssCal('demo1')"
																		style="cursor: pointer" />







																</c:when>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onselect")}'>

																	<input id='<c:out value="${formStrList.id}"/>'
																		class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>


																</c:when>
															</c:choose>
														</c:when>
														<c:otherwise>

															<input id='<c:out value="${formStrList.id}"/>'
																type="text" class="form-control" title="<%=pageCtr%>"
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.formField.lookup_id}'> 
																			<c:if test='${!payerMap.value.isEmpty() }'>
																				readonly="readonly"
																			</c:if>
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																size="25">
															<img src="img/cal.gif"
																onclick="javascript:NewCssCal('<c:out value="id"/>','ddmmyyyy')"
																style="cursor: pointer" />


														</c:otherwise>
													</c:choose>

												</c:when>

												<c:when test='${fieldType.contentEquals("Multiplier")}'>
													<c:set var="key">
														<c:out value="${formStrList.id}" />
													</c:set>
													<c:choose>
														<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
															<c:if
																test='${formStrList.triggerEvent.contentEquals("HiddenFieldV")}'>
															</c:if>
															<c:choose>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onchange")}'>
																	<input
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		id='<c:out value="${formStrList.id}"/>' type="number"
																		min="0" step="1" placeholder='Multiplier Field'
																		class="form-control" title="<%=pageCtr%>"
																		value='<c:out value="${payerFormDataMap[fieldId]}"/>'
																		
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),
				GetFee("<c:out value='${formStrList.id}' />*"+this.value,this.id),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onselect")}'>
																	<input
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		id='<c:out value="${formStrList.id}"/>' type="number"
																		min="0" step="1" placeholder='Multiplier Field'
																		class="form-control" title="<%=pageCtr%>"
																		value='<c:out value="${payerFormDataMap[fieldId]}"/>'
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value='${formStrList.id}' />*"+this.value,this.id)'>
																</c:when>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("readonlynitj")}'>
																	<input
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		id='<c:out value="${formStrList.id}"/>' type="number"
																		min="0" step="1" placeholder='Multiplier Field'
																		class="form-control" readonly="readonly"
																		title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value='${formStrList.id}' />*"+this.value,this.id)'>
																</c:when>
															</c:choose>
														</c:when>
														<c:otherwise>
															<input
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																id='<c:out value="${formStrList.id}"/>' type="number"
																min="0" step="1" placeholder='Multiplier Field'
																class="form-control" title="<%=pageCtr%>"
																value='<c:out value="${payerFormDataMap[fieldId]}"/>'
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value='${formStrList.id}' />*"+this.value,this.id)'>
														</c:otherwise>
													</c:choose>
												</c:when>

												<c:when
													test='${fieldType.contentEquals("Form Notification")}'>
													<%-- <input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='<c:out value="${formStrList.formField.notification_content}" />'
														type="hidden"></input>
													<label><c:out
															value="${formStrList.formField.notification_content}" />
													</label> --%>
												</c:when>

												<c:when test='${fieldType.contentEquals("Section")}'>
													<center>
														<strong><c:out
																value="${formStrList.formField.lookup_name}" /> </strong>
													</center>
												</c:when>

												<c:when
													test='${fieldType.contentEquals("Radio Button Group")}'>
													<c:set var="key1">
														<c:out value="${formStrList.id}" />
													</c:set>
													<div id="pageRfCode" class="flt">
														<%-- alert("the radio button is in when block :::::::"+${key1}); --%>

														<c:forEach items='${optionsMap2}' var="mapValue">
															<c:if test="${mapValue.key == key1 }">
																<c:forEach items="${mapValue.value}" var="item"
																	varStatus="loop">
																	<input class="gap-m" style="width: 20px; height: 20px;"
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		value='<c:out value="${key1}" />*<c:out value="${item}"/>'
																		type="radio" id='<c:out value="${formStrList.id}"/>'
																		title='<%=pageCtr%>'
																		<c:if test='${mandFlag==1}'> 
																	required='<c:out value="${formStrList.isMandatory}" />' 
																</c:if>
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id)'>
																	<span
																		style="vertical-align: top !important; padding-right: 30px !important"><c:out
																			value="${item}" /></span>
																</c:forEach>
															</c:if>
														</c:forEach>
													</div>

												</c:when>

												<c:when test='${fieldType.contentEquals("Check Box")}'>

													<c:choose>
														<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
															<c:choose>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onchange")}'>
																	<input type="checkbox"
																		id='<c:out value="${formStrList.id}"/>'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		class="form-control chbox" title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
																<c:otherwise>
																	<input type="checkbox"
																		id='<c:out value="${formStrList.id}"/>'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		class="form-control chbox" title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>

																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<input type="checkbox"
																id='<c:out value="${formStrList.id}"/>'
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																class="form-control chbox" title="<%=pageCtr%>"
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
														</c:otherwise>
													</c:choose>
												</c:when>

												<c:when test='${fieldType.contentEquals("Text Area")}'>
													<textarea id='<c:out value="${formStrList.id}"/>'
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														class="form-control" title="<%=pageCtr%>"
														<c:forEach items="${payerFormDataMap}" var="payerMap">
																		<c:if test='${payerMap.key==formStrList.id}'> 
																			value='<c:out value="${payerMap.value}"/>' 
																		</c:if>
																	</c:forEach>
														required='<c:out value="${formStrList.isMandatory}" />'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'></textarea>
												</c:when>

												<%-- <c:when
													test='${fieldType.contentEquals("File Upload Field")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload' type="hidden"></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
														type="button">Upload</button>
												</c:when> --%>

												<%-- <c:when
													test='${fieldType.contentEquals("File Upload Field")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when> --%>
												
												<c:when
													test='${fieldType.contentEquals("Document1")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload1' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>
												<c:when
													test='${fieldType.contentEquals("Document2")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload2' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>
												<c:when
													test='${fieldType.contentEquals("Document3")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload3' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>
												<c:when
													test='${fieldType.contentEquals("Document4")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload4' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>
												<c:when
													test='${fieldType.contentEquals("Document5")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload5' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>
												<c:when
													test='${fieldType.contentEquals("Document6")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload6' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>
												<c:when
													test='${fieldType.contentEquals("Document7")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload7' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>
												<c:when
													test='${fieldType.contentEquals("Document8")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload8' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>
												<c:when
													test='${fieldType.contentEquals("Document9")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload9' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>
												<c:when
													test='${fieldType.contentEquals("Document10")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='File Upload10' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

												</c:when>

												<c:when test='${fieldType.contentEquals("Photograph")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='Photo Upload' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													<button
														onclick='window.open("PayerFileUpload?filetype=photo&fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
												</c:when>

												<%-- <c:when test='${fieldType.contentEquals("Photograph")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='Photo Upload' type="hidden"></input>
													<button
														onclick='window.open("PayerFileUpload?filetype=photo","File Upload Box","width=1024,height=1024")'
														type="button">Upload</button>
												</c:when> --%>


												<%-- <c:when test='${fieldType.contentEquals("Signature")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='Signature Upload' type="hidden"></input>
													<button
														onclick='window.open("PayerFileUpload?filetype=sign","File Upload Box","width=1024,height=1024")'
														type="button">Upload</button>
												</c:when> --%>

												<c:when test='${fieldType.contentEquals("Signature")}'>
													<input
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>'
														value='Signature Upload' type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>

													<button
														onclick='window.open("PayerFileUpload?filetype=sign&fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
														type="button" class="flt btn btn-primary up-load">Upload</button>
													<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
												</c:when>


												<c:when test='${fieldType.contentEquals("Select Box")}'>
													<c:set var="key1">
														<c:out value="${formStrList.id}" />
													</c:set>
													<c:choose>
														<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
															<c:if
																test='${formStrList.triggerEvent.contentEquals("chsedropdown")}'>
																<strong>Readmission in Correspondence Course -
																	2nd Year</strong>
															</c:if>
															<c:if
																test='${formStrList.triggerEvent.contentEquals("CHSE84F")}'>
																<strong>CHSE
																	BBSR/BER/SBP/BPD__________________________/16</strong>
															</c:if>
															<c:choose>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onchange")}'>
																	<select
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		id='<c:out value="${formStrList.id}"/>'
																		title='<%=pageCtr%>' class="form-control"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>

																		<option disabled selected value="">Please
																			Select an Option</option>
																		<c:forEach items="${optionsMap2}" var="mapValue">
																			<c:if test="${mapValue.key == key1 }">
																				<c:forEach items="${mapValue.value}" var="item"
																					varStatus="loop">
																					<option
																						value='<c:out value="${key1}" />*<c:out value="${item}"/>'><c:out
																							value="${item}" /></option>
																				</c:forEach>
																			</c:if>
																		</c:forEach>
																	</select>
																</c:when>
																<c:when
																	test='${formStrList.triggerEvent.contentEquals("onselect")}'>
																	<select
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		id='<c:out value="${formStrList.id}"/>'
																		title='<%=pageCtr%>' class="form-control"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id)'>

																		<option disabled selected value="">Please
																			Select an Option</option>
																		<c:forEach items="${optionsMap2}" var="mapValue">
																			<c:if test="${mapValue.key == key1 }">
																				<c:forEach items="${mapValue.value}" var="item"
																					varStatus="loop">
																					<option
																						value='<c:out value="${key1}" />*<c:out value="${item}"/>'><c:out
																							value="${item}" /></option>
																				</c:forEach>
																			</c:if>
																		</c:forEach>
																	</select>
																</c:when>
															</c:choose>
														</c:when>
														<c:otherwise>
															<div id="pageRfCode">
																<select
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	id='<c:out value="${formStrList.id}"/>'
																	title='<%=pageCtr%>' class="form-control"
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id)'>
																	<option disabled selected value="">Please
																		Select an Option</option>
																	<c:forEach items="${optionsMap2}" var="mapValue">
																		<c:if test="${mapValue.key == key1 }">
																			<c:forEach items="${mapValue.value}" var="item"
																				varStatus="loop">
																				<option
																					value='<c:out value="${key1}" />*<c:out value="${item}"/>'><c:out
																						value="${item}" /></option>
																			</c:forEach>
																		</c:if>
																	</c:forEach>
																</select>
															</div>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:when test='${mandFlag==1}'>
													<script>
							 
							 jq(document)
								.ready(
										function() {
												//document.getElementById("<c:out value="id"/>").required = "required";
												document.getElementById("<c:out value="${formStrList.id}"/>").tabindex = "required";
												
												//alert('after jquery execution for field required flag is::'+ document.getElementById("<c:out value="id"/>").tabindex);
										
											 
										});
							 							
							 							
							</script>


												</c:when>
											</c:choose>
										</div>


									</td>
								</div>
							</div>

						</tr>
						<c:choose>
							<c:when test='${fieldType.contentEquals("Form Notification")}'>
								<script>AddToArray("<c:out value='${formStrList.formField.notification_content}'/>", "<c:out value='${formStrList.formField.lookup_name}'/>", "<c:out value='${formStrList.id}'/>" , "<c:out value='${ind.index}'/>" )</script>
							</c:when>
							<c:when
								test='${fieldType.contentEquals("E-Receipt Notification")}'>
								<script>AddToArray("<c:out value='${formStrList.formField.notification_content}'/>", "<c:out value='${formStrList.formField.lookup_name}'/>", "<c:out value='${formStrList.id}'/>" , "<c:out value='${ind.index}'/>" )</script>
							</c:when>

						</c:choose>
						<c:if test="${formDetails.getStructureList().size()-1==indexCtr}">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<!-- <div class="offset-sm-2 col-sm-12"> -->
									<span><button type="button"
											class="wizard-prev btn btn-primary rht-gap"
											onClick="return formPageBackAction(<%=pageCtr%>+1)">Back</button></span>
									<span><button type="button"
											class="wizard-next btn btn-primary"
											onClick="return formSubmitAction()">Submit</button></span>

									<!-- </div> -->
								</div>
							</div>
							<div class="col-md-12 labeling impt">
								<ul>
									<li>Mandatory fields are marked with an asterisk (*)</li>
									<li>QwikForms is a unique service powered by SabPaisa for
										paying fees, taxes, utility bill online to educational
										institutions, Online taxes, and/or any other
										corporates/institutions.</li>
								</ul>
							</div>
						</c:if>






					</c:forEach>


				</ul>
			</div>



		</form>
	</div>

	<script type="text/javascript">
		var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-36251023-1']);
	  _gaq.push(['_setDomainName', 'jqueryscript.net']);
	  _gaq.push(['_trackPageview']);

	  (function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();

</script>

	<script type="text/javascript">

jq(document).ready(function() {
    jq("div.bhoechie-tab-menu>div.list-group>a").click(function(e) {
        
    	//e.preventDefault();
        jq(this).siblings('a.active').removeClass("active");
        jq(this).addClass("active");
        var index = $(this).index();
        jq("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
        jq("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
    });
});







// funtion to be executed whenever the next button is called from a form page that is not the last page

function formPageNextAction(nextpageid){


   //alert('nextpageid is::'+nextpageid);
   var currentpagectr = nextpageid-1;
   var validationpass = true;
  //alert('currentpagectr is::'+currentpagectr);
	var elements = document.forms["QForm"].elements;
	  for (i=0; i<elements.length; i++){
	   
	    if(elements[i].title<=currentpagectr){
	    	//alert('validating the field');
	    if(null!=elements[i].tabindex){
	    	if(elements[i].tabindex=='required'){
	    		if(elements[i].value==""){
	    			//alert('field '+elements[i].name + ' cannot be empty');
	    			elements[i].focus();
	    			validationpass=false;
	    			break;
	    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
	    		}
	    		else{
	    			//alert('field '+elements[i].name + ' can be empty');
	    		}
	    	}
	      }
	    	
	    }
	    
	    	
	    	if(elements[i].pattern && elements[i].pattern!=''){
	    		//alert('pattern found and it is::'+elements[i].pattern);
	    		//alert('element value is::'+elements[i].value)
	    		//alert('pattern comparsion result is::'+new RegExp(elements[i].pattern).test(elements[i].value))
	    		
	    		if(elements[i].value!="" && !new RegExp(elements[i].pattern).test(elements[i].value)){
	    			//alert("fields '"+ elements[i].name +"' does not match the allowed pattern");
	    			elements[i].focus();
	    			//alert("focussed");
	    			validationpass=false;
	    			break;
	    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
	    		}
	    		else{
	    			//nothing
	    		}
	    	}	    
	    
	    
	    
	  }	



	/* Make ajax call below to save form data passing form id, data string etc and flag 
	 to send form direct link to the payer when currentpagectr =1  */		
	var returnFlag=false;
	//alert('currentpagectr is.. '+currentpagectr);
	//alert('submitShotFlag before is.. '+submitShotFlag);		
	if(currentpagectr==1){		
		submitShotFlag="fresh";
	}
	//alert('submitShotFlag after is.. '+submitShotFlag);	
	if(validationpass==true){
		//alert('proceeding to submit the page...'+currentpagectr);
		submitFormUsingAjax(submitShotFlag, currentpagectr);		

		if(submitShotFlag=="fresh"){
			submitShotFlag="update";
		}
	}
	
	 
	return returnFlag;

		
}



function submitFormUsingAjax(submitShot, currentpagectr) {
	
	//alert("inside submitFormUsingAjax");
	//event.preventDefault();
	var rccode="null";				
	//var feeDetails=0.0;
	rebuildArray();		
	//alert(JSON.stringify(values)); 
	//alert("after in submitFormUsingAjax rebuildArray "+  JSON.stringify(values));
	
	try
	{
	rccode = document.getElementById("rc_code").value;
	//feeDetails=document.getElementById("feeDetails").value;
	}
	catch(err){
		
	}
	//alert("feeDetails : "+feeDetails);
	/* var rcname = document.getElementById("rc_name").value;
	var rcdob = document.getElementById("demo1").value;
	var rccontact = document.getElementById("rc_contact").value;
	var rcemail = document.getElementById("rc_email").value; 
	var rcStartDate="";
	if(null!=document.getElementById("rc_formStartDate")){
		rcStartDate=document.getElementById("rc_formStartDate").value;
	}
	var rcEndDate = "";
	if(null!=document.getElementById("rc_formEndDate")){
		rcEndDate=rcStartDate=document.getElementById("rc_formStartDate").value;
	}	*/
	
	var dataArray = new Array;
	//alert("after in submitFormUsingAjax new rebuildArray "+ JSON.stringify(values));
	for ( var value in values) {
		//alert(" value from PayerFlow.jsp "+value);
		dataArray.push(values[value]);
		//alert(" dataArray from PayerFlow.jsp "+dataArray);
	}
	
	//alert("after in submitFormUsingAjax new dataarray "+   JSON.stringify(dataArray));

	var form_id = '<%=currentFormId%>';
	var bid = '<%=sesBid%>';
	var cid = '<%=sesCid%>';
	var formtemplateid = '<%=currentFormId%>';
	var forminstanceid='<%=formInstanceId%>';
	var payeeFormId ='<%=payeeformIdQC%>';
	var payeeProfi='<%=PayeeProfile%>';
	var paidAmount='<%=paidAmount%>';
	//alert('form_id : '+form_id+' : bid : '+bid+' : cid : '+cid+' : formtemplateid : '+formtemplateid+' : forminstanceid : '+forminstanceid);
	//alert('PayeeProfile : '+payeeProfi+' : payeeformIdQC : '+payeeFormId);
	//alert("values=" + dataArray + "&payeeformIdQC="+payeeFormId+"&rccode="+rccode + "&submitShot="+submitShot+"&isFormBeingRevived=Y"+"&formrevivalinstanceid="+form_id);
	/* var argument = "values=" + dataArray + "&rcname=" + rcname
			+ "&rcdob=" + rcdob + "&rccontact=" + rccontact
			+ "&rcemail=" + rcemail + "&rcStartDate=" + rcStartDate
			+ "&rcEndDate=" + rcEndDate + "&payeeformIdQC="
			+payeeformIdQC+"&rccode="+rccode + "&submitShot="+submitShot+"&isFormBeingRevived=Y"+"&formrevivalinstanceid="+form_id; */
	
	var argument = "values=" + dataArray + "&payeeformIdQC="
			+payeeFormId+"&rccode="+rccode + "&submitShot="+submitShot+"&isFormBeingRevived=Y"+"&formrevivalinstanceid="+form_id+"&paidAmount="+paidAmount;//+"&feeDetails="+feeDetails;
	
	//alert('argument values are::'+argument);
			if(currentpagectr=="last"){ //
				window.location="processFormNew?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid+ "&forminstanceid="+forminstanceid+ "&payeeProfile="+payeeProfi+"&paidAmount="+paidAmount;//+"&feeDetails="+feeDetails;
				
			}
			else{
			
		//	alert('before making ajax call array');
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
					//alert('response received from ajax');
					
					
					if(currentpagectr=="last"){
					
					
					if(jq('#a_13').css('display')!='none'){
						jq('#12').html($('#static').html()).show().siblings('div').hide();
					}
					else
					if(jq('#12').css('display')!='none'){
							jq('#a_13').show().siblings('div').hide();
					} 

					
					jq("#13").addClass('active');
					jq("#12").removeClass('active');	
					document.getElementById("1").style.display='block';
					
					
					document.getElementById("a_13").innerHTML = xhttp.responseText;
					
					
					
					
					}
					
					else{
						
						var nextpageid = currentpagectr+1;
						
						//alert('currentpagectr is::'+currentpagectr);
						jq("#tab-11-1-"+currentpagectr).removeClass('is-active');
						jq("#tab-11-"+currentpagectr).hide();
						jq("#tab-11-"+currentpagectr).removeClass('is-open');
						
						jq("#tab-11-1-"+nextpageid).addClass('is-active');
						jq("#tab-11-"+nextpageid).addClass('is-open');
						jq("#tab-11-"+nextpageid).show();									
						
																							
					}
				}
			}
			var appName = window.location.pathname;
			//alert('appname is:'+appName);
			var result = appName.substring(0,getPosition(appName,'/',2));	
			//alert('final url is:'+window.location.origin+result+'/processForm');
			xhttp.open("GET", window.location.origin+result+"/processFormNew?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid + "&forminstanceid="+forminstanceid+ "&payeeProfile="+payeeProfile+"&paidAmount="+paidAmount, true);
			//xhttp.send();			
			//xhttp.open("GET", "processForm?"+ argument, true);
			xhttp.send();
			}


}

// funtion to be executed whenever the next button is called on the last page of the form
function formSubmitAction(){
	var validationpass=true;
	var currentpagectr="last";
	submitShotFlag="update";
	var elements = document.forms["QForm"].elements;	
	for (i=0; i<elements.length; i++){
	    	//alert('validating the field');
		if(elements[i].required!=null){
	    	//alert("set 1 field is not null : 1");
	    	if(elements[i].required){
				// alert("set 1 field is not null : 2");
	    		if(elements[i].value=="" ){
	    			alert('field '+elements[i].name + ' cannot be empty');
	    			elements[i].focus();
	    			elements[i].style.color = "red";
	    			validationpass=false;
	    			break;
	    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
	    		}
	    		else{
	    			//alert('field '+elements[i].name + ' can be empty');
	    		}
	    	}
	      }
	    
	    
    	if(elements[i].pattern && elements[i].pattern!=''){
    		    		
    		if(elements[i].value!="" && !new RegExp(elements[i].pattern).test(elements[i].value)){
    			alert("fields '"+ elements[i].name +"' does not match the allowed pattern");
    			elements[i].focus();
    			validationpass=false;
    			break;
    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
    		}
    		else{
    			//nothing
    		}
    	}	    
	    
	    
	    
	  }
	    
	
	//alert('currentpagectr is.. '+currentpagectr);
	//alert('submitShotFlag is.. '+submitShotFlag);
if(validationpass==true){
	submitFormUsingAjax(submitShotFlag, currentpagectr);
	
}
	
	return false;
	
}


function rebuildArray()
{
	var elements = document.forms["QForm"].elements;
	  for (i=0; i<elements.length; i++){
		  
		 // alert(elements[i].tagName+" and type is:"+elements[i].type+ ".. and value is "+elements[i].value);
	    //alert(elements[i].value);
	    var eid=elements[i].id;
	    
	  
	   /*  if(eid==("")||eid==("captId")||eid==("captchaFromServer")||eid==("rc_name")||eid==("demo1")||eid==("rc_code")||eid==("rc_email")||eid==("rc_contact")||eid==("rc_formStartDate")||eid==("rc_formEndDate")||eid==("hiddenIdval")||eid==("currentFormId")||eid==("formInstanceId"))
	    {
	    
	  } 
	    else */
	    	
	    	
	    	  if(eid==("tcCheckID") ||eid==("sendNewSms") ){
			    }else{
			    	if(elements[i].type=='radio' || elements[i].type=='checkbox'){													    		
			    		//alert('element type is ..'+  elements[i].type + '..and selected is...' + elements[i].checked);
			    	}
			    	if(!(elements[i].tagName=='INPUT' && elements[i].type=='radio' && (elements[i].type!='checkbox' && elements[i].checked==false))){	
			    		//alert('id is..'+elements[i].id +'.. types is..'+elements[i].type + '..and value is .. '+elements[i].value );
				    		if(elements[i].type=='checkbox'){
				    			if(elements[i].checked){
			    					AddToArray("on", elements[i].name,elements[i].id,i);
				    			}
				    			else{
				    				AddToArray("off", elements[i].name,elements[i].id,i);
				    			}
				    		}	
				    		else{
			    				AddToArray(elements[i].value, elements[i].name,elements[i].id,i);
				    		}
				       	}
				    else{
				    		//alert('case of radio unselected option and the unselected option is..'+elements[i].type + '...and value is.. .'+elements[i].value );
				       }
			    }
	    	
	    	
	  }		
	 // alert("addToArray ::: "+JSON.stringify(AddToArray));
}

function confirmExit(){ 

	if(confirm('Are you sure you want to exit?','Yes', 'No')){
		
		window.location='getPayerFormsById?formid=<%=request.getParameter("formid")  %>&bid=<%=request.getParameter("bid") %>&cid=<%=request.getParameter("cid")%>';
		
		
	}
	return false;
	
}

function makeGetRequest() {
	 var checker = document.getElementById('tcCheckID');
	 var sendbtn = document.getElementById('sendNewSms');
	 // when unchecked or checked, run the function
	 checker.onchange = function(){
	if(this.checked){
	    sendbtn.disabled = false;
	} else {
	    sendbtn.disabled = true;
	}

	}


}






// funtion to be executed whenever the back button is called from a form page 

function formPageBackAction(nextpageid){
	//alert('nextpageid is::'+nextpageid);
	var currentpagectr = nextpageid-1;
	//alert('currentpagectr is::'+currentpagectr);
	
	if(currentpagectr==1){		
		
		
		
		jq("#tab-11-1-"+currentpagectr).removeClass('is-active');
		jq("#tab-11-"+currentpagectr).hide();
		jq("#tab-11-"+currentpagectr).removeClass('is-open');
	
		jq("#tab-10-1-1").addClass('is-active');
		jq("#tab-10-1").show();
		jq("#tab-10-1").addClass('is-open');			
	}
	else{
		
		var prevpagectr = currentpagectr-1;
		
		jq("#tab-11-1-"+currentpagectr).removeClass('is-active');
		jq("#tab-11-"+currentpagectr).hide();
		jq("#tab-11-"+currentpagectr).removeClass('is-open');
	
		jq("#tab-11-1-"+prevpagectr).addClass('is-active');
		jq("#tab-11-"+prevpagectr).addClass('is-open');
		jq("#tab-11-"+prevpagectr).show();
	}
	

	return false;

		
}	

function refreshTheCaptch() {
	alert('about to refresh captcha');
	jq("#captcha").load(location.href + " #captcha");
	alert('after refreh captcha');
	
	
}
function refreshPageRfCode() {
    jq("#pageRfCode").load(location.href + " #pageRfCode");
}







</script>


</body>
</html>
