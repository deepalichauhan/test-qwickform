<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.Base64"%>

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
	CollegeBean collegeBean = new CollegeBean();
	
	String profile=null;
	Integer collegeID=null;
		try
		{
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			loginUser = (LoginBean) session.getAttribute("loginUserBean");
			 profile = (String) session.getAttribute("sesProfile");
			 collegeID = (Integer) session.getAttribute("CollegeId");
		}catch(NullPointerException e)
		{
			System.out.print("Nullpointer Exception in JSP...");
			response.sendRedirect("sessionTerminated");
		}
		AppPropertiesConfig QFormsProperties = new AppPropertiesConfig();
		Properties properties = QFormsProperties.getPropValues();

		String clientLogoLink = properties.getProperty("clientLogoLink");

		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	
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
	
	
	
	
	<%-- <!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			
			
			<a class="navbar-brand" href="#"> <img
				src="<%=collegeBean.getCollegeLogo()%>"></a> <a
				class="navbar-brand" href="<%=clientLogoLink%>"><span> <%=collegeBean.getCollegeName()%>,<br><%=collegeBean.getState()%>
			</span></a>

		<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"> <%=loginUser.getUserName()%></span> <span
						class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<!-- <li><a id="saveProfileTagId" onclick="" href="EditUserDetail.jsp">Settings</a></li> -->
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
						<jsp:include page="menuAdmin.jsp"></jsp:include>
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
				<form name="AdminOperator" action="" method="post" id="operatorFormId" target="_blank">
            <%-- <s:token/> --%>
				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
						
						
							<!-- <div class="box-header well" data-original-title="">

								<button onclick="addOperatorAction('formOperatorAction')"
									class="btn btn-default pull-right btn-sm">Add New
									Operator</button>
								<div class="box-icon"></div>
							</div> -->
							
							

						</div>
					</div>
				</div>
			</form>


				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Operators
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form name="FormName" id="operatorsList" action="" method="POST" target="_blank">
								<%-- <s:token/> --%>
                                    <input type="hidden" name="id" id="id" value=""/>
									
									<table class="table table-striped table-condensed"
										id="mainForm1">
										<thead>
											<tr>
												<th>Sr. No.</th>
												<th>Name</th>
												<th>Contact</th>
												<th>Email</th>

												<th>Address</th>
												<th>Actions</th>
												<th></th>
												<th></th>


											</tr>
										</thead>
										<!-- listOprtBean -->
										<%
											int i = 1;
										%>
										<c:forEach items="${listOprtBean}" var="lstoprtbean">
											<tr>
												<td><%=i%></td>
												<td><c:out value="${lstoprtbean.operatorName}" />&nbsp;
													<c:out value="${lstoprtbean.operatorLstName}" /></td>
												<td><c:out value="${lstoprtbean.operatorContact}" /></td>
												<td><c:out value="${lstoprtbean.operatorEmail}" /></td>
												<td><c:out value="${lstoprtbean.operatorAddress}" /></td>

												<td colspan="3"><button type="button"
														onclick="viewForm('viewOperatorDetails','<c:out value="${lstoprtbean.operatorId}"/>')"
														class="btn btn-success btn-sm">View</button>
													<button type="button"
														onclick="editOperatorForm('EditOperatorDetails','<c:out value="${lstoprtbean.operatorId}"/>')"
														class="btn btn-info btn-sm">Edit</button> 
														 <button type="button" onclick="deleteOperator('<c:out value="${lstoprtbean.operatorId}"/>')"
														class="btn btn-warning btn-sm">Delete</button> </td>

												<%
													i++;
												%>
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

		var custom = "";
		var fee = 0;
		var totfee = 0;
		var hostel = 0;
		var bus = 0;
		var hostelfee = 0;
		var busfee = 0;
		function GetFees(x) {
			document.getElementById("operatorsList").reset();
			if (x == "BT3" || x == "MT3GEN" || x == "MB14GEN") {
				fee = 42450;
				hostel = 2500;
				bus = 1800;
			}
			if (x == "BT5" || x == "BT7") {
				fee = 24950;
				hostel = 2500;
				bus = 1800;
			}
			if (x == "MT15SC" || x == "MB15SC" || x == "MS15SC"
					|| x == "PD15SCFT" || x == "PD15SCPT") {
				fee = 12550;
				hostel = 2500;
				bus = 1800;
			}
			if (x == "MS14GEN" || x == "PDGEN") {
				fee = 14950;
				hostel = 2500;
				bus = 1800;
			}
			if (x == "MT14SC" || x == "MB14SC" || x == "MS14SC"
					|| x == "MT12SC" || x == "MT14SC") {
				fee = 7450;
				hostel = 2500;
				bus = 1800;
			}
			if (x == "MT12GENPT") {
				fee = 17450;
			}
			if (x == "MT14GENPT") {
				fee = 27450;
			}
			if (x == "BT1" || x == "MT15GEN" || x == "MB15GEN") {
				fee = 47550;
				hostel = 2500;
				bus = 1800;
			}
			if (x == "MS15GEN" || x == "PD15GENFT" || x == "PD15GENPT") {
				fee = 20050;
				hostel = 2500;
				bus = 1800;
			}
			document.getElementById("fee").value = fee;
			document.getElementById("total").value = fee;
			document.getElementById("hosfee").value = 0;
			document.getElementById("busfee").value = 0;
			totfee = fee;

		}
		function TotalFee(y) {
			if (y == "HostelYes") {
				hostelfee = hostel;
			}
			if (y == "HostelNo") {
				hostelfee = 0;
			}
			if (y == "BusYes") {
				busfee = bus;
			}
			if (y == "BusNo") {
				busfee = 0;
			}
			document.getElementById("hosfee").value = hostelfee;
			document.getElementById("busfee").value = busfee;
			document.getElementById("total").value = fee + busfee + hostelfee;
		}
		function Pay() {
			var name = document.getElementById("stuname").value;
			var linkadd = 'http://49.50.72.228:8080/SabPaisa/index.jsp?name='
					+ name + '&amount='
					+ document.getElementById("total").value
					+ '&client=NIT Jalandhar';
			window.location.href = linkadd;
		}
		function Reset() {
			document.getElementById("operatorsList").reset();
			document.getElementById("customTags").innerHTML = " ";
		}

		function GetFee1(x) {
			var fee = document.getElementById("total1");
			if (x == "BT") {
				fee.value = "7894";
			}
			if (x == "CE") {
				fee.value = "4594";
			}
		}
		function GetFee2(x) {
			var fee = document.getElementById("total2");
			var fee2 = document.getElementById("fee2");
			if (x == "BT") {
				fee.value = "2394";
				fee2.value = "2394";
			}
			if (x == "CE") {
				fee.value = "4294";
				fee2.value = "4294";
			}
		}

		function addField() {

			var a = document.getElementById("sem").value;
			var b = document.getElementById("selectDT").value;
			custom = custom + " " + a + " " + b + "<br>";
			document.getElementById("customTags").innerHTML = custom;

		}
		
		function addOperator() {
			window.open("formOperator.jsp", "Preview", "width=500,height=600");
		}
		
		function addOperatorAction(actionName) {
			//alert(actionName);
			document.AdminOperator.action=actionName;
			document.getElementById("operatorFormId").submit();
		}
		
		function viewForm(viewOperatorDetailsAction,id) {
			//alert('value of viewOperatorDetailsAction:'+viewOperatorDetailsAction);
			document.FormName.action=viewOperatorDetailsAction;
			document.getElementById("id").value=id;
			document.getElementById("operatorsList").submit();
			//window.open("viewOperatorDetails?id=" + id, "Preview", "width=500,height=560"); /* operatorDetails.jsp */
		}

		/* deleteOperator */
		function deleteOperator(id) {

			window.open("deleteOperatorDetails?id=" + id, "Preview",
					"width=500,height=768"); /* operatorDetails.jsp */
			window.reload();
		}
		function editForm(id) {
			window.open("EditOperatorDetails?id=" + id, "Edit Operator",
			"width=500,height=560"); 
		}
		function editOperatorForm(editOperatorDetailsAction,id) {
			//alert('value of editOperatorDetailsAction:'+editOperatorDetailsAction);
			document.FormName.action=editOperatorDetailsAction;
			document.getElementById("id").value=id;
			document.getElementById("operatorsList").submit(); 
		}
		function viewForm2() {
			window.open("operatorDetails2.jsp", "Preview",
					"width=500,height=768");
		}
		function viewForm3() {
			window.open("operatorDetails3.jsp", "Preview",
					"width=500,height=768");
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


	</script>
</body>
</html>
