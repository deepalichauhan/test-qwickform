<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<!DOCTYPE html>
<%@page import="org.apache.log4j.Logger"%>

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


<%
	Integer sesBid = null, sesCid = null;
	CollegeBean collegeBean = new CollegeBean();
	int pageCtr =0;
	Integer currentFormId=null;
	String formInstanceId = null;
	Logger log = Logger.getLogger("Frm Details Actor");
	try {

		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		currentFormId = (Integer) session.getAttribute("currentFormId");
		formInstanceId = (String) session.getAttribute("formInstanceId");
	
		log.info("currentFormId: formDetailsActor.jsp is:"+currentFormId);
		log.info("formInstanceId: formDetailsActor.jsp is:"+formInstanceId);
		log.info(" sesCid.jsp is:"+sesCid);
		log.info("sesBid:  is:"+sesBid);
		
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

<body onunload="window.opener.reload()">

	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			
			<div class="btn-group pull-right">
				
			</div>
			<!-- user dropdown ends -->

			<!-- theme selector starts -->



			<div class="btn-group pull-right">
				

			</div>




		</div>
	</div>
	<!-- topbar ends -->
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
									<i class="glyphicon glyphicon-star-empty"></i>
									<c:out value="${formName}" />
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->

								<table class="table table-striped table-condensed">
									<c:forEach items="${formViewData}" var="formViewData">
										<tr>
											<td><strong><c:out value="${formViewData.label}" /></strong></td>
											<td><c:out
													value="${formViewData.value.substring(value.indexOf('*')+1)}" /></td>
										</tr>
									</c:forEach>
									<tr>
										<td colspan="2"><center><strong>Receipt Details</strong></center></td>
									</tr>
									<tr>
										<td>Name:</td>
										<td><c:out value="${sesCurrentFormData.name}" /></td>
									</tr>
									<tr>
										<td>Contact:</td>
										<td><c:out value="${sesCurrentFormData.contact}" /></td>
									</tr>
									<tr>
										<td>Email:</td>
										<td><c:out value="${sesCurrentFormData.email}" /></td>
									</tr>
									<tr>
										<td>Date of Birth</td>
										<td>
											<fmt:formatDate value="${sesCurrentFormData.dobDate}" pattern="dd/MM/yyyy" var="parsedDateTime" type="both" />
											<c:out value="${parsedDateTime}" />
											
										</td>
									</tr>
									<tr>
										<td><button onclick="window.close()"
												class="btn btn-sm btn-warning">Close</button></td>
										<td><button onclick='window.location="submitFormData?bid=<%=sesBid%>&cid=<%=sesCid%>&action=approve"' class="btn btn-sm btn-success pull-right">Approve</button>
											<button onclick='window.location="submitFormDataDis?bid=<%=sesBid%>&cid=<%=sesCid%>&action=disapprove"' class="btn btn-sm btn-danger pull-right">Disapprove</button>
										</td>
									</tr>
								</table>
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


</body>
</html>
