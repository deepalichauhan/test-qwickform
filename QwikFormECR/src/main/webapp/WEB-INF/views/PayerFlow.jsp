<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page
	import="org.apache.logging.log4j.Logger, org.apache.logging.log4j.LogManager"%>

<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.StateBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page import="java.util.Base64"%>

<head>

<%
	Logger log = LogManager.getLogger("Dynamic Payer Flow");
	
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
	String cobImage=""; 

	try {
		payeeformIdQC = (String) request.getParameter("form.id");
		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");

		clgName = (String) session.getAttribute("SelectedInstitute");
		insCode = (String) session.getAttribute("InstituteCode");

		PayeeProfile = (String) session.getAttribute("PayeeProfile");
		formid = ((String) session.getAttribute("formid")==null)?"":((String) session.getAttribute("formid")); 
		redirectedFrom= (String) session.getAttribute("redirectedFrom")==null?"":(String) session.getAttribute("redirectedFrom");
		
		log.info("redirectedFrom is::"+redirectedFrom);
		log.info("Sess BID ::" + sesBid);
		log.info(" sesCid ::" + sesCid); 
		log.info("clgName ::" + clgName);
		log.info("insCode ::" + insCode);
		log.info(" payeeProfile ::" + PayeeProfile);
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
	} catch (java.lang.Exception e) {
		response.sendRedirect("sessionTerminated");
	}
%>

<%
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();

	String qFormsIP = properties.getProperty("qFormsIP");
	String clientLogoLink = properties.getProperty("clientLogoLink");
	String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
	log.info("collegeBean:" + collegeBean);
	


%>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>QwikForms Forms</title> 
	<script	src="bower_components/jquery/jquery.min.js"></script>
	<link href="css/docs.min.css" rel="stylesheet" type="text/css" />
	<link href="css/bootstrap-select.css" rel="stylesheet" type="text/css" />

	<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<link href="css/wizard.css" rel="stylesheet" />
	<link href="css/style-tabbs.css" rel="stylesheet" />
	<link href="css/style-new.css" rel="stylesheet" />

	<%-- <script language="javascript" type="text/javascript"
		src="js/formjs/myScriptNew20july2019.js"></script> --%>


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

