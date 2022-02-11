<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

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


<body onload="ExecuteFun();">


	<%
		LoginBean loginUser = new LoginBean();
		String profile = null;
		Integer collegeID = null;
		CollegeBean collegeBean = new CollegeBean();

		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
		String clientLogoLink = properties.getProperty("clientLogoLink");

		try {
			loginUser = (LoginBean) session.getAttribute("loginUserBean");
			profile = (String) session.getAttribute("sesProfile");
			collegeID = (Integer) session.getAttribute("CollegeId");
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		} catch (NullPointerException e) {
			System.out.print("Nullpointer Exception in JSP...");
	%>
	<script type="text/javascript">
			
			window.location="timeIntervalPage";
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

			<a class="navbar-brand" href="#"> <img
				src="<%=collegeBean.getCollegeLogo()%>"></a> <a
				class="navbar-brand" href="<%=clientLogoLink%>"><span> <%=collegeBean.getCollegeName()%>,<br><%=collegeBean.getState()%>
			</span></a>

			<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"> <%=loginUser.getUserName()%></span> <span
						class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<!-- <li><a id="saveProfileTagId" onclick="" href="EditUserDetail.jsp">Settings</a></li> -->
					<li class="divider"></li>
					<li><a href="logOutUser">Logout</a></li>
				</ul>
			</div>
			<!-- user dropdown ends -->

			<!-- theme selector starts -->
		</div>
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">
			<!-- left menu starts -->
			<div class="col-sm-2 col-lg-2">
				<div class="sidebar-nav">
					<div class="nav-canvas">
						<jsp:include page="menuAdmin.jsp"></jsp:include>
					</div>
				</div>
			</div>
			<!--/span-->
			<!-- left menu ends -->

			<noscript>
				<div class="alert alert-block col-md-12">
					<h4 class="alert-heading">Warning!</h4>

					<p>
						You need to have <a href="http://en.wikipedia.org/wiki/JavaScript"
							target="_blank">JavaScript</a> enabled to use this site.
					</p>
				</div>
			</noscript>

			<div id="content" class="col-lg-10 col-sm-12">
				<!-- content starts -->



				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner"></div>
					</div>
					<div class="row">
						<div class="box col-md-12">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-star-empty"></i>Filters
									</h2>
								</div>
								<div class="box-content">
									<table class="table table-condensed">
										<tbody>
											<tr>
												<td>Filter By College: <select
													onchange="showTable(this.value)" data-rel="chosen">
														<option value="None">Select School</option>
														<option value="engineering">St Xaviers School</option>
														<option value="management">St Pauls School</option>
														<option value="jrcollege">Loyola School</option>
												</select>
												</td>
												<td>Filter By Payer Status: <select
													onchange="showTable(this.value)" data-rel="chosen">
														<option value="None">Select Payment Status</option>
														<!-- <option value="unregistered">Registered</option> -->
														<option value="registered">Registered</option>
														<option value="Paid">Examination Fee Paid</option>
												</select>
												</td>
												<td>Filter By Payer Category: <select
													onchange="showTable(this.value)" data-rel="chosen">
														<option value="None">Select Payer Category</option>
														<option value="ix">Class IX</option>
														<option value="x">Class X</option>
														<option value="xi">Class XI</option>
												</select>
												</td>

											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<a
						href="http://43.252.89.122:8080/Qforms/studentsdata.xlsx"
						download="ExportFile"> <img height="50" widht="50"
						src="excel.png" />
					</a> <a
						href="http://43.252.89.122:8080/QForms/studentsdata.xlsx"
						download="ExportCSV"> <img height="50" widht="50"
						src="CSV.png" />
					</a> <a
						href="http://43.252.89.122:8080/QForms/studentsdata.xlsx"
						download="ExportPDF"> <img height="50" widht="50"
						src="pdf1.png" />
					</a>
					<div class="row">
						<div class="box col-md-12">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-star-empty"></i>Payers Data
									</h2>

									<div class="box-icon">
										<a href="#" class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
									</div>
								</div>
								<div class="box-content">

									<table style="display: none" id="unregistered"
										class="table table-striped">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Class</th>
												<th>Contact</th>
												<th>DOB</th>
												<th>Status</th>
												
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>Aditya Kumakale</td>
												<td>III</td>
												<td>College of Engineering and Technology</td>
												<td>8390888755</td>
												<td>25/04/2005</td>
												<td>Registered</td>
											</tr>
											<tr>
												<td>2</td>
												<td>Ravi K</td>
												<td>XI</td>
												<td>College of Arts, Science and Commerce (Jr. College)</td>
												<td>8390888345</td>
												<td>12/04/2006</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>3</td>
												<td>Abhishesk L</td>
												<td>X</td>
												<td>St. Xavier's Public School</td>
												<td>8390882332</td>
												<td>11/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>4</td>
												<td>Jayant M</td>
												<td>X</td>
												<td>St. Xavier's Public School</td>
												<td>8390844533</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>5</td>
												<td>Bhushan K</td>
												<td>IX</td>
												<td>DAV Public School</td>
												<td>888574456</td>
												<td>15/08/2007</td>
												<td>Registered</td>
												
											</tr>

										</tbody>
									</table>



									<table style="display: none" id="registered"
										class="table table-striped">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Class</th>
												<th>Contact</th>
												<th>DOB</th>
												<th>Status</th>
												
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>Dinesh L</td>
												<td>X</td>
												<td>St. Xavier's Public School</td>
												<td>8390882332</td>
												<td>11/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>2</td>
												<td>Suraj K</td>
												<td>XI</td>
												<td>College of Arts, Science and Commerce (Jr. College)</td>
												<td>8390844345</td>
												<td>12/04/2006</td>
												<td>Registered</td>
												
											</tr>

											<tr>
												<td>3</td>
												<td>Mukesh M</td>
												<td>X</td>
												<td>St. Xavier's Public School</td>
												<td>83908433533</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>4</td>
												<td>Aditya Sawant</td>
												<td>XI</td>
												<td>College of Arts, Science and Commerce (Jr. College)</td>
												<td>8392288755</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>

										</tbody>
									</table>


									<table style="display: none" id="Paid"
										class="table table-striped">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Class</th>
												<th>Contact</th>
												<th>DOB</th>
												<th>Status</th>

											</tr>
										</thead>
										<tbody>


											<tr>
												<td>1</td>
												<td>Lokesh M</td>
												<td>X</td>
												<td>DAV Public School</td>
												<td>83908222533</td>
												<td>25/04/2005</td>
												<td>Exam Fee Paid</td>

											</tr>
											<tr>
												<td>2</td>
												<td>Parag Prashar</td>
												<td>XI</td>
												<td>St. Xavier's Public School</td>
												<td>839084445</td>
												<td>25/04/2005</td>
												<td>Exam Fee Paid</td>

											</tr>

										</tbody>
									</table>

									<table style="display: none" id="x" class="table table-striped">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Class</th>
												<th>Contact</th>
												<th>DOB</th>
												<th>Status</th>
												
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>Abhishesk L</td>
												<td>X</td>
												<td>DAV Public School</td>
												<td>8395523432</td>
												<td>11/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>2</td>
												<td>Ravi K</td>
												<td>X</td>
												<td>St. Xavier's Public School</td>
												<td>8394488345</td>
												<td>12/04/2006</td>
												<td>Registered</td>
												
											</tr>

											<tr>
												<td>3</td>
												<td>Jayant M</td>
												<td>X</td>
												<td>DAV Public School</td>
												<td>8390844533</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>


										</tbody>
									</table>

									<table style="display: none" id="ix"
										class="table table-striped">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Class</th>
												<th>Contact</th>
												<th>DOB</th>
												<th>Status</th>
												
											</tr>
										</thead>
										<tbody>


											<tr>
												<td>1</td>
												<td>Prakash Kumar</td>
												<td>IX</td>
												<td>St. Xavier's Public School</td>
												<td>8390333533</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>2</td>
												<td>Viraj Pratap</td>
												<td>IX</td>
												<td>St. Xavier's Public School</td>
												<td>8390888755</td>
												<td>25/04/2005</td>
												<td>Exam Fee Paid</td>
												<td></td>
											</tr>

										</tbody>
									</table>

									<table style="display: none" id="xi"
										class="table table-striped">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Class</th>
												<th>Contact</th>
												<th>DOB</th>
												<th>Status</th>
												
											</tr>
										</thead>
										<tbody>
										<tbody>
											<tr>
												<td>1</td>
												<td>Abhishesk M</td>
												<td>XI</td>
												<td>College of Arts, Science and Commerce (Jr. College)</td>
												<td>8391112332</td>
												<td>11/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>2</td>
												<td>Ravi Sagar</td>
												<td>XI</td>
												<td>College of Arts, Science and Commerce (Jr. College)</td>
												<td>8390111345</td>
												<td>12/04/2006</td>
												<td>Registered</td>
												
											</tr>

										</tbody>
									</table>

									<table style="display: none" id="engineering"
										class="table table-striped">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Class</th>
												<th>College</th>
												<th>Contact</th>
												<th>DOB</th>
												<th>Status</th>
												
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>Aditya Kumakale</td>
												<td>IV</td>
												<td>College of Engineering and Technology</td>
												<td>8390888755</td>
												<td>25/04/2005</td>
												<td>Registered</td>
											
											</tr>
											<tr>
												<td>2</td>
												<td>Ravi K</td>
												<td>III</td>
												<td>College of Engineering and Technology</td>
												<td>8390888345</td>
												<td>12/04/2006</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>3</td>
												<td>Abhishesk L</td>
												<td>II</td>
												<td>College of Engineering and Technology</td>
												<td>8390882332</td>
												<td>11/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>4</td>
												<td>Jayant M</td>
												<td>III</td>
												<td>College of Engineering and Technology</td>
												<td>8390844533</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>5</td>
												<td>Bhushan K</td>
												<td>IV</td>
												<td>College of Engineering and Technology</td>
												<td>888574456</td>
												<td>15/08/2007</td>
												<td>Registered</td>
												
											</tr>

										</tbody>
									</table>

									<table style="display: none" id="management"
										class="table table-striped">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Class</th>
												<th>College</th>
												<th>Contact</th>
												<th>DOB</th>
												<th>Status</th>
												
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>Abhinav U</td>
												<td>III</td>
												<td>College of Business Management</td>
												<td>8390888755</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>2</td>
												<td>Aneesh J</td>
												<td>I</td>
												<td>College of Business Management</td>
												<td>8390888345</td>
												<td>12/04/2006</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>3</td>
												<td>Mayur V</td>
												<td>I</td>
												<td>College of Business Management</td>
												<td>8390882332</td>
												<td>11/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>4</td>
												<td>Tanmay D</td>
												<td>II</td>
												<td>College of Business Management</td>
												<td>8390844533</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>5</td>
												<td>Grishma R</td>
												<td>I</td>
												<td>College of Business Management</td>
												<td>888574456</td>
												<td>15/08/2007</td>
												<td>Registered</td>
												
											</tr>

										</tbody>
									</table>
									<table style="display: none" id="jrcollege"
										class="table table-striped">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Class</th>
												<th>College</th>
												<th>Contact</th>
												<th>DOB</th>
												<th>Status</th>
												
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>Gauruav A</td>
												<td>XI</td>
												<td>College of Arts, Science and Commerce (Jr. College)</td>
												<td>8390888755</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>2</td>
												<td>Nikhil L</td>
												<td>XI</td>
												<td>College of Arts, Science and Commerce (Jr. College)</td>
												<td>8390888345</td>
												<td>12/04/2006</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>3</td>
												<td>Radhika J</td>
												<td>XII</td>
												<td>College of Arts, Science and Commerce (Jr. College)</td>
												<td>8390882332</td>
												<td>11/04/2005</td>
												<td>Registered</td>
												
											</tr>
											<tr>
												<td>4</td>
												<td>Abhay G</td>
												<td>XII</td>
												<td>College of Arts, Science and Commerce (Jr. College)</td>
												<td>8390844533</td>
												<td>25/04/2005</td>
												<td>Registered</td>
												
											</tr>


										</tbody>
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


			</footer>
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
			function showTable(optvalue) {
				document.getElementById("unregistered").style.display = "none";
				document.getElementById("registered").style.display = "none";
				document.getElementById("Paid").style.display = "none";
				document.getElementById("ix").style.display = "none";
				document.getElementById("x").style.display = "none";
				document.getElementById("xi").style.display = "none";
				document.getElementById("engineering").style.display = "none";
				document.getElementById("management").style.display = "none";
				document.getElementById("jrcollege").style.display = "none";

				document.getElementById(optvalue).style.display = "block";
			}

			function OpenForm() {
				window.location = "getFormforPayer?formId=152";
			}
		</script>
</body>
</html>
