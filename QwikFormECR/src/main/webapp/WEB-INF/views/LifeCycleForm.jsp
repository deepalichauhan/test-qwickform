<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms Form Life Cycle</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The styles -->
<link id="bs-css" href="css/bootstrap-cerulean.min.css" rel="stylesheet">

<link href="css/charisma-app.css" rel="stylesheet">
<link href='bower_components/fullcalendar/dist/fullcalendar.css'
	rel='stylesheet'>
<link href='bower_components/fullcalendar/dist/fullcalendar.print.css'
	rel='stylesheet' media='print'>
<!-- <link href='bower_components/chosen/chosen.min.css' rel='stylesheet'> -->
<link href='css/chosen.css' rel='stylesheet'>
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
</head>

<body>

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
									<i class="glyphicon glyphicon-star-empty"></i> Define Form Life
									Cycle
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form id="ActorForm" action="saveFormLifeCycle" method="post" modelAttribute="formCycles">


									<table id="mainForm1"
										class="table table-condensed table-striped">
										<thead>
											<tr>
												<th>Form Stage No.</th>
												<th>Actor (User)</th>
												<th>Action on Submit</th>
												<th>Allow Form Edit</th>
										</thead>
										<tbody id="stageDiv">
											<tr>
												<td colspan="4"><button
														class="btn btn-info btn-sm pull-right" type="button"
														onclick="addStage()">Add Stage</button></td>
											</tr>
											<tr>
												<td><input style="width: 20%; height: 100%"
													class="form-control" readonly="readonly" value="0"
													name="${flcBean[0].stage_number}"></td>
												<td><select required="required" style="width: 50%; height: 100%"
													name="${flcBean[0].actor_id}">
														<option disabled="disabled" selected="selected" value="">Please Select an Option</option>
														<c:forEach items="${actors}" var="actors">
															<option value='<c:out value="${actors.actor_id}"/>'><c:out
																	value="${actors.actor_alias}" /></option>
														</c:forEach>
												</select></td>
												<td><select  required="required" style="width: 50%; height: 100%"
													name="${flcBean[0].form_action}">
														<option disabled="disabled" selected="selected" value="">Please Select an Option</option>
														<c:forEach items="${formactions}" var="formactions">
															<option><c:out value="${formactions.action_name}" /></option>
														</c:forEach>
												</select></td>
												<td><!-- Yes<input required="required" style="width: 50%; height: 100%"
													name="formCycles[0].isEditable" value="Y" hidden="hidden"> -->
														
														<select required="required" style="width: 50%; height: 100%"
													name="${flcBean[0].isEditable}">
														<option value="" selected="selected" disabled="disabled">Please Select an Option</option>
														<option value="Y">Yes</option>
														<option value="N">No</option>
												</select>
														
														
														</td>
											</tr>
											<tr>
												<td><input style="width: 20%; height: 100%"
													class="form-control" readonly="readonly" value="1"
													name="${formCycles[1].stage_number}"></td>
												<td><select required="required" style="width: 50%; height: 100%"
													name="${formCycles[1].actor_id}">
														<option disabled="disabled" selected="selected" value="">Please Select an Option</option>
														<c:forEach items="${actors}" var="actors">
															<option value='<c:out value="${actors.actor_id}"/>'><c:out
																	value="${actors.actor_alias}" /></option>
														</c:forEach>
												</select></td>
												<td><select  required="required" style="width: 50%; height: 100%"
													name="${formCycles[1].form_action}">
														<option disabled="disabled" selected="selected" value="">Please Select an Option</option>
														<c:forEach items="${formactions}" var="formactions">
															<option><c:out value="${formactions.action_name}" /></option>
														</c:forEach>
												</select></td>
												<td><select required="required" style="width: 50%; height: 100%"
													name="${formCycles[1].isEditable}">
														<option value="" selected="selected" disabled="disabled">Please Select an Option</option>
														<option value="Y">Yes</option>
														<option value="N">No</option>
												</select></td>
											</tr>
										</tbody>
									</table>
									<table class="table table-condensed table-striped">
										<tbody>
											<tr>
												<td>
													<button class="btn btn-success btn-sm">Save
														Configuration</button>
												</td>
												<td><button onclick="window.close()"
														class="btn btn-warning btn-sm">Cancel</button></td>
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
	<%-- <script src="bower_components/chosen/chosen.jquery.min.js"></script>
	<script src="bower_components/chosen/chosen.jquery.js"></script> --%>
	<script src="js/chosen.jquery.min.js"></script>
	<script src="js/chosen.jquery.js"></script>
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
		var stagecount = 1;
		function addStage() {
			//alert("stagecount is "+stagecount);
			stagecount++;
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
					document.getElementById("stageDiv").innerHTML += xhttp.responseText;
					/* $("#selectActors"+stagecount).chosen();
					$("#selectAction"+stagecount).chosen();  */
				}
			}
			//alert("stagecount is "+stagecount);
			xhttp.open("GET", "addStageToLifeCycleForm?reqStageCount="
					+ stagecount, true);
			xhttp.send();
		}
	</script>
</body>
</html>
