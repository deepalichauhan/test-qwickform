<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.StateBean"%>

<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<%@page import="java.util.Base64"%>

<head>

<%
	Logger log = Logger.getLogger("PayerFlow.jsp");
	Integer sesBid = null, sesCid = null;
	CollegeBean collegeBean = new CollegeBean();

	String CollegeName=null, CollegeState=null;
	StateBean collegeStateBean=null;
	String payeeformIdQC = null,formid=null;
	String PayeeProfile = "";
	String clgName = "";
	String insCode = "";
	int pageCtr = 0;
	String redirectedFrom="";

	try {
		payeeformIdQC = (String) request.getParameter("form.id");

		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("collegeBean");

		clgName = (String) session.getAttribute("SelectedInstitute");
		insCode = (String) session.getAttribute("InstituteCode");

		PayeeProfile = (String) session.getAttribute("PayeeProfile");
		formid = ((String) session.getAttribute("formid")==null)?"":((String) session.getAttribute("formid")); 
		redirectedFrom= (String) session.getAttribute("redirectedFrom")==null?"":(String) session.getAttribute("redirectedFrom");
		log.info("redirectedFrom is::"+redirectedFrom);
		log.info("Sess BID ::" + sesBid);
		log.info(" sesCid ::" + sesCid); 
		log.info("Sess BID ::" + sesBid);
		log.info(" payeeformIdQC ::" + payeeformIdQC);
		log.info("form template id is ::" + formid );
		
		session.removeAttribute("reqVerFlag");
		request.removeAttribute("verified");
		request.removeAttribute("msg");
		session.removeAttribute("msg");
		String sesVerFlag = (String) session.getAttribute("reqVerFlag");
		String reqVerFlag = (String) request.getAttribute("verified");
		log.info("session attribute -sesVerFlag - removed and is now set to.."+sesVerFlag);
		log.info("request attribute -reqVerFlag - removed and is now set to.."+reqVerFlag);
		
%>
<%
	} catch (java.lang.NullPointerException e) {
%>

<script type="text/javascript">
	window.location = "PaySessionOut";
</script>
<%
	}
%>

<%
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();

	String qFormsIP = properties.getProperty("qFormsIP");
	String clientLogoLink = properties.getProperty("clientLogoLink");
	String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	collegeBean = (CollegeBean) session.getAttribute("collegeBean");
	log.info("collegeBean:" + collegeBean);
	


%>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>FormLink Forms</title> <script
		src="bower_components/jquery/jquery.min.js"></script>
	<link href="css/docs.min.css" rel="stylesheet" type="text/css" />
	<link href="css/bootstrap-select.css" rel="stylesheet" type="text/css" />

	<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<link href="css/wizard.css" rel="stylesheet" />
	<link href="css/style-tabbs.css" rel="stylesheet" />
	<link href="css/style-new.css" rel="stylesheet" />

	<script language="javascript" type="text/javascript"
		src="js/formjs/myScriptN.js"></script>


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
var signature_upload=true;
var photo_upload=true;
var file_upload=true;
var signature_uploaded=false;
var photo_uploaded=false;
var file_uploaded=false;


function getPosition(str, m, i) {
	   return str.split(m, i).join(m).length;
	}

</script>


	<style>
.not-padding {
	padding: 0
}
</style>
</head>

