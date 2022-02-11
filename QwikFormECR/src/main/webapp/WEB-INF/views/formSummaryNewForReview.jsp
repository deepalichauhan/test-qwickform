<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.SampleFormView"%>

<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="java.util.Base64"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page isELIgnored="false"%>

<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms</title>
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
			formBean=(SampleFormBean)request.getAttribute("form");
			
			/* ArrayList<SampleFormView> formViewData = new ArrayList(); */
				Logger log = LogManager.getLogger("Form Summary New For Reviewed");
			
				String PayeeProfile = null, dob=null, contact=null,formid=null;
				Integer sesBid = null, sesCid = null ;
				CollegeBean collegeBean = new CollegeBean();
				Integer currentFormId=null;
				String formInstanceIdSummary=null;
				String flag=null, flag1=null; 
				String currency = null;
				String formnumber=null;
				HashMap<Integer, String> formDataMap=null;
				String value=null;
				try {
					/* formViewData=(ArrayList<SampleFormView>)session.getAttribute("formViewData"); */
					collegeBean=(CollegeBean)session.getAttribute("CollegeBean");
					sesBid = (Integer) request.getAttribute("BankId");
					sesCid = (Integer) request.getAttribute("CollegeId");
					PayeeProfile = (String) session.getAttribute("PayeeProfile");
					currentFormId = (Integer) request.getAttribute("currentFormId");
					
					formInstanceIdSummary = (String) request.getAttribute("formInstanceId");
					formnumber = formBean.getFormNumber();
					formDataMap=(HashMap<Integer, String>)session.getAttribute("sesCurrentFormMap");
					flag=(String)request.getAttribute("veriflag");
					flag1=(String)request.getAttribute("veriflag1");
					
					formid = ((String) session.getAttribute("formid")==null)?"":((String) session.getAttribute("formid"));			
					dob = ((String) session.getAttribute("dob")==null)?"":((String) session.getAttribute("dob"));			
					contact = (String) session.getAttribute("contact")==null?"":(String) session.getAttribute("contact");	
					
					log.info("Form Summary New For Reviewed::collegeBean with collegecode  is: "+collegeBean.getCollegeCode());
					log.info("Form Summary New For Reviewed::sesBid  is: "+sesBid);
					log.info("Form Summary New For Reviewed::sesCid  is: "+sesCid);
					log.info("Form Summary New For Reviewed::PayeeProfile  is: "+PayeeProfile);
					log.info("Form Summary New For Reviewed::currentFormId is: "+currentFormId);
					log.info("Form Summary New For Reviewed::formInstanceId is: "+formInstanceIdSummary);
					log.info("Form Summary New For Reviewed::formnumber is: "+formnumber);
					
					log.info("Form Summary New For Reviewed::flag for hasInstruction is:"+flag1);
					log.info("Form Summary New For Reviewed::flag for movetoPG is:"+flag);
					
					log.info("Form Summary New For Reviewed::formBean.FormId is:"+formBean.getFormId());
					
					
					
					if(formid==""){				
						formid=formInstanceIdSummary;
					}
					
					
				} catch (NullPointerException e) {
			%>
	<script type="text/javascript">
				window.location = "paySessionOut";
			</script>
	<%
	session.removeAttribute("form");
				}
			%>
	<%
				AppPropertiesConfig appProperties = new AppPropertiesConfig();
				Properties properties = appProperties.getPropValues();

				String qFormsIP = properties.getProperty("qFormsIP");
				String clientLogoLink = properties.getProperty("clientLogoLink");
				String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
				String cCodeForMagicBricks=properties.getProperty("cCodeForMagicBricks");
				String cCodeForTVS = properties.getProperty("cCodeForTVS");
				String cIdForNPCI = properties.getProperty("cIdForNPCI");
				String fileUploadPathNew=properties.getProperty("fileUploadPathNew");
				String imageFileURL = properties.getProperty("cobImage");
				String filePath="null",fileName="";
				if(null!=formBean.getFile_Path1()){
					filePath=imageFileURL+formBean.getFile_Path1();
					fileName=formBean.getFile_Path1().substring(formBean.getFile_Path1().lastIndexOf("/")+1, formBean.getFile_Path1().length());
				}
				if(null!=session.getAttribute("uploadedfiles")){
					session.removeAttribute("uploadedfiles");
				}
				log.info("Form Summary New For Reviewed::filePath for filePath is:"+filePath);
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
	<!-- <form id="QForm1" method="post"> -->
	<input type="hidden" name="currentFormId" id="currentFormId"
		value="<%=currentFormId%>"></input>
	<input type="hidden" name="formInstanceId" id="formInstanceId"
		value="<%=formInstanceIdSummary%>"></input>

	<div class="container bg-img-x" style="margin: 15px auto;">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 top-main-bg-table"
			style="padding: 0;">
			<div class="form-group-banks-step3">

				<div class="bs-example-td">

					<table class="table-td" style="width: 100%;">
						<tr class="panel-heading">
							<td colspan="2">Please review the Captured Form Data</td>
						</tr>


						<%if(null!=formBean.getPhotograph()){ %>

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

										<%} catch (Exception ex) {
														ex.printStackTrace();
													}
												%>

									</div>
								</div>
							</td>

						</tr>

						<%}%>
					</table>

					<table class="table-td" style="width: 100%; align-items: left">


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
									</c:set> <c:choose>
										<c:when test="${nextTab1=='Empty'}">
											<c:out value=" " />
										</c:when>
										<c:otherwise>
											<strong><c:out value="${fieldValue}" /></strong>
										</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
						<tr>
							<%if(null!=formBean.getFile_Path1()){ %>
							<td class="wd-four">Uploaded File</td>
							<td class="wd-six">
								<%
											try {
										%> <%-- <img id="photo"
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getSignature())%>"
								alt="" title="" width="120px" height="50px" class="flleft"> --%>
								<img height="80" width="160"
								src='<c:out value="<%=filePath%>" />'> <%
											} catch (Exception ex) {
										}
		 							%>
							</td>

							<%} %>
						</tr>
						<tr>
							<td class="wd-four">Form Id</td>
							<td class="wd-six"><%=formnumber%></td>
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

						<%
							if (!sesCid.equals(cIdForNPCI) || sesCid != Integer.parseInt(cIdForNPCI)) {
						%>		
						<c:if test="${0.0!=lateFeeAmount}">
							<tr>
								<td class="wd-four">Late Fee Amount</td>
								<td class="wd-six"><c:out value="${lateFeeAmount}" /></td>
							</tr>
						</c:if>


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
						<%
							}
						%>
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
						
						<%if(sesCid.equals(cIdForNPCI) || sesCid==Integer.parseInt(cIdForNPCI)) {%>
						<tr><td colspan="2">Corporate Information</td></tr>
							<tr>
								<td class="wd-four">Corporate Name</td>
								<td class="wd-six">SRS Live Technologies Pvt Ltd</td>
							</tr>
							<tr>
								<td class="wd-four">Utility Number</td>
								<td class="wd-six">SRS123456789</td>
							</tr>
							<tr><td colspan="2"><u><b>Note:</b></u> Your in the process of registration of E-Mandate. Please process to continue the registration 
							process. In case of any discrepancy found in the above mentioned fields you may cancel or go back to edit 
							the required fields</td></tr>
						<%} %>
						
					</table>

					<div class="form-check" style="padding-top: 20px;">
						<label class="form-check-label"> <input
							class="form-check-input" type="checkbox" id="termsagreement"
							onclick="showProceed()"> Please agree with the <a
							href="TermsAndConditions.html" target="_new"> terms &
								condition </a>, and check the checkbox to proceed further
						</label>
					</div>
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
										class="form-control" value="<%=formid%>"> <span><button
											type="button" class="wizard-goto btn btn-primary smbuttonss"
											onClick="backToForms()">Go Back</button></span>
									<%-- <span><button
											type="button" class="wizard-prev btn btn-primary rht-gap"
											onClick='window.location="getPayerFormsById1?formid=<%=formBean.getFormId()%>&bid=<%=sesBid %>&cid=<%=sesCid %>&PayeeProfile=<%=PayeeProfile%>"'>Previous</button></span>
 --%>
									<span style="padding-left: 30px;">
										<button type="button"
											class="wizard-goto btn btn-primary smbuttonss"
											onClick="window.print()">Print</button>
									</span>
								</form>
							</div>

							<div>

								<span> &nbsp;&nbsp;&nbsp; </span>
								<div>


									<c:choose>
										<c:when
											test='${formDetails.getLife_cycle().contentEquals("yes")}'>
											<span>
												<button type="submit"
													onclick='window.location="submitFormData?bid=<%=sesBid%>&cid=<%=sesCid%>&formid=<%=currentFormId%>&forminstanceid=<%=formInstanceIdSummary%>"'
													class="wizard-goto btn btn-primary smbuttonss">Submit</button>
											</span>
										</c:when>
										<c:otherwise>
											<span id="proceedForward" class="blcking"
												style="display: none"> <span id="ProceedForPayment">
													<%
												if(collegeBean.getCollegeCode().equalsIgnoreCase(cCodeForMagicBricks) 
														|| collegeBean.getCollegeCode().equalsIgnoreCase(cCodeForTVS)){
											%>
													<button type="submit"
														onclick='window.location="SaveViewForm?bid=<%=sesBid%>&cid=<%=sesCid%>&formid=<%=currentFormId%>&forminstanceid=<%=formInstanceIdSummary%>"'
														class="wizard-goto btn btn-primary smbuttonss">Save
														Data</button> <%
												}else if(flag.contentEquals("yes") && flag1.contentEquals("yes")){
											%>
													<button type="submit"
														onclick='window.location="SaveViewForm?bid=<%=sesBid%>&cid=<%=sesCid%>&formid=<%=currentFormId%>&forminstanceid=<%=formInstanceIdSummary%>"'
														class="wizard-goto btn btn-primary smbuttonss">Save
														Data</button> <%
												}else{
												%>
													<button type="submit"
														onclick='window.location="processTransWithReviewedLink?bid=<%=sesBid%>&cid=<%=sesCid%>&formid=<%=currentFormId%>&forminstanceid=<%=formInstanceIdSummary%>"'
														class="wizard-goto btn btn-primary smbuttonss">Proceed</button>
													<% } %> <!--	<button class="btn btn-info smbuttonss" type="button" onclick='AddTransToCart("<%=formInstanceIdSummary%>")'>Add To Cart</button> -->
											</span>
											</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- </form> -->


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
					/* var checker = document.getElementById('QForm1');
					checker.reset(); */
					
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
				
				// This function to be called from formsummaryrevival.jsp
				function backToForms(){
					
					var r = confirm("By Going back you may lose some of the data you want to enter, are you sure?");
					if(r == true){
					 var PayerProfile = '<%=PayeeProfile%>';
					var bid = '<%=sesBid%>';
					var cid = '<%=sesCid%>';	
					var contact ='<%=contact%>';
					var dob='<%=dob%>';
					var formid='<%=formid%>';
					
					if(formid==''){				
						formid='<%=formInstanceIdSummary%>';
					}
				
					window.location='getPayerFormsById?formid='+formid+'&bid='+bid+'&cid='+cid+'&PayeeProfile='+PayerProfile+'&contact='+contact+'&dob='+dob;
					 
					 
					
					 document.goBackForms.action="getPayerFormsById";
						document.getElementById("backGo").submit();
					
					}	
					else{
						return false;
					}
				    }
				
				function goToPreviousForms(){
					alert("work in goToPreviousForms()");
					var formid='<%=formBean.getFormId()%>';
					alert(formid);
					var PayerProfile = '<%=PayeeProfile%>';
					alert(PayerProfile);
					var bid = '<%=sesBid%>';
					alert(bid);
					var cid = '<%=sesCid%>';	
					alert(cid);
					//http://localhost:8081/QwikForms/getPayerFormsById?formid=295&bid=3&cid=260&PayeeProfile=Tata1
							alert("useable URL is "+'getPayerFormsById?formid='+formid+'&bid='+bid+'&cid='+cid+'&PayeeProfile='+PayerProfile);
					window.location='getPayerFormsById?formid='+formid+'&bid='+bid+'&cid='+cid+'&PayeeProfile='+PayerProfile;
				}
			</script>
</body>


</html>