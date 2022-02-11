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
	<!-- topbar starts -->
	<div style="display: none" class="navbar navbar-default" role="navigation" id="topbarCHSE">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			
					<a class="navbar-brand" href="#"> <img
				alt="Charisma Logo" src="img/logo_nitj.png"></a> <a
				class="navbar-brand" href="#"><span>NITJ
					</span></a>
			<div class="btn-group pull-right">
				<button type="button" class="btn btn-default"
					onclick="viewHistory()">
					<i class="glyphicon glyphicon-time"></i> Previous Transactions
				</button>

			</div>




		</div>
	</div>
	
	<div style="display: none" class="navbar navbar-default" role="navigation" id="topbarNITJ">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			
					<a class="navbar-brand" href="#"> <img
				src="img/logo_nitj.png"></a> <a
				class="navbar-brand" ><span>NITJ, Jalandhar</span></a>
			<div class="btn-group pull-right">
				

			</div>




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
									<i class="glyphicon glyphicon-star-empty"></i> Fee Payment Form
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form id="nitForm"  onsubmit="return checkForm(this);" method="post">
									<table>
										<tr>
											<td colspan="2">
												<div class="control-group">
													<label class="control-label" for="selectError">Select
														Institute</label>

													<div class="controls">
														<select onchange="getValue(this.value)" name="${fd.paymentCat}" id="selectInst"
															data-rel="chosen" required="required">
															<option selected="selected" disabled="disabled">Select
																An Option</option>
															
																<option value="nitj2" herf="nitjFeesPaymentForm.jsp">National Institute of
																Technology, Jalandhar</option>


														</select>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="10">
												<div>
													<label class="control-label" for="selectError">Select
														Fee To Pay</label>

													<div   id="chseSelectList">
														<select name="fd.paymentCat"
															onchange="GetForm(this.value)" id="selectFee" style="display: none"
															>
															<option selected="selected" disabled="disabled">Select
																An Option</option>
															

                                                               <option value="1">Exam Fee-2016(Correspondence-without fine)Principal </option>
																<option value="2">Exam Fees-2016(Ex-Reg with fine)</option> 
																<option value="3">Exam Fee-2016(Correspondence-without fine)Student </option>
																<option value="4">Readmission in Correspondence Course - 2nd year</option> 
																<option value="5">Admission Fee for M.COM 2015</option> 
														</select>
													</div>
													
													
													<div  id="nitjSelectList" >
													<!--  -->
													<!-- onchange="GetFees(this.value)" -->
														<select 
															onchange="GetFees(this.value),AddToArray(this.value,this.name,this.id)"
														required="required"	name="Payment Category"
															id="1"
															style="display: none" >
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

									 <table style="display: none" id="mainForm4">
										<tr>
											<td><label class="control-label" for="roll">Enrollment
													No.</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Enrollment No."  type="text"
												class="form-control" id="1"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name
													of Student</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="firstName"  type="text"
												class="form-control" id="222">&nbsp;
												<input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="lstName" type="text"
												class="form-control" id="223">
												
												</td>
										</tr>
										<tr>
											<td><label class="control-label" for="fathername">Name
													of Father</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Name of Father"  type="text"
												class="form-control" id="3"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="fathername">Name
													of Mother</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Name of Mother"  type="text"
												class="form-control" id="4"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Select
													Course Admitted</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Course Admitted"  id="5">
														<option value=""></option>
														<option value="Arts">Arts</option>
														<option value="Commerce">Commerce</option>
													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Select
													Academic Session</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Academic Session"  id="6">
														<option value=""></option>

														<option value="2014-15">2014-15</option>
														<option value="2013-14">2013-14</option>
														<option value="2012-13">2012-13</option>
														<option value="2011-12">2011-12</option>
														<option value="2010-11">2010-11</option>
													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Select
													Enrollment No. Issued By</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Enrollment No. Issued By"  id="7">
														<option value=""></option>
														<option value="CHSE-Bhubaneshwar">CHSE-Bhubaneshwar</option>
														<option value="Zone Office-Behrampur">Zone
															Office-Behrampur</option>
														<option value="Zone Office-Baripada">Zone
															Office-Baripada</option>
														<option value="Zne Office-Sambalpur">Zne
															Office-Sambalpur</option>
													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Select
													Readmission Fees</label></td>
											<td>
												<div class="controls">
													<select name="Readmission Fees"
														onchange="GetFee1(this.value),AddToArray(this.value,this.name,this.id)"
														 id="8">
														<option value=""></option>

														<option value="2250">2250</option>
														<option value="2750">2750</option>
													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="remarks">Remarks</label></td>
											<td><textarea name="Remarks"
													onchange="AddToArray(this.value,this.name,this.id)"
													class="form-control" id="9"></textarea></td>
										</tr>
										<tr>
											<td colspan="2"><strong>Please enter your Name,
													Date of Birth & Mobile Number. This is required to reprint
													your e-receipt / remittance(PAP) form, if the need arises.</strong></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name</label></td>
											<td><input name="Name"  type="text"
												class="form-control" id="10"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="dob">Date
													of Birth</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Date of Birth"  type="date"
												class="form-control" id="11"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stucontact">Mobile
													Number</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Mobile Number"  type="tel"
												pattern="[0-9]*" class="form-control" id="12"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stucontact">Address
											</label></td>
											<td><textarea
													onchange="AddToArray(this.value,this.name,this.id)"
													name="Address"  class="form-control"
													id="13"></textarea></td>
										</tr>
										<tr>
											<td><label class="control-label" for="total">Total
													Fee</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Total Fee" type="text" readonly="readonly"
												class="form-control" id="0"></td>
										</tr>
										<tr>
											<td>
										<!-- onclick="formSubmit()" -->		<button type="button" onclick="formSubmit()"
													class="btn btn-success">Pay</button>
											</td>
											<td><button class="btn btn-default" onclick="Reset()">
													Reset</button></td>
										</tr>
									</table>
 





