<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
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
<link rel="shortcut icon" href="img/favicon.ico">
<script src='https://www.google.com/recaptcha/api.js'></script>
<script src="http://cdn.jsdelivr.net/webshim/1.12.4/extras/modernizr-custom.js"></script>

<script language="javascript" type="text/javascript"
	src="js/datetimepicker_css_100Year.js">
	<script src="http://cdn.jsdelivr.net/webshim/1.12.4/polyfiller.js">
</script>
<script>
	webshims.setOptions('waitReady', false);
	webshims.setOptions('forms-ext', {
		types : 'date'
	});
	webshims.polyfill('forms forms-ext');
</script>
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

<body onload="ExecuteFun();">
	<%
		Integer sesBid = null, sesCid = null;
			CollegeBean collegeBean = new CollegeBean();
			try {

		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
	%>
	<%
		} catch (java.lang.NullPointerException e) {
	%>

	<script type="text/javascript">
		window.location = "paySessionOut";
	</script>
	<%
		}
	%>

	<%
		//String cid = (String) session.getAttribute("cid");
			String PayeeProfile = (String) session.getAttribute("PayeeProfile");
			//int bid = Integer.parseInt((String) session.getAttribute("bid"));

			AppPropertiesConfig quickCollectProperties = new AppPropertiesConfig();
			Properties properties = quickCollectProperties.getPropValues();

			String clientLogoLink = properties.getProperty("clientLogoLink");
	%>
	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>

			<%
				try {
			%>
			<a class="navbar-brand" href="#"> <img
				src="<%=collegeBean.getCollegeLogo()%>"></a> <a
				class="navbar-brand" href="<%=clientLogoLink%>"><span> <%=collegeBean.getCollegeName()%>,<br><%=collegeBean.getState()%>
			</span></a><span style="margin-left: 10%;"></span> <img alt=""
				src="<%=collegeBean.getBankDetailsOTM().getBankLogo()%>"
				style="width: 300px; height: 80px;">

			<%
				} catch (java.lang.NullPointerException e) {
			%>

			<script type="text/javascript">
				window.location = "PaySessionOut";
			</script>
			<%
				}
			%>





		</div>
		
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">

			<div id="content" class="col-lg-12 col-sm-12">
				<!-- content starts -->




				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Transaction
									Details
								</h2>
								<%
									String collegeCode = (String) session.getAttribute("clientCode");
								%>
								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<%
									String msg = (String) request.getAttribute("msg");
									if (msg != null) {
								%>

								<span style="color: red"><%=msg%></span>
								<%
									}
								%>
								<form action="viewPreviousTxn" id="previoustxnIdAction"
									name="previoustxnIdAction" method="post">
									<table id="mainForm">
										<tr>
											<td>
												<%
													try {

														if (PayeeProfile.equals("Institute")) {
												%> <label class="control-label" for="roll">Date of
													Incorporation</label> <%
 	} else {
 %> <label class="control-label" for="roll"> Date of Birth</label> <%
 	}
 	} catch (NullPointerException e) {
 %> <script type="text/javascript">
		window.location = "PaySessionOut";
	</script> <%
 	}
 %>









											</td>
											<td><input type="hidden" name="clientId"
												value='<%=sesCid%>'> <input name="birthDate"
												id="idDOB" required="required" placeholder="DD-MM-YYYY"
												type="text" class="form-control" style="height: 30px;"><img
												src="img/cal.gif"
												onclick="javascript:NewCssCal('idDOB','ddmmyyyy')"
												style="cursor: pointer" /></td>

											<td><label class="control-label" for="stuname">Contact
													Number</label></td>

											<td><input name="contactNo"
												placeholder="Enter Mobile Number" pattern="[789][1-9]"
												required="required" type="text" class="form-control"
												id="idMob"></td>


											<td></td>
											<td></td>

										</tr>
										<tr>
											<td></td>
											<td></td>

											<td style="text-align: center;"><span
												style="font-weight: bolder; font-size: x-large;">AND</span>
											</td>
											<td></td>
											<td></td>
											<td></td>


										</tr>

										<tr>




											<td><label class="control-label" for="">Transaction
													Id</label></td>
											<td>
												<!--  pattern="[a-zA-Z\s]*"--> <input name="transId"
												id="idTxn" required="required"
												placeholder="Enter Transaction Id" type="text"
												class="form-control">
											</td>


											<td
												style="text-align: center; font-size: large; font-weight: bolder;">OR</td>




											<td><label class="control-label" for="dob">From</label>
												<input name="fromDate" id="idFrom" required="required"
												placeholder="DD-MM-YYYY" type="text" class="form-control"
												style="height: 30px;"><img src="img/cal.gif"
												onclick="javascript:NewCssCal('idFrom','ddmmyyyy')"
												style="cursor: pointer" /></td>
											<td></td>
											<td><label class="control-label" for="dob">To</label> <input
												name="toDate" id="idTo" required="required" type="text"
												placeholder="DD-MM-YYYY" class="form-control"
												style="height: 30px;"><img src="img/cal.gif"
												onclick="javascript:NewCssCal('idTo','ddmmyyyy')"
												style="cursor: pointer" /></td>
										</tr>




										<tr>
											<!-- <td colspan="2"><div class="g-recaptcha"
													data-sitekey="6LfXBBQTAAAAAJbcVf6bLQxjbKjdtJeReDXa_DML"></div>
											</td> -->
											<div class="button-section-ss">
						<button  class="btn btn-info btn-sm"  onclick="window.history.back(-1)" >Back</button>
													<button type="button" id="submit_button"
													class="btn btn-success">View Transactions</button>
						</div>
											

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




									<!-- </form> -->
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
	<script type="text/javascript">
		function ExecuteFun() {

			setTimeout(function() {
				ExecuteFun();
				//location.reload();
				var bid =
	<%=sesBid%>
		;
				var cid =
	<%=sesBid%>
		;
				if (bid == '' || bid == null) {
					window.location = "TimeIntervalPage";
				}

			}, 120000);
	</script>
	<script>
		$("#submit_button")
					.click(
							function() {

								var mobNum = $("#idMob").val();
								var dob = $("#idDOB").val();
								var txnId = $("#idTxn").val();
								var from = $("#idFrom").val();
								var to = $("#idTo").val();
								var previoustxn = $("#previoustxnIdAction")
										.val();

								var patternMobNum = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;

								if (dob == '' && mobNum == '' && txnId == ''
										&& from == '' && to == '') {
									alert("Please Enter Date Of Birth , Mobile Number And Transaction ID OR From Date ,To Date");
									return false;

								}

								if (dob == ''
										&& (mobNum == '' || mobNum.length != 10)) {

									alert("Please Enter Date Of Birth and Mobile Number");
									return false;
								}

								if (txnId == '' && from == '' && to == '') {

									alert("Please Enter Tranaction Id or From Date, to Date");
									return false;

								} else if (txnId != ''
										|| (from != '' && to != '')) {
									document.getElementById(
											'previoustxnIdAction').submit();
									return true;
								} else {
									alert("Please Enter Tranaction Id or From Date, to Date");
									return false;
								}

							});
			function ExecuteFun() {

				setTimeout(function() {
					ExecuteFun();
					//location.reload();
					var bid =
	<%=sesBid%>
		var cid =
	<%=sesBid%>
		if (bid == '' || bid == null) {
						window.location = "PaySessionOut";
					}

				}, 120000);
			}
		}
	</script>

</body>
</html>
