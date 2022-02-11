<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		CollegeBean collegeBean = new CollegeBean();
		try {

			AppPropertiesConfig qfProperties = new AppPropertiesConfig();
			Properties properties = qfProperties.getPropValues();

			String clientLogoLink = properties.getProperty("clientLogoLink");
			String idval = (String) request.getParameter("id");
			System.out.println("id val:" + idval);
		} catch (NullPointerException e) {
	%>
	<script type="text/javascript">
		window.location = "TimeIntervalPage.jsp"
	</script>
	<%
		}
	%>
	<!-- topbar starts -->
	<%-- <div class="navbar navbar-default" role="navigation">

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
 --%>







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
									<i class="glyphicon glyphicon-star-empty"></i> SuperAdmin
									Details
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">

								<%
									String msg = (String) request.getAttribute("msg");
								%>
								<%
									if (msg != null)

									{
								%>

								<div
									style="color: green; text-align: center; font-weight: bold; font-size: medium;">
									<%=msg%>
								</div>

								<%
									}
								%>



								<!-- put your content here -->
								<form id="" action="EditSuperAdminDetails" method="POST"
									enctype="multipart/form-data" modelAttribute="superAdmin">
									<%-- 
									<s:token /> --%>
									<table id="mainForm1"
										class="table table-striped table-condensed">
										<tbody>
											<tr>

												<td>UserName</td>
												<td><div id="the-basics" class="has-success">
														<div class="controls">


															<input type="text" name="userName"
																value='<c:out value="${superAdmin.userName}"/>'>
															<input type="hidden" name="id"
																value='<c:out value="${superAdmin.id}"/>'>
														</div>
													</div>
											<tr />

											<tr>

												<td>Pass</td>
												<td><div id="the-basics" class="has-success">
														<div class="controls">
															<input type="password" maxlength="12"
																name="Pass" required="required"
																placeholder="Password" id="txtPassword"
																onkeyup="CheckPasswordStrength(this.value)" /> <span>Password
																should be of 8 characters and contain
																uppercase,lowercase,number and special character </span> <span
																id="password_strength"></span>
														</div>
													</div>
											<tr />
											<tr>
												<td>Name</td>
												<td><div id="the-basics" class="has-success">
														<div class="controls">
															<input type="text" name="name"
																value='<c:out value="${superAdmin.name}"/>'>
														</div>
													</div>
											<tr />


											<tr>
												<td>ContactNumber</td>
												<td><div id="the-basics" class="has-success">
														<div class="controls">
															<input type="text" name="contact"
																value='<c:out value="${superAdmin.contact}"/>'>
														</div>
													</div></td>
											<tr />
											<tr>
												<td>EmailId</td>
												<td><div id="the-basics" class="has-success">
														<div class="controls">
															<input type="text" name="email"
																value='<c:out value="${superAdmin.email}"/>'>
														</div>
													</div></td>
											<tr />
											<!--  <tr>
													<td> Logo </td>
													
													<td><div id="the-basics" class="has-success">
															<input  id="payer_type"
																name="userImage"
															
																placeholder="logo Name" type="file" required="required"
																class="form-control" />
														</div>
														 </td>

													

												</tr>  -->

											<tr>
												<td><input type="submit" value="Update"
													class="btn btn-info"></td>
												<!--  onclick="return validation()" -->
												<td>
													<button type="button" onclick="window.close();"
														class="btn btn-default">Close</button>
												</td>

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
						<button type="button" class="close" data-dismiss="modal">в</button>
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

	<script type="text/javascript">
		function CheckPasswordStrength(password) {
			var password_strength = document
					.getElementById("password_strength");

			//TextBox left blank.
			if (password.length == 0) {
				password_strength.innerHTML = "";
				return;
			}

			//Regular Expressions.
			var regex = new Array();
			regex.push("[A-Z]"); //Uppercase Alphabet.
			regex.push("[a-z]"); //Lowercase Alphabet.
			regex.push("[0-9]"); //Digit.
			regex.push("[$@$!%*#?&]"); //Special Character.

			var passed = 0;

			//Validate for each Regular Expression.
			for (var i = 0; i < regex.length; i++) {
				if (new RegExp(regex[i]).test(password)) {
					passed++;
				}
			}

			//Validate for length of Password.
			if (passed > 4 && password.length > 8) {
				passed++;
			}

			//Display status.
			var color = "";
			var strength = "";
			switch (passed) {
			case 0:
			case 1:
				strength = "Weak";
				color = "red";
				break;
			case 2:
				strength = "Good";
				color = "darkorange";
				break;
			case 3:
			case 4:
				strength = "Strong";
				color = "green";
				break;
			case 5:
				strength = "Very Strong";
				color = "darkgreen";
				break;
			}
			password_strength.innerHTML = strength;
			password_strength.style.color = color;
		}

		function validation() {
			var password = document.getElementById("txtPassword").value;

			if (password.length < 8) {
				alert("Password is too_short");
				return false;
			} else if (password.length > 12) {
				alert("Password is too_long");
				return false;
			} else if (password.search(/\d/) == -1) {
				alert("no_num");
				return false;
			} else if (password.search(/[A-Z]/) == -1) {
				alert("no Cap _letter");
				return false;
			} else if (password.search(/[a-z]/) == -1) {
				alert("no Sm _letter");
				return false;
			} else if (password
					.search(/[^a-zA-Z0-9\!\@\#\$\%\^\&\*\(\)\_\+\.\,\;\:]/) != -1) {
				alert("bad_char");
				return false;
			}
			alert("ok!!" + password);

		}
	</script>
</body>
</html>