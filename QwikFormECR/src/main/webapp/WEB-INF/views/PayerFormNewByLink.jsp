<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>

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
	String curentFormId=null;
	String formInstanceId = null; 
	Logger log = LogManager.getLogger("Payer Form New"); 
	try { 
	
	sesBid = (Integer) session.getAttribute("BankId"); 
	sesCid = (Integer) session.getAttribute("CollegeId"); 
	collegeBean = (CollegeBean) session.getAttribute("CollegeBean"); 
	currentFormId = (Integer) session.getAttribute("currentFormId"); 
	//curentFormId = (String) session.getAttribute("currentFormId"); 
	formInstanceId = (String) session.getAttribute("formInstanceId"); 
	
	log.info("sesBid: PayerFormNew.jsp is:"+sesBid); 
	log.info("sesCid: PayerFormNew.jsp is:"+sesCid); 
	log.info("collegeBean: PayerFormNew.jsp is:"+collegeBean); 
	log.info("currentFormId: PayerFormNew.jsp is:"+currentFormId); 
	log.info("formInstanceId: PayerFormNew.jsp is:"+formInstanceId);
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

	<%
		
	%>
	<!-- external javascript -->

	<%
		
		Integer payeeformIdQC = currentFormId;
		
			
		
		String PayeeProfile = ""; 
		String clgName = ""; 
		String insCode = ""; 

		try { 
		sesBid = (Integer) session.getAttribute("BankId"); 
		sesCid = (Integer) session.getAttribute("CollegeId"); 
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean"); 
		PayeeProfile = (String) session.getAttribute("PayeeProfile"); 
		log.info("PayeeProfile: PayerFormNew.jsp is:"+PayeeProfile);
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



	<%
		System.out.println("Winny payeeformIdQC:" + payeeformIdQC);
	%>

	<!--onsubmit="return validateUploadElements()"  -->
	<form id="QForm" method="post">
		<input type="hidden" name="currentFormId" id="currentFormId"
			value="<%=currentFormId%>"></input>
		<!-- <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off" id="formssection"> -->
			<div class="pan-heading">
				<c:out value="${form.getFormName()}" />
			</div>
			<div class="top-pad"></div>
			<ul class="accordion-tabs-minimal">
				<li class="tab-header-and-content">
					<a href="#" class="tab-link is-active" id="tab-10-1-1">Basic Information</a>
					<!-- <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tab-content" id="tab-10-1"> -->
						
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
									<div class="col-lg-1 nopadding">
										<select id="mf" required="required" class="form-control">
											<option value="M">Mr.</option>
											<option value="F">Miss.</option>
										</select>
									</div>
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
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12"> <%
									 	if (PayeeProfile.contentEquals("Institute")) {
									 %> Date of Incorporation * <%
									 	} else {
									 %> Date of Birth * <%
									 	}
									 %>
								</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" class="form-control" id="demo1"
										required="required" placeholder="DD-MM-YYYY" title="0"
										value='<c:out value="${sampleFormBean.dob}"/>'> 
									<img src="images/calendra.png"
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
						<c:if test='${form.verificationFlag=="Y"}'>
							<c:if test='${form.isAadhaarVerified=="Y"}'>
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
							<c:if test='${form.isPANVerified=="Y"}'>
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
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Form
									Start Date</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<fmt:formatDate value="${form.formStartDate}" pattern="dd-MM-yyyy" var="parsedDateTime" type="date" />
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
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Form
									End Date</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<fmt:formatDate value="${form.formEndDate}" pattern="dd-MM-yyyy" var="parsedDateTime1" type="date" />
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
									<span><!-- <button type="button"
											class="wizard-prev btn btn-primary rht-gap"
											onClick="return goToStart()">Back</button> --></span>
									<span>
									<button onClick=" return goToFormPages()" type="button"
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
								<c:out value="${form.hasInstructions}" />
							</c:set>
							<c:choose>
								<c:when test='${inFlg.contentEquals("Y")}'>
									<button onclick='downloadFile(<c:out value="${form.id}" />)'>Download Instructions</button>
								</c:when>
								<c:otherwise>
									<c:out value="${form.id}" />
									<button style="display: none;" onclick='downloadFile()'>Download Instructions</button>
								</c:otherwise>
							</c:choose>
						</div>
					<!-- </div> -->
				</li>
				
				<c:forEach items="${form.structureList}" var="formStrList" varStatus="ind">
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
									<span><%-- <button type="button"
											class="wizard-prev btn btn-primary rht-gap"
											onClick="return formPageBackAction(<%=pageCtr%>)">Back</button> --%></span>
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
													value='<c:out value="${payerFormDataMap[fieldId]}"/>'
													maxlength="254" class="form-control" title="<%=pageCtr%>"
													<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
													pattern='<c:out value="${formStrList.formField.validation_expression}"/>'
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
															class="form-control" title="<%=pageCtr%>" maxlength="254"
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
															class="form-control" title="<%=pageCtr%>" maxlength="254"
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
														value='<c:out value="${payerFormDataMap[fieldId]}"/>'
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
												</c:when>
												<c:when test='${formStrList.triggerEvent.contentEquals("onselect")}'>
													<input type="email" id='<c:out value="${formStrList.id}"/>'
														class="form-control" title="<%=pageCtr%>"
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
												<%-- alert("the radio button is in when block :::::::"+${key1}); --%>
												
												<c:forEach items='${optionsMap2}' var="mapValue">
													<c:if test="${mapValue.key == key1 }"> 
													<c:forEach items="${mapValue.value}" var="item" varStatus="loop">
													<input class="gap-m" style="width: 20px; height: 20px;" 
														name='<c:out value="${formStrList.formField.lookup_name}"/>'
														value='<c:out value="${item}" />*<c:out value=""/>'
														type="radio" id='<c:out value="${formStrList.id}"/>'
														title='<%=pageCtr%>' 
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>
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
														onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
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
										id='<c:out value="${formStrList.id}"/>' value='File Upload'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when> --%>
								
								<c:when test='${fieldType.contentEquals("Document1")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload1'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								<c:when test='${fieldType.contentEquals("Document2")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload2'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								<c:when test='${fieldType.contentEquals("Document3")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload3'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								<c:when test='${fieldType.contentEquals("Document4")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload4'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								<c:when test='${fieldType.contentEquals("Document5")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload5'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								<c:when test='${fieldType.contentEquals("Document6")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload6'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								<c:when test='${fieldType.contentEquals("Document7")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload7'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								<c:when test='${fieldType.contentEquals("Document8")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload8'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								<c:when test='${fieldType.contentEquals("Document9")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload9'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>
								<c:when test='${fieldType.contentEquals("Document10")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='File Upload10'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUploadGeneral?fieldId=<c:out value='${formStrList.id}'/>
										<c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='${formStrList.id}'/>"><h5></h5></span>
								</c:when>		
								<c:when test='${fieldType.contentEquals("Photograph")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='Photo Upload'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUpload.jsp?filetype=photo&fieldId=<c:out value='${formStrList.id}'/><c:if test='%{#mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
										type="button" class="flt btn btn-primary up-load">Upload</button>
									<span id="<c:out value='id'/>"><h5></h5></span>
								</c:when>				
								<c:when test='${fieldType.contentEquals("Signature")}'>
									<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
										id='<c:out value="${formStrList.id}"/>' value='Signature Upload'
										type="hidden"
										<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
									<button
										onclick='window.open("PayerFileUpload.jsp?filetype=sign&fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
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
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>),GetFee("<c:out value='${formStrList.id}' />*"+this.value,this.id),<c:out value="${formStrList.jsFunction}"/>(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'>
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
										<c:if test='${formStrList.triggerEvent.contentEquals("chsedropdown")}'>
											<strong>Readmission in Correspondence Course - 2nd Year</strong>
										</c:if>
										<c:if test='${formStrList.triggerEvent.contentEquals("CHSE84F")}'>
											<strong>CHSE BBSR/BER/SBP/BPD__________________________/16</strong>
										</c:if>
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
															        <option value='<c:out value="${item}" />'><c:out value="${item}" /></option>
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
															        <option value='<c:out value="${item}" />'><c:out value="${item}" /></option>
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
															        <option value='<c:out value="${item}" />'><c:out value="${item}" /></option>
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
		
		<!--    - 26-09-2016 - Looking to print the Back and Next Buttons at the bottom of the last form page -->

		<c:if test="${form.getStructureList().size()-1==indexCtr}">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="form-group">
					<div class="offset-sm-2 col-sm-12">
						
						<span><%-- <button type="button"
							class="wizard-prev btn btn-primary rht-gap smbuttonss"
							onClick="formPageBackAction(<%=pageCtr%>+1)">Back</button> --%></span> <span><button
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
<!-- </div> -->
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

	function toggleAadhaarTextInput(){
		if(document.getElementById("cb_aadhaar").checked){
			document.getElementById("rc_aadhaar").readOnly=false;
			
		}
		else{
			document.getElementById("rc_aadhaar").readOnly=true;
			document.getElementById("rc_aadhaar").value="";
		}
	}
	
function verifyDocUploadFields(){ 
	alert("inside verifyDocUploadFields"); 
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
	var xhttp1 = new XMLHttpRequest();
	
	xhttp1.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			document.getElementById("2").style.visibility="hidden";
			
			document.getElementById("a_12").innerHTML = this.responseText;
			$("#tab-10-1-1").addClass('is-active');
			$("#tab-10-1").show();
			$("#tab-10-1").addClass('is-open');
			
			
			var formtemplateid = '<%=currentFormId %>';
			
			alert('formtemplateid now is::'+formtemplateid);					

		}
	}
}	
}	
} 


