<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
	
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

<%
		LoginBean loginBean = new LoginBean();
	CollegeBean collegeBean = new CollegeBean();
	String profile=null;
	String clientLogoLink=null;
	Integer collegeID=null;
	try
	{
		loginBean = (LoginBean) session.getAttribute("loginUserBean");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		 profile = (String) session.getAttribute("sesProfile");
		 collegeID = (Integer) session.getAttribute("CollegeId");
		 
		 AppPropertiesConfig appProperties = new AppPropertiesConfig();
			Properties properties = appProperties.getPropValues();

		 clientLogoLink = properties.getProperty("clientLogoLink");
			String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	}catch(NullPointerException e)
	{
		//response.sendRedirect("TimeIntervalPage");
		
		%>
		<script type="text/javascript">
		
		window.location="timeIntervalPage";
		</script>
		<%
	}
		

		

		
	%>

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
									<i class="glyphicon glyphicon-star-empty"></i> Operator Details
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form id="nitForm" action="operatorForm" method="POST">
									

									<table id="mainForm1">
										<tbody>

												<tr>

													<td>Name</td>
													<td><div id="the-basics" class="has-success">
															<input required="required" id="District/Area"
																name="${operatorBean.operatorName}"
															
																placeholder="First Name" type="text"
																class="form-control">
														</div></td>

													<td><div id="the-basics" class="has-success">
															<input required="required"
																name="${operatorBean.operatorLstName}"
																placeholder="Last Name" type="text" class="form-control">
														</div></td>

												</tr>

												<tr>

													<td>Gender</td>
													<td><div id="the-basics" class="has-success">

															
															
															
															
																
														
																<input type="radio" required="required"
																	name="${operatorBean.gender}" id="userPrefixMr"
																	value="Male">Male
															&nbsp;&nbsp;&nbsp;<input type="radio" required="required"
																	name="${operatorBean.gender}" id="userPrefixMrs"
																	value="Female">Female
															
															



														</div></td>

												</tr>
												
												
												
												<tr>

													<td>Address
													(Only characters,no symbols)</td>
													<td colspan="2"><div id="the-basics"
															class="has-success">
															<textarea required="required" id="CollegeName"
																name="${operatorBean.operatorAddress}"
																placeholder="Address" class="form-control"></textarea>

														</div></td>

												</tr>

												<tr>

													<td>Primary Mobile Number</td>
													<td colspan="2"><div id="the-basics"
															class="has-success">
															<input required="required" id="Contact"
																name="${operatorBean.operatorContact}" maxlength="10"
																
																placeholder="Mobile Number" pattern="[789][0-9]{9}"
																type="text" class="form-control">

														</div></td>

												</tr>
												<tr>

													<td>Secondary Mobile Number</td>
													<td colspan="2"><div id="the-basics"
															class="has-success">
															<input id="Contact"
																name="${operatorBean.operatorContactSec}" maxlength="10"
																
																placeholder="Mobile Number" pattern="[789][0-9]{9}"
																type="text" class="form-control">

														</div></td>

												</tr>
												<tr>

													<td>Email Id</td>
													<td colspan="2"><div id="the-basics"
															class="has-success">
															<input required="required" id="Contact"
																
																name="${operatorBean.operatorEmail}" placeholder="Email ID"
																type="email" class="form-control">

														</div></td>

												</tr>
												<tr>
												<td><button type="submit" class="btn btn-sm btn-success" >Save</button></td>
												<td><button class="btn btn-sm btn-warning" onclick="window.close()">Cancel</button></td>
												</tr>



											</tbody>
									</table>
									
									



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
	
	function GetForm(x)
	{
		if(x=="1")
			{
			document.getElementById("mainForm1").style.display="block";
			document.getElementById("mainForm2").style.display="none";
			}
		if(x=="2")
		{
		document.getElementById("mainForm1").style.display="none";
		document.getElementById("mainForm2").style.display="block";
		}
	}
	
	
		var fee = 0;
		var totfee = 0;
		var hostel = 0;
		var bus = 0;
		var hostelfee = 0;
		var busfee = 0;
		function GetFees(x) {
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
			document.getElementById("total").value = fee + busfee + hostelfee;
		}
		function Pay() {
			var linkadd = 'http://49.50.72.228:8080/SabPaisa/index.jsp?Name=Mr.XYZ&amt=7894&client=QuickCollect';
			window.location.href = linkadd;
		}
		function Reset() {
			document.getElementById("nitForm").reset();
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
		function saveForm()
		{
			alert("Operator Successfully Added");
			window.close();
		}
	</script>
</body>
</html>
