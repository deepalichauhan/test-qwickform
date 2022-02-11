<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<!DOCTYPE html>
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

<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
<script src="https://www.google.com/recaptcha/api.js"></script>
</head>

<body>

<%
			/* String cid = (String) session.getAttribute("cid"); */
		 int bid1=Integer.parseInt((String)session.getAttribute("bid"));
		 AppPropertiesConfig quickCollectProperties = new AppPropertiesConfig();
			Properties properties = quickCollectProperties.getPropValues();

			String clientLogoLink = properties.getProperty("clientLogoLink");
		%>
  <form name="payFormCollege" action="processForm" method="post">
  <input type="hidden" id="values" name="values" value=""/>
   <input type="hidden" id="source" name="source" value="demo"/>
  
	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#"> <img
				alt="Charisma Logo" src="img/councilLogo.jpg"></a> <a
				class="navbar-brand" href="<%=clientLogoLink%>"><span>CHSE, Odisha
					</span></a>
			
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			<%
				if (bid1 == 1) {
			%>
			<img alt="" src="img/allahabad_logo.jpg">

			<%
				}

				else if (bid1 == 2) {
			%>
			<img alt="" src="img/UCO_logo1.jpg" style="width: 300px;height: 80px;">

			<%
				} else if (bid1 == 3) {
			%>
			<img alt="" src="img/UBI_logo1.jpg">

			<%
				}
			%>
		</div>
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">
			<div id="content" class="col-lg-12 col-sm-12">
				<!-- content starts -->
				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Provide details
									of payment
								</h2>
							</div>
							<table id="mainForm4">
								<tr>
									<td><label class="control-label" for="roll">College
											Code(2 characters and 2 digits)*</label></td>
									<td><input
										onchange="AddToArray(this.value,this.name,this.id)"
										name="College Code" required="required" type="text"
										class="form-control" id="401" value='<c:out value="collegeBean.collegeCode"/>'></td>
								</tr>
								<tr>
									<td><label class="control-label" for="stuname">Name
											of the College*</label></td>
									<td><input
										onchange="AddToArray(this.value,this.name,this.id)"
										name="Name of the College" required="required" type="text"
										class="form-control" id="402" value='<c:out value="collegeBean.collegeName"/>'></td>
								</tr>
								<tr>
									<td><label class="control-label" for="fathername">Address
											(without comma)*</label></td>
									<td><input
										onchange="AddToArray(this.value,this.name,this.id)"
										name="College Address" required="required" type="text"
										class="form-control" id="403"></td>
								</tr>
								<tr>
									<td><label class="control-label" for="fathername">No.
											of Candidates in Arts*</label></td>
									<td><input
										onchange="GetTotalCount(),AddToArray(this.value,this.name,this.id)"
										name="No of Candidates in Arts" required="required"
										type="text" class="form-control" id="404" value="0"></td>
								</tr>
								<tr>
									<td><label class="control-label" for="fathername">No.
											of Candidates in Science*</label></td>
									<td><input
										onchange="GetTotalCount(),AddToArray(this.value,this.name,this.id)"
										name="No of Candidates in Science" required="required"
										type="text" class="form-control" id="405" value="0"></td>
								</tr>

								<tr>
									<td><label class="control-label" for="fathername">No.
											of Candidates in Commerce*</label></td>
									<td><input
										onchange="GetTotalCount(),AddToArray(this.value,this.name,this.id)"
										name="No of Candidates in Commerce" required="required"
										type="text" class="form-control" id="406" value="0"></td>
								</tr>
								<tr>
									<td><label class="control-label" for="fathername">Total
											no. of Candidates other than BSE</label></td>
									<td><input
										onchange="GetTotalCount(),AddToArray(this.value,this.name,this.id)"
										name="Total no of Candidates other than BSE"
										required="required" type="text" class="form-control" id="407"
										value="0"></td>
								</tr>
								<tr>
									<td><label class="control-label" for="fathername">Total
											No. of Candidates</label></td>
									<td><input onchange="GetTotalCount()"
										name="Total No of Candidates" required="required"
										readonly="readonly" class="form-control" id="408"> <!-- AddToArray(this.value,this.name,this.id) -->
									</td>
								</tr>
								<tr>
									<td><label class="control-label" for="fathername">Total
											amount of fees</label></td>
									<td><input
										onchange="AddToArray(this.value,this.name,this.id)"
										name="Total Amount" required="required" readonly="readonly"
										type="text" class="form-control" id="409"></td>
								</tr>
								<tr>
									<td><label class="control-label" for="fathername">Mobile
											no.(10 digits)</label></td>
									<td><input 
										onchange="AddToArray(this.value,this.name,this.id),autoPopulateNextMobileNum(this.value);"
										name="Mobile no" required="required" type="text" 
										class="form-control" id="410"></td>
								</tr>
								<tr>
									<td><label class="control-label" for="fathername">Remarks</label></td>
									<td><input
										onchange="AddToArray(this.value,this.name,this.id)"
										name="Remarks" required="required" type="text"
										class="form-control" id="411"></td>
								</tr>
								</tr>
								<tr>
									<td colspan="2"><strong> * Total amount will be
											Rs.430/- X number of students and Students admitted other
											than BSE will have to pay Rs.20/- extra per student. </strong></td>
								</tr>
								<tr>
									<td colspan="2"><strong> * ROM shall not be
											accepted by the Council without a copy of the e-Receipt. </strong></td>
								</tr>
								<tr>
									<td colspan="2"><strong>Please enter your Name,
											Date of Birth & Mobile Number. This is required to reprint
											your e-receipt / remittance(PAP) form, if the need arises.</strong></td>
								</tr>
								<tr>
									<td><label class="control-label" for="stuname">Name*</label></td>
									<td><input
										onchange="AddToArray(this.value,this.name,this.id)"
										name="Name" required="required" type="text"
										class="form-control" id="412" value='<c:out value="collegeBean.collegeName"/>'></td>
								</tr>
								<tr>
									<td><label class="control-label" for="dob">Date of
											Incorporation*</label></td>
									<td><input
										onchange="AddToArray(this.value,this.name,this.id)"
										name="Date of Incorporation" required="required" type="date"
										class="form-control" id="413"></td>
								</tr>
								<tr>
									<td><label class="control-label" for="stucontact">Mobile
											Number*</label></td>
									<td><input id="mobileNumber2"
										onchange="AddToArray(this.value,this.name,this.id)"
										name="Mobile Number" required="required" type="tel"
										pattern="[0-9]*" class="form-control" ></td><!-- id="414" -->
								</tr>
								<tr>
									<td><label class="control-label" for="Email Id">Email
											Id </label></td>
									<td>
										<input
										onchange="AddToArray(this.value,this.name,this.id)"
										name="Email" id="415" required="required"
										placeholder="Enter Email Id" type="email" class="form-control">
									</td>
								</tr>
								<tr>
									<%
										String msg = (String) request.getAttribute("msg");
										if (msg != null) {
									%>
									<Span style="color: red"><%=msg%></Span>
									<%
										}
									%>
								 <td><div class="g-recaptcha"  
											data-sitekey="6Lfh-BMTAAAAAFgFlcuXcIbOQsOYDtQv_KPG9P1G"></div></td> 
									
									<td>
										<button type="button" id="submit_button"
											class="btn btn-success">Pay</button>
									</td>
									<td>
										
									</td>
								</tr>





								<!-- 	</form> -->
								</div>
								</div>
								</div>
								</div>
								<!--/row-->


								<!-- content ends -->
								</div>
								<!--/#content.col-md-0-->
								</div>
								<!--/fluid-row-->


								<hr>

								<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true">

									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">×</button>
												<h3>Settings</h3>
											</div>
											<div class="modal-body">
												<p>Here settings can be configured...</p>
											</div>
											<div class="modal-footer">
												<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
												<a href="#" class="btn btn-primary" data-dismiss="modal">Save
													changes</a>
											</div>
										</div>
									</div>
								</div>
								<footer class="row">

									<div style="text-align: center;">

										<!-- <a href=""
											onclick="window.open('ContactUs.html','mywindowtitle',
											'width=500,height=550')">Contact
											Us </a> <span> |&nbsp;&nbsp;</span> <a href=""
											onclick="window.open('PrivacyPolicy.html','mywindowtitle',
											'width=500,height=550')">Privacy
											Policy </a> <span> |&nbsp;&nbsp;</span> <a href=""
											onclick="window.open('Terms And Conditions.html','mywindowtitle',
											'width=500,height=550')">Terms
											& Conditions </a> <span> |&nbsp;&nbsp;</span> <a href=""
											onclick="window.open('Disclaimer.html','mywindowtitle',
											'width=500,height=550')">Disclaimer
										</a> -->







									</div>


								</footer>


								</div>
								<!--/.fluid-container-->

								<!-- external javascript -->

								<script
									src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

								<!-- library for cookie management -->
								<script src="js/jquery.cookie.js"></script>
								<!-- calender plugin -->
								<script src='bower_components/moment/min/moment.min.js'></script>
								<script
									src='bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
								<!-- data table plugin -->
								<script src='js/jquery.dataTables.min.js'></script>

								<!-- select or dropdown enhancer -->
								<script src="bower_components/chosen/chosen.jquery.min.js"></script>
								<!-- plugin for gallery image view -->
								<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
								<!-- notification plugin -->
								<script src="js/jquery.noty.js"></script>
								<!-- library for making tables responsive -->
								<script
									src="bower_components/responsive-tables/responsive-tables.js"></script>
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

								<script>
									function GetForm(x) {
										if (x == "1") {
											document
													.getElementById("mainForm1").style.display = "block";
											document
													.getElementById("mainForm2").style.display = "none";
										}
										if (x == "2") {
											document
													.getElementById("mainForm1").style.display = "none";
											document
													.getElementById("mainForm2").style.display = "block";
										}
									}

									var fee = 0;
									var totfee = 0;
									var hostel = 0;
									var bus = 0;
									var hostelfee = 0;
									var busfee = 0;
									function GetFees(x) {
										document.getElementById("nitForm")
												.reset();
										if (x == "BT3" || x == "MT3GEN"
												|| x == "MB14GEN") {
											fee = 42450;
											hostel = 2500;
											bus = 1800;
										}
										if (x == "BT5" || x == "BT7") {
											fee = 24950;
											hostel = 2500;
											bus = 1800;
										}
										if (x == "MT15SC" || x == "MB15SC"
												|| x == "MS15SC"
												|| x == "PD15SCFT"
												|| x == "PD15SCPT") {
											fee = 12550;
											hostel = 2500;
											bus = 1800;
										}
										if (x == "MS14GEN" || x == "PDGEN") {
											fee = 14950;
											hostel = 2500;
											bus = 1800;
										}
										if (x == "MT14SC" || x == "MB14SC"
												|| x == "MS14SC"
												|| x == "MT12SC"
												|| x == "MT14SC") {
											fee = 7450;
											hostel = 2500;
											bus = 1800;
										}
										if (x == "MT12GENPT") {
											fee = 17450;
										}
										if (x == "MT14GENPT") {
											fee = 27450;
										}
										if (x == "BT1" || x == "MT15GEN"
												|| x == "MB15GEN") {
											fee = 47550;
											hostel = 2500;
											bus = 1800;
										}
										if (x == "MS15GEN" || x == "PD15GENFT"
												|| x == "PD15GENPT") {
											fee = 20050;
											hostel = 2500;
											bus = 1800;
										}
										document.getElementById("fee").value = fee;
										document.getElementById("total").value = fee;
										document.getElementById("hosfee").value = 0;
										document.getElementById("busfee").value = 0;
										totfee = fee;

									}
									function TotalFee(y) {
										if (y == "HostelYes") {
											hostelfee = hostel;
										}
										if (y == "HostelNo") {
											hostelfee = 0;
										}
										if (y == "BusYes") {
											busfee = bus;
										}
										if (y == "BusNo") {
											busfee = 0;
										}
										document.getElementById("hosfee").value = hostelfee;
										document.getElementById("busfee").value = busfee;
										document.getElementById("total").value = fee
												+ busfee + hostelfee;
									}
									function Pay() {
										var linkadd = 'http://49.50.72.228:8080/SabPaisa/index.jsp?Name=Mr.XYZ&amt=7894&client=QuickCollect';
										window.location.href = linkadd;
									}
									function Reset() {
										document.getElementById("nitForm")
												.reset();
									}

									function GetFee1(x) {
										var fee = document
												.getElementById("total1");
										var fee2 = document
												.getElementById("fee1");
										if (x == "BT") {
											fee.value = "7894";
											fee2.value = "7894";
										}
										if (x == "CE") {
											fee.value = "4594";
											fee2.value = "4594";
										}
									}
									function GetFee2(x) {
										var fee = document
												.getElementById("total2");
										var fee2 = document
												.getElementById("fee2");
										if (x == "BT") {
											fee.value = "2394";
											fee2.value = "2394";
										}
										if (x == "CE") {
											fee.value = "4294";
											fee2.value = "4294";
										}
									}
									var values = {};

									function AddToArray(value, name, id) {
										
										
										value = value.split(",").join("");
										value = value.split("`").join("");
										value = value.split("=").join("");
										
										var totalNoofCandidates = document
												.getElementById("408").value;
										var totalAmount = document
												.getElementById("409").value;
										
										var id1 = "18";
										var name1 = "Total Amount";
										var id401 = document.getElementById("401").value;
										var id402 = document.getElementById("402").value;
										var id412 = document.getElementById("412").value;
										values[401] = 401 + "`" + "College Code"
										+ "=" + id401;
										values[402] = 402 + "`" + "Name of the College"
										+ "=" + id402;
										values[id] = id + "`" + name + "="
												+ value;
										values[id1] = id1 + "`"
												+ "Total No of Candidates"
												+ "=" + totalNoofCandidates;
										values[412] = 412 + "`" + "Name"
										+ "=" + id412;
										values[19] = 19 + "`" + "Total Amount"
												+ "=" + totalAmount;

										/* alert(JSON.stringify(values)); */

									}

									$("#submit_button")
											.click(
													function() {

														var emailI = $("#415")
																.val();
														var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
														var mobNum = $("#410").val();
														
														/* var mobNum1 = $("#414")
																.val(); */

														var patternMobNum = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;
														/*  var patternSem = /^\[0-9]+$/;
														 var sem=$("#6").val();
														 */var rollN = $("#401")
																.val();

														if ($("#402").val() == ""
																&& $("#403")
																		.val() == ""
																&& $("#404")
																		.val() == ""
																&& $("#405")
																		.val() == ""
																&& $("#406")
																		.val() == ""
																&& $("#407")
																		.val() == ""
																&& $("#408")
																		.val() == ""
																&& $("#409")
																		.val() == ""
																&& $("#411")
																		.val() == "") {
															alert('please fill the required field');
															return false;
														} /* else if ($("#6").val() == ""||sem.length != 1 || sem.match(patternSem )){
																																																																							    alert('please fill the vaild Semester')
																																																																							    return false;
																																																																							  } */
														/*  else if ($("#2").val() == ""){
															    alert('please fill the vaild Roll Number')
															    return false;
															  } */

														else if ($("#412")
																.val() == "") {
															alert('please fill the required field');
															return false;
														} else if ($("#410").val() == ""|| mobNum.length != 10|| !mobNum.match(patternMobNum)) {
															alert('please fill the valid Mobile Number');
															return false;
														} /* else if ($("#414")
																.val() == ""
																|| mobNum1.length != 10
																|| !mobNum
																		.match(patternMobNum)) {
															alert('please fill the valid Mobile Number');
															return false;
														} */

														else if (!emailI
																.match(emailReg)
																|| $("#415")
																		.val() == "") {
															alert('please fill the Email Id');
															return false;
														} else

															formSubmit();

													});

									function formSubmit() {

										var dataArray = new Array;
										for ( var value in values) {

											dataArray.push(values[value]);
										}

										var argument1 = "values=" + dataArray;
										var v=document.getElementsByName("g-recaptcha-response")[0].value;
										if(v.length == 0){
										alert("please Select Captcha...");
										return false;
										}
										document.getElementById("values").value=dataArray;
										document.getElementById("source").value="demo";
										document.payFormCollege.submit();
										
									//	window.location = "processForm?"+ argument + "&source=demo";

									}

									function GetTotalCount() {
										var artsCand = document
												.getElementById("404").value;
										var sCCand = document
												.getElementById("405").value;
										var coMCand = document
												.getElementById("406").value;
										var bsECand = document
												.getElementById("407").value;
										//alert(artsCand);
										//alert(artsCand);

										//alert(sCCand);

										//alert(coMCand);

										//alert(bsECand);

										var totAmt = parseFloat(artsCand)
												+ parseFloat(sCCand)
												+ parseFloat(coMCand)
												+ parseFloat(bsECand);
										var totAmtFee = parseFloat(artsCand)
												* 450 + parseFloat(sCCand)
												* 450 + parseFloat(coMCand)
												* 450 + parseFloat(bsECand)
												* 430;

										if (isNaN(totAmt)) {
											totAmt = 0;

										}
										document.getElementById("408").value = totAmt;
										if (isNaN(totAmtFee)) {

											totAmtFee == 0;

										}
										document.getElementById("409").value = totAmtFee;

									}
								function autoPopulateNextMobileNum(value){
							
								document.getElementById("mobileNumber2").value=value;	
									
									
								}	
									
								</script>
</form>
</body>

</html>
