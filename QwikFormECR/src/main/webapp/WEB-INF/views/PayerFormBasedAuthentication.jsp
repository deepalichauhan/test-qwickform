<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms SuperAdmin Portal</title>
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
	<div class="ch-container">
			<div class="row">

			<div class="row">
				<div class="col-md-12 center login-header">


					<h2>
						Welcome To QwikForms
					</h2>

				</div>
				<!--/span-->
			</div>
			<!--/row-->

			<div class="row">
				<div class="well col-md-5 center login-box">
	<%
						String msg = (String) request.getAttribute("msg");
						if (msg != null) {
					%>
					<div class="alert alert-info"
						style="font-weight: bold; font-size: medium; color: red;">

						<%=msg%>
					</div>

					<%
						} else {
					%>
					<div class="alert alert-info">Please authenticate yourself with User Password
						</div>
					<%
						}
					%>

					

					<form class="form-horizontal" action="getPayerFormsById1" method="post">
						<fieldset>
							
							<div id="input-email" class="input-group input-group-lg">

								<span class="input-group-addon"><i
									class="glyphicon glyphicon-envelope red"></i></span> <input
									type="text" name="qfId" id="qfId"
									class="form-control" required="required" placeholder="User Password">
							</div>

							<!-- <p class="center col-md-5"></p> -->
							<!-- <div id="input-number" class="input-group input-group-lg">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-lock red"></i></span> <input
									type="date" name="dob" class="form-control"
									id="dob" required="required" placeholder="Date Of Borth">
							</div> -->
							<div class="clearfix"></div>
				
							<p class="center col-md-5">
								<button type="submit" class="btn btn-primary">Proceed</button>
							</p>
							<input type="hidden" name="flag" value="0" />
							<input type="hidden" name="formid" value="<%=request.getParameter("formid") %>" />
							<input type="hidden" name="bid" value="<%=request.getParameter("bid") %>" />
							<input type="hidden" name="cid" value="<%=request.getParameter("cid") %>" />	
							<input type="hidden" name="PayeeProfile" value="<%=request.getParameter("PayeeProfile") %>" />
							
						</fieldset>
					</form>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
		</div>
		<!--/fluid-row-->
		<footer class="row"> </footer>
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

</body>
</html>
