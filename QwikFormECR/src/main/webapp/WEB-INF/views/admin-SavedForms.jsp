<%@page import="org.apache.logging.log4j.LogManager,org.apache.logging.log4j.Logger"%>
<%@page import="java.util.Base64"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
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
<%-- <style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
       top.location = self.location;
   }
</script> --%>
</head>

<body onload="ExecuteFun();"> 


	
	<%
		LoginBean loginUser = new LoginBean();
		String profile=null;
		Integer collegeID=null;
		CollegeBean collegeBean=new CollegeBean();
		
		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
		String clientLogoLink = properties.getProperty("clientLogoLink");
		
		try
			{
		loginUser = (LoginBean) session.getAttribute("loginUserBean");
		// profile = (String) session.getAttribute("sesProfile");
		// collegeID = (Integer) session.getAttribute("CollegeId");
		 
		collegeBean=(CollegeBean) session.getAttribute("CollegeBean");
		collegeID = collegeBean.getCollegeId(); 
		
			}catch(Exception e)
			{
		System.out.print("Nullpointer Exception in JSP...Admin Save Form ");
		response.sendRedirect("sessionTerminated");
	%>
	<!-- <script type="text/javascript">
	
	window.location="timeIntervalPage";
	</script> -->

	<%
		}
		
	%>
	
	<!-- topbar starts -->
	<!-- <div class="navbar navbar-default" role="navigation"> -->
