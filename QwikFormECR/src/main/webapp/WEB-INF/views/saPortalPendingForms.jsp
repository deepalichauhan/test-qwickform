<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.sabpaisa.qforms.beans.LoginBean"%>
<!DOCTYPE html>
<html lang="en">

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>

<meta charset="utf-8">
<title>QwikForms(SA) Pending Forms</title>
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
									<i class="glyphicon glyphicon-star-empty"></i> All Pending Forms
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
                          <!--   <form name="FormName" id="formList" action="" method="POST" target="_blank"> -->
                        
                             <input type="hidden" name="reqFormId" id="reqFormId" value=""/>
                              <input type="hidden" name="superAdmin" id="superAdminId" value=""/>
                               <input type="hidden" name="superAdmin" id="superAdminIds" value=""/>
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
										<c:forEach items="${pendingFormsList}" varStatus="index" var="forms">
										
											<tr>
												<td><strong> ${index.index+1 }
													</strong></td>
												<td>${forms.id }</td>
												<td>${forms.formName} </td>
												<td>${forms.formFee.feeLookup.feeName }</td>
												<td>${forms.formDate } </td>
										<td>${forms.formOwnerName }</td>
												<td>${forms.formStartDate } </td>
												<td>${forms.formEndDate }</td>
												<td>${forms.formLateEndDate }</td>
												<td>														 
												  <button
														onclick="showPreviewAction(${forms.id})"
														class="btn btn-info btn-xs">View Form</button>
														<c:choose>
															<c:when test="${test.status} == 'APPROVED'">
																<button
																onclick="alert('${forms.formName} already Approved');"
																class="btn btn-success btn-xs">Approve</button>
															</c:when>
															<c:otherwise>
																<button
																onclick='approveForm("${forms.formName}","${forms.id}")'
																class="btn btn-success btn-xs">Approve</button>
															</c:otherwise>
														</c:choose>
													   <c:choose>  
															<c:when test="${test.status} == 'DISAPPROVED'">
																<button
																onclick="alert('${forms.formName} already Disapprove');"
																class="btn btn-warning btn-xs">Disapprove</button>
															</c:when>
															<c:otherwise>
																<button
																onclick='disapproveForm("${forms.formName}","${forms.id}")'
																class="btn btn-warning btn-xs">Disapprove</button>
															</c:otherwise>
														</c:choose>
														<%-- <c:choose>  
															<c:when test="${test.status} == 'REPORT'">
																<button
																onclick="alert('${forms.formName} already reported, client can find their Report from client portal.');"
																class="btn btn-info btn-xs">Reporting</button>
															</c:when>
															<c:otherwise>
																<button
																onclick='reportWithDisapproveForm("${forms.formName}","${forms.id}")'
																class="btn btn-info btn-xs">Reporting</button>
															</c:otherwise>
														</c:choose> --%>
														<c:if test='life_cycle.contentEquals("yes")'>
														<button class="btn btn-info btn-xs" onclick='viewLifeCycle("${forms.id}")'>View Life Cycle</button>
														</c:if>
													
														
													</td>
					
											</tr>
										</c:forEach>
										
									</tbody>
								</table>
                        <!--   </form> -->
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
		var cnf = prompt("Reporting the running form " + name + " ? Please Write a Comment");
		if (cnf != null) {
			alert("Form has been Reported and client can check all reports of this form on client portal.");
			/* window.location = "disapproveForm2?formid=" + id + "&comment="
					+ cnf,"_blank"; */
			
			 window.open("reportCheckingOnDisapprovedForm?formid=" + id + "&comment="+ cnf,"width=960,height=1080");
			 //window.open("disapproveForm2?formid=" + id + "&comment="+ cnf,"width=960,height=1080");
		}
	}
	
	function showPreview(id) {
		alert("showPreview id: "+id);
		window.open("previewForm?reqFormId=" + id, "Form Preview","width=960,height=1080");
	}
	
    function showPreviewAction(id) {
	 //alert("showPreviewAction id: "+id);
	 window.open("previewForm?reqFormId=" + id, "Form Preview", "width=960,height=1080");
	}
 function showPreviewAction111(showPreviewAction,id) {
			alert("action is"+showPreviewAction+"& id is"+id);
			document.FormName.action=showPreviewAction;
			document.getElementById("reqFormId").value=id;
			document.getElementById("formList").submit();
			
			/* window.open("previewForm?reqFormId=" + id, "Form Preview",
					"width=960,height=1080"); */
		
		 } 
	function viewLifeCycle(id)
	{
		window.open("getFormCycle?reqFormId=" + id, "Form Cycle",
		"width=960,height=1080");
	}

	function uploadInstruction(id)
	{
		window.open("InstructionForm?id=" + id, "Form Instruction",
		"width=640,height=480");
	}
</script>
	</script>
</body>
</html>
