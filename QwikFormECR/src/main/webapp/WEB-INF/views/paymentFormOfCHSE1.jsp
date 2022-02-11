<!DOCTYPE html>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<%
int bid=Integer.parseInt((String)session.getAttribute("bankerId"));
String cid=(String)request.getParameter("cid");
AppPropertiesConfig appProperties = new AppPropertiesConfig();
Properties properties = appProperties.getPropValues();

String clientLogoLink = properties.getProperty("clientLogoLink");

session.setAttribute("cid", cid);
%>
	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			
			<a class="navbar-brand" href="Login.jsp"> <img
				alt="Charisma Logo" src="img/councilLogo.jpg"></a> <a
				class="navbar-brand" href="<%=clientLogoLink%>"><span>CHSE, Odisha
					</span></a>

			
			
		</div>
		<div class="btn-group pull-right">
				<button type="button" class="btn btn-default"
					onclick="viewHistory()">
					<i class="glyphicon glyphicon-time"></i> Previous Transactions
				</button>

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
				<!-- content starts -->




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
								-	<table id="mainForm">
										<tr>
											<td><label class="control-label" for="roll">Roll
													Number</label></td>
											<td>
											<input type="hidden" value='<%= request.getParameter("id")%>'>
											
											<input 
											onchange="AddToArray(this.value,this.name,this.id)"	name="Roll Number"
															id="2"
											
											 required="required" pattern="[a-zA-Z0-9]*" placeholder="Enter Roll Number"
												type="text" class="form-control"></td>
										</tr>
										<tr>
											<td><label class="control-label" for="stuname">Name
													</label></td>
											<td><input
												onchange="AddToArray(this.value,this.name,this.id)"
												name="firstName" placeholder="Enter First Name" required="required" type="text"
												class="form-control" id="222"></td>	&nbsp;
											
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
													<select onchange="GetFee1(this.value)"	name="Branch"
															id="55" required="required" 
														 >
														<option value=""></option>
														<option value="BT">BT</option>
														<option value="CE">CE</option>
														
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
											
											<input onchange="AddToArray(this.value,this.name,this.id)"	name="Name"
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
											<td><label class="control-label" for="total">Total
													Fee</label></td>
											<td><input name="fd.txnAmount" type="text"
												readonly="readonly" class="form-control" id="total1"></td>
										</tr>
										<tr>
											<td>
										<!-- onclick="formSubmit()" -->		<button type="button" id="submit_button" class="btn btn-success">Pay</button>
											</td>
											<td><button class="btn btn-default" onclick='window.location="choosePaymentForm.jsp?cid="+<%=cid %>' >
												Back</button></td>
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
								<!-- </form> -->
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
	/* var fee = 0;
	var totfee = 0;
	var hostel = 0;
	var bus = 0;
	var hostelfee = 0;
	var busfee = 0;
	function GetFees(x) {
		
		
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
		document.getElementById("12").value = fee;
		document.getElementById("hosfee").value = 0;
		document.getElementById("busfee").value = 0;
		totfee = fee;

	} */
	
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
			
		}
		if (x == "BT5" || x == "BT7") {
			fee = 24950;
			
		}
		if (x == "MT15SC" || x == "MB15SC" || x == "MS15SC"
				|| x == "PD15SCFT" || x == "PD15SCPT") {
			fee = 12550;
			
		}
		if (x == "MS14GEN" || x == "PDGEN") {
			fee = 14950;
			
		}
		if (x == "MT14SC" || x == "MB14SC" || x == "MS14SC"
				|| x == "MT12SC" || x == "MT14SC") {
			fee = 7450;
			
		}
		if (x == "MT12GENPT") {
			fee = 17450;
		}
		if (x == "MT14GENPT") {
			fee = 27450;
		}
		if (x == "BT1" || x == "MT15GEN" || x == "MB15GEN") {
			fee = 47550;
			
		}
		if (x == "MS15GEN" || x == "PD15GENFT" || x == "PD15GENPT") {
			fee = 20050;
			
		}
		/* document.getElementById("fee").value = fee; */
	//	alert("fee"+fee);
		//document.getElementById("total").value = fee;
		document.getElementById("total").value = fee;
	
		totfee = fee;

	}

	/* function TotalFee(y) {
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
		document.getElementById("12").value = fee + busfee + hostelfee;
		
	} */
	
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
	/* function Reset() {
		document.getElementById("nitForm").reset();
	}
		 */
		
		var values = {};

		function AddToArray(value, name, id) {
			value = value.split(",").join("");
			value = value.split("`").join("");
			value = value.split("=").join("");
			values[id] = id + "`" + name + "=" + value;
			var total1=document.getElementById("total1").value;
			
			var branch1=document.getElementById("55").value;
			var id1="18";
			var name1="Total Amount";
			values[id1] = id1 + "`" + name1 + "=" + total1;
			values[19] = 19 + "`" + "Branch" + "=" + branch1;
			
			
			/* alert(JSON.stringify(values)); */

		}

		function formSubmit() {
			
			/*  var inst_id = document.getElementById("1").value;
			var fee_id = document.getElementById("7").value;  
 */
 
 		
			var dataArray = new Array;
			for ( var value in values) {
				dataArray.push(values[value]);
			}
			var argument = "values=" + dataArray;/*  + "&instId=" + inst_id
					+ "&feeId=" + fee_id;  */
			window.location = "processForm?"+argument;
					
		
		
		}
		 $("#submit_button").click(function(){ 
			 var emailI=$("#224").val();
			 var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
			 var mobNum= $("#16").val();
			 var patternMobNum = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;
			 var patternSem = /^\[0-9]+$/;
			 var sem=$("#6").val();
			 var rollN=$("#2").val();
			
			  if ($("#1").val() == ""&&$("#222").val() == ""&&$("#223").val() == ""&&$("#4").val() == ""&&$("#55").val() == ""&&$("#77").val() == ""&&$("#88").val() == ""&&$("#13").val() == ""&&$("#14").val() == ""){
			    alert('please fill the required field')
			    return false;
			  } else if ($("#6").val() == ""||sem.length != 1 || sem.match(patternSem )){
				    alert('please fill the vaild Semester')
				    return false;
				  }
		 else if ($("#2").val() == ""){
			    alert('please fill the vaild Roll Number')
			    return false;
			  }
			  
			  
			  else if ($("#15").val() == ""){
			    alert('please fill the required field')
			    return false;
			  }
			  else if ($("#16").val() == ""|| mobNum.length != 10 || !mobNum.match(patternMobNum) ){
				    alert('please fill the valid Mobile Number')
				    return false;
				  }
			  else if (!emailI.match(emailReg)||$("#224").val() == ""){
				    alert('please fill the Email Id')
				    return false;
				  }
			  else
				  
				  formSubmit();
			   
			}); 
		 function viewHistory() {
				window
						.open("payer-History.jsp", "Preview",
								"width=1024,height=768");
			}
		
		 function GetFee1(x)
			{
				var fee=document.getElementById("total1");
				var fee2=document.getElementById("fee1");
				if(x=="BT")
					{
						fee.value="7894";
						fee2.value="7894";
					}
				if(x=="CE")
				{
					fee.value="4594";
					fee2.value="4594";
				}
			}
			function GetFee2(x)
			{
				var fee=document.getElementById("total2");
				var fee2=document.getElementById("fee2");
				if(x=="BT")
					{
						fee.value="2394";
						fee2.value="2394";
					}
				if(x=="CE")
				{
					fee.value="4294";
					fee2.value="4294";
				}
			}

		
	</script>
</body>
</html>
