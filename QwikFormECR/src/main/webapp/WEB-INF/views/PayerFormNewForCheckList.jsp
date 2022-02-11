<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>QwikForms PayerFormNewForCheckList</title>

<script type='text/javascript' src='js/jquery-1.11.0.min.js'></script>
<link href="css/docs.min.css" rel="stylesheet" type="text/css" />
<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link href="css/wizard.css" rel="stylesheet" />
<link href="css/style-tabbs.css" rel="stylesheet" />
<link href="css/style-new.css" rel="stylesheet" />

<script>
var arrUploadSign = new Array();
var arrUploadPhoto = new Array();
var arrUploadFile = new Array();
</script>

<%
	Integer sesBid = null, sesCid = null; 
	CollegeBean collegeBean = new CollegeBean(); 
	int pageCtr =0; 
	Integer currentFormId=null; 
	String formInstanceId = null; 
	Logger log = LogManager.getLogger("Payer Form New"); 
	try { 
	
	sesBid = (Integer) session.getAttribute("BankId"); 
	sesCid = (Integer) session.getAttribute("CollegeId"); 
	collegeBean = (CollegeBean) session.getAttribute("CollegeBean"); 
	currentFormId = (Integer) session.getAttribute("currentFormId"); 
	formInstanceId = (String) session.getAttribute("formInstanceId"); 
	
	log.info("sesCid: PayerFormNew.jsp is:"+sesCid); 
	log.info("CollegeBean.getCollegeId(): PayerFormNew.jsp is:"+collegeBean.getCollegeId()); 
	log.info("currentFormId: PayerFormNew.jsp is:"+currentFormId); 
	log.info("formInstanceId: PayerFormNew.jsp is:"+formInstanceId);
	System.out.println("session ID for this form : PayerFormNew.jsp is:"+session.getId());
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

<%-- <style id="antiClickjack">body{display:none !important;}</style> 
<script type="text/javascript"> 
if (self === top) { 
var antiClickjack = document.getElementById("antiClickjack"); 
antiClickjack.parentNode.removeChild(antiClickjack); 
} else { 
top.location = self.location; 
} 
</script> --%>
<style>
.file {
	visibility: hidden;
	position: absolute;
}
</style>
</head>
<body onload="verifyDocUploadFields()">
	<%
		AppPropertiesConfig appProperties = new AppPropertiesConfig(); 
		Properties properties = appProperties.getPropValues(); 

		String qFormsIP = properties.getProperty("qFormsIP"); 
		String clientLogoLink = properties.getProperty("clientLogoLink"); 
		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI"); 
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean"); 
		System.out.println("collegeBean:"+collegeBean);
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
		
		clgName = (String) session.getAttribute("SelectedInstitute"); 
		insCode = (String) session.getAttribute("InstituteCode"); 

		log.info("PayeeProfile: PayerFormNew.jsp is:"+PayeeProfile); 

		} catch (java.lang.NullPointerException e) { 
		System.out.println("null pointer exception");
	%>
	<script type="text/javascript"> 
		window.location="PaySessionOut"; 
	</script>

	<%
		}
		System.out.println("Winny payeeformIdQC:" + payeeformIdQC);
	%>

	<!--onsubmit="return validateUploadElements()"  -->
	<form id="QForm" method="post">
		<input type="hidden" name="currentFormId" id="currentFormId"
			value="<%=currentFormId%>"></input>
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off" id="formssection">
			<div class="pan-heading">
				<c:out value="${formdetails.getFormName()}" />
			</div>
			<div class="top-pad"></div>
			<ul class="accordion-tabs-minimal">
				<li class="tab-header-and-content">
					<a href="#" class="tab-link is-active" id="tab-10-1-1">Basic Information</a>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tab-content" id="tab-10-1">
						
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<label class="divider-label">Please enter your Name, Date
								of Birth & Mobile Number. This is required to reprint your
								e-receipt / remittance(PAP) form, if the need arises.</label>
						</div>
						<%
							if (PayeeProfile.contentEquals("Institute")) {
						%>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Institute Code *</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" id="rc_code" required="required" 
										value="<%=insCode%>" class="form-control" readonly="readonly"
										placeholder="Code" title="0">
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Institute Name *</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" id="rc_name" required="required"
										value="<%=clgName%>" class="form-control" readonly="readonly"
										placeholder="Name" title="0">
								</div>
							</div>
						</div>
						<%
							} else {
						%>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Payer Name *</label>
								<div class="col-lg-10 col-md-12 col-sm-12 col-xs-12">
									<!-- <div class="col-lg-1 nopadding">
										<select id="mf" required="required" class="form-control">
											<option value="M">Mr.</option>
											<option value="F">Miss.</option>
										</select>
									</div> -->
									<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12 respad">
										<input type="text" id="rc_name" required="required" onkeyup="return blockSpecialChar(this.value,this.id)"
											value='<c:out value="${sampleFormBean.name}"/>'
											class="form-control" 
											placeholder="Enter Name" title="0">
									</div>
								</div>
							</div>
						</div>
						<%
							}
						%>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label hidden="hidden" class="col-lg-2 col-md-12 col-sm-12 col-xs-12"> <%
									 	if (PayeeProfile.contentEquals("Institute")) {
									 %> Date of Incorporation * <%
									 	} else {
									 %> Date of Birth * <%
									 	}
									 %>
								</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input hidden="hidden" type="text" id="demo1"
										placeholder="DD-MM-YYYY" title="0"
										value='01-02-2000'><%-- value='<c:out value="${sampleFormBean.dob}"/>' --%> 
									<!-- <img src="images/calendra.png"
										onclick="javascript:NewCssCal('demo1','ddmmyyyy')"
										alt="Calendra" title="Calendra" width="20" height="20"
										class="cal-endra"> -->
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Mobile
									Number *</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input name="Mobile Number" type="text" class="form-control"
										id="rc_contact" required="required" maxlength="10"
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
										value='<c:out value="${sampleFormBean.email}"/>'
										id="rc_email" required="required" placeholder="Enter Email Id"
										type="email" placeholder="Enter Your Email Id" title="0">
								</div>
							</div>
						</div>
						<c:if test='${formdetails.verificationFlag=="Y"}'>
							<c:if test='${formdetails.isAadhaarVerified=="Y"}'>
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="form-group">
										<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Aadhaar
											Number *</label>
										<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
											<input type="text" name="Aadhaar" class="form-control"
													value='<c:out value="${sampleFormBean.payerAadhaar}"/>'
													id="rc_aadhaar" required="required"
													placeholder="Enter Aadhaar Number"
													placeholder="Enter Your Aadhaar Number" title="0"
													readonly="readonly" /> 
											<span style="float: left;"> 
												<input type="checkbox" onclick="toggleAadhaarTextInput()"
													id="cb_aadhaar" name="Aadhaar Checkbox" class="chbox"
													required="required" /> 
												<label	style="font-size: 12px; text-align: left;">I
														understand by proceeding further and checking this
														checkbox, I authorise <b>SRS Live Technologies Pvt Ltd
													</b> to perform my EKYC/AUTH for payment collection via their
														application "QwikForms". I also authorise them to collect
														my Mobile/E-mail available with UIDAI as part of KYC Data.
														I understand that the KYC data collected by SRS Live
														Technologies Pvt Ltd will not be used for any other purpose
														other than mentioned here.
												</label>
											</span>
										</div>
									</div>
								</div>
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="form-group">
										<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">PIN
											No. *</label>
										<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
											<input type="text" name="PINNO" class="form-control"
												id="rc_pinno" required="required"
												placeholder="Enter PIN Code" />
										</div>
									</div>
								</div>
							</c:if>
							<c:if test='${formdetails.isPANVerified=="Y"}'>
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="form-group">
										<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">PAN
											*</label>
										<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
											<input type="text" name="PAN" class="form-control"
												value='<c:out value="${sampleFormBean.payerPAN}"/>'
												id="rc_pan" required="required" placeholder="Enter PAN"
												placeholder="Enter Your PAN" />
										</div>
									</div>
								</div>
							</c:if>
						</c:if>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label  class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Form Start Date</label>
								
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<fmt:formatDate value="${formdetails.formStartDate}" pattern="dd-MM-yyyy" var="parsedDateTime" type="date" />
									<c:out value="${parsedDateTime}" />
									
									
									<input name="${parsedDateTime}" class="form-control"
										id="rc_formStartDate" type="hidden"
										value="<c:out value="${parsedDateTime}" />"
										title="0">
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label  class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Form End Date</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<fmt:formatDate value="${formdetails.formEndDate}" pattern="dd-MM-yyyy" var="parsedDateTime1" type="date" />
									<c:out value="${parsedDateTime1}" />
									
										
									
									<input name="${parsedDateTime1}" class="form-control"
										id="rc_formEndDate" type="hidden"
										value="<c:out value="${parsedDateTime1}" />"
										title="0">
								</div>
							</div>
						</div>
						
						<div id="pageRCCode" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12 cap-toppad">
									<span class="captcha-txt"><%=session.getAttribute("genAlphaNum")%></span>&nbsp;
								</div>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<label class="captcha-label">Captcha letters are case sensitive</label> 
									<input type='hidden' id='captchaFromServer'
										value='<%=session.getAttribute("genAlphaNum")%>' /> 
									<input type="text" class="form-control" id="captId"
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
									<span>
									<button onClick="return goToFormPages()" type="button"
										value="Next" class="btn btn-primary">Next</button>
									</span>
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
							<c:set var="inFlg">
								<c:out value="${formdetails.hasInstructions}" />
							</c:set>
							<c:choose>
								<c:when test='${inFlg.contentEquals("Y")}'>
									<button onclick='downloadFile(<c:out value="${formdetails.id}" />)'>Download Instructions</button>
								</c:when>
								<c:otherwise>
									<%-- <c:out value="${form.id}" /> --%>
									<button style="display: none;" onclick='downloadFile()'>Download Instructions</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</li>
				
				<c:forEach items="${formdetails.structureList}" var="formStrList" varStatus="ind">
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
					<c:set var="fileUpload">
					<%-- value="${ids}${stat.first ? '' : ','}${currentItem.id}" --%>
						<c:out value="${formStrList.id}" />
					</c:set>
					
					<c:if test='${fieldName.contentEquals("SiblingDiscountHidden")}'>
					</c:if>
					<c:if test='${fieldType.contentEquals("PageBreak") && fieldName.contentEquals("Page Title") || indexCtr==0 && !fieldName.contentEquals("Page Title") }'>
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
					<li class="tab-header-and-content">
						<a href="#" class="tab-link" id="tab-11-1-<%=pageCtr%>">
							<c:out value="${formStrList.fieldValues}" />
						</a>
						<div id="tab-11-<%=pageCtr%>"
							class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tab-content">
						
				</c:if>
					
					<tr>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 " >
							<div class="form-group">
								<td style="width: 300px">
									<label class="col-lg-3 col-md-12 col-sm-12 col-xs-12"> 
										<c:choose>
										<c:when test='${fieldType.contentEquals("E-Receipt Notification")}'>
											<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
												class="form-control" id='<c:out value="${formStrList.id}"/>'
												value='<c:out value="${formStrList.formField.notification_content}" />'
												type="hidden"></input>

										</c:when> 
										<c:when test='${fieldType.contentEquals("Section")}'>
										</c:when> 
										<c:otherwise>
											<c:if test='${!fieldName.contentEquals("Page Title")}'>
												<c:choose>
												<c:when test='${fieldName.contentEquals("SiblingDiscountHidden")}'>
												</c:when>
												<c:otherwise>

													<strong><c:out value="${formStrList.formField.lookup_name}" /></strong>
												</c:otherwise>
												</c:choose>	
											</c:if>
										</c:otherwise> 
										</c:choose>
										<c:if test='${mandFlag==1}'>
											<font color="red">*</font>
										</c:if>	
									</label>
								</td>
								<td>
								
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
										
									<c:choose>
										<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Number")}'>
											<c:choose>
											<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
												<c:choose>
												<c:when test='${formStrList.triggerEvent.contentEquals("onchange")}'>
													<input type="number" id='<c:out value="${formStrList.id}"/>'
														class="form-control" title="<%=pageCtr%>"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														maxlength="254"
														pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												<c:when test='${formStrList.triggerEvent.contentEquals("onselect")}'>			
													<input type="number" id='<c:out value="${formStrList.id}"/>'
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														maxlength="254"
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														class="form-control" title="<%=pageCtr%>"
														pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
														onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												</c:choose>
											</c:when>
											<c:otherwise>
												<input type="number" id='<c:out value="${formStrList.id}"/>'
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													maxlength="254" class="form-control" title="<%=pageCtr%>"
													<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
													pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
													value='<c:out value="${payerFormDataMap[fieldId]}"/>'
													onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
											</c:otherwise>
											</c:choose>
										</c:when>
										
										<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Hidden")}'>
											<c:choose>
											<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
												<c:choose>
												<c:when test='${formStrList.triggerEvent.contentEquals("onchange")}'>
													<input type="password" id='<c:out value="${formStrList.id}"/>'
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														class="form-control" title="<%=pageCtr%>"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												<c:when test='${formStrList.triggerEvent.contentEquals("onselect")}'>
													<input type="password" id='<c:out value="${formStrList.id}"/>'
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														class="form-control" title="<%=pageCtr%>"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												</c:choose>
											</c:when>
											<c:otherwise>
												<input type="password" id='<c:out value="${formStrList.id}"/>'
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													value='<c:out value="${payerFormDataMap[fieldId]}"/>'
													class="form-control" title="<%=pageCtr%>"
													<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
													onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
											</c:otherwise>
											</c:choose>
										</c:when>
										
										<c:when test='${fieldType.contentEquals("PageBreak") && fieldName.contentEquals("Page Title")}'>

										</c:when>
										
										<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Text")}'>
											<c:choose>
											<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
												<c:choose>
												<c:when test='${formStrList.triggerEvent.contentEquals("onchange")}'>
													<c:choose>
													<c:when test='${formStrList.formField.validation_expression==null || formStrList.formField.validation_expression.trim().contentEquals("")}'>
														<input type="text" id='<c:out value="${formStrList.id}"/>'
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															value='<c:out value="${payerFormDataMap[fieldId]}"/>'
															class="form-control" title="<%=pageCtr%>" 
															maxlength="254"
															onkeyup="return blockSpecialChar(this.value,'<c:out value="${formStrList.id}"/>')"
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
															onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
													</c:when>
													<c:otherwise>
														<input type="text" id='<c:out value="${formStrList.id}"/>'
															pattern='<c:out default="{*}" value="${formStrList.formField.validation_expression}" />'
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															maxlength="254"
															onkeyup="return blockSpecialChar(this.value,'<c:out value="${formStrList.id}"/>')"
															value='<c:out value="${payerFormDataMap[fieldId]}"/>'
															class="form-control" title="<%=pageCtr%>"
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
															onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
													</c:otherwise>
													</c:choose>
												</c:when>
												<c:when test='${formStrList.triggerEvent.contentEquals("onselect")}'>
													<c:choose>
													<c:when test='${formStrList.formField.validation_expression==null||formStrList.formField.validation_expression.trim().contentEquals("")}'>
														<input type="text" id='<c:out value="${formStrList.id}"/>'
															class="form-control" title="<%=pageCtr%>" 
															maxlength="254"
															onkeyup="return blockSpecialChar(this.value,'<c:out value="${formStrList.id}"/>')"
															value='<c:out value="${payerFormDataMap[fieldId]}"/>'
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
															onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
													</c:when>
													<c:otherwise>
														<input type="text" id='<c:out value="${formStrList.id}"/>'
															pattern='<c:out default="{*}" value="${formStrList.formField.validation_expression}" />'
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															maxlength="254"
															onkeyup="return blockSpecialChar(this.value,'<c:out value="${formStrList.id}"/>')"
															value='<c:out value="${payerFormDataMap[fieldId]}"/>'
															class="form-control" title="<%=pageCtr%>"
															<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
															onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id)'
															onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
													</c:otherwise>
													</c:choose>
												</c:when>
												</c:choose>
											</c:when>
											<c:otherwise>
												<c:choose>
												<c:when test='${formStrList.formField.validation_expression==null || formStrList.formField.validation_expression.trim().contentEquals("")}'>
													<input type="text" id='<c:out value="${formStrList.id}"/>'
														maxlength="254"
														onkeyup="return blockSpecialChar(this.value,'<c:out value="${formStrList.id}"/>')"
														class="form-control" title="<%=pageCtr%>"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												<c:otherwise>
													<input type="text" id='<c:out value="${formStrList.id}"/>'
														maxlength="254"
														onkeyup="return blockSpecialChar(this.value,'<c:out value="${formStrList.id}"/>')"
														class="form-control" title="<%=pageCtr%>"
														pattern='<c:out default="{*}" value="${formStrList.formField.validation_expression}" />'
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>>
												</c:otherwise>
												</c:choose>
											</c:otherwise>		
											</c:choose>
										</c:when>	
										
										<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Alpha")}'>
											<c:choose>
											<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
												<c:choose>	
												<c:when test='${formStrList.triggerEvent.contentEquals("onchange")}'>
													<input type="text" pattern="[a-zA-Z]+$"
														maxlength="254"
														placeholder="Alphabets Only" id='<c:out value="${formStrList.id}"/>'
														class="form-control" title="<%=pageCtr%>"
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												<c:when test='${formStrList.triggerEvent.contentEquals("onselect")}'>
													<input type="text" pattern="[a-zA-Z]+$" maxlength="254"
														onkeyup="return blockSpecialChar(this.value,'<c:out value="${formStrList.id}"/>')"
														placeholder="Alphabets Only" id='<c:out value="${formStrList.id}"/>'
														class="form-control" title="<%=pageCtr%>"
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												</c:choose>
											</c:when>
											<c:otherwise>
												<input type="text" pattern="[a-zA-Z]+$" maxlength="254"
													onkeyup="return blockSpecialChar(this.value,'<c:out value="${formStrList.id}"/>')"
													placeholder="Alphabets Only" id='<c:out value="${formStrList.id}"/>'
													class="form-control" title="<%=pageCtr%>"
													value='<c:out value="${payerFormDataMap[fieldId]}"/>'
													<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
											</c:otherwise>
											</c:choose>
										</c:when>
										
										<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Email")}'>
											<c:choose>
											<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
												<c:choose>
												<c:when test='${formStrList.triggerEvent.contentEquals("onchange")}'>
													<input type="email" id='<c:out value="${formStrList.id}"/>'
														class="form-control" title="<%=pageCtr%>"
														maxlength="254"
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												<c:when test='${formStrList.triggerEvent.contentEquals("onselect")}'>
													<input type="email" id='<c:out value="${formStrList.id}"/>'
														class="form-control" title="<%=pageCtr%>"
														maxlength="254"
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												</c:choose>
											</c:when>
											<c:otherwise>
												<input type="email" id='<c:out value="${formStrList.id}"/>'
													class="form-control" title="<%=pageCtr%>"
													<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													maxlength="254"
													value='<c:out value="${payerFormDataMap[fieldId]}"/>'
													onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
											</c:otherwise>
											</c:choose>
										</c:when>
										
										<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Date")}'>
											<c:choose>
											<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
												<c:choose>
												<c:when test='${formStrList.triggerEvent.contentEquals("onchange")}'>
																<!-- <c:out value="id"/> -->
													<input type="text" id='<c:out value="${formStrList.id}"/>'
														class="form-control" title="<%=pageCtr%>"
														placeholder="DD-MM-YYYY"
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														name='<c:out value="${formStrList.formField.lookup_name} "/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
													<img src="images/calendra.png"
														onclick="javascript:NewCssCal('demo1')"
														style="cursor: pointer" />
												</c:when>
												<c:when test='${formStrList.triggerEvent.contentEquals("onselect")}'>
													<input id='<c:out value="${formStrList.id}"/>' class="form-control"
														onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
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
													value='<c:out value="${payerFormDataMap[fieldId]}"/>'
													onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
													<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />'</c:if>
													size="25">
												<img src="images/calendra.png"
													onclick="javascript:NewCssCal('<c:out value="${formStrList.id}"/>','ddmmyyyy')"
													style="cursor: pointer" class="cal-endra" width="20"
													height="20" />	
																			
											</c:otherwise>
											</c:choose>
										</c:when>
										
										<c:when test='${fieldType.contentEquals("Section")}'>
											<center>
												<strong><input id='<c:out value="${formStrList.id}"/>'
													readonly="readonly" name="titleSection"
													value='<c:out value="${formStrList.formField.lookup_name}" />'></input></strong>
											</center>
										</c:when>	
										
										<c:when test='${fieldType.contentEquals("Radio Button Group")}'>
											<c:set var="key1">
												<c:out value="${formStrList.id}" />
											</c:set>
											<div id="pageRfCode" class="flt">
												<c:forEach items='${optionsMap2}' var="mapValue">
													<c:if test="${mapValue.key == key1 }"> 
													<c:forEach items="${mapValue.value}" var="item" varStatus="loop">
													<input class="gap-m" id='<c:out value="${formStrList.id}"/>'
															style="width: 20px; height: 20px;" 
															name='<c:out value="${formStrList.formField.lookup_name}"/>'
															type="radio" 
															title='<%=pageCtr%>' 
														<c:if test='${mandFlag==1}'> 
															required='<c:out value="${formStrList.isMandatory}" />' 
														</c:if>
														value='<c:out value="${key1}" />*<c:out value="${item}"/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id)'>
													<span style="vertical-align: top !important; padding-right: 30px !important"><c:out value="${item}" /></span>
													</c:forEach>
													</c:if>
												</c:forEach>
											</div>
										</c:when>						
												
										<c:when test='${fieldType.contentEquals("Check Box")}'>
											<c:choose>
											<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
												<c:choose>
												<c:when test='${formStrList.triggerEvent.contentEquals("onchange")}'>	
													<input type="checkbox" id='<c:out value="${formStrList.id}"/>'
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														class="form-control chbox" title="<%=pageCtr%>"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),
														<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												<c:otherwise>
													<input type="checkbox" id='<c:out value="${formStrList.id}"/>'
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														class="form-control chbox" title="<%=pageCtr%>"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>

												</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<input type="checkbox" id='<c:out value="${formStrList.id}"/>'
													name='<c:out value="${formStrList.formField.lookup_name}"/>'
													class="form-control chbox" title="<%=pageCtr%>"
													<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
													onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
											</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test='${fieldType.contentEquals("Text Area")}'>
											<textarea id='<c:out value="${formStrList.id}"/>' maxlength="254"
												onkeyup="return blockSpecialChar(this.value,'<c:out value="${formStrList.id}"/>')"
												name='<c:out value="${formStrList.formField.lookup_name}"/>'
												class="form-control" title="<%=pageCtr%>"
												<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												<c:out value="${payerFormDataMap[fieldId]}" />
											</textarea>
										</c:when>
								<%-- <c:when test='${fieldType.contentEquals("File Upload Field")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when> --%>
								
								<c:when test='${fieldType.contentEquals("Document1")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload1' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>
								<c:when test='${fieldType.contentEquals("Document2")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload2' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>
								<c:when test='${fieldType.contentEquals("Document3")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload3' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>
								<c:when test='${fieldType.contentEquals("Document4")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload4' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>
								<c:when test='${fieldType.contentEquals("Document5")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload5' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>
								<c:when test='${fieldType.contentEquals("Document6")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload6' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>
								<c:when test='${fieldType.contentEquals("Document7")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload7' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>
								<c:when test='${fieldType.contentEquals("Document8")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload8' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>
								<c:when test='${fieldType.contentEquals("Document9")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload9' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>
								<c:when test='${fieldType.contentEquals("Document10")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' 
										value='File Upload10' type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>

								</c:when>	
								
								<c:when test='${fieldType.contentEquals("Photograph")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='Photo Upload'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUpload?filetype=photo&fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								
								<c:when test='${fieldType.contentEquals("Signature")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='Signature Upload'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									
									<button onclick='window.open("PayerFileUpload?filetype=sign&fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>			
								
								<c:when test='${fieldType.contentEquals("Multiplier")}'>
									<c:set var="key">
											<c:out value="${formStrList.id}" />
									</c:set>				
									<c:choose>
									<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
										<c:if test='${formStrList.triggerEvent.contentEquals("HiddenFieldV")}'>
										</c:if>
										<c:choose>
										<c:when test='${formStrList.triggerEvent.contentEquals("onchange")}'>
											<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
												id='<c:out value="${formStrList.id}"/>' type="number" min="0" step="1"
												placeholder='Multiplier Field' class="form-control"
												title="<%=pageCtr%>"
												value='<c:out value="${payerFormDataMap[fieldId]}"/>'
												<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),
												GetFee("<c:out value='${formStrList.id}' />*"+this.value,this.id),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
										</c:when>
										<c:when test='${formStrList.triggerEvent.contentEquals("onselect")}'>
											<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
												id='<c:out value="${formStrList.id}"/>' type="number" min="0" step="1"
												placeholder='Multiplier Field' class="form-control"
												title="<%=pageCtr%>"
												value='<c:out value="${payerFormDataMap[fieldId]}"/>'
												<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
												onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value='${formStrList.id}' />*"+this.value,this.id)'>
										</c:when>
										<c:when test='${formStrList.triggerEvent.contentEquals("readonlynitj")}'>
											<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
												id='<c:out value="${formStrList.id}"/>' type="number" min="0" step="1"
												placeholder='Multiplier Field' class="form-control"
												readonly="readonly" title="<%=pageCtr%>"
												<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
												onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value='${formStrList.id}' />*"+this.value,this.id)'>
										</c:when>
										</c:choose>
									</c:when>
									<c:otherwise>
										<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
											id='<c:out value="${formStrList.id}"/>' type="number" min="0" step="1"
											placeholder='Multiplier Field' class="form-control"
											title="<%=pageCtr%>"
											value='<c:out value="${payerFormDataMap[fieldId]}"/>'
											<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
											onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value='${formStrList.id}' />*"+this.value,this.id)'>
									</c:otherwise>
									</c:choose>
								</c:when>			
								
								<c:when test='${fieldType.contentEquals("Form Notification")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										class="form-control" id='<c:out value="${formStrList.id}"/>'
										value='<c:out value="${formStrList.formField.notification_content}" />'
										type="hidden"></input>
									<label><c:out value="${formStrList.formField.notification_content}" /> </label>
								</c:when>				
								
								<c:when test='${fieldType.contentEquals("Select Box")}'>
									<c:set var="key1">
										<c:out value="${formStrList.id}" />
									</c:set>
									<c:choose>
									<c:when test='${formStrList.jsEnabled.contentEquals("Y")}'>
										<%-- <c:if test='${formStrList.triggerEvent.contentEquals("chsedropdown")}'>
											<strong>Readmission in Correspondence Course - 2nd Year</strong>
										</c:if>
										<c:if test='${formStrList.triggerEvent.contentEquals("CHSE84F")}'>
											<strong>CHSE BBSR/BER/SBP/BPD__________________________/16</strong>
										</c:if> --%>
										<c:choose>
										<c:when test='${formStrList.triggerEvent.contentEquals("onchange")}'>
											<select name='<c:out value="${formStrList.formField.lookup_name}"/>'
												id='<c:out value="${formStrList.id}"/>' title='<%=pageCtr%>'
												class="form-control"
												<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>

												<option disabled selected value="">Please Select an
													Option</option>
													<c:forEach items="${optionsMap2}" var="mapValue">
	    													<c:if test="${mapValue.key == key1 }"> 
															    <c:forEach items="${mapValue.value}" var="item" varStatus="loop">
															        <option value='<c:out value="${key1}" />*<c:out value="${item}"/>'><c:out value="${item}" /></option>
															    </c:forEach>
														    </c:if>
													</c:forEach>
											</select>
										</c:when>
										<c:when test='${formStrList.triggerEvent.contentEquals("onselect")}'>
											<select name='<c:out value="${formStrList.formField.lookup_name}"/>'
												id='<c:out value="${formStrList.id}"/>' title='<%=pageCtr%>'
												class="form-control"
												<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
												onselect='<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id)'>

												<option disabled selected value="">Please Select an
													Option</option>
													<c:forEach items="${optionsMap2}" var="mapValue">
	    													<c:if test="${mapValue.key == key1 }"> 
															    <c:forEach items="${mapValue.value}" var="item" varStatus="loop">
															        <option value='<c:out value="${key1}" />*<c:out value="${item}"/>'><c:out value="${item}" /></option>
															    </c:forEach>
														    </c:if>
													</c:forEach>
											</select>
										</c:when>
										</c:choose>	
									</c:when>
									<c:otherwise>
										<div id="pageRfCode">
										<select name='<c:out value="${formStrList.formField.lookup_name}"/>'
												id='<c:out value="${formStrList.id}"/>' title='<%=pageCtr%>'
												class="form-control"
												<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee(this.value,this.id)'>
												<option disabled selected value="">Please Select an
													Option </option>												
													<c:forEach items="${optionsMap2}" var="mapValue">
	    													<c:if test="${mapValue.key == key1 }"> 
															    <c:forEach items="${mapValue.value}" var="item" varStatus="loop">
															        <option value='<c:out value="${key1}" />*<c:out value="${item}"/>'><c:out value="${item}" /></option>
															    </c:forEach>
														    </c:if>
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
		<c:when test='${fieldType.contentEquals("E-Receipt Notification")}'>
			<script>AddToArray("<c:out value='${formStrList.formField.notification_content}'/>", "<c:out value='${formStrList.formField.lookup_name}'/>", "<c:out value='${formStrList.id}'/>" , "<c:out value='${ind.index}'/>" )</script>
		</c:when>
		<c:otherwise>
			<script>AddToArray("Empty", "<c:out value='${formStrList.formField.lookup_name}'/>", "<c:out value='${formStrList.id}'/>" , "<c:out value='${ind.index}'/>" )</script>
		</c:otherwise>
		</c:choose>
		
		<!--  Looking to print the Back and Next Buttons at the bottom of the last form page -->

		<c:if test="${formdetails.getStructureList().size()-1==indexCtr}">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="form-group">
					<div class="offset-sm-2 col-sm-12">
						
						<span><button type="button"
							class="wizard-prev btn btn-primary rht-gap smbuttonss"
							onClick="formPageBackAction(<%=pageCtr%>+1)">Back</button></span> <span><button
							class="wizard-next btn btn-primary smbuttonss" type="button"
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
</div>
</form>