<div class="container">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
			style="color: #3399ff;">

			<table align="center" width="100%" border="0">
				<tr>
					<td width="20%" align="center">
						<div class="university-logo- fl-logo">
							<% if(null!=collegeBean.getCollegeImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
								alt="" title="" height="60" width="200"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="200"
								height="60" />
							<%} %>
						</div>
					</td>
					<td width="60%" align="center">
					<div align="center">
						<% if(null!=collegeBean.getCollegeName()){ %> 
						<h3 style="font: bolder,cursive; "><%=collegeBean.getCollegeName() %></h3> <%}else{ %>
						<h1>SRS Live Technologies</h1> 
						<%} %>
						</div>
					</td>
					<td width="20%" align="center">
						<div class="university-logo- fr-logo">

							<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
								alt="" title="" height="40" width="60"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="200"
								height="60" />
							<%} %>

						</div>
					</td>

				</tr>
			</table>
		</div>
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
				
			</ul>
		</div>

		<div id="wizard1" class="wizard">

			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box " id="a_11">

				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 top-main-bg"
					id="1">
					<div class="pan-heading">QwikForms</div>
					<div class="top-pad"></div>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="col-sm-12 labeling">
							<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12">
								<div class="university-logo">
									
									
							<%-- <% if(null!=collegeBean.getCollegeImage()){ %>
							<img src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>" alt=""
							title="" class="border-img" ></img>
							<%
							 CollegeName = collegeBean.getCollegeName()==null?"":collegeBean.getCollegeName();
							
							 CollegeState = collegeBean.getStateBean()==null?"":collegeBean.getStateBean().getStateName();
							%>
									<a class="navbar-brand"
									href="#"><span> <br> 
								
								</span></a>							
							<%}else{ %>
							<img
							src="img\No-logo.jpg" alt=""
							title="" ></img>
							<%} %> --%>									
									
							</div>
							</div>
							<div class="col-lg-10 col-md-12 col-sm-12 col-xs-12">

								<div class="title-name">
									<c:out value="${collegeBean.collegeName}" />


									<c:out
										value="${collegeBean.getStateBean()==null?'':collegeBean.getStateBean().getStateName()}" />
									<input type="hidden" id="bankId" value="<c:out value="${bankBean.bankId}" />" />
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

											<option value="${actorBean.actor_id}"><c:out
													value="${actorBean.actor_alias}"></c:out></option>

										</c:forEach>
									</select>
								</div>
								<% if(null!=session.getAttribute("redirectedFrom") && "Bank".equals(session.getAttribute("redirectedFrom"))){ %>
								<div class="col-md-12 cntrs labeling-pad">
									<span id="btnHome">

										<button type="button" id="btn-goHome"
											onclick="gotoBankLandingPage(<%=sesBid %>)"
											class="wizard-goto btn btn-primary">Back</button>
									</span> &nbsp;&nbsp;&nbsp;&nbsp; 
									<span id="btnClicks">
									 
									 <input
										type="button" id="btnSubmit-first" value="Submit"
										class="wizard-goto btn btn-primary" /></span>
								</div>
								<% } else {%>

								<div class="col-md-12 cntrs labeling-pad">
									<span id="btnClicks">
									
									<input type="button"
										id="btnSubmit-first" value="Submit"
										class="wizard-goto btn btn-primary" /></span>
								</div>

								<% } %>
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
										<li>QwikForms is a unique service powered by SabPaisa for
											paying fees, taxes, utility bill online to educational
											institutions, Online taxes, and/or any other
											corporates/institutions.</li>
									</ul>
								</div>

							</div></li>
						<%-- <li class="tab-header-and-content"><a href="#"
							class="tab-link">View Previous Transactions</a>
							<div class="tab-content">
								
								<form action="viewPreviousTxn" id="previoustxnIdAction"
									name="previoustxnIdAction">
									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

										<div class="col-md-6 labeling impt not-padding">

											

											<div
												class="col-lg-12 col-md-12 col-sm-12 col-xs-12 not-padding">
												<div class="form-group">

													<%
												try {

													if (session.getAttribute("PayeeProfileName").toString().equals("Institute")) {
											%>
													<label class="col-lg-4 col-md-12 col-sm-12 col-xs-12">Date
														of Incorporation</label>
													
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
												
												<button type="submit" id="submit_button"
													class="btn btn-success">View Transactions</button>


											</div>
										</div>
								</form>
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
			\A9 A9 Copyright 2016. powered by <a href="http://www.sabpaisa.com/"
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
	$(document).ready(function() {
		console.log("okkkkkkk")
		var tdate = new Date();
		  var dd = tdate.getDate(); //yields day
		  var MM = tdate.getMonth(); //yields month
		  if(MM < 9 ){
		  MM = MM+1;
		  MM = '0'+MM;
		  }else {
		  MM = MM+1;
		  }
		  var yyyy = tdate.getFullYear(); //yields year
		  var currentDate=   dd + "-" +( MM) + "-"+ yyyy ;
		          console.log("Today date is :" + currentDate);
		          
		$("#2365").attr("min", currentDate);
		$("#16392").attr("min", currentDate);
		}); 

	
	
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
	
// funtion to be executed whenever the next button is called from a form page that is not the last page
	
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
		
		/*var perMP=0;
		var grMP=0;
		var perHS=0;
		var grHS=0;
		var perGrGen=0;
		var grGrdGen=0;

	 	var perHons=0
		var grHons=0;
		var perMaster=0;
		var grMaster=0;
		var totalGradePoint=0.0; */
		
		var diffValue="";
		var diffCategory="";
		var dob=0;
		var calculateAge="";
		
		var perMP=0;
		var grMP=0;
		var perHS=0;
		var grHS=0;
		var perGrGen="";
		var grGrdGen=0;

		var perHons="";
		var grHons=0;
		var perMaster=0;
		var grMaster=0;
		var totalGradePoint=0.0;
		var seDoctorate="";
		var grDoctorate=0;
		var catGory="";
		var uniGrGen="";
		var yearGrGen=0;
		var subGrGen="";
		var coGrGen=""
		
		var uniGrGenHons="";
		var yearGrGenHons=0;
		var subGrGenHons="";
		var coGrGenHons=""
		
		
		var couMaster="";
		var uniMaster=0;
		var yearMaster=0;
		var subMaster="";
		var coMaster=""
		
			 var grGen1="";
    	 var grHons1="";
    	 var grMaster1="";
    	 
    	 var percentGrad=0;
    	 var percentHonors=0;
    	 
    	 var pgTotalMarksHS=0;
    	 var pgMarksHS=0;
    	 var pgPerHS=0;
    	 
    	 var pgTotalMarks12=0;
    	 var pgMarks12=0;
    	 var pgPer12=0;
    	 
    	 var pgTotalMarksUG=0;
    	 var pgMarksUG=0;
    	 var pgPerUG=0;
    	 
    	 var pgTotalMarksMaster=0;
    	 var pgMarksMaster=0;
    	 var pgPerMaster=0;
		
    	 //pgcourse
    	 var pgCategory="";
    	 var pgDACategory="";
    	 var pgDACategoryType="";
    	 
    	 var pgSportsCategory="";
    	 var pgSportsCategoryType="";
    	 var pgFeeToPay=150;
    	 
	//BU105
  
	var gateValue="";
	var gateGradePoint=0;
	var gateRegNum=0;
	var yearValidGateScore="";
	var dateFormate="";
 	var dateOfJoiningFormate="";
   	 
	//DJ075
	var nitnumber="";
	var itemnumber="";
	var nitItemNumber="";

	//   alert("page id "+nextpageid + " "+currentpagectr);
	   var elements = document.forms["QForm"].elements;
	 	 
	 	  for (i=0; i<elements.length; i++){
	 	   
	 	    if(elements[i].title<=currentpagectr){
	 	    	var e = elements[i].name;
	 	    	
					
	 	    		//starting for PG
	 	    		
	 	    	//////////////////////////////////////////////////
	 	    	if(elements[i].name=="Total Marks in B.ED./B.P.ED./B.P.E./LL.B"){
	 	    		pgTotalMarksMaster = elements[i].value;
				//	alert("diffValue "+diffValue);
	 	    		pgTotalMarksMaster=parseInt(pgTotalMarksMaster);	
	 	    	}
				
	 	    	if(elements[i].name=="Marks Obtained in B.ED./B.P.ED./B.P.E./LL.B"){
	 	    		pgMarksMaster = elements[i].value;
	 	    		if(pgMarksMaster > pgTotalMarksMaster){
	 	    			elements[i].value="";
	 	    			pgMarksMaster="";
	 	    			pgTotalMarksMaster="";
	 	    			alert("Please provide correct marks");
	 	    		}
	 	    		pgMarksMaster=parseInt(pgMarksMaster);
					}
	 	    	
	 	    	if(elements[i].name=="Percentage of B.ED./B.P.ED./B.P.E./LL.B"){
	 	    		pgPerMaster = ((pgMarksMaster/pgTotalMarksMaster)*100);
	 	    	//	pgPerHS=parseInt(pgPerHS);
	 	    		elements[i].value=pgPerMaster;
	 	    		elements[i].value= parseFloat(elements[i].value).toFixed(2);
	 	    		alert("Your percentage in  "+pgPerUG);
	 	    		
					} 	
	 	    		
	 	    	///////////////////////////////
	 	    	
	 	    	
	 	    	
				 	   	if(elements[i].name=="Category-"){
				 	   		pgCategory = elements[i].value;
			 	    	}
				 	   if(elements[i].name=="Differently Abled-"){
				 		  pgDACategory = elements[i].value;
			 	    	}
				 	   
				 		if(elements[i].name=="Differently Abled Category"){
				 			pgDACategoryType = elements[i].value;
			 	    	}
				 		
				 		if(elements[i].name=="Sports Personality-"){
				 			pgSportsCategory = elements[i].value;
			 	    	}
			
				 		if(elements[i].name=="Sports Level"){
				 			pgSportsCategoryType = elements[i].value;
			 	    	}
				 	   if(elements[i].name=="Fee To Pay"){
				 		   var pgStatusDACat=false;
				 		   var pgStatusSPCat=false;
				 		  // alert(".. "+pgDACategory+ " pgDACategoryType "+pgDACategoryType + " pgSportsCategory "+pgSportsCategory+" pgSportsCategoryType "+pgSportsCategoryType );
				 		   if(pgDACategory.includes("No") && pgDACategoryType.includes("Not Applicable"))
				 		   {
				 			   //300
				 			  pgStatusDACat=true;
				 		   }else if(pgDACategory.includes("Yes") && pgDACategoryType.includes("Not Applicable"))
				 		   {
				 			   //300
					 			  pgStatusDACat=true;
					 		   }
				 		   
				 		  else if(pgDACategory.includes("No") && !pgDACategoryType.includes("Not Applicable"))
				 		   {
				 			   //300
					 			  pgStatusDACat=true;
					 	   }
				 		   
				 		   //alert("pgStatusDACat "+pgStatusDACat);
				 		   
				 		  if(pgSportsCategory.includes("No") && pgSportsCategoryType.includes("Not Applicable"))
				 		   {
				 			  //300
				 			 pgStatusSPCat=true;
				 		   }else if(pgSportsCategory.includes("Yes") && pgSportsCategoryType.includes("Not Applicable"))
				 		   {
				 			   //300
					 			  pgStatusSPCat=true;
					 		   }
				 		   
				 		  else if(pgSportsCategory.includes("No") && !pgSportsCategoryType.includes("Not Applicable"))
				 		   {
				 			   //300
					 			  pgStatusSPCat=true;
					 	 }
				 		  
				 		 //alert("pgStatusSPCat "+pgStatusSPCat);
				 		   
				 		// alert("pgCategory "+pgCategory + " pgStatusSPCat "+pgStatusSPCat+ " pgStatusDACat "+pgStatusDACat);
				 		   if(pgCategory.includes("Unreserved") && 
				 				   pgStatusSPCat && pgStatusDACat){
				 		  elements[i].value=300;
				 		  amount="300";
				 		   }else{
				 			  elements[i].value=150;
				 			 amount="150";
				 		   }
				 		   alert("Fee to Pay "+elements[i].value);
			 	    	}
			
			
	 	    	
	 	    	///////////////////
	 	    		
						 	    	if(elements[i].name=="Total Marks in- MP"){
						 	    		pgTotalMarksHS = elements[i].value;
									//	alert("diffValue "+diffValue);
										if(pgTotalMarksHS!=0 && pgTotalMarksHS!=""){
						 	    		pgTotalMarksHS=parseInt(pgTotalMarksHS);	
										}else{
											
											alert("Please provide correct total marks in MP")
										}
						 	    	}
	 	    					
						 	    	if(elements[i].name=="Marks Obtained in- MP"){
						 	    		pgMarksHS = elements[i].value;
						 	    		if(pgMarksHS!=0 && pgMarksHS!=""){
						 	    		if(pgMarksHS > pgTotalMarksHS){
						 	    			elements[i].value="";
						 	    			alert("Please provide correct marks obtained in MP");
						 	    		}else{
						 	    			pgMarksHS=parseInt(pgMarksHS);
						 	    		}
						 	    		}else{
						 	    			alert("Please provide correct marks obtained in MP");
						 	    		}
						 	    		
										}
						 	    	
						 	    	if(elements[i].name=="Percentage of- MP"){
						 	    		pgPerHS = ((pgMarksHS/pgTotalMarksHS)*100);
						 	    	//	pgPerHS=parseInt(pgPerHS);
						 	    		elements[i].value=pgPerHS;
						 	    		elements[i].value= parseFloat(elements[i].value).toFixed(2);
						 	    		alert("Your percentage in MP is "+pgPerHS);
						 	    		
										}
						 	    	
								//////////////////////////////////////////////////
						 	    	if(elements[i].name=="Total Marks in-HS"){
						 	    		pgTotalMarks12 = elements[i].value;
						 	    		if(pgTotalMarks12!=0 && pgTotalMarks12!=""){
						 	    			pgTotalMarks12=parseInt(pgTotalMarks12);	
						 	    		}
											else{
											
											alert("Please provide correct total marks in HS")
										}
						 	    	
						 	    	}
	 	    					
						 	    	if(elements[i].name=="Marks Obtained in-HS"){
						 	    		pgMarks12 = elements[i].value;
						 	    		if(pgMarks12!=0 && pgMarks12!=""){
						 	    		if(pgMarks12 > pgTotalMarks12){
						 	    			elements[i].value="";
						 	    			alert("Please provide correct marks obtained in HS");
						 	    		}else{
						 	    			pgMarks12=parseInt(pgMarks12);
						 	    		}
						 	    		}else{
						 	    			alert("Please provide correct marks obtained in HS");		
						 	    		}
						 	    		
										}
						 	    	
						 	    	if(elements[i].name=="Percentage of-HS"){
						 	    		pgPer12 = ((pgMarks12/pgTotalMarks12)*100);
						 	    	//	pgPerHS=parseInt(pgPerHS);
						 	    		elements[i].value=pgPer12;
						 	    		elements[i].value= parseFloat(elements[i].value).toFixed(2);
						 	    		alert("Your percentage in HS is "+pgPer12);
						 	    		
										}
						 	    	
						 	    	
						 	   	//////////////////////////////////////////////////
						 	    	if(elements[i].name=="Total Hons Marks in-UG"){
						 	    		pgTotalMarksUG = elements[i].value;
									//	alert("diffValue "+diffValue);
						 	    		pgTotalMarksUG=parseInt(pgTotalMarksUG);	
						 	    	}
	 	    					
						 	    	if(elements[i].name=="Obtained Hons Marks in-UG"){
						 	    		pgMarksUG = elements[i].value;
						 	    		if(pgMarksUG > pgTotalMarksUG){
						 	    			elements[i].value="";
						 	    			pgMarksUG="";
						 	    			alert("Please provide correct marks");
						 	    		}
						 	    		pgMarksUG=parseInt(pgMarksUG);
										}
						 	    	
						 	    	if(elements[i].name=="Percentage of Hons Marks-UG"){
						 	    		pgPerUG = ((pgMarksUG/pgTotalMarksUG)*100);
						 	    	//	pgPerHS=parseInt(pgPerHS);
						 	    		elements[i].value=pgPerUG;
						 	    		elements[i].value= parseFloat(elements[i].value).toFixed(2);
						 	    		alert("Your percentage in UG is "+pgPerUG);
						 	    		
										} 	
						 	    	
	 	    		
	 	    	
	 	    	//finish for PG
						
								//starting
								 
								if(elements[i].name=="DIFFERENTLY ABLED"){
									diffValue = elements[i].value;
								//	alert("diffValue "+diffValue);
									}
								
								if(elements[i].name=="DIFFERENTLY ABLED CATEGORY"){
									diffCategory = elements[i].value;
								//	alert("diffCategory "+diffCategory);
									}
								if(elements[i].name=="CATEGORY" || elements[i].name=="Category"){
									catGory = 	elements[i].value;					
								}
							//	alert("catGory "+catGory);
							//	alert("elements[i].name "+elements[i].name);
								
								if(elements[i].name=="DATE OF BIRTH" || elements[i].name=="Date of Birth"  
										|| elements[i].name==" Date of Birth" ||  elements[i].name=="Date of Birth "){
									//	alert("Date of Birth");
										dob = elements[i].value;
										var res = dob.split("-", 3);
										//alert("res "+res);
										var dt = new Date();
						                                          
										var td=res[0];
										var tm=res[1];
										var ty=res[2];
										var calAge= tm+"/"+td+"/"+ty;
										//alert("td "+td+" "+tm+ " "+ty+ " "+calAge);
										//alert("callling ");
										var finalAge=getAge(calAge);
										//alert("finalAge "+finalAge);
										calculateAge=finalAge;
									//	alert("calAge "+calAge);
										
									//	ageValue = dt.getFullYear()-ty;
									//	alert("dob "+calculateAge);
									}
									
									if(elements[i].name=="Age" || elements[i].name=="AGE"){
								//	alert("calculateAge "+calculateAge);
										var aged = calculateAge.split(".", 3);
										var cy=aged[0];
										var cm=aged[1];
										var cd=aged[2];
										elements[i].value="";
										//to be commented
								//		alert("ade "+elements[i].value);
									//	elements[i].value=cy+" years "+cm +" months "+cd+" days";
									//	elements[i].value=cy;	
									
										if(catGory!=""){
										 if(diffValue.includes("Yes") || diffValue.includes("YES")){
										//	alert("s "+cy+ " "+cm+" "+cd+ " "+calculateAge);
											if(cy>43){
												
												alert("You are not eligible");
											}else if(cy==43 && (cm>0 || cd>0)){
												alert("You are not eligible");
											}else{
											//	alert("ade ");
												elements[i].value=cy+" years "+cm +" months "+cd+" days";
												
												//alert("ade "+elements[i].value);
											}										
											
										}else{
										//	alert("NO "+cy+ " "+cm+" "+cd+ " "+calculateAge);
											if(cy>38){
												
												alert("You are not eligible");
											}else if(cy==38 && (cm>0 || cd>0)){
												alert("You are not eligible");
											}else{
											//	alert("ade ");
												elements[i].value=cy+" years "+cm +" months "+cd+" days";
												
											//	alert("ade "+elements[i].value);
											}	
											
											
											
										}}else{
										console.log("catGory is empty "+catGory);
										elements[i].value=cy+" years "+cm +" months "+cd+" days";
									}
										// for date type 12_02_2019

                                        if(calculateAge!=""){
											alert("Age is "+elements[i].value);
											
											}else{
											alert("Please provide DOB in dd-MM-YYYY format");
											elements[i].value="";
											
											}	
									}
								
								/// starting 
								
								if(elements[i].name=="PERCENT MARKS OBTAINED-A-MP"){
									perMP = elements[i].value;
									if(elements[i].value > 100){
										elements[i].value="";
										perMP="";
										alert("PERCENT MARKS OBTAINED-A-MP should be less then 100 ");
									}
									
								}
							//	alert("diffCategory,diffCategory "+diffCategory);
								if(elements[i].name=="GRADE POINT-10-PERCENT OF A-MP"){
									
									if(perMP!=""){
									elements[i].value = perMP*0.1;
									grMP=elements[i].value;
									}
									alert("GRADE POINT-10 PERCENT OF A-MP "+elements[i].value);
									totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grMP));
								//	alert("total grade "+parseFloat(totalGradePoint).toFixed());
								}
								
								if(elements[i].name=="PERCENT MARKS OBTAINED-B-HS"){
									perHS = elements[i].value;
									if(elements[i].value > 100){
										
										elements[i].value="";
										perHS="";
										alert("PERCENT MARKS OBTAINED-B-HS should be less then 100 ");
									}
									
								}
								if(elements[i].name=="GRADE POINT-10-PERCENT OF B-HS"){
									
									if(perHS!=""){
									elements[i].value = perHS*0.1;
									grHS=elements[i].value;
									}
									alert("GRADE POINT-10-PERCENT OF B-HS "+elements[i].value);
									totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grHS));
								//	alert("total grade "+parseFloat(totalGradePoint).toFixed());
								}
								//////////////////
								
								if(elements[i].name=="COURSE-GRADUATION-GENERAL"){
									coGrGen=elements[i].value;
								//	alert("course gr general seected "+coGrGen);
								}
								if(coGrGen.includes("Not Application") || coGrGen.includes("Not Applicable")  ){
									 uniGrGen="NA";
									 yearGrGen=0;
									 subGrGen="NA";
									 perGrGen=0;
									
								}

								if(elements[i].name=="UNIVERSITY NAME-GRADUATION-GENERAL"){
									if(coGrGen.includes("Not Application") || coGrGen.includes("Not Applicable")){
										elements[i].value="NA";
									}
								}
								

								if(elements[i].name=="YEAR OF PASSING-GRADUATION-GENERAL"){
									if(coGrGen.includes("Not Application") || coGrGen.includes("Not Applicable")){
										elements[i].value=0;
									}
									
								}
								
								if(elements[i].name=="SUBJECTS TAKEN-GRADUATION-GENERAL"){
									if(coGrGen.includes("Not Application") || coGrGen.includes("Not Applicable")){
										elements[i].value="NA";
									}
									
								}
								
								if(elements[i].name=="PERCENT MARKS OBTAINED-C-GRADUATION-GEN"){
								//	alert("perGrGen "+perGrGen)
									if(coGrGen.includes("Not Application") || coGrGen.includes("Not Applicable")){
										elements[i].value=0;
									}
									if(elements[i].value > 100 ){
										
										elements[i].value="";
										perGrGen="";
										alert("PERCENT MARKS OBTAINED-C-GRADUATION-GEN should be less then 100 ");
									}
									else if(elements[i].value!=0){
									percentGrad=elements[i].value;
							 /* if(catGory.includes("General") || catGory.includes("GENERAL")){
										if(elements[i].value < 50){
											elements[i].value="";
											perGrGen="";
											alert("You are not eligible");
										}}else{ 
											if(elements[i].value <45){
											elements[i].value="";
											perGrGen="";
											alert("You are not eligible");
											
										}
										}  */
									
									}
								//	alert("per Gn "+elements[i].value);
									perGrGen=elements[i].value;
									
								 } 
								if(elements[i].name=="GRADE POINT-15-PERCENT OF C-GEN"){
								//	perGrGen=0;
									if(coGrGen.includes("Not Application") || coGrGen.includes("Not Applicable")){
										elements[i].value=0;
										perGrGen="";
									}
									if(perGrGen!=""){
									elements[i].value = perGrGen*0.15;
									grGrdGen=elements[i].value;
									}
									alert("GRADE POINT-15-PERCENT OF C-GEN "+elements[i].value);
									totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grGrdGen));
								//	alert("total grade "+parseFloat(totalGradePoint).toFixed());
								}
								
								/////////////////////////
								
								if(elements[i].name=="COURSE-GRADUATION-HONORS" || elements[i].name==" COURSE-GRADUATION-HONORS" || 
										elements[i].name==" COURSE-GRADUATION-HONORS " || elements[i].name=="COURSE-GRADUATION-HONORS " || elements[i].name=="COURSE-GRADUATION-HONORS17023"){
							//	 	alert("honors "+elements[i].name);
									coGrGenHons=elements[i].value;
						//			alert("COURSE-GRADUATION-HONORS "+coGrGenHons);
								}
								if(coGrGenHons.includes("Not Application") || coGrGenHons.includes("Not Applicable") ){
									 uniGrGenHons="NA";
									 yearGrGenHons=0;
									 subGrGenHons="NA";
									 perHons=0;
									
								}

								if(elements[i].name=="UNIVERSITY NAME- GRADUATION-HONORS" || elements[i].name==" UNIVERSITY NAME-GRADUATION-HONORS"
									|| elements[i].name==" UNIVERSITY NAME-GRADUATION-HONORS " || elements[i].name=="UNIVERSITY NAME-GRADUATION-HONORS ")
								{
								//	alert("UNIVERSITY NAME-GRADUATION-HONORS "+elements[i].name);
									if(coGrGenHons.includes("Not Application") || coGrGenHons.includes("Not Applicable")){
										elements[i].value="NA";
									}
								}
								

								if(elements[i].name=="YEAR OF PASSING-GRADUATION-HONORS"){
									if(coGrGenHons.includes("Not Application") || coGrGenHons.includes("Not Applicable")){
										elements[i].value=0;
									}
									
								}
								
								if(elements[i].name=="SUBJECTS TAKEN-GRADUATION-HONORS"){
									if(coGrGenHons.includes("Not Application") || coGrGenHons.includes("Not Applicable")){
										elements[i].value="NA";
									}
									
								}
								
								if(elements[i].name=="PERCENT MARKS OBTAINED-D-GRADUATION-HONS"){
									//perHons = elements[i].value;
									if(coGrGenHons.includes("Not Application") || coGrGenHons.includes("Not Applicable")){
										elements[i].value=0;
									}
									if(elements[i].value > 100 ){
										
										elements[i].value="";
										perHons="";
										alert("PERCENT MARKS OBTAINED-D-GRADUATION-HONS should be less then 100 ");
									}else if(elements[i].value!=0){
										percentHonors=elements[i].value;
									/* if(catGory.includes("General")|| catGory.includes("GENERAL")){
										
										if(elements[i].value <50){
											elements[i].value="";
											perHons="";
											alert("You are not eligible");
										}}else{ 
											if(elements[i].value <45){
											elements[i].value="";
											perHons="";
											alert("You are not eligible");
											
										}
										} */
								}
								//	alert("per hons "+elements[i].value);
									perHons=elements[i].value;	
								}
								if(elements[i].name=="GRADE POINT-20-PERCENT OF D-HONS"){
								//	perHons=0;
									if(coGrGenHons.includes("Not Application") || coGrGenHons.includes("Not Applicable")){
										elements[i].value=0;
										perHons="";
									}
									if(perHons!=""){
									elements[i].value = perHons*0.2;
									grHons=elements[i].value;
									 totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grHons));
									 alert("Grade point of Hons. "+grHons);
		
									}
									totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grHons));
								//	alert("total grade "+parseFloat(totalGradePoint).toFixed());
								}
								
								///////6///////////////////
						
								
								if(elements[i].name=="COURSE - MASTER" || elements[i].name==" COURSE - MASTER" || 
										elements[i].name==" COURSE - MASTER " || elements[i].name=="COURSE - MASTER " || elements[i].name=="COURSE - MASTER"){
			//						alert("mastrer "+elements[i].value);
									couMaster=elements[i].value;
								}
								
								if(elements[i].name=="UNIVERSITY NAME-MASTER" || elements[i].name==" UNIVERSITY NAME-MASTER"
									|| elements[i].name==" UNIVERSITY NAME-MASTER " || elements[i].name=="UNIVERSITY NAME-MASTER ")
								{
								//	alert("UNIVERSITY NAME-GRADUATION-HONORS "+elements[i].name);
									if(couMaster.includes("Not Application") || couMaster.includes("Not Applicable")){
										elements[i].value="NA";
									}
								}
								
								if(elements[i].name=="YEAR OF PASSING-MASTERS COURSE"){
									if(couMaster.includes("Not Application") || couMaster.includes("Not Applicable")){
										elements[i].value=0;
									}
									
								}
								
								if(elements[i].name=="SUBJECTS TAKEN-MASTERS COURSE"){
									if(couMaster.includes("Not Application") || couMaster.includes("Not Applicable")){
										elements[i].value="NA";
									}
									
								}
								
								
								
								
								if(elements[i].name=="PERCENT MARKS OBTAINED-E-MASTERS"){
									if(couMaster.includes("Not Application") || couMaster.includes("Not Applicable")){
										elements[i].value=0;
									}
									if(elements[i].value > 100){
										
										elements[i].value="";
										perMaster="";
										alert("PERCENT MARKS OBTAINED-E-MASTERS should be less then 100 ");
									}
									else if(elements[i].value!=""){
									//	alert("percentHonors "+percentHonors+ " percentGrad "+percentGrad+" elements[i].value "+elements[i].value);
									
									perMaster=elements[i].value;
									/* if(catGory.includes("General")|| catGory.includes("GENERAL")){
										if(elements[i].value <50 && percentHonors<50 && percentGrad<50){
											elements[i].value="";
											perMaster="";
											alert("You are not eligible,please check your marks");
										}}else{ 
											if(elements[i].value <45 && percentHonors<45 && percentGrad<45){
											elements[i].value="";
											perMaster="";
											alert("You are not eligible, please check your marks");
											
										}
										} */
									
								}
								//	alert("per perMaster "+elements[i].value);
									//perMaster=elements[i].value;		
								}
								if(elements[i].name=="GRADE POINT-20-PERCENT OF E-MASTERS"){
									if(couMaster.includes("Not Application") || couMaster.includes("Not Applicable")){
									//	alert("hons and grd "+coGrGenHons+ " "+coGrGen);
										if(coGrGenHons.includes("Not Applicable") && coGrGen.includes("Not Applicable")){
										//	alert("0 "+coGrGenHons+ " "+coGrGen+" m "+perMaster+" v "+elements[i].value);
											elements[i].value="";
											perMaster="";
										//	alert("1 "+coGrGenHons+ " "+coGrGen+" m "+perMaster+" v "+elements[i].value);
											alert("Please provide either Graduation General , Graduation Honors or Master Marks");
										}else{
											//alert("3 "+coGrGenHons+ " "+coGrGen+" m "+perMaster+" v "+elements[i].value);
											elements[i].value=0;
											perMaster=0;
										}
										
									}
									//alert("2 "+coGrGenHons+ " "+coGrGen+" m "+perMaster+" v "+elements[i].value);
									if(perMaster!="" && elements[i].value!=""){
									elements[i].value = perMaster*0.2;
									grMaster=elements[i].value;
									alert("Grade Point of Master "+grMaster);
									}else{
										grMaster=0;
									}
									totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grMaster));
									//alert("total grade "+parseFloat(totalGradePoint).toFixed());
								}
								
						///finished 
						
						// Start validation for DJ075
							if(elements[i].name=="NIT No"){
									
									nitnumber = elements[i].value;
									var l=nitnumber.length;
									var n=nitnumber.indexOf("*");
									nitnumber=nitnumber.substring(n+1, l);
									
									//alert("in else block nitnumber "+ nitnumber);
									//alert("Total marks in MP "+ nitnumber);
							}

							if(elements[i].name=="Item No"){
									
									itemnumber = elements[i].value;
									var l=itemnumber.length;
									var n=itemnumber.indexOf("*");
									itemnumber=itemnumber.substring(n+1, l);	
								//alert("in else block itemnumber "+ itemnumber);
								//alert("Total marks in MP itemnumber "+ itemnumber);
							}
						
							if(elements[i].name=="NIT-Item No"){
	
								if(nitnumber!="" &&  itemnumber!=""){
									
									nitItemNumber=nitnumber+"/"+itemnumber;
									alert("nit-Item Number is : "+nitItemNumber);
									elements[i].value=nitItemNumber;
								 }else{
									 alert("Please select NIT and Item Number.");
									elements[i].value="";
								}
							}

						// End validation for DJ075						

		
						// Start BU105 M.Phil Form Validation
						if(elements[i].name=="Total Marks-Grade-MP"){
							totalMarksMP = elements[i].value;
							if(isNaN(elements[i].value)){
                                alert("Please provide numeric value.");
                                elements[i].value="";
                        	}
							alert("Before Total marks in MP "+ totalMarksMP);
							if(totalMarksMP===0  ){
								alert("Please provide correct total marks in MP");
								elements[i].value="";
								totalMarksMP="";
							}else{
								 totalMarksMP = elements[i].value;

							}
							totalMarksMP=parseInt(totalMarksMP);	
							alert("Total marks in MP "+ totalMarksMP);
						}
						
						if(elements[i].name=="Marks Obtained in MP"){
							alert("checking "+isNaN( elements[i].value));
							gradeMP = elements[i].value;
							alert("checking "+isNaN( elements[i].value));
							if(isNaN(elements[i].value)){
	                             alert("Please provide numeric value.");
	                             elements[i].value="";
	                       	}
							if(gradeMP<=totalMarksMP ){
								gradeMP=parseInt(gradeMP);
							}else{
								alert("Please provide Marks Obtained less than to Total Marks in MP");
								elements[i].value="";
								totalMarksMP="";
							}
							alert("marks obtained in MP "+gradeMP);
						}
						
						if(elements[i].name=="Percentage of marks-MP"){
							alert("after Total marks in MP "+ totalMarksMP + "  "+gradeMP);
								if(totalMarksMP>=gradeMP){
									perMarksMP = (gradeMP/totalMarksMP)*100;
									alert("Your percentage in MP "+perMarksMP);
									elements[i].value = perMarksMP;
		                            elements[i].value = parseFloat(elements[i].value).toFixed(2);	
								}else{
									alert("Please provide correct total marks in MP");
									elements[i].value="";
									totalMarksMP="";
									gradeMP="";
									perMarksMP="";
									alert("Obtained Marks should be less than Total Marks.");
								}
							alert("% marks in MP "+ perMarksMP + "  "+elements[i].value);
						}
						
						if(elements[i].name=="Total Marks-Grade-12th"){
							totalMarksHS = elements[i].value;
							if(isNaN(elements[i].value)){
	                                                        alert("Please provide numeric value.");
	                                                        elements[i].value="";
	                                                }
							alert("Before Total marks in HS "+ totalMarksHS);
							if(totalMarksHS===0) {
								alert("Please provide correct total marks in HS");
								elements[i].value="";
								totalMarksHS="";
							}else{
								totalMarksHS=elements[i].value;
							}
							totalMarksHS=parseInt(totalMarksHS);
							alert("Total marks in HS "+ totalMarksHS);
						}
						if(elements[i].name=="Marks Obtained in 12th"){
							gradeHS = elements[i].value;
							if(isNaN(elements[i].value)){
	                                                        alert("Please provide numeric value.");
	                                                        elements[i].value="";
	                                                }
							if(gradeMP<=totalMarksMP ){
								gradeHS=parseInt(gradeHS);
							}else{
								alert("Please provide Marks Obtained less than to Total Marks in 12th");
								elements[i].value="";
								gradeHS="";
							}
								alert("marks obtained in 12th "+gradeHS);
						}
						if(elements[i].name=="Percentage of marks-12th" || elements[i].name=="Percentage of marks-12th "){
							alert("after Total marks in HS "+ totalMarksHS + "  "+gradeHS);
							if(totalMarksHS>gradeHS ){
								perMarksHS = (gradeHS/totalMarksHS)*100;
								alert("Your percentage in 12th "+perMarksHS);
								elements[i].value = perMarksHS;
	                                                        elements[i].value = parseFloat(elements[i].value).toFixed(2);
							}else{
								alert("Please provide correct marks in 12th");
								elements[i].value="";
								totalMarksHS="";
								gradeHS="";
								perMarksHS="";
							}
							alert("% marks in HS "+ perMarksHS + "  "+elements[i].value);
						}
					
						if(elements[i].name=="Total Marks-Grade Degree"){
							totalMarksPG = elements[i].value;
							if(isNaN(elements[i].value)){
	                                                        alert("Please provide numeric value.");
	                                                        elements[i].value="";
	                                                }
							alert("Before Total marks in HS "+ totalMarksPG);
							if(totalMarksPG===0) {
								alert("Please provide correct total marks in HS");
								elements[i].value="";
								totalMarksPG="";
							}else{
								totalMarksPG=elements[i].value;
							}
							totalMarksPG=parseInt(totalMarksPG);
							alert("Total marks in HS "+ totalMarksPG);
						}
						
						if(elements[i].name=="Marks Obtained Degree"){
							gradePG = elements[i].value;
							if(isNaN(elements[i].value)){
	                                                        alert("Please provide numeric value.");
	                                                        elements[i].value="";
	                                                }
							if(gradeMP<=totalMarksMP ){
								gradePG=parseInt(gradePG);
							}else{
								alert("Please provide Marks Obtained less than to Total Marks in 12th");
								elements[i].value="";
								gradePG="";
							}
								alert("marks obtained in 12th "+gradePG);
						}
						
						if(elements[i].name=="Percentage Degree"){
							alert("after Total marks in HS "+ totalMarksPG + "  "+gradePG);
							if(totalMarksPG>gradePG ){
								perMarksPG = (gradePG/totalMarksPG)*100;
								alert("Your percentage in 12th "+perMarksPG);
								elements[i].value = perMarksPG;
	                                                        elements[i].value = parseFloat(elements[i].value).toFixed(2);
							}else{
								alert("Please provide correct marks in 12th");
								elements[i].value="";
								totalMarksPG="";
								gradePG="";
								perMarksPG="";
							}
							alert("% marks in HS "+ perMarksPG + "  "+elements[i].value);
						}
						
						if(elements[i].name=="Total Marks-Grade Master"){
							totalGrade = elements[i].value;
							if(isNaN(elements[i].value)){
	                                                        alert("Please provide numeric value.");
	                                                        elements[i].value="";
	                                                }
							alert("Before Total marks in HS "+ totalGrade);
							if(totalGrade===0) {
								alert("Please provide correct total marks in HS");
								elements[i].value="";
								totalGrade="";
							}else{
								totalGrade=elements[i].value;
							}
							totalGrade=parseInt(totalGrade);
							alert("Total marks in HS "+ totalGrade);
						}
						
						if(elements[i].name=="Marks obtained Master"){
							marksGrade = elements[i].value;
							if(isNaN(elements[i].value)){
	                                                        alert("Please provide numeric value.");
	                                                        elements[i].value="";
	                                                }
							if(gradeMP<=totalMarksMP ){
								marksGrade=parseInt(marksGrade);
							}else{
								alert("Please provide Marks Obtained less than to Total Marks in 12th");
								elements[i].value="";
								marksGrade="";
							}
								alert("marks obtained in 12th "+marksGrade);
						}
						
						if(elements[i].name=="Percentage Master"){
							alert("after Total marks in HS "+ totalGrade + "  "+marksGrade);
							if(totalGrade>marksGrade ){
								perGrade = (marksGrade/totalGrade)*100;
								alert("Your percentage in 12th "+perGrade);
								elements[i].value = perGrade;
	                                                        elements[i].value = parseFloat(elements[i].value).toFixed(2);
							}else{
								alert("Please provide correct marks in 12th");
								elements[i].value="";
								totalGrade="";
								marksGrade="";
								perGrade="";
							}
							alert("% marks in HS "+ perGrade + "  "+elements[i].value);
						}
						
						if(elements[i].name=="Total Marks-Grade M Phil"){
							totalMarksUG = elements[i].value;
							if(isNaN(elements[i].value)){
	                                                        alert("Please provide numeric value.");
	                                                        elements[i].value="";
	                                                }
							alert("Before Total marks in HS "+ totalMarksUG);
							if(totalMarksUG===0) {
								alert("Please provide correct total marks in HS");
								elements[i].value="";
								totalMarksUG="";
							}else{
								totalMarksUG=elements[i].value;
							}
							totalMarksUG=parseInt(totalMarksUG);
							alert("Total marks in HS "+ totalMarksUG);
						}
						
						if(elements[i].name=="Marks obtained M Phil"){
							gradeUG = elements[i].value;
							if(isNaN(elements[i].value)){
	                                                        alert("Please provide numeric value.");
	                                                        elements[i].value="";
	                                                }
							if(gradeMP<=totalMarksMP ){
								gradeUG=parseInt(gradeUG);
							}else{
								alert("Please provide Marks Obtained less than to Total Marks in 12th");
								elements[i].value="";
								gradeUG="";
							}
								alert("marks obtained in 12th "+gradeUG);
						}
						
						if(elements[i].name=="Percentage M Phil"){
							alert("after Total marks in HS "+ totalMarksUG + "  "+gradeUG);
							if(totalMarksUG>gradeUG ){
								perMarksUG = (gradeUG/totalMarksUG)*100;
								alert("Your percentage in 12th "+perMarksUG);
								elements[i].value = perMarksUG;
	                                                        elements[i].value = parseFloat(elements[i].value).toFixed(2);
							}else{
								alert("Please provide correct marks in 12th");
								elements[i].value="";
								totalMarksUG="";
								gradeUG="";
								perMarksUG="";
							}
							alert("% marks in HS "+ perMarksUG + "  "+elements[i].value);
						}
						// End BU105 M.Phil Form Validation
						
						// use for BU105 M.Tech Form file
						
						if(elements[i].name=="GATE"){
							//alert("Gate field Value is Selected "+elements[i].value);
							if(elements[i].value==""){
								alert("Please select any value in Gate");
								return false;
							}else if(elements[i].value=="1773*Yes"){
								//alert("In if block Gate field Value is Selected "+elements[i].value);
								gateValue=elements[i].value;
							}else{
								gateValue=elements[i].value;
								//alert("gateValue variable result is  "+gateValue);
							}  
						}   
						
						if(elements[i].name=="Valid GATE Score out of 100"){
							//alert("grade point out of 100 for bu105 ");
							if(gateValue=="" || gateValue==null){
								alert("Please select Gate first");
							}else if(gateValue=="1773*Yes"){
								//alert("selected Gate Value is "+gateValue); 
								if(elements[i].value=="" || elements[i].value==null || elements[i].value>=100 ||elements[i].value<=0 ){
									alert("Please insert grade point out of 100 first in correct format");
									elements[i].value="";
									return false;
								}else{
									gateGradePoint = elements[i].value;
									//alert("gateGradePoint is ::: "+gateGradePoint);
								}
							}else{
								elements[i].value=0;
							} 
						}
						if(elements[i].name=="GATE Registration No"){
							//alert("Gate Registration Number out of 100 for bu105 ");
							if(gateValue=="" || gateValue==null){
								alert("Please select Gate first");
							}else if(gateValue=="1773*Yes"){
								//alert("selected Gate Value is "+gateValue); 
								if(elements[i].value=="" || elements[i].value==null || elements[i].value<=0 ){
									alert("Please insert GATE Registration Number");
									elements[i].value="";
									return false;
								}else{
									gateRegNum = elements[i].value;
									//alert("GATE Registration Number is ::: "+gateRegNum);
								}
							}else{
								elements[i].value=0;
							} 
						}
						
						if(elements[i].name=="Year of Valid GATE Score"){
							if(gateValue=="" || gateValue==null){
								alert("Please select Gate first");
							}else if(gateValue=="1773*Yes"){
								//alert("selected Gate Value is "+gateValue);
								if(elements[i].value=="" || elements[i].value==null || elements[i].value==0){
									alert("Please insert Year of Valid GATE Score");
									elements[i].value="";
									return false;
								}else if(elements[i].value.indexOf("-")>0){
									//alert("elements[i].value "+elements[i].value);
									yearValidGateScore = elements[i].value;
									//alert("yearValidGateScore "+yearValidGateScore);
								}else{
									alert("Please select Year of Valid GATE Score in dd-mm-yyyy format");
									return false;
								}
							}else if(gateValue=="1773*No"){
								elements[i].value=00-00-0000;
							}
						}
						

						if(elements[i].name=="Date of Birth" ){
							 
								if(elements[i].value.indexOf("-")>0){
									//alert("elements[i].value "+elements[i].value);
									dateFormate = elements[i].value;
									//alert("yearValidGateScore "+yearValidGateScore);
								}else{
									alert("Please select Date in dd-mm-yyyy format");
									return false;
								}
							
						}
						
						 if(elements[i].name=="Sponsored"){
							//alert("Sponsored field Value is Selected 1"+elements[i].value);
							if(elements[i].value=="1762*Yes"){
								//alert("In if block Gate field Value is Selected 1"+elements[i].value);
								//alert("You select Sponsored is Yes, So Please upload your NOC Mentioning Experience Certificate");
								sponsoredValue=elements[i].value;
							}else if(elements[i].value=="1762*No"){
								//alert("NOC Mentioning Experience Certificate is Not Mendetory");
								sponsoredValue=elements[i].value;
								//alert("gateValue variable result is 1 "+sponsoredValue);
							}else{
								alert("Please select any one option in Sponsored.");
								return false;
							}
						}

						if(elements[i].name=="Date of joining the post"){
						//alert("date of joining the post");
							if(sponsoredValue=="1762*Yes" && elements[i].value.indexOf("-")>0){
								dateOfJoiningFormate = elements[i].value;
							}else if(sponsoredValue=="1762*No"){
								//alert("sponsoredValue is for date of joining "+sponsoredValue);
							    elements[i].value="Not Applicable";
							}else if(sponsoredValue=="1762*Yes" && elements[i].value=="Not Applicable"){
								alert("Please insert valid Date of joining.");
								elements[i].value="";
							}else{
                                                                alert("Please select Date in dd-mm-yyyy format");
                                                                return false;
                                                        }
						} 

						if(elements[i].name=="NOC Mentioning Experience"){
								//alert("date of joining the post");
									if(sponsoredValue=="1762*Yes"){
										alert("Plesas upload your NOC file");
									    elements[i].required=1;
									}else if(sponsoredValue=="1762*No"){
										alert("Please insert valid Date of joining.");
										elements[i].required=0;
									}
						}

						//end of BU105 M.Tech Form File


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
	 	    
	 	    if(elements[i].required!=null){
	 	    	
		 //	    	alert("Mandatory Field Name : "+elements[i].name+", and Field Value is : "+elements[i].value);
	 	    	if(elements[i].required){
	 	    	//	alert("tr "+elements[i].name);
	 	    	
	 	    		if(elements[i].value.trim()=="" || (elements[i].checked==false && elements[i].type=='checkbox' 
	 	    				&& elements[i].value.trim()=="off")){
	 	    			alert("field Name '"+ elements[i].name +"' with red asterisk must be filled in, So Please Fill them");
	 	    			validationpass=false;
	 	    			elements[i].focus();
	 	    		//	alert("Filed "+elements[i].name+", set validation false "+validationpass);
	 	    			
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
		//	alert("validation "+validationpass);
			returnFlag=submitFormUsingAjax(submitShotFlag, currentpagectr);		

			if(submitShotFlag=="fresh"){
				submitShotFlag="update";
			}
		}
		
		 
		return returnFlag;
	
			
	}
	

	// funtion to be executed whenever the back button is called from a form page 

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
	
	// funtion to be executed whenever the next button is called from the Payer Basic Information page
	function goToFormPages(){
		//alert("called gotoFormPages----v ");
		   var currentpagectr=0;
		   var validationpass = true;
			$("#15645").addClass("hide");
			$("#15712").addClass("hide");
			$("#15883").addClass("hide");	
		   
		 	var elements = document.forms["QForm"].elements;
		// 	  alert("test nitin "+elements); 
		 	  for (i=0; i<elements.length; i++){
		 	    
		 	    if(elements[i].title<=currentpagectr){
		 	    	var e = elements[i].name;
			    	
		 	    	
		 	    if(elements[i].required!=null){
		 	    	// alert("test "+elements[i].name); 
		 	    	
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
    			    //   alert("aadhaar verify internal url is"+aUrl);
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
	
	
	
	//for testing 
	
	function goToFormPagess(){
		//alert("called gotoFormPagesv II");
		   var currentpagectr=0;
		   var validationpass = true;
			$("#15645").addClass("hide");
			$("#15712").addClass("hide");
			$("#15883").addClass("hide");	
		   
		 	var elements = document.forms["QForm"].elements;
		 	 // alert("test nitin "+elements); 
		 	  for (i=0; i<elements.length; i++){
		 	    
		 	    if(elements[i].title<=currentpagectr){
		 	    	var e = elements[i].name;
		 	    //	 alert("test  "+elements[i].name); 
		 	    	
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
    			    //   alert("aadhaar verify internal url is"+aUrl);
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


	//	alert("testing validation "+validationpass);
	if (validationpass){
		
		
	/* 	var captID_val=document.getElementById("captchaFromServer").value;	
		var captId=document.getElementById("captId").value;				
		
	 */	
		
		/* if(captID_val != captId)
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
		 */
		$("#tab-10-1-1").removeClass('is-active');
		$("#tab-10-1").hide();
		$("#tab-10-1").removeClass('is-open');
		
		$("#tab-11-1-1").addClass('is-active');
		$("#tab-11-1").addClass('is-open');
		$("#tab-11-1").show();
	
		/* } */
		/* NO save calls at this time */
	
	  }
		return false;
		
	}
	
	
	
	
	
	
	
	
	
	
	/* Nitin */
			function validateIfsc(){
		var elements = document.forms["QForm"].elements;
		// var payeeformIdQC =<%=payeeformIdQC%>;
		   var bid = '<%=sesBid%>';
		var cid = '<%=sesCid%>';
		var formtemplateid = document.getElementById("currentFormId").value;
		var emailId = "NA";
		var nameOfBank = "NA";
		var bankBranch ="NA";
		var ifsc ="NA";
		
		for (i=0; i<elements.length; i++){
		  alert( elements[i].name);
		   if(elements[i].name===("Email")){
		    emailId= elements[i].value;
		   }
		  if(elements[i].name==="Name of the Bank" ){
		 console.log("Checking "+elements[i].name);
		  nameOfBank = elements[i].value;
		   
		  }
		 
		if(elements[i].name==="Bank Branch"){
		 console.log("Checking "+elements[i].name);
		 bankBranch =  elements[i].value;
		  }
		 
		  console.log("Banks Details  "+nameOfBank + " branch "+bankBranch+ " "+elements[i].name);    
		if(elements[i].name==="IFS Code"){
		console.log("Checking "+elements[i].name);
		ifsc = elements[i].value;
		}
		   
		}
	/* 	alert("Log is  bid "+bid+ " cid "+cid+" fid "+formtemplateid+ " eid "+emailId + " nob "+nameOfBank
		+" bb "+bankBranch+ " ifsc "+ifsc); */
		
		}
	
			function getAge(dateString) {
				// alert("-- "+dateString);
				/*alert("age "+dateString+ " y "+dateString.substring(6,10)+ " m "+ dateString.substring(0,2)-1+ " d "+
						dateString.substring(3,5)); */
				  var now = new Date();
				  var today = new Date(now.getYear(),now.getMonth(),now.getDate());

				  var yearNow = "119";
				  var monthNow = 5;
				  var dateNow =30;

				  var dob = new Date(dateString.substring(6,10),
				                     dateString.substring(0,2) - 1,                   
				                     dateString.substring(3,5)                  
				                     );

			//	  alert("dobb "+dob);
		 		  var yearDob = dob.getYear();
				  var monthDob = dob.getMonth();
				  var dateDob = dob.getDate(); 
				//	alert("dateDob -"+dateDob+", monthDob -"+monthDob+", yearDob - "+yearDob);	
				  /* var yearDob = year;
				  var monthDob = month;
				  var dateDob = day; */
			
				  var age = {};
				  var ageString = "";
				  var yearString = "";
				  var monthString = "";
				  var dayString = "";
				  var monthAge ="";
			// alert("date now "+dateNow+ " "+dateDob);	

				  yearAge = yearNow - yearDob;
				  //yearAge = yearAge+1;
				  if (monthNow >= monthDob) {
				     monthAge = monthNow - monthDob;
			        	}
				  else {
				    yearAge--;
				 //    	alert("monthNow : "+monthNow+", monthDob : "+monthDob);
					var monb=12;
					monthAge = (monb + monthNow) - monthDob;
				//	alert("Month Age "+monthAge);
				  }

				 
				  if (dateNow >= dateDob)
				    var dateAge = dateNow - dateDob;
				  else {
				    monthAge--;
				    var dateAge = 31 + dateNow - dateDob;

				    if (monthAge < 0) {
				      monthAge = 11;
				      yearAge--;
				    }
				  }

				  age = {
				      years: yearAge,
				      months: monthAge,
				      days: dateAge
				      };

				  if ( age.years > 1 ) yearString = ".";
				  else yearString = ".";
				  if ( age.months> 1 ) monthString = ".";
				  else monthString = ".";
				  if ( age.days > 1 ) dayString = ".";
				  else dayString = ".";


				  if ( (age.years > 0) && (age.months > 0) && (age.days > 0) )
				    ageString = age.years + yearString  + age.months + monthString  + age.days + dayString ;
				  else if ( (age.years == 0) && (age.months == 0) && (age.days > 0) )
				    ageString =  age.days + dayString;
				  else if ( (age.years > 0) && (age.months == 0) && (age.days == 0) )
				    ageString = age.years + yearString ;
				  else if ( (age.years > 0) && (age.months > 0) && (age.days == 0) )
				    ageString = age.years + yearString + age.months + monthString;
				  else if ( (age.years == 0) && (age.months > 0) && (age.days > 0) )
				    ageString = age.months + monthString + age.days + dayString ;
				  else if ( (age.years > 0) && (age.months == 0) && (age.days > 0) )
				    ageString = age.years + yearString + age.days + dayString ;
				  else if ( (age.years == 0) && (age.months > 0) && (age.days == 0) )
				    ageString = age.months + monthString ;
				  else ageString = ".";

				  // for date formate is 12_02_2019
				  
				  console.log("age years is "+age.years); 
	                 if(isNaN(age.years)){
	                         console.log("years is nan");
	                         ageString="";
	                         alert("Please provide Date of Birth in dd-MM-YYYY format");
	                 }else{
	                         console.log("not nan");
	                 }
	                 console.log("ageString is "+ageString);
				  
				  return ageString;
				}



			//	alert(getAge('28/05/1995'));
	
	
	// funtion to be executed whenever the next button is called on the last page of the form
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
		
		 var marksGrade=0;
		var totalGrade=0;
		var perGrade=0; 
		
		
		 var marksGradatution=0;
			var totalGradutation=0;
			var perGradatuation=0; 
			
		
		var perMP=0;
		var grMP=0;
		var perHS=0;
		var grHS=0;
		var perGrGen=0;
		var grGrdGen=0;

		var perHons=0
		var grHons=0;
		var perMaster=0;
		var grMaster=0;
		var totalGradePoint=0.0;
		var seDoctorate="";
		var grDoctorate=0;
		
		var currency=""; 
		
		
		 //pgcourse
   	 var pgCategory="";
   	 var pgDACategory="";
   	 var pgDACategoryType="";
   	 
   	 var pgSportsCategory="";
   	 var pgSportsCategoryType="";
   	 var pgFeeToPay=150;
		
	//BU105
   	 var cgpaPoint=0
   	 var tcpaPoint=0

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
	 		 	    		alert("sign is mandatory but not uploaded");
	 					    signature_upload = false;
	 		 	        }
				        }
	 		 	    }
					
		
				
				//new requirement
				
				//starting
				
				///////////////////////////
				
				 	if(elements[i].name=="Category-"){
			 	   		pgCategory = elements[i].value;
		 	    	}
			 	   if(elements[i].name=="Differently Abled-"){
			 		  pgDACategory = elements[i].value;
		 	    	}
			 	   
			 		if(elements[i].name=="Differently Abled Category"){
			 			pgDACategoryType = elements[i].value;
		 	    	}
			 		
			 		if(elements[i].name=="Sports Personality-"){
			 			pgSportsCategory = elements[i].value;
		 	    	}
		
			 		if(elements[i].name=="Sports Level"){
			 			pgSportsCategoryType = elements[i].value;
		 	    	}
			 	   if(elements[i].name=="Fee To Pay"){
			 		   var pgStatusDACat=false;
			 		   var pgStatusSPCat=false;
			 		  // alert(".. "+pgDACategory+ " pgDACategoryType "+pgDACategoryType + " pgSportsCategory "+pgSportsCategory+" pgSportsCategoryType "+pgSportsCategoryType );
			 		   if(pgDACategory.includes("No") && pgDACategoryType.includes("Not Applicable"))
			 		   {
			 			   //300
			 			  pgStatusDACat=true;
			 		   }else if(pgDACategory.includes("Yes") && pgDACategoryType.includes("Not Applicable"))
			 		   {
			 			   //300
				 			  pgStatusDACat=true;
				 		   }
			 		   
			 		  else if(pgDACategory.includes("No") && !pgDACategoryType.includes("Not Applicable"))
			 		   {
			 			   //300
				 			  pgStatusDACat=true;
				 	   }
			 		   
			 		   //alert("pgStatusDACat "+pgStatusDACat);
			 		   
			 		  if(pgSportsCategory.includes("No") && pgSportsCategoryType.includes("Not Applicable"))
			 		   {
			 			  //300
			 			 pgStatusSPCat=true;
			 		   }else if(pgSportsCategory.includes("Yes") && pgSportsCategoryType.includes("Not Applicable"))
			 		   {
			 			   //300
				 			  pgStatusSPCat=true;
				 		   }
			 		   
			 		  else if(pgSportsCategory.includes("No") && !pgSportsCategoryType.includes("Not Applicable"))
			 		   {
			 			   //300
				 			  pgStatusSPCat=true;
				 	 }
			 		  
			 		 //alert("pgStatusSPCat "+pgStatusSPCat);
			 		   
			 		// alert("pgCategory "+pgCategory + " pgStatusSPCat "+pgStatusSPCat+ " pgStatusDACat "+pgStatusDACat);
			 		   if(pgCategory.includes("Unreserved") && 
			 				   pgStatusSPCat && pgStatusDACat){
			 		  elements[i].value=300;
			 		  amount="300";
			 		   }else{
			 			  elements[i].value=150;
			 			 amount="150";
			 		   }
			 		   alert("Fee to Pay "+elements[i].value);
		 	    	}
				
				
				////////////////////////////
				

				if(elements[i].name=="PERCENT MARKS OBTAINED-A-MP"){
					perMP = elements[i].value;
					if(elements[i].value > 100){
						elements[i].value="";
						perMP="";
						alert("PERCENT MARKS OBTAINED-A-MP should be less then 100 ");
					}
					
				}
				if(elements[i].name=="GRADE POINT-10-PERCENT OF A-MP"){
					
					if(perMP!=""){
					elements[i].value = perMP*0.1;
					grMP=elements[i].value;
					}
					alert("GRADE POINT-10 PERCENT OF A-MP "+elements[i].value);
					totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grMP));
				//	alert("total grade "+parseFloat(totalGradePoint).toFixed());
				}
				
				if(elements[i].name=="PERCENT MARKS OBTAINED-B-HS"){
					perHS = elements[i].value;
					if(elements[i].value > 100){
						
						elements[i].value="";
						perHS="";
						alert("PERCENT MARKS OBTAINED-B-HS should be less then 100 ");
					}
					
				}
				if(elements[i].name=="GRADE POINT-10-PERCENT OF B-HS"){
					
					if(perHS!=""){
					elements[i].value = perHS*0.1;
					grHS=elements[i].value;
					}
					alert("GRADE POINT-10-PERCENT OF B-HS "+elements[i].value);
					totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grHS));
				//	alert("total grade "+parseFloat(totalGradePoint).toFixed());
				}
				//////////////////
				
				if(elements[i].name=="PERCENT MARKS OBTAINED-C-GRADUATION-GEN"){
					perGrGen = elements[i].value;
					if(elements[i].value > 100){
						
						elements[i].value="";
						perGrGen="";
						alert("PERCENT MARKS OBTAINED-C-GRADUATION-GEN should be less then 100 ");
					}
					
				}
				if(elements[i].name=="GRADE POINT-15-PERCENT OF C-GEN"){
					
					if(perGrGen!=""){
					elements[i].value = perGrGen*0.15;
					grGrdGen=elements[i].value;
					}
					alert("GRADE POINT-15-PERCENT OF C-GEN "+elements[i].value);
					totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grGrdGen));
				//	alert("total grade "+parseFloat(totalGradePoint).toFixed());
				}
				
				/////////////////////////
				
				if(elements[i].name=="PERCENT MARKS OBTAINED-D-GRADUATION-HONS"){
					perHons = elements[i].value;
				//	alert("PERCENT MARKS OBTAINED-D-GRADUATION-HONS  "+elements[i].value);
					if(elements[i].value > 100){
						
						elements[i].value="";
						perHons="";
						alert("PERCENT MARKS OBTAINED-D-GRADUATION-HONS should be less then 100 ");
					}
					
				}
				if(elements[i].name=="GRADE POINT-20-PERCENT OF D-HONS"){
					
					if(perHons!=""){
					elements[i].value = perHons*0.2;
					grHons=elements[i].value;
						
					}
					totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grHons));
					alert("Grade Point of Graduation Hons. "+grHons);
				}
				
				//////////////////////////
				
				
				
				if(elements[i].name=="PERCENT MARKS OBTAINED-E-MASTERS"){
					perMaster = elements[i].value;
					if(elements[i].value > 100){
						
						elements[i].value="";
						perMaster="";
						alert("PERCENT MARKS OBTAINED-E-MASTERS should be less then 100 ");
					}
					
				}
				if(elements[i].name=="GRADE POINT-20-PERCENT OF E-MASTERS"){
					
					if(perMaster!=""){
					elements[i].value = perMaster*0.2;
					grMaster=elements[i].value;
					alert("Grade Point of Master "+grMaster);		
					}
					totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grMaster));
					//alert("total grade "+parseFloat(totalGradePoint).toFixed());
				}
				
				if(elements[i].name=="COURSE-DOCTORATE-MPHIL DEGREE"){
					seDoctorate=elements[i].value;
				//	alert("COURSE-DOCTORATE-MPHIL DEGREE "+seDoctorate);
			}
				
				if(elements[i].name=="GRADE POINT FOR PHDMPHILBOTH" || elements[i].name=="GRADE POINT FOR PHD/M.PHIL/BOTH" ){
					//alert("grade "+seDoctorate);
				if(seDoctorate.includes("M.Phil") || seDoctorate.includes("M.PHIL")){
					//alert("grade1 "+seDoctorate);
					grDoctorate="5";
					
					
				}else if(seDoctorate.includes("PHD") || seDoctorate.includes("PHD ")){
					grDoctorate="8";
					
					
				}else if(seDoctorate.includes("BOTH") || seDoctorate.includes("BOTH ")){
					grDoctorate="8";
					
					
				} 
				else{
				//	alert("grade 2"+seDoctorate);
					grDoctorate="0";
				}
				//alert("grade3 "+grDoctorate);
				elements[i].value=grDoctorate;
				alert("GRADE POINT FOR PHD/M.PHIL "+elements[i].value);
				totalGradePoint=(parseFloat(totalGradePoint))+(parseFloat(grDoctorate));
				}
				
				
				if(elements[i].name=="TOTAL GRADE POINT"){
				//	alert(" Final total "+(grHS+grMP + grGrdGen+grHons+grMaster));
					elements[i].value=(parseFloat(grHS).toFixed(2))+(parseFloat(grMP).toFixed(2))+(parseFloat(grGrdGen).toFixed(2))+(parseFloat(grHons).toFixed(2))+(parseFloat(grMaster).toFixed(2));
					elements[i].value=totalGradePoint;
					elements[i].value=parseFloat(elements[i].value).toFixed(2)
					alert("TOTAL GRADE POINT "+elements[i].value)
					
				}
				
				//////////////////////////

				/* finished */
				
				if(elements[i].name=="Category 1" || elements[i].name=="Category-" || elements[i].name=="Category"){
					category = elements[i].value;
				//	alert("category is last "+category);
				}
				
				
			 	if(elements[i].name=="Total Marks-Grade Master"){
			
					totalGrade = elements[i].value;
					 if(isNaN(elements[i].value)){
                                                        elements[i].value="";
                                                }

					totalGrade=parseInt(totalGrade);
				//	alert("marks obtained in MP "+gradeMP);
				}
				if(elements[i].name=="Marks obtained Master"){
					marksGrade = elements[i].value;
					 if(isNaN(elements[i].value)){
                                                        elements[i].value="";
                                                }

			//	alert("Before Total marks in MP "+ totalMarksMP);
					if(marksGrade===0  ){
						alert("Please provide correct total marks in Master");
						elements[i].value="";
						marksGrade="";
					}else{
						marksGrade = elements[i].value;

						}
					marksGrade=parseInt(marksGrade);	
				//	alert("Total marks in MP "+ totalMarksMP);
				}
			//	alert("elements name "+elements[i].name + " "+elements[i].value);
				if(elements[i].name=="Percentage Master"){
				//	alert("after Total marks in MP "+ totalMarksMP + "  "+gradeMP);
						if(totalGrade>marksGrade){
							perGrade = (marksGrade/totalGrade)*100;
					//		alert("category in grade is "+category);
							if(category.includes("UR")){
								if(perGrade<55){
									alert("You are not eligible");
									elements[i].value="";
									totalGrade="";
									marksGrade="";
									perGrade="";
								}
							
							}else{
								if(perGrade<50){
									alert("You are not eligible");
									elements[i].value="";
									totalGrade="";
									marksGrade="";
									perGrade="";
								}
							}
							
							
							alert("Your percentage in Grade Master "+perGrade);
						}
						
						else{
							alert("Obtained marks should be less then total marks.");
							elements[i].value="";
							totalGrade="";
							marksGrade="";
							perGrade="";
						}
						
					//	alert("% marks in MP "+ perMarksMP + "  "+elements[i].value);
						elements[i].value = perGrade;
						if(elements[i].value !=""){
						elements[i].value = parseFloat(elements[i].value).toFixed(2);
						}
				}
				 
				
				
				
				
				if(elements[i].name=="Total Marks-Grade"){
					totalGradutation = elements[i].value;
					totalGradutation=parseInt(totalGradutation);
				//	alert("marks obtained in MP "+gradeMP);
				}
				if(elements[i].name=="Marks Obtained"){
					marksGradatution = elements[i].value;
			//	alert("Before Total marks in MP "+ totalMarksMP);
					if(marksGradatution===0  ){
						alert("Please provide correct total marks in Grade");
						elements[i].value="";
						marksGradatution="";
					}else{
						marksGradatution = elements[i].value;

						}
					marksGradatution=parseInt(marksGradatution);	
				//	alert("Total marks in MP "+ totalMarksMP);
				}
					
					// Use for BU105 M.Tech form File
					
					if(elements[i].name=="CGPA or Equivalent in 10 point scale - if applicable"){
						//alert("CGPA or Equivalent in 10 point scale - if applicable for bu105 ");
							if(elements[i].value=="" || elements[i].value==null || elements[i].value>=10 ||elements[i].value<0 ){
								alert("Please insert CGPA or Equivalent in less than 10 point scale");
								elements[i].value="";
								return false;
							}else{
								cgpaPoint = elements[i].value;
								//alert("cgpaPoint is ::: "+cgpaPoint);
							}
					}
					
					if(elements[i].name=="TCPA or Equivalent in 100 point scale - if applicable"){
						//alert("TCPA or Equivalent in 100 point scale - if applicable for bu105 ");
							if(elements[i].value=="" || elements[i].value==null || elements[i].value>=100 ||elements[i].value<=0 ){
								alert("Please insert TCPA or Equivalent in less than 100 point scale");
								elements[i].value="";
								return false;
							}else{
								tcpaPoint = elements[i].value;
								//alert("tcpaPoint is ::: "+tcpaPoint);
							}
					}
					
					//end BU105 M.Tech Form File
					
					
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
	 		 	    			alert("Photo is mandatory but not uploaded");
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
	 		 	    			alert("file is mandatory but not uploaded");
	 		 					file_upload = false;
	 		 					
	 		 		 	    	}
	 		 	    	}
	 		 	        
	 		    }	 	    		
	 	    		
					
					//changes for file upload
		 	    
		 	    if(elements[i].required!=null){
		 	    	//alert("this is in submit button 1");
		 	    	if(elements[i].required){
		 	    	//alert("Mandatory Field Name : "+elements[i].name+", and Field Value is at 2991: "+elements[i].value);
		 	    		//alert("this is in submit button 2");
		 	    	
	 	    		if(elements[i].value.trim()=="" || (elements[i].checked==false && elements[i].type=='checkbox' 
	 	    				&& elements[i].value.trim()=="off")){
	 	    			//alert("this is in submit button 3");
	 	    				alert("fields '"+ elements[i].name +"' with red asterisk must be filled in, So Please Fill that");
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
	
		
		  //if(validationpass==true){
		//		submitFormUsingAjax(submitShotFlag, currentpagectr);
		 // }
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
				
				//alert("calling submitFormUsingAjax() "+currentpagectr)
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
						
						// validate and reject stale sessions : code starts 

						var bid = '<%=sesBid %>';
						var cid = '<%=sesCid %>';			
						var formtemplateid = document.getElementById("currentFormId").value;			
					//	var forminstanceid = document.getElementById("formInstanceId").value;
					//	alert('formtemplateid being sent in ajax call is::'+formtemplateid);
					//	alert('forminstanceid being sent in ajax call is::'+forminstanceid);		
						
						// validate and reject stale sessions : code ends 
						
						xhttp.open("GET", window.location.origin+result+"/processForm?"+ argument+"&bid="+bid+"&cid="+cid+"&formid="+formtemplateid + "&forminstanceid="+forminstanceid, true);
						
						
						xhttp.send();

		return false;
	}
	
	
	
	
	function goToStart(){
		var bid =<%=sesBid%>;
		var cid =<%=sesCid%>;
		window.location="StartUrl?bid="+bid+"&cid="+cid+"&currentSessionReturn=Y";
		
	}		
	
	function goToForm(){
//	alert("go to form ");
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
	
//	alert("called gotoformPages ");
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
				
				
				// validate and reject stale sessions : code starts 

				var bid = '<%=sesBid %>';
				var cid = '<%=sesCid %>';

				
				// validate and reject stale sessions : code ends 				
				
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
				
				// validate and reject stale sessions : code starts 

				var bid = '<%=sesBid %>';
				var cid = '<%=sesCid %>';						

				
				// validate and reject stale sessions : code ends 				
				
				
				xhttp.open("GET", window.location.origin+result+"/GetForms?isActor=N&PayeeProfile=" + opt+ "&bid="+bid+ "&cid="+cid,
						true);
				
				xhttp.send();
			}

		}

		function getFormPages() {
		//	alert("getFormPages() "+document.getElementById("formId").value);
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
			
			// validate and reject stale sessions : code starts 

			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';
	
			
			// validate and reject stale sessions : code ends 			
		//	alert("form id "+formId+ " bid "+bid+ " cid "+cid);
		//	alert("request is "+window.location.origin+result+"/getFormforPayer?formId=" + formId + "&bid="+bid+ "&cid="+cid);
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
			
			// validate and reject stale sessions : code starts 

			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';
			var formtemplateid = document.getElementById("currentFormId").value;			
			var forminstanceid = document.getElementById("formInstanceId").value;
			//alert('formtemplateid now is::'+formtemplateid);
			//alert('forminstanceid is::'+forminstanceid);	
			
			//validate and reject stale sessions : code ends 				
			
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
				
				
				// validate and reject stale sessions : code starts 

				var bid = '<%=sesBid %>';
				var cid = '<%=sesCid %>';
				
				// validate and reject stale sessions : code ends 					
				
				
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
			
			//  validate and reject stale sessions : code starts 

			var bid = '<%=sesBid %>';
			var cid = '<%=sesCid %>';
			//alert('bid is::'+bid);
			//alert('cid is::'+bid);
			
			// validate and reject stale sessions : code ends 			
			
			
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
																window.location = "PaySessionOut.jsp";
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
												
												//  validate and reject stale sessions : code starts 

												var bid = '<%=sesBid %>';
												var cid = '<%=sesCid %>';
												//alert('bid is::'+bid);
												//alert('cid is::'+bid);
												
												// validate and reject stale sessions : code ends 													
												
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
														window.location = "PaySessionOut.jsp";
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
	//alert("Filed type "+elements[i].type+", and value is "+elements[i].value+", status "+elements[i].checked);
														    			if(elements[i].checked){
													    					AddToArray("on", elements[i].name,elements[i].id,i);
														    			}													    			else{
		//alert("Inside false checkbox condition");							AddToArray("off", elements[i].name,elements[i].id,i);
		elements[i].value="off";
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
											
											var l=value.length;
											var n=value.indexOf("*");
											value=value.substring(n+1, l)
											//alert (value);
											value = value.split(",").join("");
											value = value.split("`").join("");
											value = value.split("=").join("");
											/* values[id] = id + "`" + name + "=" + value+"$"+order; */
											/*update ` character with & as it was given 400 bad request  */
											values[id] = id + "~" + name + "=" + value+"$"+order;
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

	<!-- <s:if test='%{form.getJsEnabled().contentEquals("Y")}'>
		<script src="js/formjs/myScriptNew2468.js"></script>
	</s:if> -->
	
	 <script language="javascript" type="text/javascript"
		src="js/datetimepicker_css.js">
	</script> 

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>
	
	<!-- Js files for Validation Start -->
       <script src="js/formjs/myScriptNew2468.js"></script>
        <script src="js/formjs/myScriptAYPA1_20Sep_v1e.js"></script>
        <script src="js/formjs/RNCB1FormValidation_16Dec2019.js"></script>
        <script src="js/formjs/HEP01FormValidation_04March2020_v1.js"></script>
        <script src="js/formjs/BU104_BU105_28Feb2020_Validation_V3.js"></script>
        <script src="js/formjs/SKMUFormValidation_19March2020.js"></script>
        <script src="js/formjs/NESSS_Validation_30April2020_V1.js"></script>
        <script src="js/formjs/STACSTuitionOnlineFee_15July2020.js"></script>
        <script src="js/formjs/TNBCollege_validations.js"></script>
        <script src="js/formjs/SIMC1_FormValidations.js"></script>
        <script src="js/formjs/CBGKS_FormValidations.js"></script>
        <script src="js/formjs/CBGKS_FormValidation.js"></script>
        <script src="js/formjs/KIRODIMALFormValidations.js"></script>
        <script src="js/formjs/RECUPFormValidation_V2.js"></script>
	
	<!--  Js files for Validation Start -->
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
					window.location = "PaySessionOut.jsp";
				}

				}, 120000);
			}
			
			
			function gotoBankLandingPage(bid){
				
				window.location = "StartUrl?bid="+bid+"&cid=ALL&currentSessionReturn=Y&redirectedFrom=Bank";
				
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

</body>
</html>
