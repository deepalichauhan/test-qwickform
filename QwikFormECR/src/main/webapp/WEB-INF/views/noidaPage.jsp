
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>

<meta charset="utf-8">
<title>NOIDA AUTHORITY</title>
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

	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<div align="center">
				<h2>NOIDA AUTHORITY</h2>
			</div>
			<a class="navbar-brand" href="index.html"> <img
				alt="Charisma Logo" src="img/noidaauthoritylogo.jpg"
				class="hidden-xs" /> <span></span></a>




		</div>
		<div class="btn-group pull-right"></div>
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
				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Noida Authority
									Payment Form
								</h2>
								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">

								<table>
									<tr>
										<td colspan="2"><input type="hidden" id="314"
											name="clientCode" value="NoidaAuthority">
											<div class="control-group">
												<label class="control-label" for="selectError">Select
													Financial Year </label>

												<div class="control-label">
													<select class="form-control" name="Financial Year" id="301"
														onchange="AddToArray(this.value,this.name,this.id)"
														data-rel="chosen" required="required">
														<option selected="selected" disabled="disabled">Select
															The Financial Year</option>
														<option value="2014-2015">2014-2015</option>
													</select>
												</div>
											</div></td>
									</tr>
								</table>

								<table id="mainForm">

									<tr>
										<td><label class="control-label" for="selectBranch">Department
										</label></td>
										<td>
											<div class="control-label">
												<select class="form-control"
													onchange="AddToArray(this.value,this.name,this.id)"
													name="Department" id="302" required="required">
													<option selected="selected" disabled="disabled">Select
														Department</option>
													<option value="WC">WORKS COMMITTEE-(WC)</option>
													<option value="CPE">CPE</option>
													<option value="PE">PE</option>
												</select>
											</div>
										</td>
									</tr>

									<tr>
										<td><label class="control-label" for="roll">
												Tender Reference No</label></td>
										<td><input
											onchange="AddToArray(this.value,this.name,this.id)"
											name="TenderReferenceNo" id="303" required="required"
											pattern="[a-zA-Z0-9]*"
											placeholder="Enter Tender Reference No" type="text"
											class="form-control"></td>
									</tr>
									<tr>
										<td><label class="control-label" for="stuname">
												Confirm Tender Reference No</label></td>

										<td><input name="firstName"
											placeholder="Confirm Tender Reference No" required="required"
											type="text" class="form-control" id="304"></td>

									</tr>
									<tr>
										<td><label class="control-label" for="stuname">
												Bidder ID</label></td>

										<td><input
											onchange="AddToArray(this.value,this.name,this.id)"
											name="BidderID" placeholder="Bidder ID" required="required"
											type="text" class="form-control" id="315"></td>


									</tr>




									<tr>
										<td><label class="control-label" for="selectBranch">Payment
												Type</label></td>
										<td>
											<div class="control-label">
												<select class="form-control"
													onchange="AddToArray(this.value,this.name,this.id)"
													name="Payment Type" id="305" required="required">
													<option selected="selected" disabled="disabled">Select
														Payment Type</option>
													<option value="EMD">EMD</option>

												</select>
											</div>
										</td>
									</tr>
									<tr>
										<td><label class="control-label" for="selectBranch">Tender
												Type</label></td>
										<td>
											<div class="control-label">
												<select class="form-control"
													onchange="AddToArray(this.value,this.name,this.id)"
													name="Tender Type" id="306" required="required">
													<option selected="selected" disabled="disabled">Select
														Tender Type</option>
													<option value="Re Tender">Re Tender</option>

												</select>
											</div>
										</td>
									</tr>


									<tr>
										<td><label class="control-label" for="name"> Name</label></td>
										<td>
											<!--  pattern="[a-zA-Z\s]*"--> <input
											onchange="AddToArray(this.value,this.name,this.id)"
											name="firstName" id="307" required="required"
											placeholder="Enter Name" type="text" class="form-control">
										</td>
									</tr>
									<tr>
										<td><label class="control-label" for="stucontact">Mobile
												Number</label></td>
										<td>
											<!--id="stucontact"  --> <input
											onchange="AddToArray(this.value,this.name,this.id)"
											name="Mobile Number" id="308" required="required"
											pattern="[789][0-9]{9}" placeholder="Enter Mobile Number"
											type="tel" class="form-control">
										</td>
									</tr>
									<tr>
										<td colspan="2"><strong>
												<h3>Bank account details (for refund )</h3>
										</strong></td>
									</tr>

									<tr>
										<td><label class="control-label" for="fathername">
												Name of The Bank </label></td>
										<td>
											<!--  pattern="[a-zA-Z\s]*"--> <input
											onchange="AddToArray(this.value,this.name,this.id)"
											name="Name of The Bank" id="309" required="required"
											placeholder="Enter Name of The Bank " type="text"
											class="form-control">
										</td>
									</tr>
									<tr>
										<td><label class="control-label" for="fathername">
												Bank Branch </label></td>
										<td>
											<!--  pattern="[a-zA-Z\s]*"--> <input
											onchange="AddToArray(this.value,this.name,this.id)"
											name="Bank Branch" id="310" required="required"
											placeholder="Enter Bank Branch " type="text"
											class="form-control">
										</td>
									</tr>
									<tr>
										<td><label class="control-label" for="fathername">
												Bank account No </label></td>
										<td>
											<!--  pattern="[a-zA-Z\s]*"--> <input
											onchange="AddToArray(this.value,this.name,this.id)"
											name="Bank account No" id="311" required="required"
											placeholder="Enter Bank account No" type="text"
											class="form-control">
										</td>
									</tr>
									<tr>
										<td><label class="control-label" for="fathername">
												IFS Code </label></td>
										<td>
											<!--  pattern="[a-zA-Z\s]*"--> <input
											onchange="AddToArray(this.value,this.name,this.id)"
											name="IFS Code" id="312" required="required"
											placeholder="Enter IFS Code" type="text" class="form-control">
										</td>
									</tr>
									<tr>
										<td><label class="control-label" for="fathername">
												Amount </label></td>
										<td>
											<!--  pattern="[a-zA-Z\s]*"--> <input
											onchange="AddToArray(this.value,this.name,this.id)"
											name="Total Amount" id="313" required="required"
											placeholder="Enter Amount" type="text" class="form-control">
										</td>
									</tr>

									<tr>
										<td colspan="2"><strong>Disclaimer :The
												responsibility of inputting & verifying the payable amount
												would solely rest upon the bidder.<br> In the event of
												incorrect payment,niether IBL nor NOIDA Authority would be
												responsible for REFUND.<br> No communication with
												respect to errorneous payment shall be entertained. .
										</strong></td>
									</tr>

									<tr>
										<td>
											<!-- onclick="formSubmit()" -->
											<button type="button" id="submit_button"
												class="btn btn-success">Submit</button>
										</td>
										<td><button class="btn btn-default" onclick="Reset()">
												Reset</button></td>
									</tr>
									<tr>
										<td colspan="2"><strong>Memo: Your request has
												sucessfully been made .Please proceed to pay . .</strong></td>
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
		
		var values = {};

		function AddToArray(value, name, id) {
			value = value.split(",").join("");
			value = value.split("`").join("");
			value = value.split("=").join("");
			values[id] = id + "`" + name + "=" + value;
			
			var clientid1=document.getElementById("314").value;
			values[314] = 314 + "`" + "clientCode" + "=" + clientid1;
			
			
			/* alert(JSON.stringify(values)); */
		}

		function formSubmit() {
			
			/* alert("hello........"); */
			var dataArray = new Array;
			for ( var value in values) {
				dataArray.push(values[value]);
			}
			var argument = "values=" + dataArray;
			window.location = "processForm?"+argument;
		}
	  $("#submit_button").click(function(){ 
			 /* var emailI=$("#224").val();
			 var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
			  */var mobNum= $("#308").val();
			 var patternMobNum = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;
			 var patternAcNumber = /^\[0-9]+$/;
			 var acNumber=$("#311").val();
			 var tenderApNo=$("#303").val();
			 var ctenderApNo=$("#304").val();
			 
			/*  var rollN=$("#2").val(); */
			
			  if ($("#301").val() == ""&&$("#302").val() == ""&&$("#303").val() == ""&&$("#304").val() == ""&&$("#305").val() == ""&&$("#306").val() == ""&&$("#307").val() == ""&&$("#309").val() == ""&&$("#310").val() == ""){
			    alert('please fill the required field')
			    return false;
			  } else if ($("#304").val() == ""|| !tenderApNo.match(ctenderApNo )){
				    alert('please fill the vaild Tender Number')
				    return false;
				  }
			  else if ($("#311").val() == ""|| acNumber.match(patternAcNumber )){
				    alert('please fill the vaild Account Number')
				    return false;
				  }
		 else if ($("#312").val() == ""){
			    alert('please fill the required field')
			    return false;
			  }
			  
			  
			  else if ($("#313").val() == "" && $("#315").val() == ""){
			    alert('please fill the required field')
			    return false;
			  }
			  else if ($("#308").val() == ""|| mobNum.length != 10 || !mobNum.match(patternMobNum) ){
				    alert('please fill the valid Mobile Number')
				    return false;
				  }
			  /* else if (!emailI.match(emailReg)||$("#224").val() == ""){
				    alert('please fill the Email Id')
				    return false;
				  } */
			  else
				  
				  formSubmit();
			   
			}); 
		 function viewHistory() {
				window
						.open("payer-History.jsp", "Preview",
								"width=1024,height=768");
			}
		
		
		
	</script>
</body>
</html>