<div  role="navigation">
		<div class="navbar-inner">
			<table align="center" width="100%" border="0">
				<tr align="center">
					<td width="20%" align="center">
						<div class="university-logo- fl-logo">
							<% if(null!=collegeBean.getCollegeImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
								alt="" title="" height="60" width="200"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
								height="60" />
							<%} %>							
						</div>
					</td>
					<td width="60%" align="center">
					<div align="center" style="font: bolder,cursive;color: olive; ">	<% if(null!=collegeBean.getCollegeName()){ %> 
						<h3 style="font: bolder,cursive; "><%=collegeBean.getCollegeName() %></h3> <%}else{ %>
						<h1>SRS Live Technologies</h1> 
						<%} %></div>
					</td>
					<td width="20%" align="center">
						<div class="university-logo- fr-logo">

							<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
								alt="" title="" height="40" width="60"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="200"
								height="60" />
							<%} %>

						</div>
					</td>
					
					<!-- <td width="20%" align="center">
					
					
					</td> -->

				</tr>
			</table>
		</div>
	</div>
	
	<div class="navbar navbar-default" role="navigation">
	<div class="btn-group pull-right">
						<table>
							<tr>
								<td></td>
								<td><button class="btn btn-default dropdown-toggle"
										data-toggle="dropdown">
										<i class="glyphicon glyphicon-user"></i><span
											class="hidden-sm hidden-xs"> <%=loginUser.getUserName()%></span>
										<span class="caret"></span>
									</button>
		
		
									<ul class="dropdown-menu">
										<!-- <li><a id="saveProfileTagId" onclick="" href="EditUserDetail.jsp">Settings</a></li> -->
										<li class="divider"></li>
										<li><a href="logOutUser">Logout</a></li>
									</ul></td>
							</tr>
						</table>
					</div>
	</div>
	<!-- topbar ends -->
	
	<%-- <div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>	
			<a style=" font-family: cursive; font-size: xx-large; padding-left: 450px"> <span> 
				<%=collegeBean.getCollegeName()%>
			</span>
			</a>
			
			
			<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"> <%=loginUser.getUserName()%></span> <span
						class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					
					<li class="divider"></li>
					<li><a href="logOutUser">Logout</a></li>
				</ul>
			</div>
			




		</div>
	</div>
	<!-- topbar ends --> --%>
	<div class="ch-container">
		<div class="row">
			<!-- left menu starts -->
			<div class="col-sm-2 col-lg-2">
				<div class="sidebar-nav">
					<div class="nav-canvas">
					<%if(loginUser.getUserName()!="DEX321"){%>
					<jsp:include page="menuAdmin.jsp"></jsp:include>
					<% }else{%>	
					<jsp:include page="menu_clientDetails.jsp"></jsp:include>
					<%} %>
						
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
									<i class="glyphicon glyphicon-star-empty"></i> Saved Forms
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								
								<form name="FormName" id="operatorsList" action="" method="POST" target="_blank">
							
                                    <input type="hidden" name="reqFormId" id="reqFormId" value=""/>
								
								<!-- <form id="nitForm" action="payForm" method="POST"> -->
								<c:choose>
									<c:when test="${beanFormDetailsList.isEmpty()}">
										<div
											style="font-size: large; font-weight: bold; text-align: center; color: red;">Records
											not available</div>
									</c:when>
									<c:otherwise>
										<table class="table table-striped table-condensed" id="mainForm1">
											<thead>
												<tr>
													<th>Sr. No.</th>
													<th>Form Name</th>
													<th>Owner</th>
													<th>Actions</th>



												</tr>
											</thead>
											<%
												int i = 1;
											%>
											<c:forEach items="${beanFormDetailsList}" var="formlist">

												<tr>
													<td><%=i%></td>
													<td><c:out value="${formlist.formName}" /></td>
													<td><c:out value="${formlist.formOwnerName}" /></td>
													
													<td><div><button type="button"
															onclick="showPreviewAction('previewForm','<c:out value="${formlist.id}" />')"
															class="btn btn-success btn-xs">View</button> 
															
															<button type="button"
															onclick="showLinksAction(${formlist.id})"
															class="btn btn-info btn-xs">Microsite URL</button>
															
															
															</div>
															<%-- <div><button type="button"
															onclick='window.open("LandingPageForm?formId=<c:out value='${formlist.id}' />","LPForm","height=768,width=1024")'
															class="btn btn-info btn-xs">Upload Landing Page</button>
															<button type="button"
															onclick='window.open("GetFormURL?reqFormId=<c:out value='${formlist.id}' />","LPForm","height=768,width=1024")'
															class="btn btn-default btn-xs">Microsite URL</button>
															</div> --%>
															<%
															 	i++;
															 %>
												</tr>


											</c:forEach>

											</table>
											</c:otherwise>

										</c:choose>

										
									 											
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
		function showPreview(id) {
			window.open("previewForm?reqFormId=" + id, "Form Preview",
					"width=960,height=1080");
		}
		
		function showPreviewAction(previewFormData,id) {
			alert("previewForm is"+previewFormData+ "& id is: "+id);
			document.FormName.action=previewFormData;
			document.getElementById("reqFormId").value=id;
			document.getElementById("operatorsList").submit();
			
			/* window.open("previewForm?reqFormId=" + id, "Form Preview",
					"width=960,height=1080"); */
		}
		
		function showLinksAction(id) {
			//alert("showLinksAction id: "+id);
		 window.open("linksForFormPay?reqFormId=" + id, "Form Preview", "width=960,height=1080");
		}
		
		function ExecuteFun() {

			setTimeout(function() {
				ExecuteFun();
				//location.reload();
				var id = <%=collegeID%>;
				var logId = document.getElementById('loginBean').value;
				if (id == '' || id == null) {
					window.location = "TimeIntervalPage";
				} 

			}, 120000);
		}
		
		function viewForm(viewOperatorDetailsAction,id) {
			//alert('value of viewOperatorDetailsAction:'+viewOperatorDetailsAction);
			document.FormName.action=viewOperatorDetailsAction;
			document.getElementById("id").value=id;
			document.getElementById("operatorsList").submit();
			//window.open("viewOperatorDetails?id=" + id, "Preview", "width=500,height=560"); /* operatorDetails.jsp */
		}

	</script>
</body>
</html>
