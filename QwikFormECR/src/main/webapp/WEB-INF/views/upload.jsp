<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>QwikForms</title>
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
<link rel="shortcut icon" href="img/favicon.ico">
<style type="text/css">
.alert2-info {
	background-color: #7b0909;
	border-color: rgba(8, 8, 8, 0);
	color: #ffffff;
}

.alert2 {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
}
</style>
<script type="text/javascript">
	function ShowHideDiv(id) {
		var formBox = document.getElementById("formBox");
		var qcBox = document.getElementById("qcBox");
		if (id == 'fid') {
			document.getElementById('qcBox').style.display = 'none';
			document.getElementById('formBox').style.display = 'block';
			document.getElementById('photoBox').style.display = 'block';
		}
		if (id == 'qcid') {
			document.getElementById('formBox').style.display = 'none';
			document.getElementById('qcBox').style.display = 'block';
			document.getElementById('photoBox').style.display = 'block';
		}
	}
	
	function ShowHidePanal(id) {
		
		if (id == 'forPhoto') {
			
			document.getElementById('signBox').style.display = 'none';
			document.getElementById('photoBox').style.display = 'block';
		}
		if (id == 'forSign') {
			document.getElementById('photoBox').style.display = 'none';
			document.getElementById('signBox').style.display = 'block';
			
		
		}
		
		
	}
</script>
</head>
<body>
	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">
		<jsp:include page="SuperAdminHader_Include.jsp"></jsp:include>

	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">
			<!-- left menu starts -->
			<div class="col-sm-2 col-lg-2">
				<div class="sidebar-nav">
					<div class="nav-canvas">
						<jsp:include page="menu-SA.jsp"></jsp:include>
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

				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-edit"></i> Controls
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-setting btn-round btn-default"><i
										class="glyphicon glyphicon-cog"></i></a> <a href="#"
										class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
										class="btn btn-close btn-round btn-default"><i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content">


								<!-- <span>I want to </span> <label for="chkYes"> <input
									type="radio" id="forPhoto" name="chkPassPort"
									onclick="ShowHidePanal(this.id)" /> Upload Photo
								</label> <label for="chkNo"> <input type="radio" id="forSign"
									name="chkPassPort" onclick="ShowHidePanal(this.id)" />
									 Upload Sign
								</label> -->


								<div class="radio">
									<label> <input type="radio" id="fid" name="chkPassPort"
										onclick="ShowHideDiv(this.id)"> I have Form Id.
									</label>
								</div>
								<div class="radio">
									<label> <input type="radio" id="qcid"
										name="chkPassPort" onclick="ShowHideDiv(this.id)" /> I have
										QwikForms Transaction Id
									</label>
								</div>


							</div>

						</div>

					</div>

				</div>




				<div class="row" id="photoBox" style="display: none">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-edit"></i> Photo Upload
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-setting btn-round btn-default"><i
										class="glyphicon glyphicon-cog"></i></a> <a href="#"
										class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
										class="btn btn-close btn-round btn-default"><i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content">
								<form role="form" action="photoUpload" method="post"
									enctype="multipart/form-data" target="_blank">
									<div class="control-group">
										
										<div class="form-group">
											<select id="selectType" required="required"
												class="form-control" name="fileType" style="width: 200px;">
												<option selected="selected" disabled="disabled">Select
													An Option</option>
												<option value="p">Photo</option>
												<option value="s">Signature</option>
											</select>
										
									</div>
									</div>


									<div class="form-group" id="formBox" style="display: none">
										<label for="exampleInputEmail1">Form Id</label> <input
											type="number" class="form-control" name="formId"
											placeholder="Form ID" style="width: 200px;">
									</div>
									<div class="form-group" id="qcBox" style="display: none">
										<label for="exampleInputEmail1">QwikForms
											Transaction Id</label> <input type="text" class="form-control"
											name="qcId" placeholder="QwikForms Transaction Id" style="width: 200px;">
									</div>

									<div class="form-group">
										<label for="exampleInputFile">File Photo</label> <input
											type="file" name="photo" />
									</div>
									<button type="submit" class="btn btn-default">Submit</button>
								</form>
							</div>
						</div>
					</div>
					<!--/span-->
				</div>
				<!-- <div class="row" id="signBox" style="display: none">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-edit"></i> Sign Upload
								</h2>
								<div class="box-icon">
									<a href="#" class="btn btn-setting btn-round btn-default"><i
										class="glyphicon glyphicon-cog"></i></a> <a href="#"
										class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
										class="btn btn-close btn-round btn-default"><i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content">
								<form role="form" action="signUpload" method="post"	enctype="multipart/form-data">
									<div class="form-group" id="formBox1" style="display: none">
										<label for="exampleInputEmail1">Form Id</label> <input
											type="number" class="form-control" name="formId1"
											placeholder="Form ID">
									</div>
									<div class="form-group" id="qcBox1" style="display: none">
										<label for="exampleInputEmail1">QwikForms
											Transaction Id</label> <input type="text" class="form-control"
											name="qcId1" placeholder="QwikForms Transaction Id">
									</div>

									<div class="form-group">
										<label for="exampleInputFile">Upload Sign</label> <input
											type="file" name="photo1" />
									</div>
									<button type="submit" class="btn btn-success">Submit</button>
								</form>

							</div>
						</div>
					</div>
					/span

				</div> -->
				<!--/row-->

				<!-- content ends -->
			</div>
			<!--/#content.col-md-0-->
		</div>
		<!--/fluid-row-->

		<!-- Ad, you can remove it -->

		<!-- Ad ends -->

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
				onclick="window.open('TermsAndConditions.html','mywindowtitle',
											'width=500,height=550')">Terms
				&amp; Conditions </a> <span> |&nbsp;&nbsp;</span> <a href=""
				onclick="window.open('Disclaimer.html','mywindowtitle',
											'width=500,height=550')">Disclaimer
			</a>







		</div>


		</footer>
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


</script>
</body>
</html>