function goToFormPages(){
	alert("called gotoFormPages----v ");
	   var currentpagectr=0;
	   var validationpass = true;
		$("#15645").addClass("hide");
		$("#15712").addClass("hide");
		$("#15883").addClass("hide");	
	   
	 	var elements = document.forms["QForm"].elements;
	 	  alert("test  "+elements); 
	 	  for (i=0; i<elements.length; i++){
	 	    
	 	    if(elements[i].title<=currentpagectr){
	 	    	var e = elements[i].name;
	 	    	 //alert("test  "+elements[i].name); 
	 	    	
	 	    if(elements[i].required!=null){
	 	    	
	 	    	if(elements[i].required){
	 	    		
	 	    		if(elements[i].value==""){
	 	    			//alert('fields with asterisks must be filled in');
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
		  
		  
		  
	 	 /*  AAdhaar Validation function starts*/	

  		var str, element = document.getElementById('rc_aadhaar'),element1 =  document.getElementById('cb_aadhaar');

		if (element1 != null)
        	 {
	 
		if(document.getElementById("cb_aadhaar")!= null)
	 
        if(document.getElementById("cb_aadhaar").checked )
         { 
        	
        	element = document.getElementById('rc_aadhaar');
        	
        	 if (element != null)
        	 {   
        		 var aadhaar = document.getElementById('rc_aadhaar').value;
        		 var payerName = document.getElementById('rc_name').value;;
        		 var payerGender = document.getElementById('mf').value; 
        		 var payerMobile = document.getElementById('rc_contact').value;
        		 var payerPINCode = document.getElementById('rc_pinno').value;;
        		  
               	if(aadhaar != '')
	 	               {
               	   //alert("Please wait while your aadhaar is being verified.");
        	       var aUrl = "http://localhost:8080/DexServicesGit/verifyAadhaarDemographics/"+aadhaar+"/"+payerName+"/"+payerGender+"/"+payerMobile+"/"+payerPINCode+"/Y/Y";
			       //alert("aadhaar verify internal url is"+aUrl);
        	       var request = new XMLHttpRequest();
			           request.open('GET', aUrl, false);  // `false` makes the request synchronous
			           request.send(null);
								
						if (request.status === 200) 
						{
							  console.log(request.responseText);
							  var msg=request.responseText;
							//alert (msg);
							 if(msg=="Authenticated Successfully")
							 {
								
								//alert("Aadhaar is valid");
								validationpass = true;
							    
						        }
							
							 else{
								 
	 						     //alert("Invalid Aadhaar  No");
	 	 						 document.getElementById("rc_aadhaar").focus();
	 						     validationpass = false;
						       }
						}
						else
							{
							validationpass = false;
							alert("Aahaar Verification not complete. Please try again.");
							}
						
					}
   	
            }
         }
         else{  
                document.getElementById("cb_aadhaar").focus();
                 alert("Please check the checkbox for aadhaar verification consent");
                 validationpass = false;
              }
     
			 } 


			/*  AAdhaar Validation function ends*/	   
		  
		  

		 	 // regular expression to match required date format and mobile number format
		 	
	 	  
	 	    if(document.getElementById("demo1").value != '' && !document.getElementById("demo1").value.match(/^\d{1,2}\-\d{1,2}\-\d{4}$/)) {
	 	      //alert("Invalid Date Format: " + document.getElementById("demo1").value);
	 	     document.getElementById("demo1").focus();
	 	     validationpass = false;
	 	    }
	 	    if(document.getElementById("rc_contact").value != '' && !document.getElementById("rc_contact").value.match(/^[0-9]{10}$/)) {
		 	     // alert("Invalid Mobile Number Format: " + document.getElementById("rc_contact").value);
		 	     document.getElementById("rc_contact").focus();
		 	     validationpass = false;
		 	}		
	 	    if(document.getElementById("rc_email").value != '' && !document.getElementById("rc_email").value.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)) {
		 	     //alert("Invalid Email Format: " + document.getElementById("rc_email").value);
		 	     document.getElementById("rc_email").focus();
		 	     validationpass = false;
		 	}			


			//alert("testing validation "+validationpass);
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

function downloadFile(value)
{
	
	window.location = "InstructionDownloadForm?reqFormId=" + value ;
	log.info("reqFormId:"+ value);
//	window.location = "ApplicantReportsAllClientsBAPR?feeType=" + id;

	
}

function formPageNextAction(nextpageid){

	
	   var currentpagectr = nextpageid-1;
	   var validationpass = true;
	   var ageValue="";
		var gradeMP=0;
		var gradeGr=0;
		var gradeHs=0;
		var gradeHons=0;
		var gradeMaster=0;
		var gradeDoctrol=0;
		var totalGrade=0;
		
		var totalMarksMP=0;
		var perMarksMP=0;
		var totalMarksHS=0;
		var perMarksHS=0;
		var gradeUG=0;
		var totalMarksUG=0;
		var perMarksUG=0;
		var gradePG=0;
		var totalMarksPG=0;
		var perMarksPG=0;
		var ageValue=0;
		var category="";
		var sportsAbled="";
		var differentlyAbled="";
		 var da=true;	
		var amount="";
		var course="";	
	//   alert("page id "+nextpageid + " "+currentpagectr);
	   var elements = document.forms["QForm"].elements;
	 	 
	 	  for (i=0; i<elements.length; i++){
	 	   
	 	    if(elements[i].title<=currentpagectr){
	 	    	var e = elements[i].name;
	 	    	
	 	    //	alert("i is "+i +" "+elements[i].title);
	 	    	/*  if(elements[i].title=="second"){ */
			 			/* if(elements[i].name=="DATE OF BIRTH"){ */
	 	    	if(elements[i].name=="DATE OF BIRTH" || elements[i].name=="Date of Birth"  || elements[i].name==" Date of Birth" ||  elements[i].name=="Date of Birth "){
                 //     alert("value "+i+ " "+elements[i].name);
                        var mydate = elements[i].value;
                     //    mydate= mydate.format("DD-MM-yyyy");
                     //   alert(mydate);
                          var res = mydate.split("-", 3);
                         var dt = new Date();
				                        // alert(res);
				             //alert("inside date of birth "+elements[i].value+ " "+dt.getFullYear()+ " "+mydate.getFullYear());
				                           var ty=res[2];
				                           ageValue = dt.getFullYear()-ty;
				                  //      alert(ageValue);
				                   
									} 
								if(elements[i].name=="Age"){
								alert("Age is "+ageValue);
								elements[i].value = ageValue;
								}
								
								
								
						if(elements[i].name=="PERCENT MARKS OBTAINED-A-MP"){
							gradeMP = elements[i].value;
						//	alert("grade MP "+gradeMP);
						}
						if(elements[i].name=="GRADE POINT-10 PERCENT OF A-MP"){
							elements[i].value = gradeMP*0.1;
						//	alert("grade MPss "+elements[i].value);
						}
						
						if(elements[i].name=="Percentage Marks obtained Graduation General"){
							gradeGr = elements[i].value;
							alert("grade gr. "+gradeGr);
						}
						if(elements[i].name=="Grade Gr General"){
							elements[i].value = gradeGr*0.15;
						//	alert("grade grss "+elements[i].value);
						}
					
						
						
				
						if(elements[i].name=="Marks Obtained in MP"){
							gradeMP = elements[i].value;
						//	alert("marks obtained in MP "+gradeMP);
						
							gradeMP=parseInt(gradeMP);
							}
						if(elements[i].name=="Total Marks in MP"){
							totalMarksMP = elements[i].value;
						//	alert("Before Total marks in MP "+ totalMarksMP);
							if(totalMarksMP===0  ){
							//	alert("Please provide correct total marks in MP");
								elements[i].value="";
								totalMarksMP="";
							}else{
								totalMarksMP = elements[i].value;
	
							}
							totalMarksMP=parseInt(totalMarksMP);
						//	alert("Total marks in MP "+ totalMarksMP);
						}
					//	alert("elements name "+elements[i].name + " "+elements[i].value);
						if(elements[i].name=="Percentage of MP"){
						//	alert("after Total marks in MP "+ totalMarksMP + "  "+gradeMP);
								if(totalMarksMP>gradeMP){
									perMarksMP = (gradeMP/totalMarksMP)*100;
								}else{
							//		alert("Please provide correct total marks in MP");
									elements[i].value="";
									totalMarksMP="";
									gradeMP="";
									perMarksMP="";
								}
								elements[i].value = perMarksMP;
								elements[i].value = parseFloat(elements[i].value).toFixed(2);
						//		alert("% marks in MP "+ perMarksMP + "  "+elements[i].value);
						}
						
						
						
						if(elements[i].name=="Marks Obtained in HS"){
							gradeHS = elements[i].value;
							gradeHS=parseInt(gradeHS);
						//	alert("marks obtained in HS "+gradeHS);
						}
						if(elements[i].name=="Total Marks in HS"){
							totalMarksHS = elements[i].value;
						//	alert("Before Total marks in HS "+ totalMarksHS);
							if(totalMarksHS===0){
						//		alert("Please provide correct total marks in HS");
								elements[i].value="";
								totalMarksHS="";
							}else{
                                                     totalMarksHS=elements[i].value;
                                                     }

							totalMarksHS=parseInt(totalMarksHS);	
						//	alert("Total marks in HS "+ totalMarksHS);
						}
					//	alert("elements name "+elements[i].name + " "+elements[i].value);
						if(elements[i].name=="Percentage of HS" || elements[i].name=="Percentage Marks Obtained HS "){
						//	alert("after Total marks in HS "+ totalMarksHS + "  "+gradeHS);
								if(totalMarksHS>gradeHS ){
									perMarksHS = (gradeHS/totalMarksHS)*100;
								}else{
								//	alert("Please provide correct total marks in HS");
									elements[i].value="";
									totalMarksHS="";
									gradeHS="";
									perMarksHS="";
								}
								elements[i].value = perMarksHS;
								elements[i].value = parseFloat(elements[i].value).toFixed(2);
							//	alert("% marks in HS "+ perMarksHS + "  "+elements[i].value);
						}
					
						 if(elements[i].name=="Program or Course"){
		                                        console.log("before course "+elements[i].value);
             		                        course=elements[i].value;
}
	
						
						
						if(elements[i].name=="Obtained Hons Marks of UG" || elements[i].name=="Obtained Hons. Marks of UG"){
							gradeUG=elements[i].value;	
						//	alert("marks obtained in UG "+gradeUG);
						
							gradeUG=parseInt(gradeUG);
							}
						if(elements[i].name=="Total Hons Marks of UG" || elements[i].name=="Total Hons. Marks of UG" || elements[i].name=="Total Hons.Marks of UG" || elements[i].name== "Total Hons Marks in UG"){
							totalMarksUG = elements[i].value;
						//	alert("Before Total marks in UG "+ totalMarksUG);
							if(totalMarksUG===0){
							//	alert("Please provide correct total marks in UG");
								elements[i].value="";
								totalMarksUG="";
							}else{
                                                     totalMarksUG=elements[i].value;
                                                     }
						console.log("before  "+course + " t/f  "+course.includes("M.A"));
					/* if((course.includes("M.A")) || (course.includes("M.Sc"))|| (course.includes("M.Com"))|| (course.includes("MLIS"))){
                                                     console.log("inside success condition before");
                                                     totalMarksUG=800;
}*/


							totalMarksUG=parseInt(totalMarksUG);
						
						//	alert("Total marks in UG "+ totalMarksUG);
						}
					//	alert("elements name "+elements[i].name + " "+elements[i].value);
						if(elements[i].name=="Percentage of Hons Marks UG" || elements[i].name=="Percentage of Hons. Marks UG"){
							//alert("after Total marks in UG "+ totalMarksUG + "  "+gradeUG);
								if(totalMarksUG>gradeUG ){
									perMarksUG = (gradeUG/totalMarksUG)*100;
								}else{
								//	alert("Please provide correct total marks in UG");
									elements[i].value="";
									totalMarksUG="";
									gradeUG="";
									perMarksUG="";
								}
								elements[i].value = perMarksUG;
								elements[i].value = parseFloat(elements[i].value).toFixed(2);
							//	alert("% marks in UG "+ perMarksUG + "  "+elements[i].value);
						}
						
						
						
						
						if(elements[i].name=="Marks Obtained in PG" ){
							gradePG = elements[i].value;
							gradePG=parseInt(gradePG);
						//	alert("marks obtained in PG "+gradePG);
						}
						if(elements[i].name=="Total marks in PG" || elements[i].name=="Total Marks in PG"){
							totalMarksPG = elements[i].value;
						//	alert("Before Total marks in PG "+ totalMarksPG);
							if(totalMarksPG===0){
								alert("Please provide correct total marks in PG");
								elements[i].value="";
								totalMarksPG="";
							}else{
                                                     totalMarksPG=elements[i].value;
                                                     }
							totalMarksPG=parseInt(totalMarksPG);
					
						//	alert("Total marks in UG "+ totalMarksUG);
						}
					//	alert("elements name "+elements[i].name + " "+elements[i].value);
						if(elements[i].name=="Percentage of PG"){
						//	alert("after Total marks in PG "+ totalMarksPG + "  "+gradePG);
								if(totalMarksPG>gradePG ){
									perMarksPG = (gradePG/totalMarksPG)*100;
								}else{
								//	alert("Please provide correct total marks in PG");
									elements[i].value="";
									totalMarksPG="";
									perMarksPG="";
									gradePG="";
								//	perMarksPG="0.0";
								}
								elements[i].value = perMarksPG;
								elements[i].value = parseFloat(elements[i].value).toFixed(2);
							//	alert("% marks in PG "+ perMarksPG + "  "+elements[i].value);
						}
						
					
						if(elements[i].name=="Category 1" || elements[i].name=="Category-"|| elements[i].name=="Category"){
							category = elements[i].value;
						//	alert("category is "+category);
						}
						
						if(elements[i].name=="DIFFERENTLY ABLED" || elements[i].name=="Differently Abled-" || elements[i].name=="Differently Abled"){
							differentlyAbled = elements[i].value;
						//	alert("differentlyAbled is "+differentlyAbled);
						}
						if(elements[i].name=="Select Sports" || elements[i].name=="Sports Personality-"  || elements[i].name=="Sports Personality"){
							sportsAbled = elements[i].value;
						//	alert("sportsAbled is "+sportsAbled);
						}
						console.log("Before name "+elements[i].name);
						if(elements[i].name=="Total Amount" || elements[i].name==" Total Amount" || elements[i].name=="Total Amount " || elements[i].name==" Total Amount " ){
							 console.log("after name "+elements[i].name);
						//	sportsAbled = elements[i].value;
						//	alert("sportsAbled is "+sportsAbled);
						if((differentlyAbled.includes("Yes")) && (sportsAbled.includes("Yes"))){
						//	alert("both are true");
							elements[i].value="150";
							amount="150";
						}
						 if((differentlyAbled.includes("No")) && (sportsAbled.includes("Yes"))){
						//	alert("One is false");
							elements[i].value="150";
							amount="150";
						}
						 if((differentlyAbled.includes("Yes")) && (sportsAbled.includes("No"))){
						//	alert("One is false");
							elements[i].value="150";
							amount="150";
						}
						 if((differentlyAbled.includes("No")) && (sportsAbled.includes("No"))) {
						//	alert("both are false "+category);
							if(category.includes("Unreserved")){
								elements[i].value="300";
								amount="300";
							}else{
								elements[i].value="150";
								amount="150";
							}
						}
						
						}	

						
						
						
						
						
						
		 	    	
	 	    	 /* } */
	 	    
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
}	

function AddToArray(value, name, id,order) {
	
	value = value.split(",").join("");
	value = value.split("`").join("");
	value = value.split("=").join("");
	
	values[id] = id + "~" + name + "=" + value+"$"+order;
	 alert(JSON.stringify(values)); 

}	

function blockSpecialChar(value,id){
	var yourInput = value;

	re = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi;
	var isSplChar = re.test(yourInput);
	if(isSplChar){
			var no_spl_char = yourInput.replace(/[`~!@#$%^&*()|+\=?;:'",.<>\{\}\[\]\\\/]/gi, '');
			document.getElementById(id).value=no_spl_char;

		}
}

function GetFee(x, id) {
	AddToOptionsArray(x, id)
	var dataArray = new Array;
	for ( var value in options) {
		dataArray.push(options[value]);
	}
	//alert(dataArray);
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (xhttp.readyState == 4 && xhttp.status == 200) {
			//alert("Fee is "+xhttp.responseText);
			//document.getElementById("FeeBox").innerHTML = xhttp.responseText;
		}
	}
	var appName = window.location.pathname;
	var result = appName.substring(0,getPosition(appName,'/',2));
	
	

	var bid = '<%=sesBid %>';
	var cid = '<%=sesCid %>';
	//alert('bid is::'+bid);
	//alert('cid is::'+bid);
	
													
	
	xhttp.open("GET", window.location.origin+result+"/getFee?optionArray=" + dataArray + "&bid="+bid + "&cid=" +cid, true);
	
	xhttp.send();
}

function formSubmitAction(){
	
	/* 	show the summary page, hide the current page */
	
	var currentpagectr="last";
	var returnFlag=false;
	var validationpass=true;
	var ageValue="";
	var gradeMP=0;
	var gradeGr=0;
	var gradeHs=0;
	var gradeHons=0;
	var gradeMaster=0;
	var gradeDoctrol=0;
	var totalGrade=0;
	
	var totalMarksMP=0;
	var perMarksMP=0;
	var totalMarksHS=0;
	var perMarksHS=0;
	var gradeUG=0;
	var totalMarksUG="0";
	var perMarksUG=0;
	var gradePG=0;
	var totalMarksPG=0;
	var perMarksPG=0;
	var ageValue="";
	var category="";
	var sportsAbled="";
	var differentlyAbled="";
	var amount="";
	var course="";
	
	var elements = document.forms["QForm"].elements;	
	
 	  for (i=0; i<elements.length; i++){
	 	    
	 	    	var e = elements[i].name;
				//changes for file upload
				
				
			    if(elements[i].name=="Sign"){
 		 	    	//alert("in element Sign");
 		 	    	//alert('mandatory flag for sign is..'+elements[i].required);
 		 	    	if(!elements[i].required){
 		 	    		//alert("sign is optional");
 		 	    		signature_upload = true;
 		 	    	}
 		 	    	else{
 		 	    		//alert("sign is mandatory");
 		 	    	if(!signature_uploaded){
 		 	    		//alert("sign is mandatory but not uploaded");
 					    signature_upload = false;
 		 	        }
			        }
 		 	    }
				
	
			
			//new requirement
				
			if(elements[i].name=="DATE OF BIRTH"|| elements[i].name=="Date of Birth" || elements[i].name=="Date of Birth " || elements[i].name==" Date of Birth" ){                                           
				var mydate = elements[i].value;
                                           
			var res = mydate.split("-", 3);
			var dt = new Date();
                                      
			var ty=res[2];
			ageValue = dt.getFullYear()-ty;
                                       
				}

                                  
			console.log("at log "+elements[i].name);        
                                         
			if(elements[i].name=="AGE" || elements[i].name=="Age"){
			alert("Age is "+ageValue);
                                     elements[i].value=ageValue;       
					}	
			




				if(elements[i].name=="Marks Obtained in MP"){
					gradeMP = elements[i].value;
					gradeMP=parseInt(gradeMP);
				//	alert("marks obtained in MP "+gradeMP);
				}
				if(elements[i].name=="Total Marks in MP"){
					totalMarksMP = elements[i].value;
				//	alert("Before Total marks in MP "+ totalMarksMP);
					if(totalMarksMP===0  ){
					//	alert("Please provide correct total marks in MP");
						elements[i].value="";
						totalMarksMP="";
					}else{
						 totalMarksMP = elements[i].value;

						}
					totalMarksMP=parseInt(totalMarksMP);	
				//	alert("Total marks in MP "+ totalMarksMP);
				}
			//	alert("elements name "+elements[i].name + " "+elements[i].value);
				if(elements[i].name=="Percentage of MP"){
				//	alert("after Total marks in MP "+ totalMarksMP + "  "+gradeMP);
						if(totalMarksMP>gradeMP){
							perMarksMP = (gradeMP/totalMarksMP)*100;
						}else{
						//	alert("Please provide correct total marks in MP");
							elements[i].value="";
							totalMarksMP="";
							gradeMP="";
							perMarksMP="";
						}
						elements[i].value = perMarksMP;
						elements[i].value = parseFloat(elements[i].value).toFixed(2);
				//		alert("% marks in MP "+ perMarksMP + "  "+elements[i].value);
				}
				
				
				
				if(elements[i].name=="Marks Obtained in HS"){
					gradeHS = elements[i].value;
					gradeHS=parseInt(gradeHS);
				//	alert("marks obtained in HS "+gradeHS);
				}
				if(elements[i].name=="Total Marks in HS"){
					totalMarksHS = elements[i].value;
				//	alert("Before Total marks in HS "+ totalMarksHS);
					if(totalMarksHS===0) {
				//		alert("Please provide correct total marks in HS");
						elements[i].value="";
						totalMarksHS="";
					}else{
						totalMarksHS=elements[i].value;
						}
					totalMarksHS=parseInt(totalMarksHS);
				//	alert("Total marks in HS "+ totalMarksHS);
				}
			//	alert("elements name "+elements[i].name + " "+elements[i].value);
				if(elements[i].name=="Percentage of HS" || elements[i].name=="Percentage Marks Obtained HS "){
			//	alert("after Total marks in HS "+ totalMarksHS + "  "+gradeHS);
						if(totalMarksHS>gradeHS ){
							perMarksHS = (gradeHS/totalMarksHS)*100;
						}else{
							alert("Please provide correct total marks in HS");
							elements[i].value="";
							totalMarksHS="";
							gradeHS="";
							perMarksHS="";
						}
						elements[i].value = perMarksHS;
						elements[i].value = parseFloat(elements[i].value).toFixed(2);
					//	alert("% marks in HS "+ perMarksHS + "  "+elements[i].value);
				}
				
				
				if(elements[i].name=="Program or Course"){
				console.log("before course "+elements[i].value);
				course=elements[i].value;
}	
				if(elements[i].name=="Obtained Hons Marks of UG" || elements[i].name=="Obtained Hons. Marks of UG"){
					gradeUG = elements[i].value;
					gradeUG=parseInt(gradeUG);
				//	alert("marks obtained in UG "+gradeUG);
				}
				if(elements[i].name=="Total Hons Marks of UG" || elements[i].name=="Total Hons. Marks of UG" ||elements[i].name=="Total Hons.Marks of UG" ){
					totalMarksUG = elements[i].value;
				//	alert("Before Total marks in UG "+ totalMarksUG);
					if(totalMarksUG===0){
					//	alert("Please provide correct total marks in UG");
						elements[i].value="";
						totalMarksUG="";
					}else{
                                                    totalMarksUG=elements[i].value;
                                                    }
					console.log("course be condition "+course);
					console.log("total marks in  ug "+totalMarksUG);
					totalMarksUG=parseInt(totalMarksUG);

				//	alert("Total marks in UG "+ totalMarksUG);
				}
				
				if(elements[i].name=="Total Hons Marks in UG"){
					totalMarksUG=elements[i].value;
					if(totalMarksUG===0){
					elements[i].value="";
					totalMarksUG="";
					}
				else{
				totalMarksUG=elements[i].value;
					}
		
					
}
			//	alert("elements name "+elements[i].name + " "+elements[i].value);
				if(elements[i].name=="Percentage of Hons Marks UG" || elements[i].name=="Percentage of Hons. Marks UG" || elements[i].name=="Percentage Of Graduation"){
					console.log("after Total marks in UG "+ totalMarksUG + "  "+gradeUG);
						if(totalMarksUG>gradeUG ){
							perMarksUG = (gradeUG/totalMarksUG)*100;
						}else{
							console.log("Please provide correct total marks in UG");
							elements[i].value="";
							totalMarksUG="";
							gradeUG="";
							perMarksUG="";
						}
						console.log("percentage after calcultaing ug---- "+elements[i].value);
						elements[i].value = perMarksUG;
						elements[i].value = parseFloat(elements[i].value).toFixed(2);
					//	alert("% marks in UG "+ perMarksUG + "  "+elements[i].value);
				}
				
				
				
				
				if(elements[i].name=="Marks Obtained in PG" ){
					gradePG = elements[i].value;
					gradePG=parseInt(gradePG);
				//	alert("marks obtained in PG "+gradePG);
				}
				if(elements[i].name=="Total marks in PG" || elements[i].name=="Total Marks in PG"){
					totalMarksPG = elements[i].value;
				//	alert("Before Total marks in PG "+ totalMarksPG);
					if(totalMarksPG===0){
						//alert("Please provide correct total marks in PG");
						elements[i].value="";
						totalMarksPG="";
					}else{
                                                    totalMarksPG=elements[i].value;
                                                    }

					totalMarksPG=parseInt(totalMarksPG);	
				//	alert("Total marks in UG "+ totalMarksUG);
				}
			//	alert("elements name "+elements[i].name + " "+elements[i].value);
				if(elements[i].name=="Percentage of PG"){
				//	alert("after Total marks in PG "+ totalMarksPG + "  "+gradePG);
						if(totalMarksPG>gradePG ){
							perMarksPG = (gradePG/totalMarksPG)*100;
						}else{
						//	alert("Please provide correct total marks in PG");
							elements[i].value="";
							totalMarksPG="";
							perMarksPG="";
							gradePG="";
						//	perMarksPG="0.0";
						}
						elements[i].value = perMarksPG;
						elements[i].value = parseFloat(elements[i].value).toFixed(2);
				//	alert("% marks in PG "+ perMarksPG + "  "+elements[i].value);
				}
				
			
				if(elements[i].name=="Category 1" || elements[i].name=="Category-" || elements[i].name=="Category"){
					category = elements[i].value;
				//	alert("category is "+category);
				}
				
				if(elements[i].name=="DIFFERENTLY ABLED" || elements[i].name=="Differently Abled-"  || elements[i].name=="Differently Abled"){
					differentlyAbled = elements[i].value;
				//	alert("differentlyAbled is "+differentlyAbled);
				}
				if(elements[i].name=="Select Sports" || elements[i].name=="Sports Personality-"  || elements[i].name=="Sports Personality"){
					sportsAbled = elements[i].value;
				//	alert("sportsAbled is "+sportsAbled);
				}
				if(elements[i].name=="Total Amount" || elements[i].name=="Total Amount " || elements[i].name==" Total A						amount" || elements[i].name==" Total Amount "){
				//	sportsAbled = elements[i].value;
				//	alert("sportsAbled is "+sportsAbled);
				if((differentlyAbled.includes("Yes")) && (sportsAbled.includes("Yes"))){
				//	alert("both are true");
					elements[i].value="150";
					amount="150";
				}
				if((differentlyAbled.includes("No")) && (sportsAbled.includes("Yes"))){
				//	alert("One is false");
					elements[i].value="150";
					amount="150";
				}
				if((differentlyAbled.includes("Yes")) && (sportsAbled.includes("No"))){
				//	alert("One is false");
					elements[i].value="150";
					amount="150";
				}
				if((differentlyAbled.includes("No")) && (sportsAbled.includes("No"))){
					console.log("both are false "+category);
					if(category.includes("Unreserved")){
						elements[i].value="300";
						amount="300";
					}else{
						elements[i].value="150";
						amount="150";
					}
				}
				
				}
				
				
				
 		 	    if(elements[i].name=="Photo"){
 		 	    	//alert("in element Photo");
 		 	    	//alert('mandatory flag for sign is..'+elements[i].required);
 		 	    	if(!elements[i].required){
 		 	    		//alert("sign is optional");
 		 	    		photo_upload = true;
 		 	    	}
 		 	    	else
 		 	    		{//alert("photo is mandatory");
 		 	    		if(!photo_uploaded){
 		 	    			//alert("Photo is mandatory but not uploaded");
 		 					photo_upload = false;
 		 		 	    	}
 		 	    		}
 		 	    	
 		    }	 	    
 		 	    if(elements[i].name.includes("Upload")){
 		 	    	//alert("in element file_upload");
 		 	    	if(!elements[i].required){
 		 	    		//alert("file is optional");
 		 	    		file_upload = true;
 		 	    	}
 		 	    	else{
 		 	    		//alert("file is mandatory");
 		 	    		if(!file_uploaded){
 		 	    			//alert("file is mandatory but not uploaded");
 		 					file_upload = false;
 		 					
 		 		 	    	}
 		 	    	}
 		 	        
 		    }	 	    		
 	    		
				
				//changes for file upload
	 	    
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
		//alert("photo_upload=="+photo_upload+ "& signature_upload=="+signature_upload+"&file_upload"+file_upload);
		  if(!photo_upload || !signature_upload || !file_upload){
			  alert("Please upload all attachments");  
		  }
		  else{
			submitFormUsingAjax(submitShotFlag, currentpagectr);
		  }
	  }
	  
	return returnFlag;
	
}

function submitFormUsingAjax(submitShot, currentpagectr) {
	
	
	//event.preventDefault();
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
	if(document.getElementById("rc_payerID")){
		var rcPayerID = document.getElementById("rc_payerID").value;
	}
	var rcEndDate = document.getElementById("rc_formEndDate").value; 
	
	try
	{
	rccode = document.getElementById("rc_code").value;
	}
	catch(err){
		
		
	}

	
	var dataArray = new Array;
//	alert(" value from PayerFlow.jsp "+values.length);
	for ( var value in values) {
	//	alert(" value from PayerFlow.jsp "+value);
		dataArray.push(values[value]);
	//	alert(" dataArray from PayerFlow.jsp "+dataArray);
	}
	
	var payeeformIdQC =<%=payeeformIdQC%>;
	var argument = "values=" + dataArray + "&rcname=" + rcname
			+ "&rcdob=" + rcdob + "&rccontact=" + rccontact + "&rcPayerID=" + rcPayerID
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
					document.getElementById("1").style.display='block';
					
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
			
			

			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';			
			var formtemplateid = '<%=currentFormId %>';			
		
			
			xhttp.open("GET", window.location.origin+result+"/processForm?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid + "&forminstanceid="+forminstanceid, true);
			
			
			xhttp.send();

return false;
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