<body class="scrollTop">
	<div class="logoparts">
		<span class="clientlogo"> <!-- <img src="<s:property value='collegeBean.collegeLogo'/>" alt="" title="" width="100px" height="100px"> -->
			<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %> <img
			src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
			alt="" title=""></img> <%}else{ %> <%} %>


		</span> <span class="providerlogo"><img src="images/sabpaisa-logo.png"
			alt="" title=""></span>
	</div>
	<div class="container bg-img-x" style="margin: 15px auto;">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 bg-colors">
			<ul id="main" class="nav nav-tabs">
				<li role="presentation" class="wizard-step-indicator active" id="11"><a
					href="#1" onclick="return goToStart()">Get Started</a></li>
				<li role="presentation" class="wizard-step-indicator not-allowed"
					id="12"><a href="#formssection"
					onclick="return showFormDataOnTabClick()">Form Fill</a></li>
				<li role="presentation" class="wizard-step-indicator not-allowed"
					id="13"><a href="#messages">Summary</a></li>
				<!--<li role="presentation" class="wizard-step-indicator not-allowed" id="14"><a href="#finish">Payment Summary</a></li>-->
			</ul>
		</div>

		<div id="wizard1" class="wizard">



			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box " id="a_11">

				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 top-main-bg"
					id="1">
					<div class="pan-heading">FormLink</div>
					<div class="top-pad"></div>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="col-sm-12 labeling">
							<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12">
								<div class="university-logo">

									<% if(null!=collegeBean.getCollegeImage()){ %>
									<img
										src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
										alt="" title="" class="border-img"></img>
									<%
							 CollegeName = collegeBean.getCollegeName()==null?"":collegeBean.getCollegeName();
							
							 CollegeState = collegeBean.getStateBean()==null?"":collegeBean.getStateBean().getStateName();
							%>
									<a class="navbar-brand" href="#"><span>
											<%-- <%=CollegeName%> --%> <br> <%--  <%=CollegeState%> --%>
									</span></a>
									<%}else{ %>
									<img src="img\No-logo.jpg" alt="" title=""></img>
									<%} %>


									<!-- 	<img src="<s:property value="collegeBean.collegeLogo"/> "
										alt="" title="" class="border-img" /> -->



								</div>
							</div>
							<div class="col-lg-10 col-md-12 col-sm-12 col-xs-12">

								<div class="title-name">
									<c:out value="${collegeBean.collegeName}" />
									,

									<c:out
										value="${collegeBean.getStateBean()==null?'':collegeBean.getStateBean().getStateName()}" />
									<input type="hidden" id="bankId"
										value="<c:out value="${bankBean.bankId}" />" />
								</div>
								<label for="exampleInputEmail1"
									class="col-sm-3 col-form-label labeling">Select *</label>
								<div class="col-sm-6 ddown" id="">
									<select id="codeOfCollege" class="form-control selectpicker">
										<option value="">--Selected--</option>
										<c:forEach items="${beanPayerTypeLst}" var="payerBean">

											<option value="${payerBean.payer_type}"><c:out
													value="${payerBean.payer_type}"></c:out></option>

										</c:forEach>
										<c:forEach items="${actorList}" var="actorBean">

											<option value="${actorBean.actor_id}$actor"><c:out
													value="${actorBean.actor_alias}"></c:out></option>

										</c:forEach>
									</select>
								</div>
								<% if(null!=session.getAttribute("redirectedFrom") && "Bank".equals(session.getAttribute("redirectedFrom"))){ %>
								<div class="col-md-12 cntrs labeling-pad">
									<span id="btnHome"><button type="button" id="btn-goHome"
											onclick="gotoBankLandingPage(<%=sesBid %>)"
											class="wizard-goto btn btn-primary">Back</button> </span>

									&nbsp;&nbsp;&nbsp;&nbsp; <span id="btnClicks"><input
										type="button" id="btnSubmit-first" value="Submit"
										class="wizard-goto btn btn-primary" /></span>
								</div>
								<% } else {%>

								<div class="col-md-12 cntrs labeling-pad">
									<span id="btnClicks"><input type="button"
										id="btnSubmit-first" value="Submit"
										class="wizard-goto btn btn-primary" /></span>
								</div>

								<% } %>
							</div>

						</div>
						<div class="col-md-12 labeling impt">
							<ul>
								<li>Mandatory fields are marked with an asterisk (*)</li>
								<li>FormLink is a unique service powered by SabPaisa for
									paying fees, taxes, utility bill online to educational
									institutions, Online taxes, and/or any other
									corporates/institutions.</li>
							</ul>
						</div>
					</div>
				</div>





				<div id="2" class="acrd-tabs" style="display: none;">
					<ul class="accordion-tabs-minimal">
						<li class="tab-header-and-content"><a href="#"
							class="tab-link is-active">Pay Fees</a>
							<div class="tab-content is-open" style="display: block;">

								<div id="showFormList"></div>


								<div class="col-md-12 labeling impt">
									<ul>
										<li>Mandatory fields are marked with an asterisk (*)</li>
										<li>FormLink is a unique service powered by SabPaisa
											for paying fees, taxes, utility bill online to educational
											institutions, Online taxes, and/or any other
											corporates/institutions.</li>
									</ul>
								</div>

							</div></li>
						<li class="tab-header-and-content"><a href="#"
							class="tab-link">View Previous Transactions</a>
							<div class="tab-content">
								<!-- ANISH RAAT KA TOOFAAN -->
								<form action="viewPreviousTxn" id="previoustxnIdAction"
									name="previoustxnIdAction">
									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

										<div class="col-md-6 labeling impt not-padding">

											<%--  <strong> * Please enter One of the following Combinations</strong>
												<ul>
													<li>- Enter Date of Birth,Contact Number and Transaction ID,</li>
													 OR
													<li>- Enter Date of Birth,Contact Number and From Date, To Date</li>
												</ul>
											</div> --%>

											<div
												class="col-lg-12 col-md-12 col-sm-12 col-xs-12 not-padding">
												<div class="form-group">

													<%
												try {

													if (session.getAttribute("PayeeProfileName").toString().equals("Institute")) {
											%>
													<label class="col-lg-4 col-md-12 col-sm-12 col-xs-12">Date
														of Incorporation</label>
													<!-- <label class="text-uppercase-trans-top">Date of Birth</label> -->
													<%
												} else {
											%>

													<label class="col-lg-4 col-md-12 col-sm-12 col-xs-12">Date
														of Birth</label>
													<%
												}
												} catch (NullPointerException e) {
											%>

													<label class="col-lg-4 col-md-12 col-sm-12 col-xs-12">Date
														of Birth *</label>
													<script type="text/javascript">
												//window.location = "PaySessionOut.jsp";
												
											</script>
													<%
												}
											%>

													<div class="col-lg-10 col-md-12 col-sm-12 col-xs-12 ">
														<input type="hidden" name="clientId" value='<%=sesCid%>'>
															<input type="text" class="form-control" name="birthDate"
															id="idDOB" placeholder="DD-MM-YYYY"><img
																src="images/calendra.png" alt="Calendra"
																title="Calendra" width="20" height="20"
																class="cal-endra"
																onclick="javascript:NewCssCal ('idDOB','ddmmyyyy')"
																style="cursor: pointer" />
													</div>
												</div>
											</div>
											<div
												class="col-lg-12 col-md-12 col-sm-12 col-xs-12 not-padding">
												<div class="form-group">
													<label class="col-lg-4 col-md-12 col-sm-12 col-xs-12">Contact
														Number *</label>
													<div class="col-lg-10 col-md-12 col-sm-12 col-xs-12">
														<input class="form-control" placeholder="98X XXXX 123"
															pattern="[789][1-9]" type="tel" id="idMob"
															name="contactNo">
													</div>
												</div>
											</div>



										</div>
										<div class="col-lg-8 col-md-12 col-sm-12 col-xs-12">
											<table border="0" cellpadding="0" cellspacing="0"
												width="100%">

												<tr>

													<td style="width: 40%;">


														<div
															class="col-lg-12 col-md-12 col-sm-12 col-xs-12 not-padding">
															<div class="form-group">
																<label
																	class="col-lg-12 col-md-12 col-sm-12 col-xs-12 not-padding">Transaction
																	ID</label>
																<div
																	class="col-lg-12 col-md-12 col-sm-12 col-xs-12 not-padding">
																	<input type="text" class="form-control" name="transId"
																		id="idTxn" placeholder="Trans ID">
																</div>
															</div>
														</div>

													</td>
													<td style="padding-top: 54px;">


														<div
															class="col-lg-2 col-md-1 col-sm-2 col-xs-2 not-padding">
															<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2 divider">
																OR</div>
														</div>


													</td>
													<td style="padding-top: 26px; width: 30%;">



														<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

															<div class="form-group-tt">
																<label class="col-lg-12 col-md-12 col-sm-12 col-xs-12">Date
																	From</label>
																<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
																	<input type="text" class="form-control" name="fromDate"
																		id="idFrom" placeholder="DD-MM-YYYY"><img
																		src="images/calendra.png" alt="Calendra"
																		title="Calendra" width="20" height="20"
																		class="cal-endra"
																		onclick="javascript:NewCssCal ('idFrom','ddmmyyyy')"
																		style="cursor: pointer" width="20" height="20" />
																</div>
															</div>
														</div>
													</td>
													<td style="padding-top: 26px; width: 30%;">
														<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
															<div class="form-group-tt">
																<label class="col-lg-12 col-md-12 col-sm-12 col-xs-12">Date
																	To</label>
																<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
																	<input type="text" class="form-control" name="toDate"
																		id="idTo" placeholder="DD-MM-YYYY"> <img
																		src="images/calendra.png" alt="Calendra"
																		title="Calendra" width="20" height="20"
																		class="cal-endra"
																		onclick="javascript:NewCssCal ('idTo','ddmmyyyy')"
																		style="cursor: pointer" width="20" height="20">
																</div>
															</div>
														</div>
													</td>
												</tr>

											</table>
										</div>
										<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">


											<div
												class="col-lg-12 col-md-12 col-sm-12 col-xs-12 cntrs labeling-pad">
												<!-- <button type="submit" class="wizard-goto btn btn-primary rht-gap" id="btnClickst">Back</button> -->
												<!--<input type="submit" value="Go" class="wizard-next btn btn-primary" id="btnSubmit-third"/>-->
												<%-- 	<span id="stepsthree"><input type="submit" value="Go" class="wizard-next btn btn-primary" id="submit_button"/></span> --%>
												<!--<span id="stepstwo"><input type="submit" id="btnSubmited-recipt-" value="Go" class="wizard-next btn btn-primary"/></span>-->

												<button type="submit" id="submit_button"
													class="btn btn-success">View Transactions</button>


											</div>
										</div>
								</form>
								<div class="col-md-12 labeling impt">
									<ul>
										<li>Mandatory fields are marked with an asterisk (*)</li>
										<li>FormLink is a unique service powered by SabPaisa
											for paying fees, taxes, utility bill online to educational
											institutions, Online taxes, and/or any other
											corporates/institutions.</li>
									</ul>
								</div>


							</div></li>
					</ul>

				</div>

			</div>


			

			<div id="form_section"></div>


			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off"
				id="a_12" style="display: none;"></div>


			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off"
				id="a_13" style="display: none;"></div>



		</div>


	</div>
	</div>
	<div id="footer">

		<p>
			© Copyright 2016. powered by <a href="http://www.sabpaisa.com/"
				alt="SRS Live Technologies Pvt Ltd"
				title="SRS Live Technologies Pvt Ltd">SRS Live Technologies Pvt
				Ltd</a>.
		</p>
		<ul class="footer-ul">
			<li><a href="ContactUs.html" target="_blank">Contact Us</a></li>
			<li><a href="PrivacyPolicy.html" target="_blank">Privacy
					Policy</a></li>
			<li><a href="TermsAndConditions.html" target="_blank">Terms
					& Conditions</a></li>
			<li><a href="PrivacyPolicy.html" target="_blank">Payment
					Security</a></li>
			<li><a href="Disclaimer.html" target="_blank">Disclaimer</a></li>
		</ul>
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
                   	   alert("Please wait while your aadhaar is being verified.");
            	       var aUrl = "http://localhost:8080/DexServicesGit/verifyAadhaarDemographics/"+aadhaar+"/"+payerName+"/"+payerGender+"/"+payerMobile+"/"+payerPINCode+"/Y/Y";
    			       alert("aadhaar verify internal url is"+aUrl);
            	       var request = new XMLHttpRequest();
   			           request.open('GET', aUrl, false);  // `false` makes the request synchronous
   			           request.send(null);
   								
   						if (request.status === 200) 
   						{
   							  console.log(request.responseText);
   							  var msg=request.responseText;
   							alert (msg);
   							 if(msg=="Authenticated Successfully")
   							 {
   								
   								alert("Aadhaar is valid");
   								validationpass = true;
   							    
   						        }
   							
   							 else{
   								 
   	 						     alert("Invalid Aadhaar  No");
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
	
	
	function formSubmitAction(){
		
		/* 	show the summary page, hide the current page */
		
		var currentpagectr="last";
		var returnFlag=false;
		var validationpass=true;
		var nameOfBank = "";
	 	var bankBranch = "";
	 	var ifsc = "";
		 var responseForIfsc ="false";
		
		var elements = document.forms["QForm"].elements;	
	//	alert("calling the form Submit button ");	
	 	  for (i=0; i<elements.length; i++){
		 	    
		 	    	var e = elements[i].name;
					//changes for file upload
					
				    if(elements[i].name=="Sign"){
	 		 	    	alert("in element Sign");
	 		 	    	alert('mandatory flag for sign is..'+elements[i].required);
	 		 	    	if(!elements[i].required){
	 		 	    		alert("sign is optional");
	 		 	    		signature_upload = true;
	 		 	    	}
	 		 	    	else{
	 		 	    		alert("sign is mandatory");
	 		 	    	if(!signature_uploaded){
	 		 	    		alert("sign is mandatory but not uploaded");
	 					    signature_upload = false;
	 		 	        }
				        }
	 		 	    }
					
			//		alert("NAme of the element i " +i+"  "+elements[i].name+"  "+elements[i].value);					
	 		 	    if(elements[i].name=="Photo"){
	 		 	    	alert("in element Photo");
	 		 	    	alert('mandatory flag for sign is..'+elements[i].required);
	 		 	    	if(!elements[i].required){
	 		 	    		alert("sign is optional");
	 		 	    		photo_upload = true;
	 		 	    	}
	 		 	    	else
	 		 	    		{//alert("photo is mandatory");
	 		 	    		if(!photo_uploaded){
	 		 	    			alert("Photo is mandatory but not uploaded");
	 		 					photo_upload = false;
	 		 		 	    	}
	 		 	    		}
	 		 	    	
	 		    }	 	    
	 		 	    if(elements[i].name.includes("Upload")){
	 		 	    	alert("in element file_upload");
	 		 	    	if(!elements[i].required){
	 		 	    		alert("file is optional");
	 		 	    		file_upload = true;
	 		 	    	}
	 		 	    	else{
	 		 	    		alert("file is mandatory");
	 		 	    		if(!file_uploaded){
	 		 	    			alert("file is mandatory but not uploaded");
	 		 					file_upload = false;
	 		 					
	 		 		 	    	}
	 		 	    	}
	 		 	        
	 		    }	 	    		
	 	    		
					
					//changes for file upload
		 	    
		 	    if(elements[i].required!=null){
		 	    	
		 	    	if(elements[i].required){
		 	    		
		 	    		if(elements[i].value==""){
		 	    			/* console.log("Testing submit method ");
		 	    			alert("Testting "); */
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
					
			//alert("start codition i "+"  "+i+"  "+elements[i].name);
			if(elements[i].name==="Name of Bank"/* || elements[i+1].name==="Bank Branch"*/){	
		 	  // 	alert("Correct info "+elements[i].name + "  "+elements[i+1].name+"  "+elements[i+2].name);
				if(elements[i].name==="Name of Bank"){
		 	//	  console.log("Checking "+elements[i].name);
		 		   nameOfBank = elements[i].value;
		 		     
		 	   }
		 	  
		 	   if(elements[i+1].name==="Branch Name"){
		 	//	  alert("Checking bb "+elements[i+1].name);
		 		  bankBranch =  elements[i+1].value;
		 	   }
		 	   
		 	  //alert("Banks Details  "+nameOfBank + " branch "+bankBranch+ " "+elements[i+2].name);	    
				if(elements[i+2].name==="IFS Code"){
			//		console.log("Checking "+elements[i].name);
					 ifsc = elements[i+2].value;
				}
			//	alert("Complete info "+nameOfBank+ "  "+bankBranch+ "   "+ifsc);
				if(nameOfBank!="" && bankBranch!="" && ifsc!=""){
			//		console.log("------------------------------------->>>>>>>>> Final o/p");
					if(nameOfBank.match(" ")) {
						nameOfBank = nameOfBank.replace(/\s+/g, '%20');
					} 
					if(bankBranch.match(" ")) {
						bankBranch = bankBranch.replace(/\s+/g, '%20');
					} 
					
				//	var reponseForIfsc ="";
					console.log("Completed "+nameOfBank+ "  "+bankBranch+ "   "+ifsc);
					 var aUrl = "https://api.techm.co.in/api/getbank/"+nameOfBank+"/"+bankBranch;
				      console.log("ifsc verify internal url is "+aUrl);
						// requesting ifsc code
				      $.getJSON(aUrl, function (response) {
				    	 // alert(JSON.stringify(response));
				    	   
				    	  if(response.status === "success"){
			//		alert("Response status is success ");		
			    		  console.log("ifsc matching "+ifsc + "  "+response.data.IFSC);
				    	  if(ifsc == response.data.IFSC){
				    	 console.log("okdd"+response.data.IFSC);
					
				    	 responseForIfsc = "ok";
				//	alert("value for reso "+ responseForIfsc );

				    	  }else{
				    		  alert("Please provide valid IFSC Code");
						responseForIfsc = "false";
				    	  }}else{
				    		  alert("Please provide valid full Bank and Branch name ");
				    	  }
				         /*  $.each(data, function (i, field) {
				              var textNode = document.createTextNode(i+ " " +JSON.stringify(field));
				           //  alert(JSON.stringify(field));
				            // alert(response['IFSC']);
				          }); */
				      });
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
	
		
		  //if(validationpass==true){
		//		submitFormUsingAjax(submitShotFlag, currentpagectr);
		 // }
		if(validationpass==true){
			//alert("photo_upload=="+photo_upload+ "& signature_upload=="+signature_upload+"&file_upload"+file_upload);
			  if(!photo_upload || !signature_upload || !file_upload){
				  alert("Please upload all attachments");  
			  }
			  else{
				myFunction();
				alert("Redirecting on summary page ");
				if(responseForIfsc === "ok"){
			//	alert("Redirecting on summary pages ");
				submitFormUsingAjax(submitShotFlag, currentpagectr);}
				else{
				alert("Please verify the given information. ");
					}
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
				for ( var value in values) {
					dataArray.push(values[value]);
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
						var formtemplateid = document.getElementById("currentFormId").value;			
					//	var forminstanceid = document.getElementById("formInstanceId").value;
					//	alert('formtemplateid being sent in ajax call is::'+formtemplateid);
					//	alert('forminstanceid being sent in ajax call is::'+forminstanceid);		
						
						
						xhttp.open("GET", window.location.origin+result+"/processForm?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid + "&forminstanceid="+forminstanceid, true);
						
						
						xhttp.send();

		return false;
	}
	
	
	
	
	function goToStart(){
		var bid =<%=sesBid%>;
		var cid =<%=sesCid%>;
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
				
				
				

				var bid = '<%=sesBid %>';
				var cid = '<%=sesCid %>';

				
			
				
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
				


				var bid = '<%=sesBid %>';
				var cid = '<%=sesCid %>';						

				
				
				
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
			
			

			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';
	
			
			
			
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
			
			
			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';
			var formtemplateid = document.getElementById("currentFormId").value;			
			var forminstanceid = document.getElementById("formInstanceId").value;
			//alert('formtemplateid now is::'+formtemplateid);
			//alert('forminstanceid is::'+forminstanceid);	
			
			
			
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
				
				
				

				var bid = '<%=sesBid %>';
				var cid = '<%=sesCid %>';
				
						
				
				
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
			
			

			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';
			//alert('bid is::'+bid);
			//alert('cid is::'+bid);
			
			
			
			
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
											//alert('elements array is..'+elements);
											  for (i=0; i<elements.length; i++){
											
											    var eid=elements[i].id;
											   // alert(eid);
											  
											    if(eid==("")|| eid==("rc_aadhaar") || eid==("captId")||eid==("captchaFromServer")||eid==("rc_name")||eid==("demo1")||eid==("rc_code")||eid==("rc_email")|| eid==("rc_payerID")|| eid==("rc_contact")||eid==("rc_formStartDate")||eid==("rc_formEndDate")||eid==("hiddenIdval")||eid==("currentFormId")||eid==("formInstanceId") ||eid==("cb_aadhaar")||eid==("cb_pan")||eid==("mf"))
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
										
										

										
										var values = {};
										var options = {};

										function AddToArray(value, name, id,order) {
										
											value = value.split(",").join("");
											value = value.split("`").join("");
											value = value.split("=").join("");
											values[id] = id + "`" + name + "=" + value+"$"+order;
											// alert(JSON.stringify(values)); 

										}									
											
									
										
											
											     function backToForms(){
													var bid = '<%=sesBid%>';
													var cid = '<%=sesCid%>';
													var form_id='<%=formid %>';
													var redirectedFrom = '<%=redirectedFrom%>';
													
													if(redirectedFrom=='Bank'){
														window.location='StartUrl?bid='+bid+'&cid='+cid+"&currentSessionReturn=Y&redirectedFrom=Bank";
													}
													else{				
														window.location='StartUrl?bid='+bid+'&cid='+cid+"&currentSessionReturn=Y";
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
	<script src="js/formjs/myScriptN.js"></script>

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
				
				window.location = "Start.jsp?bid="+bid+"&cid=ALL&currentSessionReturn=Y&redirectedFrom=Bank";
				
			}
			
			function downloadFile(value)
			{
				
				window.location = "InstructionDownloadForm?reqFormId=" + value ;
				log.info("reqFormId:"+ value);
			//	window.location = "ApplicantReportsAllClientsBAPR?feeType=" + id;
	
				
			}


			function toggleAadhaarTextInput(){
				if(document.getElementById("cb_aadhaar").checked){
					document.getElementById("rc_aadhaar").readOnly=false;
					
				}
				else{
					document.getElementById("rc_aadhaar").readOnly=true;
					document.getElementById("rc_aadhaar").value="";
				}
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
	
			
	</script>
	<script>
function myFunction() {
   setTimeout(function(){ }, 5000);
}
</script>	

</body>
</html>
