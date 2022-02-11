<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms Upload Landing Page</title>
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
		try {
			loginBean = (LoginBean) session.getAttribute("loginUserBean");
			if(null==loginBean){
				
				    //response.sendRedirect("sessionFailurePage");
				    %>
				    <script type="text/javascript">
			
			window.location="timeIntervalPage"
			</script>
				    <%
			}

		} catch (NullPointerException e) {
			
			%>
			<script type="text/javascript">
			
			window.location="timeIntervalPage"
			</script>
			<%
		}
	%>

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
									<i class="glyphicon glyphicon-star-empty"></i> Upload Landing
									Page
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form:form action="uploadLP" namespace="/" method="POST" enctype="multipart/form-data">
									<table class="table table-striped table-condensed">
									<tr>
									
									<td>Select Landing Page Jsp:
									<input hidden="hidden" type="text" name="reqFormId" value='<%=request.getParameter("formId")%>'>
									
									<input type="file" name="userImage" label="Select a File to upload"
										size="40" />
										
									<%-- <s:file name="userImage" label="Select a File to upload"
										size="40" /> --%></td>
									</tr>
									<tr>
									<td>
									<input type="submit" cssClass="btn btn-info btn-sm" value="Submit" name="submit" />
									<%-- <s:submit  cssClass="btn btn-info btn-sm" value="Submit" name="submit" /> --%>
									</td>
									</tr>
								</table>
								</form:form>

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
	</div>
	<div id="footer">
      <div class="container">
		<p>© Copyright 2016. powered by <a href="http://www.sabpaisa.com/" alt="SRS Live Technologies Pvt Ltd" title="SRS Live Technologies Pvt Ltd">SRS Live Technologies Pvt Ltd</a>.</p>
		
		
		<ul class="footer-ul">
			<li><a href="#" target="_blank">About us</a></li>
			<li><a href="#" target="_blank">Our Vision</a></li>
			<li><a href="#" target="_blank">Our Team</a></li>
			<li><a href="#" target="_blank">Press</a></li>
			<li><a href="#" target="_blank">Career</a></li>
			<li><a href="#" target="_blank">Contact Us</a></li>
			<li><a href="#" target="_blank">Privacy Policy</a></li>
			
			<li><a href="#" target="_blank">Terms&Conditions</a></li>
			<li><a href="#" target="_blank">Payment Security</a></li>
			<li><a href="#" target="_blank">Disclaimer</a></li>
		</ul>

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
		function saveForm() {
			document.getElementById("FeeForm").submit();
			alert("Fee Successfully Added");
			window.close();
		}
		function getMoreOptions(profile) {
			if (profile === "REVIEWER") {
				document.getElementById("revOptions").style.display = "table-row";
				document.getElementById("revEmail").required = "required";
			} else {
				document.getElementById("revOptions").style.display = "none";
				document.getElementById("revEmail").required = false;
			}
		}
	</script>
</body>
</html>
