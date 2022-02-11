<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.sabpaisa.qforms.beans.SuperAdminBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>QWickCollect</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
<meta name="author" content="Muhammad Usman">

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

	<%
		SuperAdminBean saBean = (SuperAdminBean) session.getAttribute("loginClient");
		try {
			saBean = (SuperAdminBean) session.getAttribute("sABean");
		} catch (NullPointerException e) {
			System.out.print("Nullpointer Exception in JSP...");
		}
	%>
	<div class="ch-container">
		<div class="row">
			<div class="row">
				<div class="well col-md-5 center login-box">



					<div class="alert alert-info">Please Fill the Form</div>

					<form class="form-horizontal" action="reg" method="post" modelAttribute="superAdmin">

						<input id="comId" name="companyBean.id" type="hidden"
							value="<%=saBean.getCompanyBean().getId()%>">

						<table id="mainForm1">
							<tbody>

								<tr>

									<td>User Name</td>
									<td><div id="the-basics" class="has-success">
											<input type="text" name="userName"
												class="form-control" required="required"
												placeholder="Username">
										</div></td>
								</tr>
								<tr>

									<td>Password</td>
									<td><div id="the-basics" class="has-success">
											<input type="password" maxlength="12" name="pass"
												class="form-control" required="required"
												placeholder="Password" id="txtPassword"
												onkeyup="CheckPasswordStrength(this.value)" /> <span
												id="password_strength"></span>
										</div></td>
								</tr>
								<tr>

									<td>Full Name</td>
									<td><div id="the-basics" class="has-success">
											<input type="text" name="name"
												class="form-control" required="required"
												placeholder="Full Name">
										</div></td>
								</tr>
								<tr>

									<td>Contact Number</td>
									<td><div id="the-basics" class="has-success">
											<input type="number" name="contact"
												class="form-control" required="required" pattern="[0-9]{10}"
												placeholder="Contact No">
										</div></td>

								</tr>
								<tr>

									<td>Email Id</td>
									<td><div id="the-basics" class="has-success">
											<input type="email" name="email"
												class="form-control" required="required"
												placeholder="EmailId">
										</div></td>
								<tr>

									<td><button class="btn btn-sm btn-warning"
											onclick="window.close()">Cancel</button></td>
									<td><button class="btn btn-sm btn-success" type="submit"
											onclick="return validation()">Save</button></td>
								</tr>
							</tbody>
						</table>

					</form>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
		</div>
		<!--/fluid-row-->

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