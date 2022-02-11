<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>QwikForms Form</title>

<link href="css/docs.min.css" rel="stylesheet" type="text/css" />
<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link href="css/wizard.css" rel="stylesheet" />
<link href="css/style-tabbs.css" rel="stylesheet" />
<link href="css/style-new.css" rel="stylesheet" />

<%
	Integer sesBid = null, sesCid = null;
	CollegeBean collegeBean = new CollegeBean();
	int pageCtr =0;
	Integer currentFormId=null;
	String formInstanceId = null;
	Logger log = LogManager.getLogger("PayerFormListNew Payer Form New");
	String redirectedFrom="";
	try {

		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		currentFormId = (Integer) session.getAttribute("currentFormId");
		formInstanceId = (String) session.getAttribute("formInstanceId");
		redirectedFrom= (String) session.getAttribute("redirectedFrom")==null?"":(String) session.getAttribute("redirectedFrom");
		log.info("redirectedFrom is::"+redirectedFrom);	
		log.info("currentFormId: PayerFormNewInternal.jsp is:"+currentFormId);
		log.info("formInstanceId: PayerFormNewInternal.jsp is:"+formInstanceId);
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
	String dispchar ="display:none"; 
	Cookie[] cookies = request.getCookies(); 
	if (cookies !=
	null) { for (Cookie cookie : cookies) { if
	(cookie.getName().equals("user")) usercookie = cookie.getValue(); if
	(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue(); }
	} else { sessionID = session.getId(); }
%>

<script src="bower_components/jquery/jquery.min.js"></script>
<link href="css/docs.min.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap-select.css" rel="stylesheet" type="text/css" />

<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link href="css/wizard.css" rel="stylesheet" />
<link href="css/style-tabbs.css" rel="stylesheet" />
<link href="css/style-new.css" rel="stylesheet" />

<script language="javascript" type="text/javascript"
	src="js/datetimepicker_css_100Year.js"></script>
<script>

var captcha_match = false;

$(document).ready(function()
{
	$('ul#main li').click(function()
	{
	$('#main').find('li').removeClass('active')
		$(this).addClass('active')
		$('.box').hide()
		$( '#a_' + $(this)  .attr('id')  ).show()
	
	});

});
</script>
<script type="text/javascript">
		$(document).ready(function(){
			$(this).scrollTop(0);
		});

var submitShotFlag = "fresh";

var forminstanceid="";

//to get the substring before nth character in a string 
function getPosition(str, m, i) {
	   return str.split(m, i).join(m).length;
	}

</script>


<style>
.not-padding {
	padding: 0
}
</style>

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
		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String qFormsIP = properties.getProperty("qFormsIP");
		String clientLogoLink = properties.getProperty("clientLogoLink");
		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		log.info("collegeBean is in PayerFormInternal.jsp ::::::::::"+collegeBean);
	%>

	<%
		
	%>
	<!-- external javascript -->

	<%
		String payeeformIdQC = (String) request.getParameter("formId");
		String PayeeProfile = "";
		String clgName = "";
		String insCode = "";
		
		try {
			sesBid = (Integer) session.getAttribute("BankId");
			sesCid = (Integer) session.getAttribute("CollegeId");
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			PayeeProfile = (String) session.getAttribute("PayeeProfile");
			
			log.info("PayeeProfile is::"+PayeeProfile);
			clgName = (String) session.getAttribute("SelectedInstitute");
			insCode = (String) session.getAttribute("InstituteCode");
			
			

		} catch (java.lang.NullPointerException e) {
			System.out.println("null pointer exception");
	%>
	<script type="text/javascript">
			window.location="PaySessionOut";
			</script>

	<%
		}
	%>

	<script type="text/javascript">

	var values = {};
	var options = {};

	function AddToArray(value, name, id,order) {
	
		value = value.split(",").join("");
		value = value.split("`").join("");
		value = value.split("=").join("");
		values[id] = id + "`" + name + "=" + value+"$"+order;
		

	}				

</script>

	<%
		System.out.println("Winny payeeformIdQC:" + payeeformIdQC);
	%>
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off" id="a_13"
		style="display: none;">
		<!-- </div> -->
		<form id="QForm" method="post">
			<input type="hidden" name="currentFormId" id="currentFormId"
				value="<%=currentFormId%>" />
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off"
				id="formssection"">
				<div class="pan-heading">
					<c:out value="${form.getFormName()}" />
				</div>
			</div>
			<div class="top-pad"></div>
			<ul class="accordion-tabs-minimal">
				<li class="tab-header-and-content"><a href="#"
					class="tab-link is-active" id="tab-10-1-1">Basic Information</a>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tab-content"
						id="tab-10-1">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<label class="divider-label">Please enter your Name, Date
								of Birth & Mobile Number. This is required to reprint your
								e-receipt / remittance(PAP) form, if the need arises. </label>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Payer
									Name *</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" id="rc_name" required="required"
										value='<c:out value="${sampleFormBean.name}"/>'
										class="form-control" placeholder="Enter Name" title="0">
								</div>
							</div>
						</div>

						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">
									Date of Birth * </label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" class="form-control" id="demo1"
										required="required" placeholder="DD-MM-YYYY" title="0"
										value='<c:out value="${sampleFormBean.dob}"/>'> <img
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
									Number *</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input name="Mobile Number" type="text" class="form-control"
										id="rc_contact" required="required"
										value='<c:out value="${sampleFormBean.contact}"/>'
										placeholder="Mobile Number" title="0">
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Email
									Id *</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" name="Email" class="form-control"
										value='<c:out value="${sampleFormBean.email}"/>' id="rc_email"
										required="required" placeholder="Enter Email Id" type="email"
										placeholder="Enter Your Email Id" title="0">
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Form
									Start Date</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<fmt:formatDate value="${form.formStartDate}"
										pattern="dd-MM-yyyy" var="parsedDateTime" type="both" />
									<c:out value="${parsedDateTime}" />

									<input name="${form.formStartDate}" class="form-control"
										id="rc_formStartDate" type="hidden"
										value="<c:out value="${parsedDateTime}"  />" title="0">
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Form
									End Date</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<fmt:formatDate value="${form.formEndDate}"
										pattern="dd-MM-yyyy" var="parsedDateTime1" type="both" />

									<c:out value="${parsedDateTime1}" />


									<input name="${form.formEndDate}" class="form-control"
										id="rc_formEndDate" type="hidden"
										value="<c:out value="${parsedDateTime1}" />" title="0">
								</div>
							</div>
						</div>
						<div id="pageRCCode"
							class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12 cap-toppad">
									<span class="captcha-txt"><%=session.getAttribute("genAlphaNum")%></span>&nbsp;
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
											onClick="return goToStart()">Back</button></span>

									<button onClick="return goToFormPages()" type="button"
										value="Next" class="btn btn-primary">Next</button>

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
							<c:set var="instFlag">
								<c:out value="${form.hasInstructions}" />
							</c:set>
							<c:if test='${instFlag=="Y"}'>
								<button onclick="downloadFile()">Download Instructions</button>
							</c:if>
						</div>
					</div></li>
				<c:forEach items="${form.structureList}" var="formStrList"
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

					<!--   dynamic form page tabs and fields printing starts here -->
					<c:if test='${fieldName.contentEquals("SiblingDiscountHidden")}'>
					</c:if>
					<c:if
						test='${fieldType.contentEquals("PageBreak") && fieldName.contentEquals("Page Title") || indexCtr==0 && !fieldName.contentEquals("Page Title") }'>
						<%
							pageCtr = pageCtr+1;
					%>
						<c:if test='${indexCtr!=0}'>
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
								class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tab-content">
					</c:if>

					<tr>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<td style="width: 300px"><label
									class="col-lg-3 col-md-12 col-sm-12 col-xs-12"> <c:choose>
											<c:when
												test='${fieldType.contentEquals("E-Receipt Notification")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													class="form-control"
													id='<c:out value="${formStrList.id}"/>'
													value='<c:out value="${formStrList.formField.notification_content}" />'
													type="hidden"></input>

											</c:when>
											<c:when test='${fieldType.contentEquals("Section")}'>
											</c:when>
											<c:otherwise>
												<c:if test='${!fieldName.contentEquals("Page Title")}'>
													<c:choose>
														<c:when
															test='${fieldName.contentEquals("SiblingDiscountHidden")}'>
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
														<choose> <c:when
															test='${formStrList.triggerEvent.contentEquals("onchange")}'>
															<input type="number"
																id='<c:out value="${formStrList.id}"/>'
																class="form-control" title="<%=pageCtr%>"
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																value='<c:out value="payerFormDataMap[${fieldId}]}"/>'
																pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),
												<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
														</c:when> <c:when
															test='${formStrList.triggerEvent.contentEquals("onselect")}'>
															<input type="number"
																id='<c:out value="${formStrList.id}"/>'
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																class="form-control" title="<%=pageCtr%>"
																pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
														</c:when> </choose>
													</c:when>
													<c:otherwise>
														<input type="number"
															id='<c:out value="${formStrList.id}"/>'
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															value='<c:out value="payerFormDataMap[${fieldId}]"/>'
															class="form-control" title="<%=pageCtr%>"
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
															pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
															onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
													</c:otherwise>
												</c:choose>
											</c:when>

											<c:when
												test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Hidden")}'>
												<c:choose>
													<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
														<c:choose>
															<c:when
																test='${formStrList.triggerEvent.contentEquals("onchange")}'>
																<input type="password"
																	id='<c:out value="${formStrList.id}"/>'
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	class="form-control" title="<%=pageCtr%>"
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
															</c:when>
															<c:when
																test='${formStrList.triggerEvent.contentEquals("onselect")}'>
																<input type="password"
																	id='<c:out value="${formStrList.id}"/>'
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	class="form-control" title="<%=pageCtr%>"
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
															</c:when>
														</c:choose>
													</c:when>
													<c:otherwise>
														<input type="password"
															id='<c:out value="${formStrList.id}"/>'
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															value='<c:out value="payerFormDataMap[${fieldId}]"/>'
															class="form-control" title="<%=pageCtr%>"
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
															onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
													</c:otherwise>
												</c:choose>
											</c:when>

											<c:when
												test='${fieldType.contentEquals("PageBreak") && fieldName.contentEquals("Page Title")}'>

											</c:when>

											<c:when
												test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Text")}'>
												<c:choose>
													<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
														<c:when
															test='${formStrList.triggerEvent.contentEquals("onchange")}'>
															<c:choose>
																<c:when
																	test='${formStrList.formField.validation_expression==null || formStrList.formField.validation_expression.trim().contentEquals("")}'>
																	<input type="text"
																		id='<c:out value="${formStrList.id}"/>'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																		class="form-control" title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
																<c:otherwise>
																	<input type="text"
																		id='<c:out value="${formStrList.id}"/>'
																		pattern='<c:out default="{*}" value="${formStrList.formField.validation_expression}" />'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																		class="form-control" title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
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
																		value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:when>
																<c:otherwise>
																	<input type="text"
																		id='<c:out value="${formStrList.id}"/>'
																		pattern='<c:out default="{*}" value="${formField.validation_expression}" />'
																		name='<c:out value="${formStrList.formField.lookup_name}"/>'
																		value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																		class="form-control" title="<%=pageCtr%>"
																		<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																		onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id)'
																		onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																</c:otherwise>
															</c:choose>
														</c:when>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when
																test='${formStrList.formField.validation_expression==null||formStrList.formField.validation_expression.trim().contentEquals("")}'>
																<input type="text"
																	id='<c:out value="${formStrList.id}" />'
																	class="form-control" title="<%=pageCtr%>"
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
															</c:when>
															<c:otherwise>
																<input type="text"
																	id='<c:out value="${formStrList.id}"/>'
																	class="form-control" title="<%=pageCtr%>"
																	pattern='<c:out default="{*}" value="${formStrList.formField.validation_expression}" />'
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>>
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
																	class="form-control" title="<%=pageCtr%>"
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
															</c:when>
															<c:when
																test='${formStrList.triggerEvent.contentEquals("onselect")}'>
																<input type="text" pattern="[a-zA-Z]+$"
																	placeholder="Alphabets Only"
																	id='<c:out value="${formStrList.id}"/>'
																	class="form-control" title="<%=pageCtr%>"
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
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
															value='<c:out value="payerFormDataMap[${fieldId}]"/>'
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
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
																	id='<c:out value="${formStrList.id}" />'
																	class="form-control" title="<%=pageCtr%>"
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
															</c:when>
															<c:when
																test='${formStrList.triggerEvent.contentEquals("onselect")}'>
																<input type="email"
																	id='<c:out value="${formStrList.id}" />'
																	class="form-control" title="<%=pageCtr%>"
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
															</c:when>
														</c:choose>
													</c:when>
													<c:otherwise>
														<input type="email"
															id='<c:out value="${formStrList.id}" />'
															class="form-control" title="<%=pageCtr%>"
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															value='<c:out value="payerFormDataMap[${fieldId}]"/>'
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
																<!-- <c:out value="${formStrList.id}" /> -->
																<input type="text"
																	id='<c:out value="${formStrLink.id}"/>'
																	class="form-control" title="<%=pageCtr%>"
																	placeholder="DD-MM-YYYY"
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	name='<c:out value="${formStrLink.formField.lookup_name} "/>'
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																<img src="images/cal.gif"
																	onclick="javascript:NewCssCal('demo1')"
																	style="cursor: pointer" />

															</c:when>
															<c:when
																test='${formStrList.triggerEvent.contentEquals("onselect")}'>
																<input id='<c:out value="${formStrList.id}"/>'
																	class="form-control"
																	onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	title="<%=pageCtr%>"
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
															</c:when>
														</c:choose>
													</c:when>
													<c:otherwise>
														<input id='<c:out value="${formStrList.id}"/>' type="text"
															class="form-control" title="<%=pageCtr%>"
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															value='<c:out value="payerFormDataMap[${fieldId}]"/>'
															onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />'</c:if>
															size="25">
														<img src="img/cal.gif"
															onclick="javascript:NewCssCal('<c:out value="${formStrList.id}"/>','ddmmyyyy')"
															style="cursor: pointer" />
													</c:otherwise>
												</c:choose>
											</c:when>

											<c:when test='${fieldType.contentEquals("Section")}'>
												<center>
													<strong><c:out
															value="${formStrList.formField.lookup_name}" /></strong>
												</center>
											</c:when>

											<c:when
												test='${fieldType.contentEquals("Radio Button Group")}'>
												<c:set var="key">
													<c:out value="${formStrList.id}" />
												</c:set>
												<div id="pageRfCode">
													<c:forEach items='optionsMap2[${key}]' var="map">
														<c:out value="" />
														<input
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															value='<c:out value="${key}" />*<c:out value=""/>'
															type="radio" id='<c:out value="${formStrList.id}"/>'
															title='<%=pageCtr%>'
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
															onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id)'>
													</c:forEach>
												</div>
											</c:when>

											<c:when test='${fieldType.contentEquals("Check Box")}'>
												<input type="checkbox"
													id='<c:out value="${formStrList.id}" />'
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													class="form-control" title="<%=pageCtr%>"
													<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
													onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
											</c:when>

											<c:when test='${fieldType.contentEquals("Text Area")}'>
												<textarea id='<c:out value="${formStrList.id}"/>'
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													class="form-control" title="<%=pageCtr%>"
													<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
													onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'><c:out
														value="payerFormDataMap[${fieldId}]" /></textarea>
											</c:when>

											<%-- <c:when	test='${fieldType.contentEquals("File Upload Field")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when> --%>
											<c:when	test='${fieldType.contentEquals("Document1")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload1'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when><c:when	test='${fieldType.contentEquals("Document2")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload2'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when><c:when	test='${fieldType.contentEquals("Document3")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload3'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when><c:when	test='${fieldType.contentEquals("Document4")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload4'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when><c:when	test='${fieldType.contentEquals("Document5")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload5'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when><c:when	test='${fieldType.contentEquals("Document6")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload6'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when><c:when	test='${fieldType.contentEquals("Document7")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload8'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when><c:when	test='${fieldType.contentEquals("Document9")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload9'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when><c:when	test='${fieldType.contentEquals("Document10")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>' value='File Upload10'	type="hidden"></input>
												<button	onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when>
											<c:when test='${fieldType.contentEquals("Photograph")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}"/>'
													value='Photo Upload' type="hidden"></input>
												<button
													onclick='window.open("PayerFileUpload?filetype=photo","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when>

											<c:when test='${fieldType.contentEquals("Signature")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													id='<c:out value="${formStrList.id}" />'
													value='Signature Upload' type="hidden"></input>
												<button
													onclick='window.open("PayerFileUpload.jsp?filetype=sign","File Upload Box","width=1024,height=1024")'
													type="button">Upload</button>
											</c:when>

											<c:when test='${fieldType.contentEquals("Multiplier")}'>
												<c:set var="key">
													<c:out value="${formStrList.id}" />
												</c:set>
												<c:choose>
													<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
														<c:choose>
															<c:when
																test='${formStrList.triggerEvent.contentEquals("HiddenFieldV")}'>
															</c:when>
															<c:when
																test='${formStrList.triggerEvent.contentEquals("onchange")}'>
																<input
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	id='<c:out value="${formStrList.id}" />' type="number"
																	min="0" step="1" placeholder='Multiplier Field'
																	class="form-control" title="<%=pageCtr%>"
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value="${formStrList.id}" />&#42;"+this.value,this.id),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
															</c:when>
															<c:when
																test='${formStrList.triggerEvent.contentEquals("onselect")}'>
																<input
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	id='<c:out value="${formStrList.id}" />' type="number"
																	min="0" step="1" placeholder='Multiplier Field'
																	class="form-control" title="<%=pageCtr%>"
																	value='<c:out value="payerFormDataMap[${fieldId}]"/>'
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value="${formStrList.id}" />&#42;"+this.value,this.id)'>
															</c:when>
															<c:when
																test='${formStrList.triggerEvent.contentEquals("readonlynitj")}'>
																<input
																	name='<c:out value="${formStrList.formField.lookup_name}"/>'
																	id='<c:out value="${formStrList.id}" />' type="number"
																	min="0" step="1" placeholder='Multiplier Field'
																	class="form-control" readonly="readonly"
																	title="<%=pageCtr%>"
																	<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																	onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																	onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value="${formStrList.id}" />&#42;"+this.value,this.id)'>
															</c:when>
														</c:choose>
													</c:when>
													<c:otherwise>
														<input
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															id='<c:out value="${formStrList.id}" />' type="number"
															min="0" step="1" placeholder='Multiplier Field'
															class="form-control" title="<%=pageCtr%>"
															value='<c:out value="payerFormDataMap[${fieldId}]"/>'
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
															onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value="${formStrList.id}" />&#42;"+this.value,this.id)'>
													</c:otherwise>
												</c:choose>
											</c:when>

											<c:when
												test='${fieldType.contentEquals("Form Notification")}'>
												<input
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													class="form-control"
													id='<c:out value="${formStrList.id}" />'
													value='<c:out value="${formStrList.formField.notification_content}" />'
													type="hidden"></input>
												<label><c:out
														value="${formStrList.formField.notification_content}" /></label>
											</c:when>

											<c:when test='${fieldType.contentEquals("Select Box")}'>
												<c:set var="key">
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
														<c:if
															test='${formStrList.triggerEvent.contentEquals("onchange")}'>
															<select
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																id='<c:out value="${formStrList.id}" />'
																title='<%=pageCtr%>' class="form-control"
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
																<option disabled selected value="">Please
																	Select an Option</option>
																<c:forEach items='optionsMap2[${key}]' var="map">
																	<option
																		value='<c:out value="${map}" />*<c:out value=""/> '><c:out
																			value="" /></option>
																</c:forEach>
															</select>
														</c:if>
														<c:if
															test='${formStrList.triggerEvent.contentEquals("onselect")}'>
															<select
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																id='<c:out value="${formStrList.id}" />'
																title='<%=pageCtr%>' class="form-control"
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id)'>
																<option disabled selected value="">Please
																	Select an Option</option>
																<c:forEach items='optionsMap2[${key}]' var="map">
																	<%-- <div id='<c:out value="%{#key}" />*<c:out /> '>	</div> --%>
																	<option
																		value='<c:out value="${map}" />*<c:out value=""/> '><c:out
																			value="" /></option>
																</c:forEach>
															</select>
														</c:if>
													</c:when>
													<c:otherwise>
														<div id="pageRfCode">
															<select
																name='<c:out value="${formStrList.formField.lookup_name}"/>'
																id='<c:out value="${formStrList.id}" />'
																title='<%=pageCtr%>' class="form-control"
																<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
																onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id)'>
																<option disabled selected value="">Please
																	Select an Option</option>
																<c:forEach items='optionsMap2[${key}]' var="map">
																	<option
																		value='<c:out value="${map}" />*<c:out value=""/> '><c:out
																			value="" /></option>
																</c:forEach>
															</select>
														</div>
													</c:otherwise>
												</c:choose>
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
						<c:otherwise>
							<script>AddToArray("Empty", "<c:out value='${formStrList.formField.lookup_name}'/>", "<c:out value='${formStrList.id}'/>" , "<c:out value='${ind.index}'/>" )</script>
						</c:otherwise>
					</c:choose>

					<c:if test="${form.getStructureList().size()-1==indexCtr}">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<div class="offset-sm-2 col-sm-12">
									<span><button type="button"
											class="wizard-prev btn btn-primary rht-gap"
											onClick="formPageBackAction(<%=pageCtr%>+1)">Back</button></span> <span><button
											class="wizard-next btn btn-primary" type="button"
											onClick="return formSubmitAction()">Submit</button></span>
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

				</c:forEach>
			</ul>

		</form>
	</div>

	<script type="text/javascript">
		$(document).ready(function(){
			$("select").change(function(){
				$(this).find("option:selected").each(function(){
					if($(this).attr("value")=="individual-box"){
						$(".councils").not(".individual-box").hide();
						$(".individual-box").show();
					}
					else if($(this).attr("value")=="institue-box"){
						$(".councils").not(".institue-box").hide();
						$(".institue-box").show();
					}
					
				});
			}).change();
		});
		</script>

	<script type="text/javascript">
	
