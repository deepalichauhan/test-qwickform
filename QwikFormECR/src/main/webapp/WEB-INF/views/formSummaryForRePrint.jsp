<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>

<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="java.util.Base64"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms Form Summary</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The styles -->
<link id="bs-css" href="css/bootstrap-cerulean.min.css" rel="stylesheet">

<link href="css/charisma-app.css" rel="stylesheet">
<link href='bower_components/fullcalendar/dist/fullcalendar.css'
	rel='stylesheet'>
<link href='bower_components/fullcalendar/dist/fullcalendar.print.css'
	rel='stylesheet' media='print'>
<link href='bower_components/chosen/chosen.min.css' rel='stylesheet'>
<link href='bower_components/colorbox/example3/colorbox.css'
	rel='stylesheet'>
<link href='bower_components/responsive-tables/responsive-tables.css'
	rel='stylesheet'>
<link
	href='bower_components/bootstrap-tour/build/css/bootstrap-tour.min.css'
	rel='stylesheet'>
<link href='css/jquery.noty.css' rel='stylesheet'>
<link href='css/noty_theme_default.css' rel='stylesheet'>
<link href='css/elfinder.min.css' rel='stylesheet'>
<link href='css/elfinder.theme.css' rel='stylesheet'>
<link href='css/jquery.iphone.toggle.css' rel='stylesheet'>
<link href='css/uploadify.css' rel='stylesheet'>
<link href='css/animate.min.css' rel='stylesheet'>

<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
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

<body onload="ExecuteFun();">

	<%
	SampleFormBean formBean=new SampleFormBean();
	formBean=(SampleFormBean)session.getAttribute("form");
	%>


	<%
				Logger log = LogManager.getLogger("Form Summary Page");
	
	String PayeeProfile = null, dob = null, contact = null, formid = null;
	Integer sesBid = null, sesCid = null;
	CollegeBean collegeBean = new CollegeBean();
	Integer currentFormId = null;
	String formInstanceIdSummary = null;
	String formnumber=null;
	HashMap<Integer, String> formDataMap=null;
	String value=null;	
	try {
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		PayeeProfile = (String) session.getAttribute("PayeeProfile");
		formid = ((String) session.getAttribute("formid") == null) ? "" : ((String) session
				.getAttribute("formid"));
		dob = ((String) session.getAttribute("dob") == null) ? "" : ((String) session.getAttribute("dob"));
		contact = (String) session.getAttribute("contact") == null ? "" : (String) session
				.getAttribute("contact");
		currentFormId = (Integer) session.getAttribute("currentFormId");
		formnumber = (String) session.getAttribute("formnumber");
		formInstanceIdSummary = (String) session.getAttribute("formInstanceId");
		formDataMap=(HashMap<Integer, String>)session.getAttribute("sesCurrentFormMap");
		/* log.info("FormSummaryNew.jsp::currentFormId is:" + currentFormId);
		log.info("FormSummaryNew.jsp::formInstanceId is:" + formInstanceIdSummary);
		log.info("FormSummaryNew.jsp::formNumber is:" + formnumber); */
	/* 	value=formDataMap.get(15645);
		log.info("value is "+value);
//		log.info("value is "+value);
		if(value==null){
			log.info("inside condition");
			value=formDataMap.get(15712);
		}
		 if(value==null){
			log.info("inside condition PG APPLICATION");
			value=formDataMap.get(15883);
		} 
		log.info(" after value is "+value);
		value=value.substring(value.indexOf("=")+1, value.indexOf("$")); */
		if (formid == "") {
			formid = formInstanceIdSummary;
		}
		

	} catch (NullPointerException e) {
%>
<script type="text/javascript">
	window.location = "paySessionOut";
</script>
<%
	}
%>
<%
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();

	String QuickCollectIP = properties.getProperty("quickCollectIP");
	String clientLogoLink = properties.getProperty("clientLogoLink");
	String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	String imageFileURL = properties.getProperty("cobImage");
%>


	<%
		//String cid=(String)session.getAttribute("cid");
		//Integer cid1=Integer.parseInt(cid);
		//String bid=(String)session.getAttribute("bid");
		//Integer bid1=Integer.parseInt(bid);
		/* Integer cid=Integer.parseInt((String)session.getAttribute("cid"));
		 Integer bid=Integer.parseInt((String)session.getAttribute("bId")); */
	%>
	<!-- <div class="container">
		<div class="logoparts">
			<span class="clientlogo"><img src="images/emailwala.png"
				alt="" title="" width="100px" height="39px"></span> <span
				class="providerlogo"><img src="images/sabpaisa-logo.png"
				alt="" title="" width="100px" height="39px"></span>
		</div>
	</div> -->

	<style>
