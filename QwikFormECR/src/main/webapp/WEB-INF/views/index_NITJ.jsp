<!DOCTYPE html>
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

	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#"> <img src="img/logo_nitj.png"></a>
			<a class="navbar-brand" href="#"><span>NITJ, Jalandhar </span></a>
			<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"></span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a id="saveProfileTagId" onclick=""
						href="EditUserDetail.jsp">Settings</a></li>
					<li class="divider"></li>
					<li><a href="logOutUser">Logout</a></li>
				</ul>
			</div>

		</div>
	</div>

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

				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Student Fee
									Payment Form
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form id="nitForm" method="POST">
									<table>
										<tr>
											<td colspan="2">
												<div class="control-group">
													<label class="control-label" for="selectError">Select
														Payment Category</label>

													<div class="controls">

														<select
															onchange="GetFees(this.value),AddToArray(this.value,this.name,this.id)"
															name="Payment Category" id="1" data-rel="chosen">
															<option selected="selected" disabled="disabled">Select
																An Option</option>
															<option value="BT1">B.Tech 1st Semester (2015)</option>
															<option value="BT3">B.Tech 3rd Semester (2014)</option>
															<option value="BT5">B.Tech 5rd Semester (2013)</option>
															<option value="BT7">B.Tech 7rd Semester (2012)</option>
															<option value="MT3GEN">M.Tech (2014)
																(General/OBC)</option>
															<option value="MT14SC">M.Tech (2014) (SC/ST)</option>
															<option value="MT15GEN">M.Tech (2015)
																(General/OBC)</option>
															<option value="MT15SC">M.Tech (2015) (SC/ST)</option>
															<option value="MS15GEN">M.Sc (2015)
																(General/OBC)</option>
															<option value="MS15SC">M.Sc (2015) (SC/ST)</option>
															<option value="MS14GEN">M.Sc (2014)
																(General/OBC)</option>

															<option value="MS14SC">M.Sc (2014) (SC/ST)</option>
															<option value="MB15GEN">MBA (2015) (General/OBC)</option>
															<option value="MB14GEN">MBA (2014) (General/OBC)</option>
															<option value="MB14SC">MBA 2014 (SC/ST)</option>
															<option value="PDGEN">PhD (General/OBC)</option>
															<option value="PD15GENFT">PhD 2015 Full Time
																(General/OBC)</option>
															<option value="PD15SCFT">PhD 2015 Full Time
																(SC/ST)</option>
															<option value="PD15GENPT">PhD 2015 Part Time
																(General/OBC)</option>
															<option value="PD15SCPT">PhD Part Time (SC/ST)</option>
															<option value="MT12GENPT">M.Tech Part Time 2012
																and 2013 Batch (General/OBC)</option>
															<option value="MT12SC">M.Tech Part Time 2012 and
																2013 Batch (SC/ST)</option>
															<option value="MT14GENPT">M.Tech Part Time 2014
																Batch (General/OBC)</option>
															<option value="MT14SC">M.Tech Part Time 2014
																Batch (SC/ST)</option>
														</select>
													</div>
												</div>
											</td>
										</tr>
									</table>

									<table id="mainForm">
										<tr>
											<td><label class="control-label" for="roll">Roll
													Number</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Roll Number" id="2" required="required"
												pattern="[a-zA-Z0-9]*" placeholder="Enter Roll Number"
												type="text" class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name</label></td>
											<td><input name="Name" id="3" required="required"
												placeholder="Enter First Name" type="text"
												class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="fathername">Father's
													Name</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Father's Name" id="4" required="required"
												placeholder="Enter father Name" type="text"
												class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Select
													Branch</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Branch" id="5" required="required" data-rel="chosen">
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
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="semester" id="6" required="required" pattern="[0-9]*"
												placeholder="Enter Semester in Digit" type="text"
												class="form-control"></td>
										</tr>

										<tr>
											<td><label class="control-label" for="selectBranch">Hostel
													Required</label></td>
											<td>
												<div class="controls">


													<select required="required"
														onchange="TotalFee(this.value),AddToArray(this.value,this.name,this.id)"
														name="Hostel Required" id="7" data-rel="chosen">
														<option selected="selected" disabled="disabled">Select
															An Option</option>
														<option value="HostelYes">Yes</option>
														<option value="HostelNo">No</option>


													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Institute
													Bus Required</label></td>
											<td>
												<div class="controls">

													<select required="required"
														onchange="TotalFee(this.value),AddToArray(this.value,this.name,this.id)"
														name="Institute Bus Required" id="8" data-rel="chosen">
														<option selected="selected" disabled="disabled">Select
															An Option</option>
														<option value="BusYes">Yes</option>
														<option value="BusNo">No</option>


													</select>
												</div>
											</td>
										<tr>
											<td><label class="control-label" for="fee">Tuition
													Fee and Other Charges</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Tuition Fee and Other Charges" id="fee" type="text"
												readonly="readonly" class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="hosfee">Hostel
													Fee</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Hostel Fee" id="hostelfee" type="text"
												readonly="readonly" class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="busfee">Bus
													Fee</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Bus Fee" id="busfee" type="text" readonly="readonly"
												class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="total">Total
													Fee</label></td>
											<td><input type="text"
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Total Fee" id="total" readonly="readonly"
												class="form-control"></td>
										</tr>

										<tr>
											<td><label class="control-label" for="remarks">Remarks</label></td>
											<td><textarea
													onchange="AddToArray(this.value,this.name,this.id)"
													name="Remarks" id="13" class="form-control"
													placeholder="Enter Remarks"></textarea></td>
										</tr>
										<tr>
											<td colspan="2"><strong>Please enter your Name,
													Date of Birth & Mobile Number. This is required to reprint
													your e-receipt / remittance(PAP) form, if the need arises.</strong></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Student Name" id="14" required="required"
												placeholder="Enter Name" type="text" class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="dob">Date
													of Birth</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Date of Birth" id="15" required="required" type="date"
												class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stucontact">Mobile
													Number</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Mobile Number" id="16" required="required"
												pattern="[789][0-9]{9}" placeholder="Enter Mobile Number"
												type="tel" class="form-control"></td>
										</tr>
										<tr>
											<td>
												<button type="submit" onclick="formSubmit()"
													class="btn btn-success">Pay</button>
											</td>
											<td><button class="btn btn-default" onclick="Reset()">
													Reset</button></td>
										</tr>
									</table>

								</form>

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
	<!--/.fluid-container-->

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
	function GetFees(x) {
		//alert("testing fee");
		document.getElementById("nitForm").reset();
		if (x == "BT3" || x == "MT3GEN" || x == "MB14GEN") {
			fee = 42450;
			hostel = 2500;
			bus = 1800;
		}
		if (x == "BT5" || x == "BT7") {
			fee = 24950;
			hostel = 2500;
			bus = 1800;
		}
		if (x == "MT15SC" || x == "MB15SC" || x == "MS15SC"
				|| x == "PD15SCFT" || x == "PD15SCPT") {
			fee = 12550;
			hostel = 2500;
			bus = 1800;
		}
		if (x == "MS14GEN" || x == "PDGEN") {
			fee = 14950;
			hostel = 2500;
			bus = 1800;
		}
		if (x == "MT14SC" || x == "MB14SC" || x == "MS14SC"
				|| x == "MT12SC" || x == "MT14SC") {
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
		if (x == "BT1" || x == "MT15GEN" || x == "MB15GEN") {
			fee = 47550;
			hostel = 2500;
			bus = 1800;
		}
		if (x == "MS15GEN" || x == "PD15GENFT" || x == "PD15GENPT") {
			fee = 20050;
			hostel = 2500;
			bus = 1800;
		}
		document.getElementById("fee").value = fee;
	//	alert("fee"+fee);
		//document.getElementById("total").value = fee;
		document.getElementById("total").value = fee;
		document.getElementById("hostelfee").value = 0;
		document.getElementById("busfee").value = 0;
		totfee = fee;

	}
	function TotalFee(y) {
	//	alert("In TotalFee ");
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
		document.getElementById("hostelfee").value = hostelfee;
		document.getElementById("busfee").value = busfee;
		document.getElementById("total").value = fee + busfee + hostelfee;
	}
	
	function Reset() {
		document.getElementById("nitForm").reset();
	}
		
		
		var values = {};
		

		function AddToArray(value, name, id) {
			//alert("inside AddToArray---1");
			value = value.split(",").join("");
			value = value.split("`").join("");
			value = value.split("=").join("");
			values[id] = id + "`" + name + "=" + value;
			//alert("inside AddToArray---1");
		}

		function formSubmit() {
			
			 var total1=	document.getElementById("total").value;
	var name1="Total Amount";
	var id1=17;
	alert("total fee----"+total1+"name1---- "+name1+" id1----- "+id1);
 AddToArray(total1,name1,id1); 
			var dataArray = new Array();
    
			for ( var value in values) {
				dataArray.push(values[value]);
			}
			var argument = "values=" + dataArray;/*  + "&instId=" + inst_id
					+ "&feeId=" + fee_id;  */
					alert("argument "+argument);
			window.location = "processForm?" + argument;
		
		
		}
		
		
		
		
	</script>
</body>
</html>
