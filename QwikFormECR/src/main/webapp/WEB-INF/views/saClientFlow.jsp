<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.beans.SuperAdminBean"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


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
<body> 

	<%
 			LoginBean loginUser = new LoginBean();
 			CollegeBean collegeBean = new CollegeBean(); 
 			
 			String profile=null;
 			SuperAdminBean sAdmin = new SuperAdminBean();

 				try
 				{
 			collegeBean=(CollegeBean) session.getAttribute("colBeans");

 			sAdmin = (SuperAdminBean) session.getAttribute("sABean");
 			collegeBean = (CollegeBean) session.getAttribute("CollegeBean"); 
 				
 			loginUser = (LoginBean) session.getAttribute("loginUserBean");
 			profile = (String) session.getAttribute("sesProfile");

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
                            <form name="newClient" action="" method="post" id="newClientId" target="_blank">
                       
								<button onclick="newclientfunction('GetBankDetailsForDropdown')"
									class="btn btn-default pull-right btn-sm">Add New
									Client</button>
									
									</form> 
	<!--<button onclick='window.open("addClientToFormLinkUI.jsp","Fill Client Details","width=520,height=600")' 
									class="btn btn-default pull-right btn-sm">Add New
									Client</button>-->
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
								<form name="Formname" id="nitForm" action="" method="post" target="_blank">
                              <%--   <s:token/> --%>
                                <input type="hidden" name="id" id="id" value=""/>
									<table class="table table-striped table-condensed"
										id="mainForm1">
										<thead>
											<tr>
												<th>Sr. No.</th>
												<th>Name</th>
												<th>Code</th>
												<th>Contact</th>
												<th>Email</th>

												
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
										<c:forEach items="${collegelst}" var="bean">
											<tr>
			<%-- 								<% 
                   if (sAdmin.getCompany().equals("DEX")/*  && collegeBean.getSuperAdminBean().equals(1) */ ){ 

                          %>  --%>
												<td><%=i%></td> 
												<td><%-- <s:property value="collegeBean.collegeName" />&nbsp; --%>
												<c:out value="${bean.collegeName}"></c:out>
												</td>
												<td><c:out value="${bean.collegeCode}"></c:out><%-- <s:property value="collegeBean.collegeCode" /> --%></td>
												<td><c:out value="${bean.contact}"></c:out><%-- <s:property value="collegeBean.contact" /> --%></td>
												<td><c:out value="${bean.emailId}"></c:out><%-- <s:property value="collegeBean.emailId" /> --%></td>

												 <td colspan="3"><button type="button"
														onclick="configurationDetailAction('clientDashBoadDetails','${bean.collegeId}')"
														class="btn btn-success btn-sm">Configuration</button>
													<button type="button"
														onclick="editForm('${bean.collegeId}')"
														class="btn btn-info btn-sm">View</button> 
														
														<button type="button"
														onclick="sabPaisaClientDetails('${bean.collegeId}')"
														class="btn btn-info btn-sm">SabPaisa Details</button> <%-- <button type="button" onclick="deleteOperator('<s:property value="collegeId"/>')"
														class="btn btn-warning btn-sm">Delete</button> --%>
														<!-- <button type="button" onclick='window.open("updateBankImage","Fill Bank Details","width=480,height=500")'
													class="btn btn-sm btn-info pull-right">Edit Bank Logo</button> -->
											</td> 

												<%
													i++;
												%>
											 <%-- 	 <% } %>   --%> 
											</tr>
									
						
									
										</c:forEach>

			
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
		
		function configurationDetailAction(clientDashBoadDetailsAction,id){
			
			//alert("action is"+clientDashBoadDetailsAction+"& id is"+id);
			document.Formname.action=clientDashBoadDetailsAction;
			document.getElementById("id").value=id;
			document.getElementById("nitForm").submit();
			/* window.location="clientDashBoadDetails?id="+id;
			initBuilder */
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

		function newclientfunction(actionName)
		{
			
			
			document.newClient.action=actionName;
			document.getElementById("newClientId").submit();
			
			
			//alert("for token");
			//alert(actionName);
	//document.NewClient.action=actionName;
	//document.getElementById("newClientId").submit();
			//window.open("GetBankDetailsForDropdown","Fill Client Details","width=520,height=600");
		}

	</script>
</body>
</html>
