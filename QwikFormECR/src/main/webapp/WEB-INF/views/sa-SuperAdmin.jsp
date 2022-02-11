<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.controller.MainLoginController"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 


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



<body onload="ExecuteFun();"> 


	
	<%
		LoginBean loginUser = new LoginBean();
	/* CollegeBean collegeBean = new CollegeBean(); */
	
	String profile=null;
	/* Integer collegeID=null; */
		try
		{
			/* collegeBean = (CollegeBean) session.getAttribute("CollegeBean"); */
			loginUser = (LoginBean) session.getAttribute("loginUserBean");
			 profile = (String) session.getAttribute("sesProfile");
			/*  collegeID = (Integer) session.getAttribute("CollegeId"); */
		}catch(NullPointerException e)
		{
			System.out.print("Nullpointer Exception in JSP...");
			%>
			<script type="text/javascript">
			window.location="timeIntervalPage";
			</script>
			
			<%
		}
		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String clientLogoLink = properties.getProperty("clientLogoLink");

		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
		/* if (loginUser == null) {
		 response.sendRedirect("Login.jsp");

		 return;

		 } */
	%>
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
				<!-- content starts -->
				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">

								<!-- <button onclick='window.open("GetBankDetailsForDropdown","Fill Client Details","width=520,height=600")' 
									class="btn btn-default pull-right btn-sm">Add New
									Client</button> -->
									
								
									 <button type="button" onclick='window.open("addSuperAdminDetails","Fill Bank Details","width=480,height=500")'
													class="btn btn-sm btn-info pull-right">Add New SuperAdmin</button>
								
									
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
									<i class="glyphicon glyphicon-star-empty"></i> Clients
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
							<%-- 	<form action="EditSuperAdminDetailsById" method="post" onsubmit="target_popup(this)">
                                <s:token/> --%>
                              


									<table class="table table-striped table-condensed"
										id="mainForm1">
										<thead>
											<tr>
												<th>SR.NO.</th>
											<th>UserName</th>
												<th>Email</th>
												<th>Name</th>
												<th>Contact</th>
												
												<!-- <th>Email</th>  --> 

												
												<!-- <th>Actions</th> -->
												<th></th>
												<th></th>


											</tr>
										</thead>
										<!-- listOprtBean -->
										<%
											int i = 1;
										%>
										<%-- <s:iterator value="collegelst"> --%>
										
									<%-- 	<p>The length of collection is : ${fn:length(saList)}</p> --%>
										
										<c:forEach items="${saList}" var="bean">
											<tr>
												<td><%=i%></td>
												<!-- XSS Test -->
												
											<%-- 	<p><input name="foo" value="${fn:escapeXml(param.foo)}"></p> --%>
												
												<!-- XSS Test -->
											    <td>${bean.userName}</td>
												<td> ${bean.email}</td>
												<td> ${bean.name}</td>
												<td> ${bean.contact}</td>
												  <input type="hidden" name="id" id="id" value="${bean.id}"/>
<!-- window.open("EditSuperAdminDetailsById?id=${bean.id}","Fill Bank Details","width=480,height=500")' -->
												<td><input type="button" class="btn btn-sm btn-info pull-right" onclick='window.open("EditSuperAdminDetailsById?id=${bean.id}","Fill Bank Details","width=480,height=500")' value="Edit SuperAdmin Details"> 
											</td> 
												<%
													i++;
												%>
											</tr>
										</c:forEach>


									</table>

</form>




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
		function GetForm(x) {
			if (x == "1") {
				document.getElementById("mainForm1").style.display = "block";
				$("#fieldSelect").chosen();
			}

		}

		function Reset() {
			document.getElementById("nitForm").reset();
			document.getElementById("customTags").innerHTML = " ";
		}

		
		function addField() {

			var a = document.getElementById("sem").value;
			var b = document.getElementById("selectDT").value;
			custom = custom + " " + a + " " + b + "<br>";
			document.getElementById("customTags").innerHTML = custom;

		}
		
		function addOperator() {
			window.open("formOperator.jsp", "Preview", "width=500,height=768");
		}
		function viewForm(id) {

			window.open("viewOperatorDetails?id=" + id, "Preview",
					"width=500,height=560"); /* operatorDetails.jsp */
		}

		/* deleteOperator */
		function deleteOperator(id) {

			window.open("deleteOperatorDetails?id=" + id, "Preview",
					"width=500,height=768"); /* operatorDetails.jsp */
			window.reload();
		}
		function editForm(id) {
			window.open("ViewClientDetails?id=" + id, "View Client",
			"width=500,height=560"); 
		}
		
		function sabPaisaClientDetails(id) {
			window.open("sabPaisaClientDetails?id=" + id, "SB Client Details",
			"width=800,height=560"); 
		}
		
		
		function viewForm2() {
			window.open("operatorDetails2.jsp", "Preview",
					"width=500,height=768");
		}
		function viewForm3() {
			window.open("operatorDetails3.jsp", "Preview",
					"width=500,height=768");
		}
		
		function configurationDetails(id){
			/* window.open("clientDashBoadDetails", "Preview",
			"width=500,height=768"); */
			
			/* window.location="clientDashBoadDetails?id="+id; */
			window.location="clientDashBoadDetails?id="+id;
			initBuilder
		}
		
		<%-- function ExecuteFun() {

			setTimeout(function() {
				ExecuteFun();
				//location.reload();
				var id = <%=collegeID%>;
				var logId = document.getElementById('loginBean').value;
				if (id == '' || id == null) {
					window.location = "TimeIntervalPage";
				} 

			}, 120000);
		} --%>

		
		function editSADetails(editSAAction,id)
		{
			alert("editBankAction is"+editSAAction+"id is: "+id);
			document.Formname.action=editSAAction;
			document.getElementById("id").value=id;
			document.getElementById("nitForm").submit();
		}
		
		function target_popup(form) {
		    window.open('', 'formpopup', 'width=400,height=400,resizeable,scrollbars');
		    form.target = 'formpopup';
		}

	</script>
</body>
</html>

