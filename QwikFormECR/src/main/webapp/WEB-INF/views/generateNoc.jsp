<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.StateBean"%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.util.Base64"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>QwikForms Forms</title> 
	<script src="bower_components/jquery/jquery.min.js"></script>
	<link href="css/docs.min.css" rel="stylesheet" type="text/css" />
	<link href="css/bootstrap-select.css" rel="stylesheet" type="text/css" />
	<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<link href="css/wizard.css" rel="stylesheet" />
	<link href="css/style-tabbs.css" rel="stylesheet" />
	<link href="css/style-new.css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="js/datetimepicker_css_100Year.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(this).scrollTop(0);
		});

		var submitShotFlag = "fresh";

		var forminstanceid = "";
		var signature_upload = true;
		var photo_upload = true;
		var file_upload = true;
		var signature_uploaded = false;
		var photo_uploaded = false;
		var file_uploaded = false;
		var aadhaarCheck = false;

		 
		function getPosition(str, m, i) {
			return str.split(m, i).join(m).length;
		}
	</script>


	<style>
.not-padding {
	padding: 0
}
</style>
</head>

<body class="scrollTop">
	<div class="logoparts">
		<span class="clientlogo"> 
		
		</span> <span class="providerlogo"><img src="images/sabpaisa-logo.png"
			alt="" title="" height="25%" width="25%"></span>
		
	</div>
	<div class="container bg-img-x" style="margin: 15px auto;">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 bg-colors">
			<ul id="main" class="nav nav-tabs">
				<li role="presentation" class="wizard-step-indicator active" id="11"><a
					href="#1" onclick="return goToStart()">Receipt</a></li>

		
			</ul>
		</div>

		<div id="wizard1" class="wizard">



			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box " id="a_11">

				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 top-main-bg"
					id="1">
					<div class="pan-heading">QwikForms</div>
					<div class="top-pad"></div>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="col-sm-12 labeling">

							<form action="getNocCertificate" method="post">

								<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12"></div>
								<div class="col-lg-10 col-md-12 col-sm-12 col-xs-12">

									<div class="title-name">Generate NOC</div>
									<div class="title-name">
										<font size="5" color="RED"> <%
 	String msg = (String) request.getAttribute("msg");
 	if (msg != null) {
 %> <%=msg%> <%
 	}
 %>

										</font>
									</div>
									<label for="exampleInputEmail1"
										class="col-sm-3 col-form-label labeling">Enter SabPaisa TxnId *</label>
									<div class="col-sm-6 ddown" id="">
										<input type="text" name="txnId"
											class="form-control selectpicker" value="" maxlength="25"
											required></input><font size="2" color="RED"> Ex:
											6xxxxxxxxxxxxxxx</font>
									</div>
									<div class="col-md-12 cntrs labeling-pad">
										<span id="btnClicks"> 
											<button type="submit" class="wizard-goto btn btn-primary">Submit</button>
										</span>
									</div>
								</div>
							</form>
						</div>
						<div class="col-md-12 labeling impt">
							<ul>
								<li>Mandatory fields are marked with an asterisk (*)</li>
								<li>QwikForms is a unique service powered by SabPaisa for
									paying fees, taxes, utility bill online to educational
									institutions, Online taxes, and/or any other
									corporates/institutions.</li>
							</ul>
						</div>
					</div>
				</div>







			</div>


		</div>


	</div>
	</div>
	<div id="footer">

		<p>
			© Copyright 2016. powered by <a href="http://www.sabpaisa.com/"
				alt="SRS Live Technologies Pvt Ltd"
				title="SRS Live Technologies Pvt Ltd">SRS Live Technologies Pvt
				Ltd</a>.
		</p>
		<ul class="footer-ul">
			<li><a href="ContactUs.html" target="_blank">Contact Us</a></li>
			<li><a href="PrivacyPolicy.html" target="_blank">Privacy
					Policy</a></li>
			<li><a href="TermsAndConditions.html" target="_blank">Terms
					& Conditions</a></li>
			<li><a href="PrivacyPolicy.html" target="_blank">Payment
					Security</a></li>
			<li><a href="Disclaimer.html" target="_blank">Disclaimer</a></li>
		</ul>
	</div>


	<script type="text/javascript">
		$(document).ready(function() {
			$("select").change(function() {
				$(this).find("option:selected").each(function() {
					if ($(this).attr("value") == "individual-box") {
						$(".councils").not(".individual-box").hide();
						$(".individual-box").show();
					} else if ($(this).attr("value") == "institue-box") {
						$(".councils").not(".institue-box").hide();
						$(".institue-box").show();
					}

				});
			}).change();
		});
	</script>






	<script src="js/jquery.simplewizard.js"></script>
	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<script src="js/bootstrap-select.js"></script>

	<!-- calender plugin -->
	<script src="bower_components/moment/min/moment.min.js"></script>
	<script src="bower_components/fullcalendar/dist/fullcalendar.min.js"></script>
	<!-- data table plugin -->
	<script src="js/jquery.dataTables.min.js"></script>

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


	<script language="javascript" type="text/javascript"
		src="js/datetimepicker_css_100Year.js">
		
	</script>

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>






</body>
</html>