//  funtion to be executed whenever the next button is called from a form page that is not the last page
	
	function formPageNextAction(nextpageid){

	
	   var currentpagectr = nextpageid-1;
	   var validationpass = true;
	   var elements = document.forms["QForm"].elements;
	 	 
	 	  for (i=0; i<elements.length; i++){
	 	   
	 	    if(elements[i].title<=currentpagectr){
	 	    	var e = elements[i].name;
	 	    
	 	    if(elements[i].required!=null){
	 	    	
	 	    	if(elements[i].required){
	 	    		
	 	    		if(elements[i].value==""){
	 	    			alert("fields '"+ elements[i].name +"' with red asterisk must be filled in");
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
	 	    	
	 	    	
 	    	
 	    	if(elements[i].pattern && elements[i].pattern!=''){
 	    		
 	    		if(elements[i].value!="" && !new RegExp(elements[i].pattern).test(elements[i].value)){
 	    			alert("fields '"+ elements[i].name +"' does not match the allowed pattern");
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



		/* Make ajax call below to save form data passing form id, data string etc and flag 
		 to send form direct link to the payer when currentpagectr =1  */		
		var returnFlag=false;
	
		if(currentpagectr==1){		
			submitShotFlag="fresh";
		}
	
		if(validationpass==true){
			returnFlag=submitFormUsingAjax(submitShotFlag, currentpagectr);		

			if(submitShotFlag=="fresh"){
				submitShotFlag="update";
			}
		}
		
		 
		return returnFlag;
	
			
	}
	

	//  funtion to be executed whenever the back button is called from a form page 

	function formPageBackAction(nextpageid){
		
		var currentpagectr = nextpageid-1;
		
		
		if(currentpagectr==1){			
			
			$("#tab-11-1-"+currentpagectr).removeClass('is-active');
			$("#tab-11-"+currentpagectr).hide();
			$("#tab-11-"+currentpagectr).removeClass('is-open');
		
			$("#tab-10-1-1").addClass('is-active');
			$("#tab-10-1").show();
			$("#tab-10-1").addClass('is-open');	
			
		}
		else{
			
			var prevpagectr = currentpagectr-1;
			
			$("#tab-11-1-"+currentpagectr).removeClass('is-active');
			$("#tab-11-"+currentpagectr).hide();
			$("#tab-11-"+currentpagectr).removeClass('is-open');
		
			$("#tab-11-1-"+prevpagectr).addClass('is-active');
			$("#tab-11-"+prevpagectr).addClass('is-open');
			$("#tab-11-"+prevpagectr).show();
		}
		
				
		/* Make ajax call below to save form data passing form id, data string etc 
		 */
		
		return false;
	
			
	}	
	
	//  funtion to be executed whenever the next button is called from the Payer Basic Information page
	function goToFormPages(){
		
		   var currentpagectr=0;
		   var validationpass = true;
		   
		 	var elements = document.forms["QForm"].elements;
		 	 
		 	  for (i=0; i<elements.length; i++){
		 	   
		 	    if(elements[i].title<=currentpagectr){
		 	    	var e = elements[i].name;
		 	    	
		 	    if(elements[i].required!=null){
		 	    	
		 	    	if(elements[i].required){
		 	    		
		 	    		if(elements[i].value==""){
		 	    			alert('fields with asterisks must be filled in');
		 	    			elements[i].focus();
		 	    			//alert("focussed");
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
		 	    
		 	  }	
	
			 	 // regular expression to match required date format and mobile number format
			 	
		 	  
		 	    if(document.getElementById("demo1").value != '' && !document.getElementById("demo1").value.match(/^\d{1,2}\-\d{1,2}\-\d{4}$/)) {
		 	      alert("Invalid Date Format: " + document.getElementById("demo1").value);
		 	     document.getElementById("demo1").focus();
		 	     validationpass = false;
		 	    }
		 	    if(document.getElementById("rc_contact").value != '' && !document.getElementById("rc_contact").value.match(/^[0-9]{10}$/)) {
			 	      alert("Invalid Mobile Number Format: " + document.getElementById("rc_contact").value);
			 	     document.getElementById("rc_contact").focus();
			 	     validationpass = false;
			 	}		
		 	    if(document.getElementById("rc_email").value != '' && !document.getElementById("rc_email").value.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)) {
			 	     alert("Invalid Email Format: " + document.getElementById("rc_email").value);
			 	     document.getElementById("rc_email").focus();
			 	     validationpass = false;
			 	}			


		
	if (validationpass){
		
		
		var captID_val=document.getElementById("captchaFromServer").value;	
		var captId=document.getElementById("captId").value;				
		
		
		
		if(captID_val != captId)
		{
			
			
			if(captId=='')
			{
				alert("Please enter Captcha value in the field provided!");				
				captcha_match=false;
				
			} else{			
			alert("You got the Captcha wrong, try again !");
			//$("#pageRCCode").load(location.href + " #pageRCCode");	
			captcha_match=false;
			
		    } 
		}
		else{
			
		captcha_match=true;
		
		$("#tab-10-1-1").removeClass('is-active');
		$("#tab-10-1").hide();
		$("#tab-10-1").removeClass('is-open');
		
		$("#tab-11-1-1").addClass('is-active');
		$("#tab-11-1").addClass('is-open');
		$("#tab-11-1").show();
	
		}
		/* NO save calls at this time */
	
	  }
		return false;
		
	}
	
	//   -  funtion to be executed whenever the next button is called on the last page of the form
	function formSubmitAction(){
		
		/* 	show the summary page, hide the current page */
		
		var currentpagectr="last";
		var returnFlag=false;
		var validationpass=true;
		
		var elements = document.forms["QForm"].elements;	
		
	 	  for (i=0; i<elements.length; i++){
		 	    
		 	    	var e = elements[i].name;
		 	    
		 	    if(elements[i].required!=null){
		 	    	
		 	    	if(elements[i].required){
		 	    		
		 	    		if(elements[i].value==""){
		 	    			alert("fields '"+ elements[i].name +"' with red asterisk must be filled in");
		 	    			elements[i].focus();
		 	    			//alert("focussed");
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
	 	    			//alert("focussed");
	 	    			validationpass=false;
	 	    			break;
	 	    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
	 	    		} 
	 	    		else{
	 	    			//alert('field '+elements[i].name + ' can be empty');
	 	    		}
	 	    	}			 	    	
		 	    	
		 	    
		 	  }			
	
		
		  if(validationpass==true){
				submitFormUsingAjax(submitShotFlag, currentpagectr);
		  }
		
		return returnFlag;
		
	}
	
	function submitFormUsingAjax(submitShot, currentpagectr) {
		
				
				//event.preventDefault();
				var rccode="null";	
				var actorFlow="";
				if(currentpagectr=="last"){	
					actorFlow="Y";
				}
				
				rebuildArray();				
				try
				{
				rccode = document.getElementById("rc_code").value;
				}
				catch(err){
					
				}
				var rcname = document.getElementById("rc_name").value;
				var rcdob = document.getElementById("demo1").value;
				var rccontact = document.getElementById("rc_contact").value;
				var rcemail = document.getElementById("rc_email").value;
				var rcStartDate = document.getElementById("rc_formStartDate").value;

				var rcEndDate = document.getElementById("rc_formEndDate").value; 
				
				try
				{
				rccode = document.getElementById("rc_code").value;
				}
				catch(err){
					
					
				}
			
				
				var dataArray = new Array;
				for ( var value in values) {
					dataArray.push(values[value]);
				}
				
				var payeeformIdQC =<%=payeeformIdQC%>;
				var argument = "values=" + dataArray + "&rcname=" + rcname
						+ "&rcdob=" + rcdob + "&rccontact=" + rccontact
						+ "&rcemail=" + rcemail + "&rcStartDate=" + rcStartDate
						+ "&rcEndDate=" + rcEndDate + "&payeeformIdQC="
						+
						payeeformIdQC+"&rccode="+rccode + "&submitShot="+submitShot;
						
						var xhttp = new XMLHttpRequest();
						xhttp.onreadystatechange = function() {
							if (xhttp.readyState == 4 && xhttp.status == 200) {
								
								
								
								if(currentpagectr=="last"){								
								
								if($('#a_13').css('display')!='none'){
									$('#12').html($('#static').html()).show().siblings('div').hide();
								}
								else
								if($('#12').css('display')!='none'){
										$('#a_13').show().siblings('div').hide();
								} 

								
								$("#13").addClass('active');
								$("#12").removeClass('active');	
								
								//$("#formssection").removeClass('is-active');
								$("#formssection").hide();
							//	$("#tab-10-1-1").removeClass('is-open');								
								
								//document.getElementById("1").style.display='block';
								
								//alert(xhttp.responseText);
								document.getElementById("a_13").innerHTML = xhttp.responseText;
								forminstanceid = document.getElementById("formInstanceId").value;
								//alert('forminstanceid read after ajax response load is::'+forminstanceid);								
								
								}
								
								else{
									
									document.getElementById("a_13").innerHTML = xhttp.responseText;
									$("#11").removeClass('active');
									$("#12").removeClass('active');
									
									var nextpageid = currentpagectr+1;
									
									$("#tab-11-1-"+currentpagectr).removeClass('is-active');
									$("#tab-11-"+currentpagectr).hide();
									$("#tab-11-"+currentpagectr).removeClass('is-open');
									
									$("#tab-11-1-"+nextpageid).addClass('is-active');
									$("#tab-11-"+nextpageid).addClass('is-open');
									$("#tab-11-"+nextpageid).show();									
									forminstanceid = document.getElementById("formInstanceId").value;
									//alert('forminstanceid read after ajax response load is::'+forminstanceid);								
																				
								}
							}
						}
					
						var appName = window.location.pathname;
						var result = appName.substring(0,getPosition(appName,'/',2));	
						
						//     validate and reject stale sessions : code starts 

						var bid = '<%=sesBid %>';
						var cid = '<%=sesCid %>';
						var formtemplateid = document.getElementById("currentFormId").value;			
					//	var forminstanceid = document.getElementById("formInstanceId").value;
					//	alert('formtemplateid being sent in ajax call is::'+formtemplateid);
					//	alert('forminstanceid being sent in ajax call is::'+forminstanceid);		
						
						//    validate and reject stale sessions : code ends 
						//alert('forminstanceid is::'+forminstanceid);
						//alert('formtemplateid is::'+formtemplateid);
					//	alert('actorFlow is::'+actorFlow);
						xhttp.open("GET", window.location.origin+result+"/processForm?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid + "&forminstanceid="+forminstanceid+"&actorFlow="+actorFlow, true);
						
						
						xhttp.send();

		return false;
	}
	
	
	
	
	function goToStart(){
		var bid ='<%=sesBid%>';
		var cid ='<%=sesCid%>';
		window.location="Start.jsp?bid="+bid+"&cid="+cid+"&currentSessionReturn=Y";
		
	}		
	
	function goToForm(){
	
	var selectedFormIndex = document.getElementById("formId").selectedIndex;
	
	if (selectedFormIndex == 0) {
		//If the "Please Select" option is selected display error.
		alert("Please Select Payer Type!");
		return false;
	}
	

	$("#11").removeClass('active');
	$("#12").addClass('active');
	$("#12").addClass('active');
	
	

	if($('#a_12').css('display')!='none'){
	$('#a_11').html($('#static').html()).show().siblings('div').hide();
	}else if($('#a_11').css('display')!='none'){
		$('#a_12').show().siblings('div').hide();
	}
	
	
	getFormPages();
	
	return true;	
	
	}
	
	
	function showFormDataOnTabClick(){
		
		//var r = confirm("If you wat to edit data, use the back buttons at the bottom. Using tabs, all data may be rereshed, are you sure?");
		//if(r == true){
		
		getFormPages();
		
	//	}
		return false;
	}
	
	
	</script>

	<script type="text/javascript">
		$(function () {
			$("#btnSubmit-second").click(function () {
				
				var ddlFruitsed = $("#ddlFruitsed");
				if (ddlFruitsed.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#11").removeClass('active');
				$("#12").addClass('active');
				return true;
			});
		});		
	</script>
	<script type="text/javascript">
		$(function () {
			$("#btnSubmitthree").click(function () {
				var ddlFruitsedthird = $("#ddlFruitsedthird");
				if (ddlFruitsedthird.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}				
				$("#11").removeClass('active');
				$("#12").addClass('active');
				return true;
			});
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#btnSubmit-first").click(function () {
				var payeeProfile = document.getElementById("codeOfCollege").value;
			//	var bankId = document.getElementById("bankId").value;
			

				//var opt = document.getElementById("codeOfCollege").value;
				
				if (payeeProfile == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#2").removeClass('active');
				$("#1").addClass('active');
				
				getFormList();
				return true;
			});
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#btnSubmit-five-t").click(function () {
				var stepbackfiveyt = $("#stepbackfiveyt");
				if (stepbackfiveyt.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#12").removeClass('active');
				$("#13").addClass('active');
				return true;
			});
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#btnSubmit-four").click(function () {
				var ddlFruitsfour = $("#ddlFruitsfour");
				if (ddlFruitsfour.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#2").removeClass('active');
				$("#1").addClass('active');
				return true;
			});
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#btnSubmit-stepfirst").click(function () {
				
		
				$("#tab-10-1-1").removeClass('is-active');
				$("#tab-10-1").hide();
				$("#tab-10-1").removeClass('is-open');
				
				$("#tab-11-1-1").addClass('is-active');
				$("#tab-11-1").addClass('is-open');
				$("#tab-11-1").show();
				return false;
			});
			$("#btnSubmit-five").click(function () {
				
	
				$("#tab-11-1-1").removeClass('is-active');
				$("#tab-11-1").hide();
				$("#tab-11-1").removeClass('is-open');
				
				$("#tab-12-1-1").addClass('is-active');
				$("#tab-12-1").addClass('is-open');
				$("#tab-12-1").show();
				return false;
			});
			
			//$("#btnSubmit-six").click(function () {
				
	
				//$("#tab-12-1-1").removeClass('is-active');
				//$("#tab-12-1").hide();
				//$("#tab-12-1").removeClass('is-open');
				
				//$("#tab-13-1-1").addClass('is-active');
				//$("#tab-13-1").addClass('is-open');
				//$("#tab-13-1").show();
				//return true;
			//});
			
			
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#btnSubmit-eight").click(function () {
				var ddlFruitsfive = $("#ddlFruitsfive");
				if (ddlFruitsfive.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#12").removeClass('active');
				$("#13").addClass('active');
				return true;
			});
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#firstback").click(function () {
				var ddlFruitsfirstback = $("#ddlFruitsfirstback");
				if (ddlFruitsfirstback.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#12").removeClass('active');
				$("#11").addClass('active');
				return true;
			});
		});
	</script>

	<script type="text/javascript">
		$(function () {
			$("#firstbackthree").click(function () {
				var ddlFruitsfirstbackthree = $("#ddlFruitsfirstbackthree");
				if (ddlFruitsfirstbackthree.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#12").removeClass('active');
				$("#11").addClass('active');
				return true;
			});
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#firstbacktwok").click(function () {
				var ddlFruitsfirstbacktwo = $("#ddlFruitsfirstbacktwo");
				if (ddlFruitsfirstbacktwo.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#12").removeClass('active');
				$("#11").addClass('active');
				return true;
			});
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#btnSubmit-seven").click(function () {
				var ddlFruitsseven = $("#ddlFruitsseven");
				if (ddlFruitsseven.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#13").removeClass('active');
				$("#12").addClass('active');
				return true;
			});
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#stepback").click(function () {
				var stepbackPrev = $("#stepbackPrev");
				if (stepbackPrev.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#12").removeClass('active');
				$("#11").addClass('active');
				return true;
			});
		});
	</script>

	<script type="text/javascript">
		$(function () {
			$("#btnSubmit").click(function () {
				var ddlFruits = $("#ddlFruits");
				if (ddlFruits.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Payer Type!");
					return false;
				}
				$("#11").removeClass('active');
				$("#12").addClass('active');
				return true;
			});
		});
	</script>


	<script type="text/javascript">
		$(function () {
			$("#btnSubmited").click(function () {
				var ddlFruitsed = $("#ddlFruitsed");
				if (ddlFruitsed.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Select Form!");
					return false;
				}
				return true;
			});
		});
	</script>
	<script type="text/javascript">
		$(function () {
			$("#btnSubmited-recipt").click(function () {
				var ddlFruitsed = $("#ddlFruitsed");
				if (ddlFruitsed.val() == "") {
					//If the "Please Select" option is selected display error.
					alert("Please Fill All Mandatory Fields!");
					return false;
				}
				return true;
			});
		});
	</script>
	<script>
	$(document).ready(function () {
	  $('.accordion-tabs-minimal').each(function(index) {
		$(this).children('li').first().children('a').addClass('is-active').next().addClass('is-open').show();
	  });
	  $('.accordion-tabs-minimal').on('click', 'li > a.tab-link', function(event) {
		if (!$(this).hasClass('is-active')) {
		  //event.preventDefault();
		  var accordionTabs = $(this).closest('.accordion-tabs-minimal');
		  accordionTabs.find('.is-open').removeClass('is-open').hide();

		  $(this).next().toggleClass('is-open').toggle();
		  accordionTabs.find('.is-active').removeClass('is-active');
		  $(this).addClass('is-active');
		} else {
		  //event.preventDefault();
		}
	  });
	});
	</script>
	<!-- >
    <script>
        $(function () {
            $("#wizard1").simpleWizard({
                cssClassStepActive: "active",
                cssClassStepDone: "done",
                onFinish: function() {
                    
                }
            });
        });
    </script> -->
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
		$(document).ready(function() {
			$("div.bhoechie-tab-menu>div.list-group>a").click(function(e) {
				//e.preventDefault();
				$(this).siblings('a.active').removeClass("active");
				$(this).addClass("active");
				var index = $(this).index();
				$("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
				$("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
			});
		});
	</script>

	<script>
		
		$('#btnClick').on('click',function(){
			if($('#1').css('display')!='none'){
			$('#2').html($('#static').html()).show().siblings('div').hide();
			}else if($('#2').css('display')!='none'){
				$('#1').show().siblings('div').hide();
			}
		});

		$('#btnClicks').on('click',function(){
			if($('#2').css('display')!='none'){
			$('#1').html($('#static').html()).show().siblings('div').hide();
			}else if($('#1').css('display')!='none'){
				$('#2').show().siblings('div').hide();
			}
		});
		
		$('#btnClicksfour').on('click',function(){
			if($('#9').css('display')!='none'){
			$('#8').html($('#static').html()).show().siblings('div').hide();
			}else if($('#8').css('display')!='none'){
				$('#9').show().siblings('div').hide();
			}
		});
		
		$('#btnClicksstepfirst').on('click',function(){
			if($('#11-1').css('display')!='none'){
			$('#10-1').html($('#static').html()).show().siblings('div').hide();
			}else if($('#10-1').css('display')!='none'){
				$('#11-1').show().siblings('div').hide();
			}
		});
			
		$('#stepsfive-t').on('click',function(){
			if($('#a_13').css('display')!='none'){
			$('#a_12').html($('#static').html()).show().siblings('div').hide();
			}else if($('#a_12').css('display')!='none'){
				$('#a_13').show().siblings('div').hide();
			}
		});
		
		$('#stepssix').on('click',function(){
			if($('#a_14').css('display')!='none'){
			$('#a_13').html($('#static').html()).show().siblings('div').hide();
			}else if($('#a_13').css('display')!='none'){
				$('#a_14').show().siblings('div').hide();
			}
		});
		
		$('#btnfirstback').on('click',function(){
			if($('#a_12').css('display')!='none'){
			$('#a_11').html($('#static').html()).show().siblings('div').hide();
			}else if($('#a_11').css('display')!='none'){
				$('#a_12').show().siblings('div').hide();
			}
		});
		
		$('#btnfirstbackthreee').on('click',function(){
			if($('#a_12').css('display')!='none'){
			$('#a_11').html($('#static').html()).show().siblings('div').hide();
			}else if($('#a_11').css('display')!='none'){
				$('#a_12').show().siblings('div').hide();
			}
		});
		
		$('#btnfirstbacktwo').on('click',function(){
			if($('#a_12').css('display')!='none'){
			$('#a_11').html($('#static').html()).show().siblings('div').hide();
			}else if($('#a_11').css('display')!='none'){
				$('#a_12').show().siblings('div').hide();
			}
		});
		
		$('#stepsseven').on('click',function(){
			if($('#a_13').css('display')!='none'){
			$('#a_12').html($('#static').html()).show().siblings('div').hide();
			}else if($('#a_12').css('display')!='none'){
				$('#a_11').show().siblings('div').hide();
			}
		});
		$('#btnClickst').on('click',function(){
			if($('#2').css('display')!='none'){
			$('#1').html($('#static').html()).show().siblings('div').hide();
			}else if($('#1').css('display')!='none'){
				$('#2').show().siblings('div').hide();
			}
		});
		$('#stepstwo').on('click',function(){
		
			if($('#a_12').css('display')!='none'){
			$('#a_11').html($('#static').html()).show().siblings('div').hide();
			}else if($('#a_11').css('display')!='none'){
				$('#a_12').show().siblings('div').hide();
			}
		});
		$('#stepsthree').on('click',function(){
			if($('#a_12').css('display')!='none'){
			$('#a_11').html($('#static').html()).show().siblings('div').hide();
			}else if($('#a_11').css('display')!='none'){
				$('#a_12').show().siblings('div').hide();
			}
		});
		$('#stepsfour').on('click',function(){
			if($('#a_14').css('display')!='none'){
			$('#a_13').html($('#static').html()).show().siblings('div').hide();
			}else if($('#a_13').css('display')!='none'){
				$('#a_14').show().siblings('div').hide();
			}
		});
		
		
	</script>

	<script>
		$('#btnClickstcaptcha').on('click',function(){
			if($('#8').css('display')!='none'){
			$('#9').html($('#static').html()).show().siblings('div').hide();
			}else if($('#9').css('display')!='none'){
				$('#8').show().siblings('div').hide();
			}
		});
	</script>



	<script type="text/javascript">
		function getFormList() {
			
			var opt = document.getElementById("codeOfCollege").value;
		
			if(opt.indexOf("$actor") > -1){
				
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {					
					
						
						document.getElementById("showFormList").innerHTML = this.responseText;
					}
				};
				var appName = window.location.pathname;
				var result = appName.substring(0,getPosition(appName,'/',2));	
				
				
				//     validate and reject stale sessions : code starts 

				var bid = '<%=sesBid %>';
				var cid = '<%=sesCid %>';

				
				//    validate and reject stale sessions : code ends 				
				
				xhttp.open("GET",window.location.origin+result+"/GetForms?isActor=Y&PayeeProfile=" + opt+ "&bid="+bid+ "&cid="+cid,
						true);				
				
				
				xhttp.send();

			} else {
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						
						document.getElementById("showFormList").innerHTML = this.responseText;
						
						
					}
				};
				var appName = window.location.pathname;
				var result = appName.substring(0,getPosition(appName,'/',2));	
				
				//     validate and reject stale sessions : code starts 

				var bid = '<%=sesBid %>';
				var cid = '<%=sesCid %>';						

				
				//    validate and reject stale sessions : code ends 				
				
				
				xhttp.open("GET", window.location.origin+result+"/GetForms?isActor=N&PayeeProfile=" + opt+ "&bid="+bid+ "&cid="+cid,
						true);
				
				xhttp.send();
			}

		}

		function getFormPages() {

			var formId = document.getElementById("formId").value;
			
			var xhttp1 = new XMLHttpRequest();
			xhttp1.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {

					
					document.getElementById("2").style.visibility="hidden";
					
					document.getElementById("a_12").innerHTML = this.responseText;
					$("#tab-10-1-1").addClass('is-active');
					$("#tab-10-1").show();
					$("#tab-10-1").addClass('is-open');
					
					
					var formtemplateid = document.getElementById("currentFormId").value;	
					//alert('formtemplateid now is::'+formtemplateid);					

				}
			}
			var appName = window.location.pathname;
			var result = appName.substring(0,getPosition(appName,'/',2));	
			
			//     validate and reject stale sessions : code starts 

			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';
	
			
			//    validate and reject stale sessions : code ends 			
			
			xhttp1.open("GET", window.location.origin+result+"/getFormforPayer?formId=" + formId + "&bid="+bid+ "&cid="+cid, true);
			
			xhttp1.send();

		}

		
		function getFilledFormPages() {

			var formId = document.getElementById("formId").value;
			//alert('form id is:'+formId);
			var xhttp1 = new XMLHttpRequest();
			xhttp1.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					
			
					document.getElementById("2").style.visibility="hidden";
					
					document.getElementById("a_12").innerHTML = this.responseText;
					$("#tab-10-1-1").addClass('is-active');
					$("#tab-10-1").show();
					$("#tab-10-1").addClass('is-open');
					

				}
			}
			var appName = window.location.pathname;
			var result = appName.substring(0,getPosition(appName,'/',2));	
			
			//     validate and reject stale sessions : code starts 

			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';
			var formtemplateid = document.getElementById("currentFormId").value;			
			var forminstanceid = document.getElementById("formInstanceId").value;
			//alert('formtemplateid now is::'+formtemplateid);
			//alert('forminstanceid is::'+forminstanceid);	
			
			//    validate and reject stale sessions : code ends 				
			
			xhttp1.open("GET", window.location.origin+result+"/getFormforPayer?formId=" + formId + "&bid="+bid+ "&cid="+cid + "&formtemplateid="+formtemplateid + "&formtemplateid="+formtemplateid, true);
			
			xhttp1.send();

		}		
		
		
		function hideDivs() {
			document.getElementById("2").style.display = "none";
		}
		function verifyCode() {

			var code = document.getElementById("collCode").value;
			
			if (code == '' || code == null) {
				alert("Please Enter College Code");
				return false;
			} else {
				
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {	
					
						document.getElementById("showFormList").innerHTML = this.responseText;
						
						
					}
				}
				var appName = window.location.pathname;
				var result = appName.substring(0,getPosition(appName,'/',2));		
				
				
				//     validate and reject stale sessions : code starts 

				var bid = '<%=sesBid %>';
				var cid = '<%=sesCid %>';
				
				//    validate and reject stale sessions : code ends 					
				
				
				xhttp.open("GET", window.location.origin+result+"/verifyCode?code="+code+"&PayeeProfile=Institute&bid="+bid+ "&cid="+cid, true);
				
				xhttp.send();				
				
			//	window.location = "verifyCode?code=" + code+"&PayeeProfile=Institute";
				return true;
				
				
				
				
			}

		}
		
		function storeCode() {
			var code = document.getElementById("selCode").value;
			if (code == "") {
				alert("Please Select an institute from the drop down.");
				return;
			}
			
			
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {	
					
					document.getElementById("showFormList").innerHTML = this.responseText;
				}
			}
			var appName = window.location.pathname;
			var result = appName.substring(0,getPosition(appName,'/',2));	
			
			//     validate and reject stale sessions : code starts 

			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';
			//alert('bid is::'+bid);
			//alert('cid is::'+bid);
			
			//    validate and reject stale sessions : code ends 			
			
			
			xhttp.open("GET", window.location.origin+result+"/storeCode?sel_code=" + code + "&bid="+bid+ "&cid="+cid, true);
			
			xhttp.send();				
		
			return true;
			
			//window.location = "storeCode?sel_code=" + code;

		}
		
	</script>

	<script type="text/javascript">
   
											function createRequestObject() {
												var tmpXmlHttpObject;

												//depending on what the browser supports, use the right way to create the XMLHttpRequest object
												if (window.XMLHttpRequest) {
													// Mozilla, Safari would use this method ...
													tmpXmlHttpObject = new XMLHttpRequest();

												} else if (window.ActiveXObject) {
													// IE would use this method ...
													tmpXmlHttpObject = new ActiveXObject(
															"Microsoft.XMLHTTP");
												}

												return tmpXmlHttpObject;
											}

											//call the above function to create the XMLHttpRequest object
											var http = createRequestObject();

											function choosePaymentPage(wordId) {
												var wordId = wordId;

												if (wordId == 1) {
													http.open('get','paymentFormOfCHSE1.jsp');
													$("#isHiddenPayButton").show();
												} else if (wordId == 2) {
													http.open('get','demoForm2.jsp');
													$("#isHiddenPayButton").show();
												} else if (wordId == 3) {
													http.open('get','demoForm3.jsp');
													$("#isHiddenPayButton").show();
												} else if (wordId == 4) {
													http.open('get','paymentFormCHSE2.jsp');
													$("#isHiddenPayButton").show();
												} else
													document.getElementById('paymentCategory').disabled = 'disabled';
												document.getElementById('selectCategoryLabel').style.visibility = "visible";
												document.getElementById('selectCategoryLabel').style.visibility = "block";
												document.getElementById('submit_button').style.visibility = "visible";

												http.onreadystatechange = processResponse;
												
												http.send();
											} 

											function makeGetRequest() {
												

												var wordId = document
														.getElementById("codeOfCollege").value;

											
											var tcCheckID = document
														.getElementById("tcCheckID");

												if (!tcCheckID.checked) {
													alert("Please  accept the payment terms and conditions");
												} else {
													if (wordId != null) {
														var opt=document.getElementById("codeOfCollege").value;
														if(opt.indexOf("$actor") > -1)
														{
															window.location = "NewUIiwantToPayOrPreviousTrans.jsp?PayeeProfile="
																+ wordId+"&isActor=Y";
														}
														else
															{
															window.location = "NewUIiwantToPayOrPreviousTrans.jsp?PayeeProfile="
																+ wordId+"&isActor=N";
															/* window.location = "NewUIiwantToPayOrPreviousTrans.jsp?PayeeProfile="
																+ wordId+"&isActor=N"; */
															}
													} else

														/* collegePage="nitjFeesPaymentForm.jsp"; */
														/* http.open('get', 'nitjFeesPaymentForm.jsp?id=' + wordId); */
														document
																.getElementById('paymentCategory').disabled = 'disabled';
													document
															.getElementById('selectCategoryLabel').style.visibility = "visible";
													document
															.getElementById('selectCategoryLabel').style.visibility = "block";
													document
															.getElementById('submit_button').style.visibility = "visible";

													//make a connection to the server ... specifying that you intend to make a GET request 
													//to the server. Specifiy the page name and the URL parameters to send
													/*  http.open('get', 'collegePage?id=' + wordId); */

													//assign a handler for the response
													http.onreadystatechange = processResponse;
													
													//actually send the request to the server
													http.send();
												}
											}

											function processResponse() {
												//check if the response has been received from the server
												if (http.readyState == 4) {

													//read and assign the response from the server
													var response = http.responseText;

													//do additional parsing of the response, if needed

													//in this case simply assign the response to the contents of the <div> on the page. 
													document
															.getElementById('selected_College').innerHTML = response;

													//If the server returned an error message like a 404 error, that message would be shown within the div tag!!. 
													//So it may be worth doing some basic error before setting the contents of the <div>
												}
											}

											function enableProToPayButtonJVM() {

												window
														.open('TC1.htm',
																'Conditions',
																'width=600,height=800,scrollbars=yes');
												//var myCheckId=document.getElementById("termAndCondition");	
												//myCheckId.checked ? document.getElementById("proceedToPay").disabled=false:document.getElementById("proceedToPay").disabled=true ;
												/* document.getElementById("proceedToPay").disabled=false;	
												var x=document.getElementById("tcCheckID");
												x.checked?document.getElementById("proceedToPayJVM").style.display="block":document.getElementById("proceedToPayJVM").style.display="none";	

												return false;	 */
											}

											function ExecuteFun() {

												setTimeout(
														function() {
															ExecuteFun();
															//location.reload();
															var bid =
										<%=sesBid%>
											;
															var cid =
										<%=sesBid%>
											;
															if (bid == ''
																	|| bid == null) {
																window.location = "PaySessionOut";
															}

														}, 120000);
											}
											
											
											
											
											
											
											
											

											
											
											function AddToOptionsArray(value, id) {
											
											options[id] = value;
												
											//	alert(JSON.stringify(options));

											}
											
											
											/*

											$('#QForm').submit(function(event) {//Code to use HTML5 form validation but prevent it from submitting
												event.preventDefault();
												formSubmit();
											}); */

											function formSubmit() {
												var rccode="null";
												rebuildArray();
												
												try
												{
												rccode = document.getElementById("rc_code").value;
												}
												catch(err){
													
												}
												var rcname = document.getElementById("rc_name").value;
												var rcdob = document.getElementById("demo1").value;
												var rccontact = document.getElementById("rc_contact").value;
												var rcemail = document.getElementById("rc_email").value;
												var rcStartDate = document.getElementById("rc_formStartDate").value;

												var rcEndDate = document.getElementById("rc_formEndDate").value;

												var fee_id = document.getElementById("selectFee").value;
												var dataArray = new Array;
												for ( var value in values) {
													dataArray.push(values[value]);
												}
												var argument = "values=" + dataArray + "&rcname=" + rcname
														+ "&rcdob=" + rcdob + "&rccontact=" + rccontact
														+ "&rcemail=" + rcemail + "&rcStartDate=" + rcStartDate
														+ "&rcEndDate=" + rcEndDate + "&payeeformIdQC="
														+
										<%=payeeformIdQC%>+"&rccode="+rccode;
										
										
										var captID_val=document.getElementById("hiddenIdval").value;
										var captId=document.getElementById("captId").value;
										
										
										
											if(captID_val != captId){
												alert("You got the Captcha wrong, try again !");
												$("#pageRCCode").load(location.href + " #pageRCCode");	
											
											return false;
											}
										
										        alert('about to submit form');
												window.location = "processForm?" + argument;
											}

											function refreshTheCaptch() {
												$("#pageRCCode").load(location.href + " #pageRCCode");
												
											}
											function refreshPageRfCode() {
												$("#pageRfCode").load(location.href + " #pageRfCode");
											}
											
											
											
											function GetFee(x, id) {
												AddToOptionsArray(x, id)
												var dataArray = new Array;
												for ( var value in options) {
													dataArray.push(options[value]);
												}
												alert(dataArray);
												var xhttp = new XMLHttpRequest();
												xhttp.onreadystatechange = function() {
													if (xhttp.readyState == 4 && xhttp.status == 200) {
														alert("Fee is "+xhttp.responseText);
														//document.getElementById("FeeBox").innerHTML = xhttp.responseText;
													}
												}
												var appName = window.location.pathname;
												var result = appName.substring(0,getPosition(appName,'/',2));
												
												//     validate and reject stale sessions : code starts 

												var bid = '<%=sesBid %>';
												var cid = '<%=sesCid %>';
												alert('bid is::'+bid);
												alert('cid is::'+bid);
												
												//    validate and reject stale sessions : code ends 													
												
												xhttp.open("GET", window.location.origin+result+"/getFee?optionArray=" + dataArray + "&bid="+bid + "&cid=" +cid, true);
												
												xhttp.send();
											}

											function ExecuteFun() {
											
											document.getElementById('sendNewSms').disabled = true;
												setTimeout(function() {
													ExecuteFun();
													//location.reload();
													var bid =
										<%=sesBid%>
											;
													var cid =
										<%=sesBid%>
											;
													if (bid == '' || bid == null) {
														window.location = "PaySessionOut";
													}

												}, 120000);
											}
										</script>
	<script type="text/javascript">
										
										function rebuildArray()
										{
											var elements = document.forms["QForm"].elements;
											alert('elements array is..'+elements);
											  for (i=0; i<elements.length; i++){
											
											    var eid=elements[i].id;
											    alert(eid);
											  
											    if(eid==("")||eid==("captId")||eid==("captchaFromServer")||eid==("rc_name")||eid==("demo1")||eid==("rc_code")||eid==("rc_email")||eid==("rc_contact")||eid==("rc_formStartDate")||eid==("rc_formEndDate")||eid==("hiddenIdval")||eid==("currentFormId")||eid==("formInstanceId"))
											    {
											   
											    } 
											    
											    else
											    	{
											    	  if(eid==("tcCheckID") ||eid==("sendNewSms") ){
													   
													    }else{
													    	if(elements[i].type=='radio' || elements[i].type=='checkbox'){													    		
													    		alert('element type is ..'+  elements[i].type + '..and selected is...' + elements[i].checked);
													    	}
													    	if(!(elements[i].tagName=='INPUT' && elements[i].type=='radio' && (elements[i].type!='checkbox' && elements[i].checked==false))){	
													    		alert('id is..'+elements[i].id +'.. types is..'+elements[i].type + '..and value is .. '+elements[i].value );
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
														    		alert('case of radio unselected option and the unselected option is..'+elements[i].type + '...and value is.. .'+elements[i].value );
														       }
													    }
											    	
											    	}
											  }		
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
										
										

										

											     function backToForms(){
													
													var bid = '<%=sesBid%>';
													var cid = '<%=sesCid%>';
													var redirectedFrom = '<%=redirectedFrom%>';
													
													if(redirectedFrom=='Bank'){
														window.location='StartUrl?bid='+bid+'&cid='+cid;
													}
													else{				
														window.location='StartUrl?bid='+bid+'&cid='+cid;
													}												
													
											     }
											     
											     
													function showProceed(){
													
														
														  if (document.getElementById('termsagreement').checked) 
														  {
															 document.getElementById('proceedForward').style.display = 'block';
														      
														  } else {

															 document.getElementById('proceedForward').style.display = 'none';
														  }
													}			
																								     
										
										</script>




	<script src="js/jquery.simplewizard.js"></script>
	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<script src="js/bootstrap-select.js"></script>

	<!-- calender plugin -->
	<script src="bower_components/moment/min/moment.min.js"></script>
	<script src="bower_components/fullcalendar/dist/fullcalendar.min.js"></script>
	<!-- data table plugin -->
	<script src="js/jquery.dataTables.min.js"></script>

	<!-- select or dropdown enhancer -->
	<script src="bower_components/chosen/chosen.jquery.min.js"></script>
	<!-- plugin for gallery image view -->
	<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
	<!-- notification plugin -->
	<script src="js/jquery.noty.js"></script>
	<!-- library for making tables responsive -->
	<script src="bower_components/responsive-tables/responsive-tables.js"></script>
	<!-- tour plugin -->
	<script
		src="bower_components/bootstrap-tour/build/js/bootstrap-tour.min.js"></script>
	<!-- star rating plugin -->
	<script src="js/jquery.raty.min.js"></script>
	<!-- for iOS style toggle switch -->
	<script src="js/jquery.iphone.toggle.js"></script>
	<!-- autogrowing textarea plugin -->
	<script src="js/jquery.autogrow-textarea.js"></script>
	<!-- multiple file upload plugin -->
	<script src="js/jquery.uploadify-3.1.min.js"></script>
	<!-- history.js for cross-browser state change on ajax -->
	<script src="js/jquery.history.js"></script>
	<!-- application script for Charisma demo -->

	<c:if test='${form.getJsEnabled().contentEquals("Y")}'>
		<script src="js/formjs/myScriptO.js"></script>
		<script src="js/formjs/myScriptArts.js"></script>
		<script src="js/formjs/myScriptScience.js"></script>
	</c:if>
	<script language="javascript" type="text/javascript"
		src="js/datetimepicker_css_100Year.js">
	</script>

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>


	<script>
	$("#submit_button")
	.click(
			function() {

				var mobNum = $("#idMob").val();
				var dob = $("#idDOB").val();
				var txnId = $("#idTxn").val();
				var from = $("#idFrom").val();
				var to = $("#idTo").val();
				var previoustxn = $("#previoustxnIdAction")
						.val();

				var patternMobNum = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;

				if (dob == '' && mobNum == '' && txnId == ''
						&& from == '' && to == '') {
					alert("Please Enter Date Of Birth , Mobile Number And Transaction ID OR From Date ,To Date");
					return false;

				}
				
		 	    if(dob!='' && !dob.match(/^\d{1,2}\-\d{1,2}\-\d{4}$/)) {
			 	      alert("Invalid Date Format for Date Of Birth Field: " + dob);
			 	    
			 	     return false;
			 	}	
		 	    
		 	    if(mobNum!= '' && !mobNum.match(/^[0-9]{10}$/)) {
			 	      alert("Invalid Mobile Number Format: " + mobNum);			 	   
			 	      return false;
			 	}		 	    

				if (dob == '' && (mobNum == '' || mobNum.length != 10)) {

					alert("Please Enter Date Of Birth and Mobile Number");
					return false;
				}

				if (txnId == '' && from == '' && to == '') {

					alert("Please Enter Tranaction Id or From Date, to Date");
					return false;

				} else if (txnId != ''
						|| (from != '' && to != '')) {
					document.getElementById(
							'previoustxnIdAction').submit();
					return true;
				} else {
					alert("Please Enter Tranaction Id or From Date, to Date");
					return false;
				}

			});

			function ExecuteFun() {

				setTimeout(function() {
				ExecuteFun();
				//location.reload();
				var bid = <%=sesBid%>
				var cid = <%=sesBid%>
				if (bid == '' || bid == null) {
					window.location = "PaySessionOut";
				}

				}, 120000);
			}
			
			
			function gotoBankLandingPage(bid){
				
				window.location = "StartUrl?bid="+bid+"&cid=ALL&currentSessionReturn=Y&redirectedFrom=Bank";
				
			}
			
function downloadFile()
{
	
	}

	</script>





</body>
</html>