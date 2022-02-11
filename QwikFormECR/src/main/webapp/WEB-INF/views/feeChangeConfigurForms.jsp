<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		/* String formIdForLateFee ="";
		if(null!=session.getAttribute("formIdForLateFee") || !session.getAttribute("formIdForLateFee").toString().isEmpty()){
		formIdForLateFee = (String) session.getAttribute("formIdForLateFee");
		} */
		String msg = (String) request.getAttribute("msg");
		String link = (String) request.getAttribute("redirectlink");
	%>


	<%
		if (msg != null) {
	%>


	<div
		style="color: green; text-align: center; font-weight: bold; font-size: x-large;">
		<%=msg%>
	</div>

	<%
		}
	%>



	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a
				style="font-family: cursive; font-size: xx-large; padding-left: 450px">
				<span> <%-- <%=collegeBean.getCollegeName()%> --%></span>
			</a>


			<div class="btn-group pull-right">

				<ul class="dropdown-menu">
					<li class="divider"></li>
					<li><a href="logOutUser">Logout</a></li>
				</ul>
			</div>
			<!-- user dropdown ends -->
			<jsp:include page="menu_clientDetails.jsp"></jsp:include>
			<!-- theme selector starts -->




		</div>
	</div>


	<div class="ch-container">
		<div class="row">
			<div class="col-sm-12 col-lg-12">
				<!-- left menu starts -->
				<div class="col-sm-2 col-lg-2">
					<div class="sidebar-nav">
						<div class="nav-canvas">

							<jsp:include page="menu-SA.jsp"></jsp:include>


						</div>
					</div>
				</div>
				<!-- left menu Ends -->
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

				<form>
					<s:token />
					<div id="content" class="col-lg-10 col-sm-10">
						<div class="row">
							<div class="box col-md-12">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-star-empty"></i>All Form List
										</h2>
										<div class="box-icon">
											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-up"></i></a>
										</div>
									</div>
									<div class="box-content">
										<!-- put your content here -->
										<table class="table table-striped table-condensed"
											cellpadding="0" cellspacing="0"
											style="border: 1px solid #ccc; background: #f9f9f9;">
											<tr>
												<td>

													<div class="control-group">
														<label class="control-label" for="selectError">Update
															By Form Name</label>

														<div class="controls" style="height: 40px; width:">
															<select id="formId" class="form-control valid"
																onchange='AddValue(this.value)' data-rel="chosen"
																required="required"
																style="width: 50px !important; min-width: 220px; max-width: 50px;">
																<option value="">--Select an option--</option>
																<c:forEach items="${formMapData}" var="formView">
																	<option value='<c:out value="${formView.key}"/>'>
																		<c:out value="${formView.value}" /></option>
																</c:forEach>
															</select>
														</div>
													</div>
												</td>
												<td style="padding: 33px 10px;">
													<div class="controls">
														<button type="button" onclick="lateFeeConfigure()"
															class="btn btn-success btn-sm">Configure Late
															Fee (Periodic with Date)</button>
													</div>
												</td>
											</tr>
											<!-- <tr>
												
											</tr> -->
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="row" id="ResultBox">
							<div class="box col-md-12">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-star-empty"></i>Late fee
											configure details
										</h2>
										<div class="box-icon">
											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-up"></i></a>
										</div>
									</div>
									<div class="box-content" style="display: none;" id="myCONF">
										<!-- <div class="box-content"> -->
										<!-- put your content here -->
										<table id="oldLateFeeTable" class='display nowrap' border="1">
											<c:if test="${not empty formDetailsForLateFee}">
												<%
													int i = 0;
												%>
												<c:forEach items="${formDetailsForLateFee}" var="lateFee">
													<tr bgcolor="#E6E6FA">
														<td rowspan="2"><c:out value="<%=++i%>" /></td>
														<td>
															<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
																<label class="col-sm-5 col-form-label labeling">Late
																	Fee Start Date</label>
																<div class="col-sm-5">
																	<input type="text" disabled="disabled"
																		readonly="readonly"
																		value='<c:out value="${lateFee.latefeeStartdate}" />'>
																</div>
															</div>
														</td>
														<td>
															<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
																<label class="col-sm-5 col-form-label labeling">Late
																	Fee End Date</label>
																<div class="col-sm-5">
																	<input type="text" disabled="disabled"
																		readonly="readonly"
																		value='<c:out value="${lateFee.latefeeEnddate}" />'>
																</div>
															</div>
														</td>
														<td rowspan="2"><input type="button"
															class="btn btn-sm btn-info pull-right"
									onclick='window.open("editLateFeeById?id=${lateFee.id}&formId=${formIdForLateFee}","Fill Late Fee Details","width=480,height=500")'
															value="Edit Late Fee">
														</td>
													</tr>
													<tr bgcolor="#E6E6FA">
														<td>
															<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
																<label class="col-sm-5 col-form-label labeling">Late
																	Fee Amount</label>
																<div class="col-sm-5">
																	<input type="text" disabled="disabled"
																		readonly="readonly"
																		value='<c:out value="${lateFee.latefeeAmount}" />'>
																</div>
															</div>
														</td>
														<td>
															<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
																<label class="col-sm-5 col-form-label labeling">Late
																	Fee Type</label>
																<div class="col-sm-5">
																	<input type="text" disabled="disabled"
																		readonly="readonly"
																		value='<c:out value="${lateFee.latefeeType}" />'>
																</div>
															</div>
														</td>
													</tr>

												</c:forEach>
											</c:if>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="row" id="ResultBox1">
							<div class="box col-md-12">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-star-empty"></i>Click for
											configure new late fee*
										</h2>
										<div class="box-icon">
											<input type="hidden" name="formIdForLateFee"
												id="formIdForLateFee"
												value="<c:out value='${formIdForLateFee}'/>" /> <span
												style="float: right"><button
													class="btn btn-sm btn-success" onclick="addButtons()">++</button></span>
										</div>
									</div>
									<div class="box-content" style="display: none;"
										id="myCONFforUpdate">


										<!-- put your content here -->
										<table id="updateLateFee" class='display nowrap'>
											<tr>
												<td>
													<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
														<label class="col-sm-3 col-form-label labeling">Start
															Date*</label>
														<div class="col-sm-5">
															<%-- <input type="hidden" name="formIdForLateFee" id="formIdForLateFee" 
															value="<c:out value='${formIdForLateFee}'/>"/> --%>

															<input id="frominput" type="date"
																placeholder="Form Start Date" name="fromDateStr"
																required="required" onchange="compareDates()">
														</div>
													</div>
												</td>
												<td>
													<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
														<label class="col-sm-3 col-form-label labeling">End
															Date*</label>
														<div class="col-sm-5">
															<input id="toinput" type="date"
																placeholder="Form End Date" required="required"
																name="toDateStr" onchange="compareDates()">
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td>
													<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
														<label class="col-sm-3 col-form-label labeling">Late
															Amount*</label>
														<div class="col-sm-5">
															<input type="text" name="latefeeAmount"
																id="latefeeAmount" placeholder="Late Fee Amount"
																required="required">
														</div>
													</div>
												</td>
												<td>
													<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
														<label class="col-sm-3 col-form-label labeling">Late
															Fee Type*</label>
														<div class="col-sm-5">
															<select name="latefeeType" id="latefeeType">
																<option value="">--Select any one--</option>
																<option value="Fixed">Fixed</option>
																<option value="Daily_Update">Daily_Update</option>
																<option value="Periodic">Periodic</option>
																<option value="Monthly_Fixed">Monthly_Fixed</option>
																<option value="Monthly_Daily">Monthly_Daily</option>
																<option value="Monthly_Periodic">Monthly_Periodic</option>
																<option value="Monthly_Periodic_Daily">Monthly_Periodic_Daily</option>
															</select>
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="2"><button class="btn btn-sm btn-success"
														onclick="saveNewConfiguredLateFee()" type="submit">Save
														New Late Fee Configuration</button>

													<button class="btn btn-sm btn-warning"
														onclick="window.close()">Cancel</button> <!-- <button class="btn btn-sm btn-success"
														onclick="updateNewConfiguredLateFee()" type="submit">Update
														Late Fee Configuration</button> --></td>

											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>

				<!--/row-->
			</div>

			<!-- content ends -->
		</div>
		<!--/#content.col-md-0-->

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

	<script>
		/* function saveForm()
		{
			document.getElementById("FeeForm").submit();
			window.location.href='<spring:url value="/Success"/>';
			window.close();
		} */
	</script>


	<script type="text/javascript">
		var val = "";
		var idVal = "";

		function AddValue(value) {
			val = value;
			//alert("formValue is "+val);
		}

		//lateFeeConfigure
		function lateFeeConfigure() {

			var x = document.getElementById("myCONF");
			var idVal = "lateFeeChange";
			//alert("idVal is "+idVal);
			//alert("formId is "+val);
			var formId = val;

			if (formId != "") {
				//alert("It is in try block for configuring new late fee with dates.");

				if (x.style.display === "none") {
					x.style.display = "block";
				} else {
					x.style.display = "none";
				}

				window.location = "findOldConfigurdLateFee?formId=" + formId
						+ "&idVal=" + idVal;
			} else {
				alert("please select a form first then update the late fee configuration.");
				return false;
			}
		}

		function addButtons() {
			var x = document.getElementById("myCONFforUpdate");
			var formId = document.getElementById("formIdForLateFee").value;
			if (formId != "") {
				if (x.style.display === "none") {
					x.style.display = "block";
				} else {
					x.style.display = "none";
				}
			} else {
				alert("please select a form first then update the late fee configuration.");
				return false;
			}

		}

		//use for comparing the dates
		function compareDates() {
			//alert("check date management");
			var fromdate = document.getElementById("frominput").value;
			var todate1 = document.getElementById("toinput").value;
			var datefrom = new Date(fromdate);
			var dateTo1 = new Date(todate1);

			if (datefrom > dateTo1) {
				alert("Form Start Date should be before Form End Date!");
				document.getElementById("toinput").value = "";
			}
		}

		//saveNewConfiguredLateFee
		function saveNewConfiguredLateFee() {

			var fromdate = document.getElementById("frominput").value;
			var todate1 = document.getElementById("toinput").value;
			var latefeeamount = document.getElementById("latefeeAmount").value;
			var latefeetype = document.getElementById("latefeeType").value;
			var formId = document.getElementById("formIdForLateFee").value;
			/* alert("FormId : "+formId+" : fromDate : "+ fromdate + " : todate : " + todate1 + " : fee amount : "
					+ latefeeamount + " : fee type : " + latefeetype); */
			var argument = "formIdForLateFee=" + formId + "&fromdate="
					+ fromdate + "&todate=" + todate1 + "&feeAmount="
					+ latefeeamount + "&feeType=" + latefeetype;
			//alert("argument : "+argument);

			if (formId != "" && fromdate != "" && todate1 != ""
					&& latefeeamount != "") {
				//alert("AAAAAAAAAAAAAAAAA");
				window.location = "saveNewConfiguredLateFee?" + argument;
			} else {
				alert("please select a form or Upload a correct file for proceed.");
				return false;
			}
			/* window.open("saveFormDataAsNewTarget?formId="+formId, "Preview",
					"width=640,height=480"); */
		}

		//updateNewConfiguredLateFee
		function updateNewConfiguredLateFee() {

			var fromdate = document.getElementById("frominput").value;
			var todate1 = document.getElementById("toinput").value;
			var latefeeamount = document.getElementById("latefeeAmount").value;
			var latefeetype = document.getElementById("latefeeType").value;
			var formId = document.getElementById("formIdForLateFee").value;
			/* alert("FormId : "+formId+" : fromDate : "+ fromdate + " : todate : " + todate1 + " : fee amount : "
					+ latefeeamount + " : fee type : " + latefeetype); */
			var argument = "formIdForLateFee=" + formId + "&fromdate="
					+ fromdate + "&todate=" + todate1 + "&feeAmount="
					+ latefeeamount + "&feeType=" + latefeetype;
			alert("argument : " + argument);

			if (formId != "" && fromdate != "" && todate1 != ""
					&& latefeeamount != "") {
				//alert("AAAAAAAAAAAAAAAAA");
				window.location = "updateNewConfiguredLateFee?" + argument;
			} else {
				alert("please select a form or Upload a correct file for proceed.");
				return false;
			}
			/* window.open("saveFormDataAsNewTarget?formId="+formId, "Preview",
					"width=640,height=480"); */
		}

		$(document).ready(function() {
			$('#fieldName').bind("cut copy paste", function(e) {
				e.preventDefault();
			});
		});
	</script>
</body>
</html>