.container {
	background-color: #f8fbff;
	padding-top: 10px;
}

table.table-td tr.panel-heading {
	background: #0072bc;
}

table.table-td tr.panel-heading td {
	color: #fff;
	font-weight: bold;
	text-align: center;
	font-size: 14px;
}

.table-td td {
	border: 1px solid #eaeaea;
}

.table-td {
	border-right: 1px solid #0072bc;
	border-left: 1px solid #0072bc;
	border-bottom: 1px solid #0072bc;
}

.logoparts {
	width: 100%;
	padding: 20px 8px 0 8px;
	margin: 0;
	display: inline-block;
	vertical-align: middle;
	line-height: 16px;
}

.clientlogo {
	text-align: left;
}

.providerlogo {
	text-align: right;
	float: right;
}

.form-check-label {
	text-align: center;
	display: block;
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
	<div class="top-headers">
		<div class="container nopadding">

			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
			style="color: #3399ff;">

			<table align="center" width="100%">
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
						<% if(null!=collegeBean.getCollegeName()){ %> <%-- <img
							src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
							alt="" title="" height="60" width="80"></img> --%>
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
			</table>
		</div>

		</div>
	</div>
	<div class="container bg-img-x" style="margin: 15px auto;">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 top-main-bg-table"
			style="padding: 0;">
			<div class="form-group-banks-step3">

				<div class="bs-example-td">

					<table class="table-td" style="width: 100%;">
						<tr class="panel-heading">
							<td colspan="2">Captured Form Data</td>
						</tr>

						<%
							if (null != formBean.getPhotograph()) {
						%>

						<tr class="lightgray">
							<td colspan="2">
								<div class="form-group">
									<div class="university-logo">
										<p class="top-mn-header">Applicant Photograph</p>

										<%
											try {
										%>

										<img
											src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getPhotograph())%>"
											alt="" title="" width="125px" height="150px" class="flleft">

										<%
											} catch (Exception ex) {
													ex.printStackTrace();
												}
										%>

									</div>
								</div>
							</td>

						</tr>

						<%
							}
						%>
					</table>

					<table class="table-td" style="width: 100%; align-items: left" >
						
						<c:forEach items="${formViewData}" var="formViewData">
							<tr>
								<td class="wd-four"><c:set var="nextTab">
										<c:out value="${formViewData.label}" />
									</c:set> <c:choose>
										<c:when test="${nextTab=='PageBreak'}">
										</c:when>
										<c:otherwise>
											<strong><c:out value="${formViewData.label}" /></strong>
										</c:otherwise>
									</c:choose></td>
								<td class="wd-six"><c:set var="nextTab1">
										<c:out
											value="${not empty formViewData.value ? formViewData.value.substring(value.indexOf('*')+0) : 'Empty'}" />
									</c:set> <c:set var="fieldValue">
										<c:out
											value="${formViewData.value.substring(value.indexOf('*')+0)}" />
									</c:set> 
									<c:set var="fileURL">
										<c:out value='<%=imageFileURL%>' />
									</c:set> 
									<c:choose>
										<c:when test="${nextTab1=='Empty'}">
											<c:out value=" " />
										</c:when>
										<c:when test="${fieldValue.indexOf('QwikFormContent')==-1}">
											<%-- <strong><c:out value="${fieldValue}" /></strong> --%>
											<c:choose>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload1'}">
																									
												<%if(null!=formBean.getFile_Path1()){ 
												%>
													<c:set var="fileName1"
														value='<%=formBean.getFile_Path1().substring(formBean.getFile_Path1().lastIndexOf("/") + 1,formBean.getFile_Path1().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path1()%>" />' target="_blank" >
													<strong><c:out
																value="${fileName1}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload2'}">
												<%if(null!=formBean.getFile_Path2()){ 
												%>
													<c:set var="fileName2"
														value='<%=formBean.getFile_Path2().substring(formBean.getFile_Path2().lastIndexOf("/") + 1,formBean.getFile_Path2().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path2()%>" />' target="_blank">
													<strong><c:out
																value="${fileName2}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload3'}">
												<%if(null!=formBean.getFile_Path3()){ 
												%>
													<c:set var="fileName3"
														value='<%=formBean.getFile_Path3().substring(formBean.getFile_Path3().lastIndexOf("/") + 1,formBean.getFile_Path3().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path3()%>" />' target="_blank">
													<strong><c:out
																value="${fileName3}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload4'}">
												<%if(null!=formBean.getFile_Path4()){ 
												%>
													<c:set var="fileName4"
														value='<%=formBean.getFile_Path4().substring(formBean.getFile_Path4().lastIndexOf("/") + 1,formBean.getFile_Path4().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path4()%>" />' target="_blank">
													<strong><c:out
																value="${fileName4}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload5'}">
																									
												<%if(null!=formBean.getFile_Path5()){
													%>
													<c:set var="fileName5"
														value='<%=formBean.getFile_Path5().substring(formBean.getFile_Path5().lastIndexOf("/") + 1,formBean.getFile_Path5().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path5()%>" />' target="_blank"><strong><c:out
																value="${fileName5}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload6'}">
												<%if(null!=formBean.getFile_Path6()){ 
												%>
													<c:set var="fileName6"
														value='<%=formBean.getFile_Path6().substring(formBean.getFile_Path6().lastIndexOf("/") + 1,formBean.getFile_Path6().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path6()%>" />' target="_blank"><strong><c:out
																value="${fileName6}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload7'}">
												<%if(null!=formBean.getFile_Path7()){ 
												%>
													<c:set var="fileName7"
														value='<%=formBean.getFile_Path7().substring(formBean.getFile_Path7().lastIndexOf("/") + 1,formBean.getFile_Path7().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path7()%>" />' target="_blank"><strong><c:out
																value="${fileName7}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload8'}">
												<%if(null!=formBean.getFile_Path8()){ 
												%>
													<c:set var="fileName8"
														value='<%=formBean.getFile_Path8().substring(formBean.getFile_Path8().lastIndexOf("/") + 1,formBean.getFile_Path8().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path8()%>" />' target="_blank"><strong><c:out
																value="${fileName8}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload9'}">
												<%if(null!=formBean.getFile_Path9()){ 
												%>
													<c:set var="fileName9"
														value='<%=formBean.getFile_Path9().substring(formBean.getFile_Path9().lastIndexOf("/") + 1,formBean.getFile_Path9().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path9()%>" />' target="_blank"><strong><c:out
																value="${fileName9}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:when
												test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload10'}">
												<%if(null!=formBean.getFile_Path10()){ 
												%>
													<c:set var="fileName10"
														value='<%=formBean.getFile_Path10().substring(formBean.getFile_Path10().lastIndexOf("/") + 1,formBean.getFile_Path10().length())%>' />
													<a href='<c:out value="<%=formBean.getFile_Path10()%>" />' target="_blank"><strong><c:out
																value="${fileName10}" /></strong></a>
												
												<% } %>
												
											</c:when>
											<c:otherwise>
												<strong> <c:out
														value="${formViewData.value.substring(value.indexOf('*')+0)}" />
												</strong>
											</c:otherwise>
										</c:choose>
										</c:when>
										
										<c:otherwise>
											<a  href='<c:out value="${fileURL}${fieldValue}" />'  target="_blank">
												<c:out value='${fieldValue.substring((fieldValue.lastIndexOf("/")+1), fieldValue.length())}' />
											</a>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
						
						<tr>
							<td class="wd-four">Form Id</td>
							<td class="wd-six">"<%=formnumber%>"</td>
						</tr>
						
						<tr>
							<td class="wd-four">Name:</td>
							<td class="wd-six"><c:out value="${form.name}" /></td>
							
						</tr>
						<tr>
							<td class="wd-four">Contact</td>
							<td class="wd-six"><c:out value="${form.contact}" /></td>
						</tr>
						
						<tr>
							<td class="wd-four">Email</td>
							<td class="wd-six"><c:out value="${form.email}" /></td>
						</tr>
						
						<tr>
							<td class="wd-four"><strong>Amount to Pay</strong></td>
							<td class="wd-six"><strong>Rs. <%
										if (sesCid == 11 && sesBid == 2 && PayeeProfile.contentEquals("NIT J students (Semester fee)")) {
									%> <%=request.getParameter("amt")%> <%
		 								} else {
											 %> <c:out value="${form.transAmount}" /> <%
											 	}
										 %>
							</strong></td>
						</tr>
						<tr>
							<td class="wd-four"><strong>Payment Status</strong></td>
							<td class="wd-six"><strong><c:out value="${transStatus}" /></strong></td>
						</tr>
						<tr>
							<%if(null!=formBean.getSignature()){ %>
							<td class="wd-four">Signature</td>
							<td class="wd-six">
								<%
											try {
										%> <img id="photo"
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getSignature())%>"
								alt="" title="" width="120px" height="50px" class="flleft">



								<%
											} catch (Exception ex) {
										}
		 							%>
							</td>

							<%} %>
						</tr>
					</table>
					
					<div class="form-group">
						<div class="offset-sm-2 col-sm-12"
							style="padding-bottom: 20px; text-align: center;">
							<!--<button type="submit" class="wizard-prev btn btn-primary">Details Not Ok</button>-->


							<div style="display: inline-block">

								<form name="goBackForms" id="backGo" class="form-horizontal"
									action="" method="post">

									<input type="hidden" name="PayeeProfile" class="form-control"
										value="<%=PayeeProfile%>"> <input type="hidden"
										name="bid" class="form-control" value="<%=sesBid%>"> <input
										type="hidden" name="cid" class="form-control"
										value="<%=sesCid%>"> <input type="hidden"
										name="contact" class="form-control" value="<%=contact%>">
									<input type="hidden" name="dob" class="form-control"
										value="<%=dob%>"> <input type="hidden" name="formid"
										class="form-control" value="<%=formid%>">
									<%-- <span><button
											type="submit" class="wizard-goto btn btn-primary smbuttonss"
											onClick="backToForms()">Go Back</button></span> --%>
									<br>
									<span><button type="button"
											class="wizard-goto btn btn-primary smbuttonss"
											onClick="window.print()">Print</button></span>
								</form>
							</div>

							<div>

								<span> &nbsp;&nbsp;&nbsp; </span>
								<div>
									<c:choose>
									<c:when test='${formDetails.getLife_cycle().contentEquals("yes")}'>
										<span>
											<button type="submit"
												onclick='window.location="submitFormData?bid=<%=sesBid%>&cid=<%=sesCid%>&formid=<%=currentFormId%>&forminstanceid=<%=formInstanceIdSummary%>"'
												class="wizard-goto btn btn-primary smbuttonss">Submit</button>
										</span>
									</c:when>

									<c:otherwise>
										<%-- <span id="proceedForward" class="blcking" style="display: none"> <span id="ProceedForPayment">
												<button type="submit"
													onclick='window.location="processTrans?bid=<%=sesBid%>&cid=<%=sesCid%>&formid=<%=currentFormId%>&forminstanceid=<%=formInstanceIdSummary%>"'
													class="wizard-goto btn btn-primary smbuttonss">Proceed</button>
												<button class="btn btn-info smbuttonss" type="button" onclick='AddTransToCart("<%=formInstanceIdSummary%>")'>Add To Cart</button>
										</span>
										</span> --%>
									</c:otherwise>
									</c:choose>
								</div>


							</div>
						</div>
					</div>


				</div>


			</div>

		</div>



		<!-- external javascript -->

		<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

		<!-- library for cookie management -->
		<script src="js/jquery.cookie.js"></script>
		<!-- calender plugin -->
		<script src='bower_components/moment/min/moment.min.js'></script>
		<script src='bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
		<!-- data table plugin -->
		<script src='js/jquery.dataTables.min.js'></script>

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
		<script src="js/charisma.js"></script>

		<script type="text/javascript">
		function verifyPages() {

			var cid1 =
	<%=sesCid%>
		;
			var bid1 =
	<%=sesBid%>
		;

			if (cid1 == 1 && bid1 == 1) {
				window.location = "GetForms";
			} else if (cid1 == 2 && bid1 == 2) {
				window.location = "nitjFeesPaymentForm.jsp";
			} else if (cid1 == 3 && bid1 == 3) {
				window.location = "noidaPage.jsp";
			}

		}

		function ExecuteFun() {

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
					window.location = "PaySessionOut.jsp";
				}

			}, 120000);
		}
		
		
		function showProceed(){
			//alert('in the function');
			
			  if (document.getElementById('termsagreement').checked) 
			  {
				 // alert('checked is'+document.getElementById('termsagreement').checked);
			      document.getElementById('proceedForward').style.display = 'inline-block';
			      
			  } else {

				//  alert('in else checked is'+document.getElementById('termsagreement').checked);
				  document.getElementById('proceedForward').style.display = 'none';
			  }
		}			
		
		/* // This function to be called from formsummaryrevival.jsp */
		function backToForms(){
			
			var r = confirm("By Going back you may lose some of the data you want to enter, are you sure?");
			if(r == true){
			 
			
			 document.goBackForms.action="getPayerFormsById";
				document.getElementById("backGo").submit();
			
			}	
			else{
				return false;
			}
		    }
	</script>
</body>
</html>
