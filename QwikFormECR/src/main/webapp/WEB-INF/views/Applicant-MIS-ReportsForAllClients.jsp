<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<%-- <style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
       top.location = self.location;
   }
</script> --%>
</head>


<body onload="ExecuteFun();">

	<%
		LoginBean loginUser = new LoginBean();
		String profile = null;
		Integer collegeID = null;
		String feeType1 = null;
		CollegeBean collegeBean = new CollegeBean();
		try {
			loginUser = (LoginBean) session.getAttribute("loginUserBean");
			profile = (String) session.getAttribute("sesProfile");
			collegeID = (Integer) session.getAttribute("CollegeId");
			feeType1 = (String) request.getAttribute("feeType");
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			System.out.println("fee type is" + feeType1);
		} catch (NullPointerException e) {
			System.out.print("Nullpointer Exception in JSP...");

			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-store");
			response.setHeader("Expires", "0");
			response.setDateHeader("Expires", -1);

			//response.sendRedirect("TimeIntervalPage");
	%>
<script type="text/javascript">
			
			window.location="timeIntervalPage"
			</script>

	<%-- <script type="text/javascript">
		window.location = "TimeIntervalPage";
	</script> --%>
	<%
		}

		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String clientLogoLink = properties.getProperty("clientLogoLink");

		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
		int count = 0;
		/* if (loginUser == null) {
		 response.sendRedirect("Login.jsp");
		
		 return;
		
		 } */
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
			<div class="col-sm-12 col-lg-12">
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
							You need to have <a
								href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a>
							enabled to use this site.
						</p>
					</div>
				</noscript>

				<div id="content" class="col-lg-10 col-sm-10">
					<!-- content starts -->



					<div class="row">
						<div class="box col-md-12">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-star-empty"></i> Report Filters
									</h2>

									<div class="box-icon">
										<a href="#" class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
									</div>
								</div>
								<div class="box-content">
									<!-- put your content here -->



									<table class="table table-striped table-condensed"
										style="overflow: auto; border: 1px solid #ccc; background: #f9f9f9;"
										cellpadding="0" cellspacing="0">
										<tr>
											<td><div class="control-group">
													<label class="control-label" for="selectError">Filter
														By Form </label>

													<div class="controls">
														
														<select name="fd.paymentCat" class="form-control"
															id="paycat" data-rel="chosen"
															onchange="getApplicantDetailsBasedONFeeType(this.value)"
															required="required">
															<option selected="selected" disabled="disabled" value="">Select
																An Option</option>
															<!-- <option value="All">All</option> -->


															<c:forEach items="${forms}" var="bean">
																
																<option value='${bean.id}'>
																	<c:out value="${bean.formName}"></c:out>
																</option>
															</c:forEach>
															
														</select>
													</div>
												</div></td>
											<td><div class="controls">
													
												</div></td>
										</tr>

									</table>
								</div>
							</div>
						</div>
					</div>

					<div class="row" style="width: 350%; overflow: scroll;">
						<div class="box col-md-32">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-star-empty"></i> Applicant
										Reports
										<!-- 	Reports -->
									</h2>

									<div class="box-icon">
										<a href="#" class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
									</div>
								</div>
								<div class="box-content">
									<!-- put your content here -->



									<table class="table table-striped table-condensed datatable"
										id="mainForm1" style="width: 350%; overflow: scroll;">
										<thead>
											<tr>
												<td>Actions <a href="#"
													onclick="ApplicantReportsBasedOnFee()"> <!-- <a href="ApplicantReportsAllClients?ForDownLoad=True" > -->

														<!-- <button type="button" class="btn btn-default btn-sm">Download
														Report</button> --> <img src="img/Xcel-icon.jpg">
												</a>

												</td>
											</tr>
											<tr>
												<th>Sr. No.</th>
												<c:forEach items="${headerSet}">
													<th><c:out value="" /></th>

												</c:forEach>




											</tr>
										</thead>
										<%
											int i = 1;
										%>
										<!--aplDetailsrmspl  aplDetails -->
										<c:forEach items="${aplDetails}" var="Outer">
											<tr>
												<td><%=i%></td>
												<c:forEach items="${Outer}">

													<td><c:out value="" /></td>
												</c:forEach>

												<%
													i++;
												%>

											</tr>
										</c:forEach>


									</table>







								</div>
							</div>
						</div>
					</div>
					<!--/row-->

				</div>
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
						<button type="button" class="close" data-dismiss="modal">\D7</button>
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

				<%-- <a href=""
					onclick="window.open('ContactUs.html','mywindowtitle',
											'width=500,height=550')">Contact
					Us </a> <span> |&nbsp;&nbsp;</span> <a href=""
					onclick="window.open('PrivacyPolicy.html','mywindowtitle',
											'width=500,height=550')">Privacy
					Policy </a> <span> |&nbsp;&nbsp;</span> <a href=""
					onclick="window.open('TermsAndConditions.html','mywindowtitle',
											'width=500,height=550')">Terms
					& Conditions </a> <span> |&nbsp;&nbsp;</span> <a href=""
					onclick="window.open('Disclaimer.html','mywindowtitle',
											'width=500,height=550')">Disclaimer
				</a>
 --%>






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
		function addField() {
			alert("Form Field Successfully Added");

			var a = document.getElementById("sem").value;
			var b = document.getElementById("selectDT").value;
			custom = custom + " " + a + " " + b + "<br>";
			document.getElementById("customTags").innerHTML = custom;

		}
		function saveForm() {
			alert("Operator Successfully Deleted");

		}
		function showReport() {
			alert("No Data Available to Download");

		}

		function viewForm() {
			alert("No Form Data Available");
		}
		function viewForm2() {
			window.open("operatorDetails", "Preview",
					"width=500,height=768");
		}
		function viewReceipt() {
			window.open("Receipt", "Preview", "width=500,height=768");
		}
		var feeType = "";
		function getApplicantDetailsBasedONFeeType(id) {

			window.location = "ApplicantReportsAllClientsForChallanMIS?feeType="
					+ id;

		}

		function ApplicantReportsBasedOnFee() {
			var feeType =
	<%=feeType1%>
		;

			window.location = "ApplicantReportsAllClientsForChallanMIS?feeType="
					+ feeType + "&ForDownLoad=True";
		}
		function ExecuteFun() {

			setTimeout(function() {
				ExecuteFun();
				//location.reload();
				var id =
	<%=collegeID%>
		;
				var logId = document.getElementById('loginBean').value;
				if (id == '' || id == null) {
					window.location = "TimeIntervalPage";
				}

			}, 120000);
		}
	</script>
</body>
</html>