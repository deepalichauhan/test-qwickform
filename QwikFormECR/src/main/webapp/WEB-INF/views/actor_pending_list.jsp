<%@page import="com.sabpaisa.qforms.beans.SuperAdminBean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<title>FomrLink(REVIEWER) Pending Forms</title>
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
SuperAdminBean saBean = null;
try {
	saBean = (SuperAdminBean) session.getAttribute("sABean");
	System.out.println("value of sabean is:"+saBean.getUserName());
} catch (NullPointerException e) {
	//response.sendRedirect("InvalidUserPage.jsp");
%>	<script type="text/javascript">
	
	window.location="timeIntervalPage"
	</script>
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

			<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs">User Options</span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li class="divider"></li>
					<li><a href="saLogout">Logout</a></li>
				</ul>
			</div>
			<!-- user dropdown ends -->

			<!-- theme selector starts -->
			<div class="btn-group pull-right theme-container">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-tint"></i><span
						class="hidden-sm hidden-xs"> </span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu" id="themes">
					<li><a data-value="classic" href="#"><i class="whitespace"></i>
							Classic</a></li>
					<li><a data-value="cerulean" href="#"><i
							class="whitespace"></i> Cerulean</a></li>
					<li><a data-value="cyborg" href="#"><i class="whitespace"></i>
							Cyborg</a></li>
					<li><a data-value="simplex" href="#"><i class="whitespace"></i>
							Simplex</a></li>
					<li><a data-value="darkly" href="#"><i class="whitespace"></i>
							Darkly</a></li>
					<li><a data-value="lumen" href="#"><i class="whitespace"></i>
							Lumen</a></li>
					<li><a data-value="slate" href="#"><i class="whitespace"></i>
							Slate</a></li>
					<li><a data-value="spacelab" href="#"><i
							class="whitespace"></i> Spacelab</a></li>
					<li><a data-value="united" href="#"><i class="whitespace"></i>
							United</a></li>
				</ul>
			</div>

		</div>
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">
			<!-- left menu starts -->
			<div class="col-sm-2 col-lg-2">
				<div class="sidebar-nav">
					<div class="nav-canvas">
						 <jsp:include page="menu-Actor.jsp"></jsp:include>
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

			<div id="content" class="col-lg-10 col-sm-10">
				<!-- content starts -->



				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-list"></i> Pending Forms To Be Filled
								</h2>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<table class='table table-striped table-condensed datatable'>
									<thead>
										<tr>
											<th>#</th>
											<th>Form ID</th>
											<th>Form Name</th>
											<th>Fee Name</th>
											<th>Date Created</th>
											<th>Created By</th>
											<th>Start Date</th>
											<th>End Date(w/o Penalty)</th>
											<th>End Date(w Penalty)</th>
											<th></th>
									</thead>
									<tbody>
										<c:forEach items="${forms}" var="forms" varStatus="index">
											<tr>
												<td><strong><c:out
															value="${index.index+1}" /></strong></td>
												<td><c:out value="${forms.id}" /></td>
												<td><c:out value="${forms.formName}" /></td>
												<td><c:out value="${forms.formFee.feeLookup.feeName}" /></td>
												<td>
													<fmt:formatDate value="${forms.formDate}" pattern="dd/MM/yyyy" var="parsedDateTime" type="date" />
													<c:out value="${parsedDateTime}" />
													<!-- <s:date name="formDate" format="dd/MM/yyyy" /> -->
												</td>
												<td><c:out value="${forms.formOwnerName}" /></td>
												<td>
													<fmt:formatDate value="${forms.formStartDate}" pattern="dd/MM/yyyy" var="parsedDateTime1" type="date" />
													<c:out value="${parsedDateTime1}" />
													<!-- <s:date name="formStartDate" format="dd/MM/yyyy" /> --> 
												</td>
												<td>
													<fmt:formatDate value="${forms.formDate}" pattern="dd/MM/yyyy" var="parsedDateTime2" type="date" />
													<c:out value="${parsedDateTime2}" />
													<!-- <s:date name="formEndDate" format="dd/MM/yyyy" /> -->
												</td>
												<td>
													<fmt:formatDate value="${forms.formDate}" pattern="dd/MM/yyyy" var="parsedDateTime3" type="date" />
													<c:out value="${parsedDateTime3}" />
													<!-- <s:date name="formLateEndDate" format="dd/MM/yyyy" /> -->
												</td>
												<td><button
														onclick='showPreview("<c:out value='${forms.id}' />")'
														class="btn btn-info btn-xs">Fill Form</button>
													</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

							</div>
						</div>
					</div>
				</div>

				<!--/row-->
<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-list"></i> Pending Forms To Be Reviewed
								</h2>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<table class='table table-striped table-condensed datatable'>
									<thead>
										<tr>
											<th>#</th>
											<th>Form ID</th>
											<th>Form Name</th>
											<th>Fee Name</th>
											<th>Date Created</th>
											<th>Created By</th>
											<th>Start Date</th>
											<th>End Date(w/o Penalty)</th>
											<th>End Date(w Penalty)</th>
											<th>Date Submitted</th>
											<th></th>
									</thead>
									<tbody>
										<c:forEach items="forms_from_instance" var="formsFormInstance" varStatus="index">
											<tr>
												<td><strong><c:out
															value="${index.index+1}" /></strong></td>
												<td><c:out value="${formsFormInstance.formdetails.id}" /></td>
												<td><c:out value="${formsFormInstance.formdetails.formName}" /></td>
												<td><c:out value="${formsFormInstance.formdetails.formFee.feeLookup.feeName}" /></td>
												<td>
													<fmt:formatDate value="${formsFormInstance.formdetails.formDate}" pattern="dd/MM/yyyy" var="parsedDateTime" type="date" />
														<c:out value="${parsedDateTime}" />
													<!-- <s:date name="formsFormInstance.formdetails.formDate" format="dd/MM/yyyy" /> -->
												</td>
												
												<td><c:out value="${formsFormInstance.formdetails.formOwnerName}" /></td>
												
												<td>
												<fmt:formatDate value="${formsFormInstance.formdetails.formStartDate}" pattern="dd/MM/yyyy" var="parsedDateTime1" type="date" />
														<c:out value="${parsedDateTime1}" />
												<!-- <s:date name="formdetails.formStartDate" format="dd/MM/yyyy" />  -->
												</td>
												
												<td>
												<fmt:formatDate value="${formsFormInstance.formdetails.formEndDate}" pattern="dd/MM/yyyy" var="parsedDateTime2" type="date" />
														<c:out value="${parsedDateTime2}" />
												<!-- <s:date name="formdetails.formEndDate" format="dd/MM/yyyy" /> -->
												</td>
												
												<td>
												<fmt:formatDate value="${formsFormInstance.formdetails.formLateEndDate}" pattern="dd/MM/yyyy" var="parsedDateTime3" type="date" />
														<c:out value="${parsedDateTime}3" />
												<!-- <s:date name="formdetails.formLateEndDate" format="dd/MM/yyyy" /> -->
												</td>
												
												<td>
												<fmt:formatDate value="${formsFormInstance.submission_date}" pattern="dd/MM/yyyy" var="parsedDateTime4" type="date" />
														<c:out value="${parsedDateTime4}" />
												<!-- <s:date name="submission_date" format="dd/MM/yyyy" /> -->
												
												</td>
												
												<td><button
														onclick='showFormForReview("<c:out value='state_id' />")'
														class="btn btn-info btn-xs">Review Form</button>
													</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

							</div>
						</div>
					</div>
				</div>

				<!-- content ends -->
			</div>
			<!--/#content.col-md-0-->
		</div>
		<!--/fluid-row-->


		<hr>

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
		function approveForm(name, id) {
			var cnf = confirm("Approve " + name + "? ")
			if (cnf) {
				alert("Form has been Approved");
				window.location = "approveForm?formid=" + id;
			}
		}
		function disapproveForm(name, id) {
			var cnf = prompt("Disapprove " + name + "? Please Write a Comment");
			if (cnf!=null) {
				alert("Form has been Disapproved");
				window.location = "disapproveForm?formid=" + id+"&comment="+cnf;
			}
		}
		function showPreview(id) {
			window.open("getFormforPayerInternal?form.id=" + id, "Form Preview",
					"width=960,height=1080");
		}
		function showFormForReview(id) {
			window.open("showFormData?reqStateId=" + id, "Form Preview",
					"width=960,height=1080");
		}
	</script>
</body>
</html>