<script> 

$(document).on('click', '.browse', function(){ 
var file = $(this).parent().parent().parent().find('.file'); 
file.trigger('click'); 
}); 
$(document).on('change', '.file', function(){ 
$(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, '')); 
}); 
</script>
	<script> 
$(function() { 
// We can attach the `fileselect` event to all file inputs on the page 
$(document).on('change', ':file', function() { 
var input = $(this), 
numFiles = input.get(0).files ? input.get(0).files.length : 1, 
label = input.val().replace(/\\/g, '/').replace(/.*\//, ''); 
input.trigger('fileselect', [numFiles, label]); 
}); 

// We can watch for our custom `fileselect` event like this 
$(document).ready( function() { 
$(':file').on('fileselect', function(event, numFiles, label) { 

var input = $(this).parents('.input-group').find(':text'), 
log = numFiles > 1 ? numFiles + ' files selected' : label; 

if( input.length ) { 
input.val(log); 
} else { 
if( log ) alert(log); 
} 

}); 
}); 



</script>

	<script> 

function verifyDocUploadFields(){ 
	alert("inside verifyDocUploadFields");
	var checker = document.getElementById('QForm');
	checker.reset();
var elements = document.forms["QForm"].elements; 
alert("inside new script"+elements); 
for (i=0; i<elements.length; i++){ 
	alert("Element Array Value===="+elements[i]); 
if(elements[i].value=="Signature Upload" && elements[i].required){ 
	
window.opener.signature_upload = false; 
arrUploadSign.push(i);
alert("Signature upload changed to "+window.opener.signature_upload); 
} 
if(elements[i].value=="Photo Upload" && elements[i].required){ 

window.opener.photo_upload = false; 
arrUploadPhoto.push(i);
alert("Photo upload changed to "+window.opener.photo_upload); 
}	    
if(elements[i].value=="File Upload" && elements[i].required){ 

window.opener.file_upload = false; 
alert("File  upload changed to"+window.opener.file_upload); 
}	
}	
} 

</script>


	<%-- <script> 
function initializeParentDiv() { 
alert("in initialize parent"); 
document.getElementById("showmsg").innerHTML = "Status is: "; 
//window.opener.document.getElementById("msgFromClass").value 

// document.getElementById("showmsg").textContent="newtext"; 
} 
</script> --%>

</body>
</html>