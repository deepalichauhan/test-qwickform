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
<title>QwikForms Form Requested Summary for BURD</title>

<link href="css/docs.min.css" rel="stylesheet" type="text/css">
<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="css/wizard.css" rel="stylesheet" />
<link href="css/style-tabbs.css" rel="stylesheet">
<link href="css/style-new.css" rel="stylesheet">
<link rel="shortcut icon" href="img/favicon.ico">
<!--<script src="js/gallery.js"></script> -->

<%
	Integer sesBid = null, sesCid = null;
	String formId=null;
	Integer currentFormId = null;
	String formInstanceId = null;
	Integer optionsFieldsCount = 0;
	BeanFormDetails formBean=new BeanFormDetails();
	String formName=null;
	//CollegeBean collegeBean = new CollegeBean();
	Logger log = LogManager.getLogger("Payer Form Revival");
	int pageCtr = 0;
	try {
		formId=(String)request.getParameter("formid");
		sesBid = (Integer) session.getAttribute("bid");
		sesCid = (Integer) session.getAttribute("cid");
		currentFormId = (Integer) session.getAttribute("currentFormId");
		formInstanceId = (String) session.getAttribute("formInstanceId");
		formBean=(BeanFormDetails)session.getAttribute("formDetails");
		formName=formBean.getFormName();
		System.out.println("FormId: PayerFormRevival.jsp is:" + formId);
		System.out.println("currentFormId: PayerFormRevival.jsp is:" + currentFormId);
		System.out.println("formInstanceId: PayerFormRevival.jsp is:" + formInstanceId);
		log.info("temptoDelete.jsp::FormName for upcoming FormBean is:"+formName);
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
		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		//String qFormsIP = properties.getProperty("qFormsIP");
		String clientLogoLink = properties.getProperty("clientLogoLink");
		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
		CollegeBean collegeBean = null;
		//collegeBean = (CollegeBean) session.getAttribute("CollegeBean");

		SampleFormBean sfb = (SampleFormBean) session.getAttribute("sesCurrentFormData");
		if (null != sfb) {
			log.info("form bean in session found, invalidating it now");
			session.removeAttribute("sesCurrentFormData");
		} else {
			log.info("no form bean in session found");
		}
	%>

	<%
		//	int bid = Integer.parseInt((String) session.getAttribute("bid"));
		//System.out.print("BID ::" + bid);
		/* String collegeCode="";
		 session.setAttribute("collegeCode", collegeCode); */
	%>

<%
		/* 
		Integer sesBid = null;
		Integer sesCid = null;
		CollegeBean collegeBean = new CollegeBean();
		 */
		Integer payeeformIdQC = (Integer) session.getAttribute("currentFormId");
		String PayeeProfile = "";
		String clgName = "";
		String insCode = "";

		try {
			sesBid = (Integer) session.getAttribute("bid");
			sesCid = (Integer) session.getAttribute("cid");
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			PayeeProfile = (String) session.getAttribute("PayeeProfile");
			if (null == PayeeProfile || "".equals(PayeeProfile)) {
				PayeeProfile = (String) request.getParameter("PayeeProfile");
			}

			Double amount = (Double) session.getAttribute("feeAmt");
			clgName = (String) session.getAttribute("SelectedInstitute");
			insCode = (String) session.getAttribute("InstituteCode");
			System.out.println("RequestedSummary.jsp payeeformIdQC ::: "+payeeformIdQC);
			System.out.println("RequestedSummary.jsp PayeeProfile ::: "+PayeeProfile);

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
		System.out.println("Winny PayeeProfile:" + PayeeProfile);
		System.out.println("Winny payeeformIdQC:" + payeeformIdQC);
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
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="background:grey;">
		
		<table width="100%">

			<tr>
				<td width="70%">
					<div class="size" style="font-size: 20px; text-transform: uppercase; padding: 12px; color: #fff;">
						<% if(null!=collegeBean.getCollegeImage()){ %>
						<img
							src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
							alt="" title="" height="80" width="80"></img>
						<%}else{ %>
						<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
							height="60" />
						<%} %>

						<% if(null!=collegeBean.getCollegeName()){ %>

						<%=collegeBean.getCollegeName() %>
						<%}else{ %>
						SRS Live Technologies

						<%} %>
					</div>
				</td>
				<td width="30%" align="right">

					<div class="size1" style="font-size: 18px; padding: 12px; color: #fff;">
						
						<h5 style="font-size: 15px; font-weight: bold; padding: 12px; color: #fff;">
							For any Queries, contact us on:</br> sabpaisa@srslive.in | 01141733223
						</h5>
						
					</div>
				</td>
			</tr>
		</table>

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
													<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>' value='Photo Upload'
														type="hidden"
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
													<input name='<c:out value="${formStrList.formField.lookup_name}"/>'
														id='<c:out value="${formStrList.id}"/>' value='Signature Upload'
														type="hidden"
														<c:if test='${mandFlag==1}'> required='<c:out value="${formStrList.isMandatory}" />' </c:if>></input>
													
													<button onclick='window.open("PayerFileUpload?filetype=sign&fieldId=<c:out value='${formStrList.id}'/><c:if test='${mandFlag==1}'>&flag=<c:out value='${formStrList.isMandatory}' /></c:if>","File Upload Box","width=1024,height=1024")'
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
	
	rebuildArray();		
	//alert(JSON.stringify(values)); 
	//alert("after in submitFormUsingAjax rebuildArray "+  JSON.stringify(values));
	
	try
	{
	rccode = document.getElementById("rc_code").value;
	}
	catch(err){
		
	}
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
	//alert('form_id : '+form_id+' : bid : '+bid+' : cid : '+cid+' : formtemplateid : '+formtemplateid+' : forminstanceid : '+forminstanceid);
	//alert('PayeeProfile : '+payeeProfi+' : payeeformIdQC : '+payeeFormId);
	//alert("values=" + dataArray + "&payeeformIdQC="+payeeFormId+"&rccode="+rccode + "&submitShot="+submitShot+"&isFormBeingRevived=Y"+"&formrevivalinstanceid="+form_id);
	/* var argument = "values=" + dataArray + "&rcname=" + rcname
			+ "&rcdob=" + rcdob + "&rccontact=" + rccontact
			+ "&rcemail=" + rcemail + "&rcStartDate=" + rcStartDate
			+ "&rcEndDate=" + rcEndDate + "&payeeformIdQC="
			+payeeformIdQC+"&rccode="+rccode + "&submitShot="+submitShot+"&isFormBeingRevived=Y"+"&formrevivalinstanceid="+form_id; */
	
	var argument = "values=" + dataArray + "&payeeformIdQC="
			+payeeFormId+"&rccode="+rccode + "&submitShot="+submitShot+"&isFormBeingRevived=Y"+"&formrevivalinstanceid="+form_id;
	
	//alert('argument values are::'+argument);
			if(currentpagectr=="last"){ //
				window.location="processFormNewForBURD?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid+ "&forminstanceid="+forminstanceid+ "&payeeProfile="+payeeProfi;
				
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
			xhttp.open("GET", window.location.origin+result+"/processFormNewForBURD?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid + "&forminstanceid="+forminstanceid+ "&payeeProfile="+payeeProfile, true);
			//xhttp.send();			
			//xhttp.open("GET", "processForm?"+ argument, true);
			xhttp.send();
			}


}

/* // funtion to be executed whenever the next button is called from the Payer Basic Information page
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
	No save calls at this time but builds form data based on the Basic Information data
	//rebuildArray();	
	}
	return false;
	
} */


 	

// funtion to be executed whenever the next button is called on the last page of the form
function formSubmitAction(){
	
	/* 	show the summary page, hide the current page */
	//alert('starting formSubmitAction ');
	
	//alert('finishing formSubmitAction ');
	/*submit t	he form to fetch the form summary page */
	var validationpass=true;
	var currentpagectr="last";
	submitShotFlag="update";
	var elements = document.forms["QForm"].elements;	
	  for (i=0; i<elements.length; i++){
	    	//alert('validating the field');
	    if(null!=elements[i].tabindex){
	    	if(elements[i].tabindex=='required'){
	    		if(elements[i].value==""){
	    			//alert('field '+elements[i].name + ' cannot be empty');
	    			elements[i].focus();
	    			elements[i].style.color = "red";
	    			validationpass=false;
	    			break;
	    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
	    		}
	    		else{
	    			alert('field '+elements[i].name + ' can be empty');
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
