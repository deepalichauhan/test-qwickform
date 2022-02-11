<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>

<meta charset="utf-8">
<title>NITJ</title>
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
<style id="antiClickjack">body{display:none !important;}</style>
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
		Integer sesBid = null;
		Integer sesCid = null;
		CollegeBean collegeBean = new CollegeBean();
		String payeeformIdQC = (String) request.getParameter("form.id");
		String PayeeProfile = null;
		String clgName = null;
		String insCode = null;
		try {
			sesBid = (Integer) session.getAttribute("BankId");
			sesCid = (Integer) session.getAttribute("CollegeId");
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			PayeeProfile = (String) session.getAttribute("PayeeProfile");
			clgName = (String) session.getAttribute("SelectedInstitute");
			insCode = (String) session.getAttribute("InstituteCode");

		} catch (java.lang.NullPointerException e) {
	%>
	<script type="text/javascript">
		window.location = "paySessionOut";
	</script>

	<%
		}
	%>

	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>

			<a class="navbar-brand" href="#"> <img alt="Charisma Logo"
				src="img/logo_nitj.png"></a> <a class="navbar-brand" href="#"><span>NITJ
			</span></a>


			
		</div>
		
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">


			<noscript>
				<div class="alert alert-block col-md-12">
					<h4 class="alert-heading">Warning!</h4>

					<p>
						You need to have <a href="http://en.wikipedia.org/wiki/JavaScript"
							target="_blank">JavaScript</a> enabled to use this site.
					</p>
				</div>
			</noscript>

			<div id="content" class="col-lg-12 col-sm-12">
				<!-- content starts -->




				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Student Fee
									Payment Form
								</h2>
								<%
									String collegeCode = (String) session.getAttribute("clientCode");
								%>
								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form id="nitForm" method="post">
									<!--action="payForm"  -->
									
									<table>
										<tr>
											<td colspan="2"><label class="control-label"
												for="selectBranch">Category </label> <!-- <label class="control-label" for="selectError">Semester
														</label> -->

												<div class="controls">



													<div class="controls">

														
														<select
															onchange="pleaseFill(),AddToArray(this.value,this.name,this.id)"
															name="Category" id="1" required="required"
															class="form-control">


															<option selected="selected" disabled="disabled">Select
																Neither bus nor Hostel</option>
															<option value="BusYes">Optional Day scholar who
																wants Bus facility</option>
															<option value="HostelYes">Hostler</option>
															<option value="DayScholar">Day Scholar</option>

														</select>
													</div></td>


										</tr>
										
										</div>
										</div>
										</td>
										</tr>
									</table>

									<table id="mainForm">
										<tr>
											<td><label class="control-label" for="roll">Roll
													Number</label></td>
											<td><input type="hidden"
												value='<%=request.getParameter("id")%>'> <input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Roll Number" id="2" required="required"
												pattern="[a-zA-Z0-9]*" placeholder="Enter Roll Number"
												type="text" class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name
													of Student</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="firstName" placeholder="Enter First Name"
												required="required" type="text" class="form-control"
												id="222"></td> &nbsp;
											
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="lstName" placeholder="Enter Last Name"
												required="required" type="text" class="form-control"
												id="223"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="fathername">Father's
													Name</label></td>
											<td>
												<!--  pattern="[a-zA-Z\s]*"--> <input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Father's Name" id="4" required="required"
												placeholder="Enter father Name" type="text"
												class="form-control">
											</td>
										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">
													Department </label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Department" id="55" class="form-control"
														placeholder="select the Department " required="required"><option
															selected="selected" disabled="disabled">Select
															The Department</option>
														<option value=""></option>
														<option value="BT">BT</option>
														<option value="CE">CE</option>
														<option value="CHE">CHE</option>
														<option value="CSE">CSE</option>
														<option value="ECE">ECE</option>
														<option value="ICE">ICE</option>
														<option value="IPE">IPE</option>
														<option value="ME">ME</option>
														<option value="TT">TT</option>
														<option value="MATH">MATH</option>
														<option value="PHYSICS">PHYSICS</option>
														<option value="CHEMISTRY">CHEMISTRY</option>
														<option value="HM">HM</option>
													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="sem">Semester</label></td>
											<td><div class="controls">

													<!-- onchange="TotalFee(this.value)" -->
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Semester" id="6" required="required"
														class="form-control">
														<option selected="selected" disabled="disabled">Select
															An Option</option>
													
														<option selected="selected" disabled="disabled">Select
															the Semester</option>
														<option value="1">1</option>
														<option value="2">2</option>
														<option value="3">3</option>
														<option value="4">4</option>
														<option value="5">5</option>
														<option value="6">6</option>
														<option value="7">7</option>
														<option value="8">8</option>

													</select>
												</div>
											</td>
										</tr>
										<tr>
											<td><label class="control-label" for="selectError">Payment Category
											</label></td>
											<td>
												<div class="controls"  id="pageRCCode">
													<select
														onchange="TotalFee(this.value),AddToArray(this.value,this.name,this.id)"
														name="Semester" id="77" data-rel="chosen"
														required="required" class="form-control">
														<option selected="selected" disabled="disabled">Select
															An Option</option>
														<option value="BTech2013B">B.Tech 2013 Batch</option>
														<option value="BTech2013bNonSARC">B.Tech.2013
															batch(DASA) students of self financial scheme(Non SARC)</option>
														<option value="BTech2013bSARCCountry">B.Tech.2013
															batch(DASA) students of self financial scheme(SARC
															Country)</option>
														<option value="BTech2014B">B.Tech 2014 Batch</option>
														<option value="BTech2015B">B.Tech 2015 Batch</option>
														<option value="BTech20142015bNonSARC">B.Tech.2014
															& 2015 batch(DASA) students of self financial scheme(Non
															SARC Country)</option>
														<option value="BTech20142015bSARCCountry">B.Tech.2014
															& 2015 batch(DASA) students of self financial scheme(SARC
															Country)</option>
														<option value="MTechMBA2015BGenOBC">M.Tech/MBA
															2015 Batch (Gen/OBC)</option>
														<option value="MTechMBA2015BSCSTCat">M.Tech/MBA
															2015 Batch (SC/ST Cat)</option>
														<option value="MSc2015PhDFTGenOBCCat">M.Sc 2015
															Batch & Ph.D (Full Time) all Batch (Gen/OBC Cat)</option>
														<option value="MSc2015PhDFTSCSTCat">M.Sc 2015
															Batch & Ph.D (Full Time) all Batch (SC/ST Cat)</option>
														<option value="MTechPT2013b7sem">M.Tech (Part
															Time)2013 batch 7th sem.</option>
														<option value="MTechPT2014b">M.Tech (Part
															Time)2014 batch</option>
														<option value="PhDPT">Ph.D (Part Time)</option>
														<option value="MTechPTC7s">M.Tech Part Time
															Continuation fee after 7th semester.</option>
														<option value="BTechCF">B.Tech Continuation fee</option>
														<option value="MTechPhDPTInternalF">M.Tech/Ph.D
															(Part Time) Internal(NITJ) Faculty/staff</option>

													</select>
												</div>
											</td>
										</tr>
										<tr>
											<td><label class="control-label" for="selectError">Late
													Fees </label></td>
											<td><div id="365ref">
													<input onblur="lstCal()"
														
														name="Late Fees" id="365" required="required"
														pattern="[0-9]*" min="1" max="20" value="500"
														placeholder="Enter Late Fees" type="number" readonly
														class="form-control">
												</div></td>
										</tr>



										<tr>
											<td><label class="control-label" for="total">Total
													Fee</label></td>
											<td>
												 <div id="reftotal"><input type="number"
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Total Fee" id="total1" readonly="readonly"
												class="form-control"></div>
											</td>
										</tr>

										<tr>
											<td><label class="control-label" for="remarks">Remarks</label></td>
											<td>
												 <textarea
													onchange="AddToArray(this.value,this.name,this.id)"
													name="Remarks" id="13" class="form-control"
													placeholder="Enter Remarks" required="required"></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="2"><strong>Please enter your Name,
													Date of Birth & Mobile Number. This is required to reprint
													your e-receipt / remittance(PAP) form, if the need arises.</strong></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name</label></td>
											<td>
												 <input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Name" id="14" required="required"
												placeholder="Enter Name" type="text" class="form-control">
											</td>
										</tr>
										<tr>
											<td><label class="control-label" for="dob">Date
													of Birth</label></td>
											<td>
												 <input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Date of Birth" id="15" required="required" type="date"
												class="form-control">
											</td>
										</tr>
										<tr>
											<td><label class="control-label" for="stucontact">Mobile
													Number</label></td>
											<td>
												 <input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Mobile Number" id="16" required="required"
												pattern="[789][0-9]{9}" placeholder="Enter Mobile Number"
												type="tel" class="form-control">
											</td>
										</tr>

										<tr>
											<td><label class="control-label" for="Email Id">Email
													Id </label></td>
											<td>
												 <input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Email" id="224" required="required"
												placeholder="Enter Email Id" type="email"
												class="form-control">
											</td>
										</tr>

										<tr>
											<td>
												
												<button type="button" id="submit_button"
													class="btn btn-success">Pay</button>
											</td>
											<td>
												
											</td>
										</tr>
									</table>
									<div style="text-align: center;">

										<a href=""
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
										</a>
									</div>
								</form>
								</form>
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

	<script>
		var fee = 0;
		var totfee = 0;
		var hostel = 0;
		var bus = 0;
		var hostelfee = 0;
		var busfee = 0;
		var latefee=500;
		function TotalFee(x) {

			var service = document.getElementById("1").value;

			if (x == "BTech2013B" && service == "BusYes") {
				fee = 26750+latefee;
			}
			if (x == "BTech2013B" && service == "HostelYes") {
				fee = 27450+latefee;
			}
			if (x == "BTech2013B" && service == "DayScholar") {
				fee = 24950+latefee;
			}

			if (x == "BTech2013bNonSARC" && service == "BusYes") {
				fee = 0;
			}
			if (x == "BTech2013bNonSARC" && service == "HostelYes") {
				fee = 13950+latefee;
			}
			if (x == "BTech2013bNonSARC" && service == "DayScholar") {
				fee = 11450+latefee;
			}

			if (x == "BTech2013bSARCCountry" && service == "BusYes") {
				fee = 0;
			}
			if (x == "BTech2013bSARCCountry" && service == "HostelYes") {
				fee = 11950+latefee;
			}
			if (x == "BTech2013bSARCCountry" && service == "DayScholar") {
				fee = 94500+latefee;
			}

			if (x == "BTech2014B" && service == "BusYes") {
				fee = 44250+latefee;
			}
			if (x == "BTech2014B" && service == "HostelYes") {
				fee = 44950+latefee;
			}
			if (x == "BTech2014B" && service == "DayScholar") {
				fee = 42450+latefee;
			}

			if (x == "BTech2015B" && service == "BusYes") {
				fee = 44250+latefee;
			}
			if (x == "BTech2015B" && service == "HostelYes") {
				fee = 44950+latefee;
			}
			if (x == "BTech2015B" && service == "DayScholar") {
				fee = 42450+latefee;
			}

			if (x == "BTech20142015bNonSARC" && service == "BusYes") {
				fee = 0;
			}
			if (x == "BTech20142015bNonSARC" && service == "HostelYes") {
				fee = 16950+latefee;
			}
			if (x == "BTech20142015bNonSARC" && service == "DayScholar") {
				fee = 14450+latefee;
			}

			if (x == "BTech20142015bSARCCountry" && service == "BusYes") {
				fee = 0;
			}
			if (x == "BTech20142015bSARCCountry" && service == "HostelYes") {
				fee = 13450+latefee;
			}
			if (x == "BTech20142015bSARCCountry" && service == "DayScholar") {
				fee = 10950+latefee;
			}

			if (x == "MTechMBA2015BGenOBC" && service == "BusYes") {
				fee = 44250+latefee;
			}
			if (x == "MTechMBA2015BGenOBC" && service == "HostelYes") {
				fee = 44950+latefee;
			}
			if (x == "MTechMBA2015BGenOBC" && service == "DayScholar") {
				fee = 42450+latefee;
			}

			
			
			
			if (x == "MTechMBA2015BSCSTCat" && service == "BusYes") {
				fee = 9250+latefee;
			}
			if (x == "MTechMBA2015BSCSTCat" && service == "HostelYes") {
				fee = 9950+latefee;
			}
			if (x == "MTechMBA2015BSCSTCat" && service == "DayScholar") {
				fee = 7450+latefee;
			}

			
			
			
			if (x == "MSc2015PhDFTGenOBCCat" && service == "BusYes") {
				fee = 16750+latefee;
			}
			if (x == "MSc2015PhDFTGenOBCCat" && service == "HostelYes") {
				fee = 17450+latefee;
			}
			if (x == "MSc2015PhDFTGenOBCCat" && service == "DayScholar") {
				fee = 14950+latefee;
			}

			
			
			if (x == "MSc2015PhDFTSCSTCat" && service == "BusYes") {
				fee = 9250+latefee;
			}
			if (x == "MSc2015PhDFTSCSTCat" && service == "HostelYes") {
				fee = 9950+latefee;
			}
			if (x == "MSc2015PhDFTSCSTCat" && service == "DayScholar") {
				fee = 7450+latefee;
			}

			
			
			
			if (x == "MTechPT2013b7sem" && service == "BusYes") {
				fee = 0;
			}
			if (x == "MTechPT2013b7sem" && service == "HostelYes") {
				fee = 0;
			}
			if (x == "MTechPT2013b7sem" && service == "DayScholar") {
				fee = 17450+latefee;
			}
			
			
			
			
			if (x == "MTechPT2014b" && service == "BusYes") {
				fee = 0;
			}
				
			if (x == "MTechPT2014b" && service == "HostelYes") {
				fee = 0;
			}
				
			if (x == "MTechPT2014b" && service == "DayScholar") {
				fee = 27450+latefee;
			}
			
			
			
			if (x == "PhDPT" && service == "BusYes") {
				fee = 0;
			}
				
			if (x == "PhDPT" && service == "HostelYes") {
				fee = 0;
			}
				
			if (x == "PhDPT" && service == "DayScholar") {
				fee = 14950+latefee;
			}
			
			
			
			if (x == "MTechPTC7s" && service == "BusYes") {
				fee = 0;
			}
				
			if (x == "MTechPTC7s" && service == "HostelYes") {
				fee = 0;
			}
				
			if (x == "MTechPTC7s" && service == "DayScholar") {
				fee = 2500+latefee;
			}
			
			
			if (x == "BTechCF" && service == "BusYes") {
				fee = 0;
			}
				
			if (x == "BTechCF" && service == "HostelYes") {
				fee = 0;
			}
				
			if (x == "BTechCF" && service == "DayScholar") {
				fee = 1500+latefee;
			}
			
			
			
			if (x == "MTechPhDPTInternalF" && service == "BusYes") {
				fee = 0;
			}
				
			if (x == "MTechPhDPTInternalF" && service == "HostelYes") {
				fee = 0;
			}
				
			if (x == "MTechPhDPTInternalF" && service == "DayScholar") {
				fee = 100+latefee;
			}
			
			
			
			

			document.getElementById("total1").value = fee;

			total = fee;

		}

		var values = {};

		function AddToArray(value, name, id) {
			value = value.split(",").join("");
			value = value.split("`").join("");
			value = value.split("=").join("");
			values[id] = id + "`" + name + "=" + value;
			var total1 = document.getElementById("total1").value;
			var id1 = "18";
			var name1 = "Total Amount";
			values[id1] = id1 + "`" + name1 + "=" + total1;

		}

		function formSubmit() {

			var rccode = "null";
			try {
				rccode = document.getElementById("rc_code").value;
			} catch (err) {

			}
			var rcname = document.getElementById("14").value;
			var rcdob = document.getElementById("15").value;
			var rccontact = document.getElementById("16").value;
			var rcemail = document.getElementById("224").value;
			var amt = document.getElementById("total1").value;

			var dataArray = new Array;
			for ( var value in values) {
				dataArray.push(values[value]);
			}

			var argument = "values=" + dataArray + "&rcname=" + rcname
					+ "&rcdob=" + rcdob + "&rccontact=" + rccontact
					+ "&rcemail=" + rcemail + "&amt=" + amt;

			window.location = "processForm?" + argument;

		}
		$("#submit_button")
				.click(
						function() {
							var emailI = $("#224").val();
							var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
							var mobNum = $("#16").val();
							var patternMobNum = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;
							var patternSem = /^\[0-9]+$/;
							var sem = $("#6").val();
							var rollN = $("#2").val();

							if ($("#1").val() == "" && $("#222").val() == ""
									&& $("#223").val() == ""
									&& $("#4").val() == ""
									&& $("#55").val() == ""
									&& $("#77").val() == ""
									&& $("#88").val() == ""
									&& $("#13").val() == ""
									&& $("#14").val() == "") {
								alert('please fill the required field')
								return false;
							} else if ($("#6").val() == "" || sem.length != 1
									|| sem.match(patternSem)) {
								alert('please fill the vaild Semester')
								return false;
							} else if ($("#2").val() == "") {
								alert('please fill the vaild Roll Number')
								return false;
							}

							else if ($("#15").val() == "") {
								alert('please fill the required field')
								return false;
							} else if ($("#16").val() == ""
									|| mobNum.length != 10
									|| !mobNum.match(patternMobNum)) {
								alert('please fill the valid Mobile Number')
								return false;
							} else if (!emailI.match(emailReg)
									|| $("#224").val() == "") {
								alert('please fill the Email Id')
								return false;
							} else

								formSubmit();

						});
		function viewHistory() {
			window
					.open("payer-History.jsp", "Preview",
							"width=1024,height=768");
		}

		function lstCal() {

			var x = document.getElementById("365").value;
			if (parseInt(x) < 0) {
				alert("Please enter valid value");
				$("#365ref").load(location.href + " #365ref");
				return "flase";
			} else {
				var y = document.getElementById("total1").value;
				document.getElementById('total1').value = parseInt(x)
						+ parseInt(y);
				document.nitForm.submit();
			}

		}
		function pleaseFill() {
			alert("Please fill in the form completely");
			
			
				$("#pageRCCode").load(location.href + " #pageRCCode");
				$("#reftotal").load(location.href + " #reftotal");
			
		}
	</script>
</body>
</html>