<!-- 
                           <table style="display: none" id="mainForm1">
										
										<tr>
											<td><label class="control-label" for="stuname">Name
													of Applicant*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Name of Student" required="required" type="text"
												class="form-control" id="2"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="fathername">Name
													of Father*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Name of Father" required="required" type="text"
												class="form-control" id="3"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="mothername">Name
													of Mother*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Name of Mother" required="required" type="text"
												class="form-control" id="4"></td>
										</tr>
										
										<tr>
											<td><label class="control-label" for="selectBranch">Sex*</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Course Admitted" required="required" id="5">
														<option value="">--Select Sex--</option>
														<option value="Arts">Male</option>
														<option value="Commerce">Female</option>
													</select>
												</div>
											</td>
										
										
										<tr>
										
										
										<tr>
											<td><label class="control-label" for="selectBranch">Nationality*</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Course Admitted" required="required" id="5">
														<option value="">--Select Nationality--</option>
														<option value="Indian">Indian</option>
														
													</select>
												</div>
											</td>
										
										
										<tr>
											<td><label class="control-label" for="selectBranch">Category*</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Course Admitted" required="required" id="5">
														<option value="">--Select Category--</option>
														<option value="Arts">General</option>
														<option value="Commerce">OBC</option>
													</select>
												</div>
											</td>
										
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="dob">Date
													of Birth</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Date of Birth" required="required" type="date"
												class="form-control" id="11"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="stuname">Address Line1(without comma)</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Address Line1" required="required" type="text"
												class="form-control" id="2"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="stuname">Address Line2(without comma)</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Address Line2" required="required" type="text"
												class="form-control" id="2"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="stuname">Address Line3(without comma)</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Address Line3" required="required" type="text"
												class="form-control" id="2"></td>
										</tr>
										
										<tr>
											<td><label class="control-label" for="stuname">Email Id</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Email Id" required="required" type="text"
												class="form-control" id="2"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="stuname">Mobile No.*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Mobile No." required="required" type="text"
												class="form-control" id="2"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="stuname">Institution Last Attended*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Institution Last Attended" required="required" type="text"
												class="form-control" id="2"></td>
										</tr>
										
										
										<tr>
										
										
											<td><label class="control-label" for="selectBranch">Compulsory Subject 1</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Course Admitted" required="required" id="5">
														<option value="">--Select Course--</option>
														<option value="Arts">Arts</option>
														<option value="Commerce">Commerce</option>
													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Select
													Academic Session</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Academic Session" required="required" id="6">
														<option value="">--Select Session--</option>

														<option value="2014-15">2014-15</option>
														<option value="2013-14">2013-14</option>
														<option value="2012-13">2012-13</option>
														<option value="2011-12">2011-12</option>
														<option value="2010-11">2010-11</option>
													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Select
													Enrollment No. Issued By</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"
														name="Enrollment No. Issued By" required="required" id="7">
														<option value="">----</option>
														<option value="CHSE-Bhubaneshwar">CHSE-Bhubaneshwar</option>
														<option value="Zone Office-Behrampur">Zone
															Office-Behrampur</option>
														<option value="Zone Office-Baripada">Zone
															Office-Baripada</option>
														<option value="Zne Office-Sambalpur">Zne
															Office-Sambalpur</option>
													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Select
													Readmission Fees</label></td>
											<td>
												<div class="controls">
													<select name="Readmission Fees"
														onchange="GetFee1(this.value),AddToArray(this.value,this.name,this.id)"
														required="required" id="8">
														<option value=""></option>

														<option value="2250">2250</option>
														<option value="2750">2750</option>
													</select>
												</div>
											</td>


										</tr>
										<tr>
											<td><label class="control-label" for="remarks">Remarks</label></td>
											<td><textarea name="Remarks"
													onchange="AddToArray(this.value,this.name,this.id)"
													class="form-control" id="9"></textarea></td>
										</tr>
										<tr>
											<td colspan="2"><strong>Please enter your Name,
													Date of Birth & Mobile Number. This is required to reprint
													your e-receipt / remittance(PAP) form, if the need arises.</strong></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name</label></td>
											<td><input name="Name" required="required" type="text"
												class="form-control" id="10"></td>
										</tr>
										
										<tr>
											<td><label class="control-label" for="stucontact">Mobile
													Number</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Mobile Number" required="required" type="tel"
												pattern="[0-9]*" class="form-control" id="12"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stucontact">Address
											</label></td>
											<td><textarea
													onchange="AddToArray(this.value,this.name,this.id)"
													name="Address" required="required" class="form-control"
													id="13"></textarea></td>
										</tr>
										<tr>
											<td><label class="control-label" for="total">Total
													Fee</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Total Fee" type="text" readonly="readonly"
												class="form-control" id="0"></td>
										</tr>
										<tr>
											<td>
												<button type="button" onclick="formSubmit()"
													class="btn btn-success">Pay</button>
											</td>
											<td><button class="btn btn-default" onclick="Reset()">
													Reset</button></td>
										</tr>
									</table> -->








                                   <table style="display: none" id="mainForm2">
										<tr>
											<td><label class="control-label" for="roll">College Code*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Enrollment No."  type="text"
												class="form-control" id="14"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name
													of the College*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Name of Student"  type="text"
												class="form-control" id="15"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="fathername">College Address(without comma)*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="College Address"  type="text"
												class="form-control" id="16"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="fathername">No. of Candidates in Arts</label></td>
											<td><input
												onchange="GetCount(),AddToArray(this.value,this.name,this.id)"
												name="Name of Mother"  type="text"
												class="form-control" id="17"></td>
										</tr>
										
										
										
										<tr>
											<td><label class="control-label" for="fathername">No. of Candidates in Science</label></td>
											<td><input
												onchange="GetCount(),AddToArray(this.value,this.name,this.id)"
												name="No. of Candidates in Science"  type="text"
												class="form-control" id="18"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="fathername">No. of Candidates in Commerce</label></td>
											<td><input
												onchange="GetCount(),AddToArray(this.value,this.name,this.id)"
												name="No. of Candidates in Commerce"  type="text"
												class="form-control" id="19"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="fathername">No. of Candidates in Vocational</label></td>
											<td><input
												onchange="GetCount(),AddToArray(this.value,this.name,this.id)"
												name="No. of Candidates in Vocational"  type="text"
												class="form-control" id="20"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="fathername">Total No. of Candidates</label></td>
											<td><input
												onchange="CalculateRemittedFee(),AddToArray(this.value,this.name,this.id)" 
												name="Total No. of Candidates"   readonly="readonly"
												class="form-control" id="21"></td>
										</tr>
										
										
										
											<tr>
											<td><label class="control-label" for="fathername">Total amount of fees collected</label></td>
											<td><input
												onchange="CalculateRemittedFee(),AddToArray(this.value,this.name,this.id)"
												name="Total No. of fee collected"  type="text" readonly="readonly"
												class="form-control" id="22"></td>
										</tr>
										
										
										
										<tr>
											<td><label class="control-label" for="fathername">Amount retained for theory exam</label></td>
											<td><input
												onchange="CalculateRemittedFee(),AddToArray(this.value,this.name,this.id)"
												name="Amount retained for theory exam"  type="text"
												class="form-control" id="23"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="fathername">Amount retained for practical exam</label></td>
											<td><input
												onchange="CalculateRemittedFee(),AddToArray(this.value,this.name,this.id)"
												name="Amount retained for practical exam"  type="text"
												class="form-control" id="24"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="fathername">Amount exempted towards fees of PH Candidates </label></td>
											<td><input
												onchange="CalculateRemittedFee(),AddToArray(this.value,this.name,this.id)"
												name="Amount exempted towards fees of PH Candidates"  type="text"
												class="form-control" id="25"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="fathername">Total amount retained for exam expenses</label></td>
											<td><input
												onchange="CalculateRemittedFee(),AddToArray(this.value,this.name,this.id)"
												name="Total amount retained for exam expenses"  type="text"
												class="form-control" id="26"></td>
										</tr>
										
										
										<tr>
											<td><label class="control-label" for="fathername">Mobile no.(10 digits)</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Mobile no"  type="text"
												class="form-control" id="27"></td>
										</tr>
										
										
										
										<tr>
											<td><label class="control-label" for="fathername">Total amount of fees remitted</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Total amount of fees remitted"  type="text" readonly="readonly"
												class="form-control" id="28"></td>
										</tr>


