<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
	<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>	
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
	Logger log = Logger.getLogger("Payer Form New");
	try {

		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		currentFormId = (Integer) session.getAttribute("currentFormId");
		formInstanceId = (String) session.getAttribute("formInstanceId");
	
		log.info("currentFormId: PayerFormNewBatch.jsp is:"+currentFormId);
		log.info("formInstanceId: PayerFormNewBatch.jsp is:"+formInstanceId);
		
		SampleFormBean sfb = (SampleFormBean) session.getAttribute("sesCurrentFormData");
		if(null!=sfb){
			log.info("form bean in session found, invalidating it now");
			session.removeAttribute("sesCurrentFormData");
		}
		else{
			log.info("no form bean in session found");
		}		
		
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

</head>
<body>
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
	
	sesBid = (Integer) session.getAttribute("BankId");
	sesCid = (Integer) session.getAttribute("CollegeId");
		//	int bid = Integer.parseInt((String) session.getAttribute("bid"));
			//System.out.print("BID ::" + bid);
			/* String collegeCode="";
			 session.setAttribute("collegeCode", collegeCode); */
	%>
	<!-- external javascript -->

	<script type="text/javascript">

var values = {};


function AddToArray(value, name, id,order) {
	//alert('adding to array');
	value = value.split(",").join("");
	value = value.split("`").join("");
	value = value.split("=").join("");
	values[id] = id + "`" + name + "=" + value+"$"+order;
	// alert(JSON.stringify(values)); 

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
	<s:if test='%{form.getJsEnabled().contentEquals("Y")}'>
		<script src="js/formjs/myScriptN.js"></script>
		<script src="js/formjs/myScriptArts.js"></script>
		<script src="js/formjs/myScriptScience.js"></script>
	</s:if>
	<script language="javascript" type="text/javascript"
		src="js/datetimepicker_css_100Year.js">
	</script>

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>



	<script>
 
 var captcha_match = false;
 var submitShotFlag = "fresh";
 var options = {};
 
 
//  to get the substring before nth character in a string 
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
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				//alert("Fee is "+xhttp.responseText);
				//document.getElementById("FeeBox").innerHTML = xhttp.responseText;
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
		
		xhttp.open("GET", window.location.origin+result+"/getFee?optionArray=" + dataArray + "&bid="+bid + "&cid=" +cid, true);
		
		xhttp.send();
	}
 
 function AddToOptionsArray(value, id) {
		
		options[id] = value;
			
		//	alert(JSON.stringify(options));

		}
 </script>





	<%
		/* 
		Integer sesBid = null;
		Integer sesCid = null;
		CollegeBean collegeBean = new CollegeBean();
		 */String payeeformIdQC = (String) request.getParameter("formId");
		String PayeeProfile = "";
		String clgName = "";
		String insCode = "";
		
		try {
			sesBid = (Integer) session.getAttribute("BankId");
			sesCid = (Integer) session.getAttribute("CollegeId");
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			PayeeProfile = (String) session.getAttribute("PayeeProfile");
			/* if(PayeeProfile==null){
		PayeeProfile="Individual";
			} */
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

	<form id="QForm" method="post">
		<input type="hidden" name="currentFormId" id="currentFormId"  value="<%=currentFormId%>" ></input>
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off"
			id="formssection"">
			<div class="pan-heading"><c:out value="${form.getFormName()}"/></div> 
			<div class="top-pad"></div>
			<ul class="accordion-tabs-minimal">
				<li class="tab-header-and-content"><a href="#" 
					class="tab-link is-active" id="tab-10-1-1">Basic Information</a>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 "
							id="tab-10-1"
							style="border: 1px solid #0072bc; border-top: 4px solid #0072bc;">
							<label class="divider-label">Please enter your Name, Date
								of Birth & Mobile Number. This is required to reprint your
								e-receipt / remittance(PAP) form, if the need arises.</label>
						
						<%
							if (PayeeProfile.contentEquals("Institute")) {
						%>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Institute
									Code *</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" id="rc_code" required="required"
										value="<%=insCode%>" class="form-control" readonly="readonly"
										placeholder="Code" title="0">
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Institute
									Name *</label>
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
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Payer
									Name *</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" id="rc_name" required="required" value='<c:out value="${sampleFormBean.name}"/>'
										class="form-control" placeholder="Enter Name" title="0">
								</div>
							</div>
						</div>

						<%
							}
						%>

						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">
							<%
							if (PayeeProfile.contentEquals("Institute")) {
							%>
								Date of Incorporation *
							<% } else { %>
							    Date of Birth *
							<% } %>	
									</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" class="form-control" id="demo1"
										required="required" placeholder="DD-MM-YYYY" title="0" value='<c:out value="${sampleFormBean.dob}"/>'>

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
										id="rc_contact" required="required" maxlength="10" value='<c:out value="${sampleFormBean.contact}"/>' 
										placeholder="Mobile Number" title="0">
								</div>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Email
									Id *</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<input type="text" name="Email" class="form-control" value='<c:out value="${sampleFormBean.email}"/>'
										id="rc_email" required="required" placeholder="Enter Email Id"
										type="email" placeholder="Enter Your Email Id" title="0">
								</div>
							</div>
						</div>

						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="form-group">
								<label class="col-lg-2 col-md-12 col-sm-12 col-xs-12">Form
									Start Date</label>
								<div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
									<fmt:formatDate value="${form.formStartDate}" pattern="dd-MM-yyyy" var="parsedDateTime" type="both" />
									<c:out value="${parsedDateTime}" />
									
									
									
									<input name="form.formStartDate" class="form-control"
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
								<fmt:formatDate value="${form.formEndDate}" pattern="dd-MM-yyyy" var="parsedDateTime1" type="both" />
									<c:out value="${parsedDateTime1}" />
									
									<input name="form.formEndDate" class="form-control"
										id="rc_formEndDate" type="hidden"
										value="<c:out value="${parsedDateTime1}" />"
										title="0">
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
									
									</span>
									
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
								<c:out value="${form.hasInstructions}" />
					     </c:set>
					     <c:choose>
					     <c:when test='${inFlg.contentEquals("Y")}'>
					     
					     <button onclick='downloadFile(<c:out value="${form.id}" />)'>Download Instructions</button>
					</c:when>
					<c:otherwise> <c:out value="${form.id}" />
					     <button style="display: none;" onclick='downloadFile()'>Download Instructions</button> </c:otherwise>
						</c:choose>
						</div>
					</div></li> 


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
												<c:when test='%{triggerEvent.contentEquals("onselect")}'>
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







//  -  funtion to be executed whenever the next button is called from a form page that is not the last page

function formPageNextAction(nextpageid){


  // alert('nextpageid is::'+nextpageid);
   var currentpagectr = nextpageid-1;
   var validationpass = true;
   //alert('currentpagectr is::'+currentpagectr);
	var elements = document.forms["QForm"].elements;
	  for (i=0; i<elements.length; i++){
	   
	    if(elements[i].title<=currentpagectr){
	    //	alert('validating the field');
	    if(null!=elements[i].tabindex){
	    	if(elements[i].tabindex=='required'){
	    		if(elements[i].value==""){
	    			alert('field '+elements[i].name + ' cannot be empty');
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
	    			alert("fields '"+ elements[i].name +"' does not match the allowed pattern");
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
	rebuildArray();		
	//alert("after rebuildArray");
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
	var rcStartDate="";
	if(null!=document.getElementById("rc_formStartDate")){
		rcStartDate=document.getElementById("rc_formStartDate").value;
	}
	var rcEndDate = "";
	if(null!=document.getElementById("rc_formEndDate")){
		rcEndDate=rcStartDate=document.getElementById("rc_formStartDate").value;
	}	
	
	var dataArray = new Array;
	for ( var value in values) {
		dataArray.push(values[value]);
	}
	var form_id = <%=request.getParameter("formid")%>;	

	var bid = '<%=sesBid%>';
	var cid = '<%=sesCid%>';
	var formtemplateid = '<%=currentFormId%>';
	var forminstanceid='<%=formInstanceId%>';
	
	var payeeformIdQC =<%=payeeformIdQC%>;
	//alert('before preparing request argument');
	var argument = "values=" + dataArray + "&rcname=" + rcname
			+ "&rcdob=" + rcdob + "&rccontact=" + rccontact
			+ "&rcemail=" + rcemail + "&rcStartDate=" + rcStartDate
			+ "&rcEndDate=" + rcEndDate + "&payeeformIdQC="
			+
			payeeformIdQC+"&rccode="+rccode + "&submitShot="+submitShot;
	//alert('argument values are::'+argument);
			if(currentpagectr=="last"){
				window.location="processForm?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid + "&forminstanceid="+forminstanceid;
				
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
			xhttp.open("GET", window.location.origin+result+"/processForm?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid + "&forminstanceid="+forminstanceid, true);
			//xhttp.send();			
			//xhttp.open("GET", "processForm?"+ argument, true);
			xhttp.send();
			}


}

//   -  funtion to be executed whenever the next button is called from the Payer Basic Information page
function goToFormPages(){

	   var currentpagectr=0;
	   var validationpass = true;
	   // alert('currentpagectr is::'+currentpagectr);
	 	var elements = document.forms["QForm"].elements;
	 	 
	 	  for (i=0; i<elements.length; i++){
	 	   
	 	    if(elements[i].title<=currentpagectr){
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
		alert("You got the Captcha wrong, try again !");
		ja("#captcha").load(location.href + " #captcha");	
		captcha_match=false;
		
	} 
	
	else{
		
	captcha_match=true;
	
	jq("#tab-10-1-1").removeClass('is-active');
	
	jq("#tab-10-1").hide();
	
	jq("#tab-10-1").removeClass('is-open');
	
	jq("#tab-11-1-1").addClass('is-active');
	jq("#tab-11-1").addClass('is-open');
	jq("#tab-11-1").show();
	
	}
	/* No save calls at this time but builds form data based on the Basic Information data*/
	//rebuildArray();	
	}
	return false;
	
}


 	

//   -  funtion to be executed whenever the next button is called on the last page of the form
function formSubmitAction(){
	
	/* 	show the summary page, hide the current page */
	//alert('starting formSubmitAction ');
	
	//alert('finishing formSubmitAction ');
	/*submit t	he form to fetch the form summary page */
	var validationpass=true;
	var currentpagectr="last";

	var elements = document.forms["QForm"].elements;	
	  for (i=0; i<elements.length; i++){
	    	//alert('validating the field');
	    if(null!=elements[i].tabindex){
	    	if(elements[i].tabindex=='required'){
	    		if(elements[i].value==""){
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
    		//alert('pattern found and it is::'+elements[i].pattern);
    		//alert('element value is::'+elements[i].value)
    		//alert('pattern comparsion result is::'+new RegExp(elements[i].pattern).test(elements[i].value))
    		
    		if(elements[i].value!="" && !new RegExp(elements[i].pattern).test(elements[i].value)){
    			alert("fields '"+ elements[i].name +"' does not match the allowed pattern");
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
	    
	
	//alert('currentpagectr is.. '+currentpagectr);
//	alert('submitShotFlag is.. '+submitShotFlag);
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
	  // alert(elements[i].value);
	    var eid=elements[i].id;
	    
	  
	    if(eid==("")||eid==("captId")||eid==("captchaFromServer")||eid==("rc_name")||eid==("demo1")||eid==("rc_code")||eid==("rc_email")||eid==("rc_contact")||eid==("rc_formStartDate")||eid==("rc_formEndDate")||eid==("hiddenIdval")||eid==("currentFormId")||eid==("formInstanceId"))
	    {
	    
	  } 
	    else
	    	{
	    	
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
	  }		
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






//   -  funtion to be executed whenever the back button is called from a form page 

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
