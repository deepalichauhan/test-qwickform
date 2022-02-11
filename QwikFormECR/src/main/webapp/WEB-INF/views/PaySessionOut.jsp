
<%-- <%@page import="org.apache.struts2.components.Else"%> --%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<body onload="noBack()">
	<!-- topbar starts -->





	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>


		</div>
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">
			<div align="center">
				

				<noscript>
					<div class="alert alert-block col-md-12">
						<h4 class="alert-heading">Warning!</h4>

						<p>
							You need to have <a
								href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a>
							enabled to use this site.
						</p>
					</div>
					<div style="display: none" class="navbar navbar-default"
						role="navigation" id="topbarCHSE">

						<div class="navbar-inner">
							<button type="button" class="navbar-toggle pull-left">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>




						</div>
					</div>







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

					<div id="content" class="col-lg-12 col-sm-12">
						<!-- content starts -->




						<div class="row">
							<div class="box col-md-12">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-star-empty"></i>QForms
										</h2>

										<div class="box-icon">
											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-up"></i></a>
										</div>
									</div>
									<div class="box-content">


										<div
											style="color: red; font-weight: bold; font-size: large; margin-left: 5%;">

											<%
												String msg = (String) request.getAttribute("msg");
												if (msg != null) {
											%>

											<%=msg%>
											<%
												} else {
											%>

											Something Went Wrong,Please try after sometime..

											<%
												}
											%>
											<br>
											<h4 style="color: gray; font-weight: bold; margin-left: 10%;">Thank
												you...!!!</h4>
										</div>


									</div>

									<div id="selected_College"></div>

									


									<script
										src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

									<!-- library for cookie management -->
									<script src="js/jquery.cookie.js"></script>
									<!-- calender plugin -->
									<script src='bower_components/moment/min/moment.min.js'></script>
									<script
										src='bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
									<!-- data table plugin -->
									<script src='js/jquery.dataTables.min.js'></script>

									<!-- select or dropdown enhancer -->
									<script src="bower_components/chosen/chosen.jquery.min.js"></script>
									<!-- plugin for gallery image view -->
									<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
									<!-- notification plugin -->
									<script src="js/jquery.noty.js"></script>
									<!-- library for making tables responsive -->
									<script
										src="bower_components/responsive-tables/responsive-tables.js"></script>
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

									<script type="text/javascript">
										<script type="text/javascript">
										window.history.forward(1);
										function noBack() {
											window.history.forward(2);
										}
									</script>

									
</body>
</html>