<tr>
											<td><label class="control-label" for="fathername">Remarks</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Remarks"  type="text"
												class="form-control" id="29"></td>
										</tr>



										</tr>
													
										
										
										<tr>
											<td colspan="2"><strong>Please enter your Name,
													Date of Birth & Mobile Number. This is required to reprint
													your e-receipt / remittance(PAP) form, if the need arises.</strong></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name*</label></td>
											<td><input name="Name"  type="text"
												class="form-control" id="30"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="dob">Date
													of Birth*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Date of Birth"  type="date"
												class="form-control" id="31"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stucontact">Mobile
													Number*</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Mobile Number"  type="tel"
												pattern="[0-9]*" class="form-control" id="32"></td>
										</tr>
										<!-- <tr>
											<td><label class="control-label" for="stucontact">Address
											</label></td>
											<td><textarea
													onchange="AddToArray(this.value,this.name,this.id)"
													name="Address" required="required" class="form-control"
													id="13"></textarea></td>
										</tr>
										<tr>
											<td><label class="control-label" for="total">Total
													Fee</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="Total Fee" type="text" readonly="readonly"
												class="form-control" id="0"></td>
										</tr> -->
										<tr>
											<td>
												<button type="button" onclick="formSubmit()"
													class="btn btn-success">Pay</button>
											</td>
											<td><button class="btn btn-default" onclick="Reset()">
													Reset</button></td>
										</tr>
									</table>
									
									
									
									
									
									</form>
									
									<table id="nitjMainForm" style="display: none">
										<tr>
											<td><label class="control-label" for="roll">Roll
													Number</label></td>
											<td><input 
											onchange="AddToArray(this.value,this.name,this.id)"	name="Roll Number"
															id="2"
											
											 required="required" pattern="[a-zA-Z0-9]*" placeholder="Enter Roll Number"
												type="text" class="form-control"></td>
										</tr>
										 <!-- <tr>
											<td><label class="control-label" for="stuname">Name</label></td>
											<td>
											 pattern="[a-zA-Z\s]*"   onchange="AddToArray(this.value,this.name,this.id)"
											<input 
												name="Name"
															id="3"
											 required="required" placeholder="Enter First Name"
												type="text" class="form-control"></td>
										</tr>  -->
										
										<tr>
											<td><label class="control-label" for="stuname">Name
													of Student</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="firstName" placeholder="Enter First Name" required="required" type="text"
												class="form-control" id="222"></td>	&nbsp;
											<!-- <td><label class="control-label" for="stuname">Name
													of Student</label></td>	 -->
											<td>	<input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="lstName" placeholder="Enter Last Name" required="required" type="text"
												class="form-control" id="223">
												
												</td>
										</tr>
										
										
										
										
										
										
										<tr>
											<td><label class="control-label" for="fathername">Father's
													Name</label></td>
											<td>
											<!--  pattern="[a-zA-Z\s]*"-->
											<input onchange="AddToArray(this.value,this.name,this.id)"	name="Father's Name"
															id="4" required="required"  placeholder="Enter father Name"
												type="text" class="form-control" ></td>
										</tr>
										<tr>
											<td><label class="control-label" for="selectBranch">Select
													Branch</label></td>
											<td>
												<div class="controls">
													<select onchange="AddToArray(this.value,this.name,this.id)"	name="Branch"
															id="55" required="required" 
														 >
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
											onchange="AddToArray(this.value,this.name,this.id)"	name="semester"
															id="6" required="required" pattern="[0-9]*" placeholder="Enter Semester in Digit"
												type="text" class="form-control"></td>
										</tr>

										<tr>
											<td><label class="control-label" for="selectBranch">Hostel
													Required</label></td>
											<td>
												<div class="controls">
												
												 <!-- onchange="TotalFee(this.value)" -->
													<select 
													
													onchange="TotalFee(this.value),AddToArray(this.value,this.name,this.id)"	name="Hostel Required"
															id="77"
													
													required="required"
														>
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
												 <!-- onchange="TotalFee(this.value)" -->
													<select required="required"
													
													onchange="TotalFee(this.value),AddToArray(this.value,this.name,this.id)"	name="Institute Bus Required"
															id="88"
													
														>
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
											<td>
											<!--  id="fee"-->
											<input 
											onchange="AddToArray(this.value,this.name,this.id)"	name="Tuition Fee and Other Charges"
															id="fee"
											 type="text"
												readonly="readonly" class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="hosfee">Hostel
													Fee</label></td>
											<td>
											<!--  id="hosfee" -->
											<input
												onchange="AddToArray(this.value,this.name,this.id)"	name="Hostel Fee"
															id="hostelfee" type="text"
												readonly="readonly" class="form-control"></td>
										</tr>
										<tr>
											<td>
											<!-- id="busfee" -->
											<label class="control-label" for="busfee">Bus
													Fee</label></td>
											<td><input onchange="AddToArray(this.value,this.name,this.id)"	name="Bus Fee"
															id="busfee"  type="text"
												readonly="readonly"  class="form-control" ></td>
										</tr>
										<tr>
											<td><label class="control-label" for="total">Total
													Fee</label></td>
											<td>
											<!-- id="total" -->
											
											<input  type="text"
											onchange="AddToArray(this.value,this.name,this.id)"	name="Total Fee"
															id="total" 
												readonly="readonly" class="form-control" ></td>
										</tr>

										<tr>
											<td><label class="control-label" for="remarks">Remarks</label></td>
											<td>
											
											<!-- id="remarks" -->
											<textarea onchange="AddToArray(this.value,this.name,this.id)"	name="Remarks"
															id="13" class="form-control" placeholder="Enter Remarks"
													></textarea></td>
										</tr>
										<tr>
											<td colspan="2"><strong>Please enter your Name,
													Date of Birth & Mobile Number. This is required to reprint
													your e-receipt / remittance(PAP) form, if the need arises.</strong></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name</label></td>
											<td>
											<!-- id="stuname" pattern="[a-zA-Z\s]*"-->
											
											<input onchange="AddToArray(this.value,this.name,this.id)"	name="Student Name"
															id="14"
											 required="required"  placeholder="Enter Name"
												type="text" class="form-control" ></td>
										</tr>
										<tr>
											<td><label class="control-label" for="dob">Date
													of Birth</label></td>
											<td>
											
											<!--  id="dob"-->
											<input onchange="AddToArray(this.value,this.name,this.id)"	name="Date of Birth"
															id="15"  required="required" type="date"
												class="form-control" ></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stucontact">Mobile
													Number</label></td>
											<td>
											<!--id="stucontact"  -->
											
											<input onchange="AddToArray(this.value,this.name,this.id)"	name="Mobile Number"
															id="16"  required="required" pattern="[789][0-9]{9}" placeholder="Enter Mobile Number"
												type="tel" class="form-control" ></td>
										</tr>
										
										<tr>
											<td><label class="control-label" for="Email Id">Email Id
													</label></td>
											<td>
											<!--id="stucontact"  -->
											
											<input onchange="AddToArray(this.value,this.name,this.id)"	name="Email"
															id="224"  required="required"  placeholder="Enter Email Id"
												type="email" class="form-control" ></td>
										</tr>
									
										<tr>
											<td>
										<!-- onclick="formSubmit()" -->		<button type="button" id="submit_button" class="btn btn-success">Pay</button>
											</td>
											<td><button class="btn btn-default" onclick="Reset()">
													Reset</button></td>
										</tr>
									</table>
									
									
								
									
									
									
									
									
								
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
		function GetForm(x) {
			if (x == "1") {
				document.getElementById("mainForm1").style.display = "block";
				document.getElementById("mainForm2").style.display = "none";
				document.getElementById("mainForm3").style.display = "none";
				document.getElementById("mainForm4").style.display = "none";
			}
			if (x == "2") {
				document.getElementById("mainForm4").style.display = "none";
				document.getElementById("mainForm2").style.display = "block";
				document.getElementById("mainForm1").style.display = "none";
				document.getElementById("mainForm3").style.display = "none";
				
			}
			if (x == "3") {
				document.getElementById("mainForm3").style.display = "block";
				document.getElementById("mainForm1").style.display = "none";
				document.getElementById("mainForm2").style.display = "none";
				document.getElementById("mainForm4").style.display = "none";
			}
			
			if (x == "4") {
				document.getElementById("mainForm2").style.display = "none";
				document.getElementById("mainForm4").style.display = "block";
				document.getElementById("mainForm1").style.display = "none";
				
				document.getElementById("mainForm3").style.display = "none";
			}

		}
		
		function getValue(x) {
			if (x == "chse1") {
				/* alert(x); */
				document.getElementById("nitjMainForm").style.display = "none";
				document.getElementById("1").style.display = "none";
				document.getElementById("topbarCHSE").style.display = "block";
				document.getElementById("topbarNITJ").style.display = "none";
				document.getElementById("selectFee").style.display = "block";
				
			}
			if (x == "nitj2") {
				/* alert(x); */
				document.getElementById("total").value = "";
				document.getElementById("fee").value = "";
				document.getElementById("hostelfee").value = "";
				document.getElementById("busfee").value = "";
				document.getElementById("topbarCHSE").style.display = "none";
				document.getElementById("selectFee").style.display = "none";
				document.getElementById("mainForm2").style.display = "none";
				document.getElementById("mainForm4").style.display = "none";
				document.getElementById("topbarNITJ").style.display = "block";	
				document.getElementById("1").style.display = "block";
				document.getElementById("nitjMainForm").style.display = "block";
				document.getElementById("55").style.display = "block";
				document.getElementById("77").style.display = "block";
				document.getElementById("88").style.display = "block";
			}
		}
		function Reset() {
			document.getElementById("nitForm").reset();
		}

		function GetFee1(x) {
			var fee = document.getElementById("0");
			fee.value = x;
			AddToArray(x, "Total Fee", "0");
		}

		function viewHistory() {
			window
					.open("payer-History.jsp", "Preview",
							"width=1024,height=768");
		}

		var values = {};

		function AddToArray(value, name, id) {
			value = value.split(",").join("");
			value = value.split("`").join("");
			value = value.split("=").join("");
			values[id] = id + "`" + name + "=" + value;
			/* alert(JSON.stringify(values)); */

		}

		function formSubmit() {
			alert("inside form submit");
		  /*   checkTheValesId();  */
			alert("hello testing......");
			var inst_id = document.getElementById("selectInst").value;
			alert("1");
			var fee_id = document.getElementById("selectFee").value;
            alert("2");
			var dataArray = new Array;
			alert("3");
			
			/* 
			if(id==""||document.getElementById("").value==null){
				alert("pls fill the fields");
			} */
			for ( var value in values) {
				alert("inside the loop");
				dataArray.push(values[value]);
			}
			alert("4");
			var argument = "values=" + dataArray + "&instId=" + inst_id
					+ "&feeId=" + fee_id;
			alert("5");
			window.location = "processForm?" + argument;
			
		}
		
		
		function GetFee2(x) {
			var fee = document.getElementById("0");
			fee.value = x;
			AddToArray(x, "Total Fee", "0");
		}
		
		
		/*  function GetCount(x,y,z,a) {
			var count;
			
			var count1 = document.getElementById("17").value;
			var count2 = document.getElementById("18").value;
			var count3 = document.getElementById("19").value;
			var count4 = document.getElementById("20").value;
			
			count = parseInt(count1)+parseInt(count2)+parseInt(count3)+parseInt(count4);
			count =parseInt(count);
			if(isNaN(count)){
				 count=0;
			 }	
			

			document.getElementById("21").value=count;
			
			
		fee.value = count;
			AddToArray(count, "Total No. of Candidates", "21"); 
		}
		 */
		 
		 
		 
		 function GetCount() {
			
				var count1;
				var count2;
				var count3;
				var count4;
				var sum=0;
			
			
				 if(isNaN(document.getElementById("17").value) || document.getElementById("17").value=='')  
				 { count1=0;
				 }
				 else{
					 count1=document.getElementById("17").value;
		 		 }
				
				 
				 if(isNaN(document.getElementById("18").value) || document.getElementById("18").value=='')  
				 { count2=0;
				 }
				 else{
					 count2=document.getElementById("18").value;
		 		 }
				
				    
				    
					 if(isNaN(document.getElementById("19").value)  || document.getElementById("19").value=='')  
					 { count3=0;
					 }
					 else{
						 count3=document.getElementById("19").value;
			 		 }
					 
					    
					  
					    
						 if(isNaN(document.getElementById("20").value)  || document.getElementById("20").value=='')  
						 { count4=0;
						 }
						 else{
							 count4=document.getElementById("20").value;
				 		 }
						 
						  
				 
				count = parseInt(count1)+parseInt(count2)+parseInt(count3)+parseInt(count4);
				
				

				document.getElementById("21").value=count;
				document.getElementById("22").value=count*520;
				document.getElementById("28").value=count*520;
				
				
			/* fee.value = count;
				AddToArray(count, "Total No. of Candidates", "21");  */
			}
		
		
		 
		 function CalculateRemittedFee() {
				
				var count1;
				var count2;
				var count3;
				var count4;
				var sum=0;
				var totalFee = document.getElementById("22").value;
				//parseInt(totalFee);
				//alert('total fee is'+totalFee);
			
				 if(isNaN(document.getElementById("23").value) || document.getElementById("23").value=='')  
				 { count1=0;
				 }
				 else{
					 count1=document.getElementById("23").value;
		 		 }
				
				 
				 if(isNaN(document.getElementById("24").value) || document.getElementById("24").value=='')  
				 { count2=0;
				 }
				 else{
					 count2=document.getElementById("24").value;
		 		 }
				
				    
				    
					 if(isNaN(document.getElementById("25").value)  || document.getElementById("25").value=='')  
					 { count3=0;
					 }
					 else{
						 count3=document.getElementById("25").value;
			 		 }
					 
					    
					  
					    
						 if(isNaN(document.getElementById("26").value)  || document.getElementById("26").value=='')  
						 { count4=0;
						 }
						 else{
							 count4=document.getElementById("26").value;
				 		 }
						 
						  
				 
				//count = 
				
				fee = totalFee - (parseInt(count1)+parseInt(count2)+parseInt(count3)+parseInt(count4));
				document.getElementById("28").value=fee;
				
				
			/* fee.value = count;
				AddToArray(count, "Total No. of Candidates", "21");  */
			}
		 
		 
		/* function CalculateFee(x,y,z,a,b) {
			var count;
			
			var fee1 = document.getElementById("22").value;
			var fee2 = document.getElementById("23").value;
			var fee3 = document.getElementById("24").value;
			var fee4 = document.getElementById("25").value;
			var fee5 = document.getElementById("26").value;
			var fee6 = document.getElementById("21").value;
			//fee6 is the no. of students
			//fee1 is all collected fee
			alert(fee1);
			alert(fee2);
			alert(fee3);
			alert(fee4);
			alert(fee5);
			alert(fee6);
		var totalFee = parseInt(fee1)-(parseInt(fee2)*parseInt(fee6) + parseInt(fee3)*parseInt(fee6) + parseInt(fee4)*parseInt(fee6) + parseInt(fee5)*parseInt(fee6));
			totalFee = parseInt(totalFee);
			/* count = parseInt(count1)+parseInt(count2)+parseInt(count3)+parseInt(count4);
			count =parseInt(count);
			if(isNaN(count)){
				 count=0;
			 }	 */
			
			/*  alert(totalFee);
			document.getElementById("28").value=totalFee;
			
			
			fee.value = totalFee;
			AddToArray(totalFee, "Total amount of fees remitted", "28"); 
		}*/
		var fee = 0;
		var totfee = 0;
		var hostel = 0;
		var bus = 0;
		var hostelfee = 0;
		var busfee = 0;
		function GetFees(x) {
			//alert("testing fee");
			/* document.getElementById("nitForm").reset(); */
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
		/* function Pay() {
			var name = document.getElementById("stuname").value;
			var linkadd = 'http://localhost:8080/SabPaisa/index.jsp?firstName='
					+ name +'&lstName=""' +'&amount='
					+ document.getElementById("total").value
					+ '&client=NIT Jalandhar';
			window.location.href = linkadd;
		} */
		function Reset() {
			document.getElementById("nitForm").reset();
		}
			
			
			var values = {};
			

			function AddToArray(value, name, id) {
				value = value.split(",").join("");
				value = value.split("`").join("");
				value = value.split("=").join("");
				values[id] = id + "`" + name + "=" + value;
			
				/* alert(JSON.stringify(values)); */
			}

		 	/* function formSubmit() {
				
			
	 var total1=	document.getElementById("total").value;
		var name1="Total Amount";
		var id1=177;
		
	 AddToArray(total1,name1,id1); 
				var dataArray = new Array();
	    
				for ( var value in values) {
					dataArray.push(values[value]);
				}
				var argument = "values=" + dataArray;
				window.location = "processForm?" + argument;
			
			
			}  */
			
			function checkTheValesId(){
				alert ("inside validation method");
				/* alert("pls fill the fields"); */
				if(id==""||id==null){
					alert("pls fill the fields");
				}/* else{
					
					alert("hello testing code:");
					
				}  */
				/* formSubmit(); */
			}
			
			/* function validate() {
		        if (document.getElementById("2").value == "") {
		            alert("User name may not be blank");
		            
		            
		        } else if (document.getElementById("3").value == "") {
		            alert("Password may not be blank.");
		        }
		    } */
		    
		    $("#submit_button").click(function(){ 
				  if ($("#1").val() == ""&&$("#222").val() == ""&&$("#223").val() == ""&&$("#4").val() == ""&&$("#55").val() == ""&&$("#6").val() == ""&&$("#77").val() == ""&&$("#88").val() == ""&&$("#13").val() == ""&&$("#14").val() == ""){
				    alert('please fill the required field')
				    return false;
				  }
				  else if ($("#15").val() == ""){
				    alert('please fill the required field')
				    return false;
				  }
				  else if ($("#16").val() == ""){
					    alert('please fill the required field')
					    return false;
					  }
				  else if ($("#").val() == ""){
					    alert('please fill the required field')
					    return false;
					  }
				  else
					  
					  formSubmit();
				   
				});
		    
		    
		    
		    
		
	</script>
</body>
</html>
