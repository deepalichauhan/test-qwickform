<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>


<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" type="text/css"
	href="DataTables/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css"
	href="DataTables/buttons.dataTables.min.css">
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

	<div class="navbar navbar-default" role="navigation">

		<jsp:include page="SuperAdminHader_Include.jsp"></jsp:include>
	</div>
	<!-- topbar ends -->
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
				<!-- content starts -->
				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<div class="box-icon"></div>
							</div>

						</div>
					</div>
				</div>



				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> All Forms
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->

								<%--  <form name="FormName" id="formList" action="" method="POST" target="_blank">
                            <s:token/> --%>
								<input type="hidden" name="reqFormId" id="reqFormId" value="" />
								<table class="table table-striped table-condensed display"
									id="mainForm1">
									<thead>
										<tr>
											<!-- <th>Sr. No</th> -->
											<th>Form ID</th>
											<th>Form Name</th>
											<th>Fee Name</th>
											<!-- <th>Date Created</th> -->
											<th>Created By</th>
											<th>Start Date</th>
											<th>End Date(w/o Penalty)</th>
											<th>End Date(w Penalty)</th>
											<th>Form Status</th>
											<!-- <th>SA Comment</th> -->
											<th>View Form /Trans Link</th>
											<th>Approve /Disapprove /Reporting</th>
											<!-- <th></th> -->
											<!-- <th></th> -->
									</thead>
									<tbody>
										<%
											int i = 1;
										%>
										<c:forEach items="${allForms}" var="test" varStatus="ind">
											<tr>
												<%-- <td><strong>  <%=i%>
												</strong></td> --%>
												<td><c:out value='${test.id}'/></td>
												<td><c:out value='${test.formName}'/></td>
												<td><c:out value='${test.formFee.feeLookup.feeName}'/></td>
												<%-- <td><c:out value='${test.formDate}'>/</c:out></td> --%>
												<td><c:out value='${test.formOwnerName}'/></td>
												<td><c:out value='${formStartDate} '/></td>
												<td><c:out value='${test.formEndDate}'/></td>
												<td><c:out value='${test.formLateEndDate}'/></td>
												<td><c:out value='${test.status}'/></td>
												<%-- <td><c:out value='${test.saComment}'/></td> --%>
												<td><button
														onclick="showPreviewAction(${test.id})"
														class="btn btn-info btn-xs">View Form</button>
													<button
														onclick="showLinksAction(${test.id})"
														class="btn btn-info btn-xs">Trans Link</button>
													<c:if test='${test.life_cycle.contentEquals("yes")}'>
														<button class="btn btn-info btn-xs"
															onclick='viewLifeCycle("<c:out value='${test.id}' />")'>View
															Life Cycle</button>
													</c:if>	
												</td>
												<td>
												<c:if test="${test.status == 'NEW' || test.status == 'DISAPPROVED' || test.status == 'REPORT'}">
													<c:choose>
														<c:when test="${test.status == 'APPROVED'}">
															<button
																onclick="alert('<c:out value='${test.formName}' /> already Approved');"                         
																class="btn btn-success btn-xs">Approve</button>
														</c:when>
														<c:otherwise>
															<button
																onclick='approveForm("<c:out value='${test.formName}' />","<c:out value='${test.id}' />")'
																class="btn btn-success btn-xs">Approve</button>
														</c:otherwise>
													</c:choose>
												</c:if>
												<c:if test="${test.status != 'NEW' && test.status == 'REPORT'}">
													<c:choose>
														<c:when test="${test.status == 'DISAPPROVED'}">
															<button
																onclick="alert('<c:out value='${test.formName}' /> already Disapproved');"
																class="btn btn-warning btn-xs">Disapprove</button>
														</c:when>
														<c:otherwise>
															<button
																onclick='disapproveForm("<c:out value='${test.formName}' />","<c:out value='${test.id}' />")'
																class="btn btn-warning btn-xs">Disapprove</button>
														</c:otherwise>
													</c:choose>
												</c:if>
												<c:if test="${test.status != 'NEW' && test.status == 'APPROVED'}">
														<c:choose>  
															<c:when test="${test.status} == 'REPORT'">
																<button
																onclick="alert('${forms.formName} already reported, client can find their Report from client portal.');"
																class="btn btn-success btn-xs">Reporting</button>
															</c:when>
															<c:otherwise>
																<button
																onclick='reportWithDisapproveForm("<c:out value='${test.formName}' />","<c:out value='${test.id}' />")'
																class="btn btn-success btn-xs">Reporting</button>
															</c:otherwise>
														</c:choose>
													</c:if>
												</td>
												<td></td>
												<%
													i++;
												%>
											</tr>
										</c:forEach>
									</tbody>






								</table>



								<!-- </form> -->



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

	<script>
	
	$(document).ready(function() {
		$('#mainForm1').DataTable({
			scrollY : '50vh',
			scrollCollapse : true,
			"scrollX" : true,
			"language" : {
				"search" : "Filter Results:"
			},
			"length" : 50,
			dom : 'Bfrtip',
			buttons : [ 'copy', 'excel', 'pdf', 'print' ]
		});
	});
	
		function approveForm(name, id) {
			var cnf = confirm("Approve " + name + "? ")
			if (cnf) {
				alert("Form has been Approved");
				window.open("approveForm2?formid=" + id,"width=960,height=1080");
			}
		}
		function disapproveForm(name, id) {
			var cnf = prompt("Disapprove " + name + "? Please Write a Comment");
			if (cnf != null) {
				alert("Form has been Disapproved");
				/* window.location = "disapproveForm2?formid=" + id + "&comment="
						+ cnf,"_blank"; */
				
				 window.open("disapproveForm2?formid=" + id + "&comment="+ cnf,"width=960,height=1080");
			}
		}
		function reportWithDisapproveForm(name, id) {
			alert("form id and name is ========== > "+id+" ,,, "+name);
			var cnf = prompt("Reporting the running form " + name + " ? Please Write a Comment" );
			if (cnf != null) {
				alert("Form has been Reported and client can check all reports of this form on client portal.");
				/* window.location = "disapproveForm2?formid=" + id + "&comment="+ cnf,"_blank"; */
				
				 window.open("reportCheckingOnDisapprovedForm?formid=" + id + "&comment="+ cnf,"width=960,height=1080");
				 //window.open("disapproveForm2?formid=" + id + "&comment="+ cnf,"width=960,height=1080");
			}
		}
		function showPreview(id) {
			window.open("previewForm?reqFormId=" + id, "Form Preview","width=960,height=1080");
		}
		
		function showLinksAction(id) {
			alert("showLinksAction id: "+id);
		 window.open("linksForFormPay?reqFormId=" + id, "Form Preview", "width=960,height=1080");
		}
		
        function showPreviewAction(id) {
			//alert("showPreviewAction id: "+id);
		 window.open("previewForm?reqFormId=" + id, "Form Preview", "width=960,height=1080");
		}
		
		function viewLifeCycle(id)
		{
			window.open("getFormCycle?reqFormId=" + id, "Form Cycle", "width=960,height=1080");
		}
	</script>
</body>
</html>
