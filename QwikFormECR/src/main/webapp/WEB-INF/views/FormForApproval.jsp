<!DOCTYPE html>
<html lang="en">
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@page import="java.util.Properties"%>
<%@page	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="java.util.Base64"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<head>

<meta charset="utf-8">
<title>QwikForms Form For Approval Transactions</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
<meta name="author" content="Muhammad Usman">

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



<link rel="stylesheet" type="text/css"
	href="DataTables/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css"
	href="DataTables/buttons.dataTables.min.css">
	<script language="javascript" type="text/javascript"
	src="js/datetimepicker_css_100Year.js">
	<script src="http://cdn.jsdelivr.net/webshim/1.12.4/polyfiller.js">
</script>
<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
<script type="text/javascript">
$("document").ready(function(){
    //say you have got 555 from the JSP as selcted value
    var selValue = <%=request.getAttribute("reqFormId")%>;
 <%--    var selMode = <%=request.getAttribute("reqpayMode")%>;
    var selStatus = <%=request.getAttribute("reqtransStatus")%>; --%>
   
    $("#formId").val(selValue).attr("selected","selected");  
  /*   $("#payMode").val(selMode).attr("selected","selected");
    $("#transStatus").val(selStatus).attr("selected","selected"); */
	
   
});
</script>
<script type="text/javascript">
$("document").ready(function(){
    //say you have got 555 from the JSP as selcted value
     var selMode = <%=request.getAttribute("reqpayMode")%>;
     $("#payMode").val(selMode).attr("selected","selected");
     
     var formDate = <%=request.getAttribute("reqFromDate")%>;
     $('#idFrom').val(formDate);
     
     
     var FormToDate = <%=request.getAttribute("reqToDate")%>;
     $('#idTo').val(FormToDate);
   <%--  var selMode = <%=request.getAttribute("reqFromDate")%>;
 
   
    $("#idFrom").val(selMode) --%>
/*  $("#payMode").val(selMode).attr("selected","selected"); */

	
   
});
</script>
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

<body>

<%
	LoginBean loginUser = new LoginBean();
	String profile=null;
	Integer collegeID=null;
	String collegeCode=null;
	CollegeBean collegeBean = new CollegeBean();
	String serviceId = null;
	try{
			 loginUser = (LoginBean) session.getAttribute("loginUserBean");
			 profile = (String) session.getAttribute("sesProfile");
			 collegeID = (Integer) session.getAttribute("CollegeId");
			 collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			 collegeCode=collegeBean.getCollegeCode();
			 collegeID=collegeBean.getCollegeId();
			 serviceId = (String) session.getAttribute("serviceId");
			 System.out.println("Service id from jsp "+serviceId);
	}catch(Exception e){
			System.out.print("Nullpointer Exception in JSP...");
			response.sendRedirect("sessionTerminated");
	}
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String clientLogoLink = properties.getProperty("clientLogoLink");
	String cCodeForApproval = properties.getProperty("cCodeForApproval");
	String cIdForApproval = properties.getProperty("cIdForApproval");
	String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	if (loginUser == null) {
		response.sendRedirect("sessionTerminated");
		return;
	 }
%>

	<!-- topbar starts -->
	
<div  role="navigation">
	<div class="navbar-inner">
		<table align="center" width="100%" border="0">
			<tr align="center">
				<td width="20%" align="center">
					<div class="university-logo- fl-logo">
						<% if(null!=collegeBean.getCollegeImage()){ %>
						<img
							src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
							alt="" title="" height="60" width="80"></img>
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
							alt="" title="" height="40" width="200"></img>
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
	<%
        String choice =(String)request.getAttribute("reqpayMode");
		String status =(String)request.getAttribute("reqtransStatus");
		//session.removeAttribute("fullDataWithAl");
	%>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">
	<div class="col-sm-12 col-lg-12">
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
<form>
<s:token/>
			<div id="content" class="col-lg-10 col-sm-10">
				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i>Transaction
									Search Filters
								</h2>
							</div>
							<div class="box-content">
								<!-- put your content here -->
							<table class="table table-striped table-condensed" cellpadding="0" cellspacing="0" style="border:1px solid #ccc; background:#f9f9f9;" >
									<tr>
										<td>
										
										<div class="control-group">
												<label class="control-label" for="selectError">Filter
													By Form </label>

												<div class="controls" style="height: 40px;width:">
								
													<select name="fd.paymentCat" class="form-control" id="formId" data-rel="chosen"
													
														required="required" style="width: 50px !important; min-width: 220px; max-width: 50px;">
														<option selected="selected" disabled="disabled" value="">Select
															An Option</option>
														<!-- <option value="All">All</option> -->


														<c:forEach items="${forms}" var="bean">
														
															<option value='${bean.id}'>
															${bean.formName}
															</option>
														</c:forEach>
													
													</select>
												</div>
											</div></td>
							<td><label class="control-label" for="dob">From</label> <!-- name="fromDate" -->
												<input name="idFrom" id="idFrom" required="required"
												placeholder="DD-MM-YYYY" type="text"  value="<%=request.getAttribute("reqFromDate") %>"  class="form-control"
												style="height: 30px;"><img src="img/cal.gif"
												onclick="javascript:NewCssCal('idFrom','ddmmyyyy')"
												style="cursor: pointer"/></td>
											
											<td><label class="control-label" for="dob">To</label> <input
												name="idTo" id="idTo" required="required" type="text" value=""
												placeholder="DD-MM-YYYY" class="form-control"
												style="height: 30px;"><img src="img/cal.gif"
												onclick="javascript:NewCssCal('idTo','ddmmyyyy')"
												style="cursor: pointer" /></td>
		
									</tr>
									<tr>
										<td><div class="control-group">
												<label class="control-label" for="selectError">Transaction
													Type</label>

												<div class="controls">
													<select name="paymentMethod" class="form-control" id="payMode" data-rel="chosen"
														required="required">
														<option selected="selected" disabled="disabled" value="">
															Select An Option</option>
														<option value="Net Banking" <%= ("Net Banking".equals(choice))?("selected='selected'"):""%>>Net Banking</option>
														<option value="Credit card" <%= ("Credit card".equals(choice))?("selected='selected'"):""%>>Credit Card</option>
														<option value="Debit cards" <%= ("Debit cards".equals(choice))?("selected='selected'"):""%>>Debit Card</option>
														<option value="Cash"<%= ("Cash".equals(choice))?("selected='selected'"):""%>>Cash</option>
														<option value="Cheque"<%= ("Cheque".equals(choice))?("selected='selected'"):""%>>Cheque</option>
													</select>
												</div>
											</div>
											</td>
											
											<td><div class="control-group">
												<label class="control-label" for="selectError">Status
													</label>

												<div class="controls">
													<select name="paymetStatus" class="form-control" id="transStatus" data-rel="chosen"
														required="required">
														<option selected="selected" disabled="disabled" value="">
															Select An Option</option>
														<option value="pending"<%= ("pending".equals(status))?("selected='selected'"):""%>>pending</option>
														<option value="success"<%= ("success".equals(status))?("selected='selected'"):""%>>success</option>
														<option value="cancelled"<%= ("cancelled".equals(status))?("selected='selected'"):""%>>cancelled</option>
														<option value="failure"<%= ("failure".equals(status))?("selected='selected'"):""%>>failure</option>
														</select>
												</div>
											</div></td>
										<td style="padding:33px 10px;"><div class="controls">
										
												<button type="button" onclick="getApplicantDetailsBasedONFeeType()"
														class="btn btn-success btn-sm">Search</button>
														
											</div>
											</td>
											
									</tr>

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
									<i class="glyphicon glyphicon-star-empty"></i>Client
									Transactions
								</h2>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<%-- <%
									int i = 1;
								%> --%>
								<table id="transTable" class='display nowrap'>
									<thead>
										<!-- <tr>
											<td>Actions <a href="#"
												onclick="ApplicantReportsBasedOnFee()"> <a href="ApplicantReportsAllClients?ForDownLoad=True" >

													<button type="button" class="btn btn-default btn-sm">Download
														Report</button> <img src="img/Xcel-icon.jpg">
											</a>

											</td>
										</tr> -->
										<tr>
											
											<th>Verified Option</th>
											<c:forEach items="${fileterdRecordsHeaders}" var="fieldList" varStatus="ind">
												<c:choose>
													<c:when test="${fn:contains(fieldList, 'transId')}">
														<th><c:out value="View Receipt" /></th>
														<th><c:out value="${fieldList}" /></th>
													</c:when>
													<c:when test="${fn:contains(fieldList, 'Notification')}">
														
													</c:when>
													<c:when test="${fn:contains(fieldList, 'fileUploadDate')}">
														
													</c:when>
													<c:otherwise>
														<th><c:out value="${fieldList}" /></th>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</tr>
									</thead>
									<!--aplDetailsrmspl  aplDetails -->
									<c:forEach items="${fullDataWithAl}" var="Outer" varStatus="ind">
										<tr>
											<td>
												<button type="button" onclick="clickForVerification()"
														class="btn btn-success btn-sm">Click for verification</button>
											</td>
											<c:forEach items="${Outer}" var="bean">
												<c:choose>
													<c:when test="${fn:contains(bean, 'QF')}">
														<td>&zwnj;
															<button type="button"
																onclick='viewFormlstAsApplicantReport("<c:out value="${bean}" />")'
																class="btn btn-success btn-sm"><c:out value="View And Download"/></button>
														</td>
														<td>&zwnj;
															<c:out value="${bean}"/>
														</td>
													</c:when>
													<c:when test="${fn:contains(bean, '2020')}">
														
													</c:when>
													<c:when test="${fn:contains(bean, 'null')}">
														
													</c:when>
													<c:otherwise>
														<td>&zwnj;
														<c:out value="${bean}"/>
														</td>
													</c:otherwise>
												</c:choose>
												
											</c:forEach>
										</tr>
									</c:forEach>
							</table>
																	<%
												
											%>
							</div>
						</div>
						
					</div>
				</div>
			</div>
			
			</form>
			<!--/#content.col-md-0-->
		</div>
		</div>
		<!--/fluid-row-->


		<hr>

		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">

			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"></button>
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
	<script src='DataTables/jquery.dataTables.min.js'></script>

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

	<!-- Datatables Scripts -->

	<script type="text/javascript"
		src="DataTables/dataTables.buttons.min.js">
		
	</script>
	<script type="text/javascript" src="DataTables/buttons.flash.min.js">
		
	</script>
	<script type="text/javascript" src="DataTables/jszip.min.js">
		
	</script>
	<script type="text/javascript" src="DataTables/pdfmake.min.js">
		
	</script>
	<script type="text/javascript" src="DataTables/vfs_fonts.js">
		
	</script>
	<script type="text/javascript" src="DataTables/buttons.html5.min.js">
		
	</script>
	<script type="text/javascript" src="DataTables/buttons.print.min.js">
		
	</script>
	<!-- DataTables Scripts end -->
	<script>
		$(document).ready(function() {
			$('#transTable').DataTable({
				scrollY : '50vh',
				scrollCollapse : true,
				"scrollX" : true,
				"language" : {
					"search" : "Filter Results:"
				},
				dom : 'Bfrtip',
				buttons : [ 'copy', 'excel', 'pdf', 'print' ]
			});
		});

	
	function clickForVerification(){
		alert("click use for verification");
		var formId=document.getElementById("formId").value;
		var cid=<%=collegeID%>;
		var cCodeForApproval=<%=cCodeForApproval%>;
		var cIdForApproval=<%=cIdForApproval%>;
		alert(formId+" : "+cid+" : "+cIdForApproval+" : "+cCodeForApproval);
	}

	function getApplicantDetailsBasedONFeeType() {
					
			var formId=document.getElementById("formId").value;
			var fromDate=document.getElementById("idFrom").value;
			var toDate=document.getElementById("idTo").value;
			var payMode=document.getElementById("payMode").value;
			var transStatus=document.getElementById("transStatus").value;
			
			<%-- var cCode=<%=collegeCode%>; --%>
			var cid=<%=collegeID%>;
			<%-- var cCodeForApproval=<%=cCodeForApproval%>; --%>
			var cIdForApproval=<%=cIdForApproval%>;
			
			alert(formId+" : "+cid+" : "+cIdForApproval);
			
			if(cid===cIdForApproval){
				if(formId!=null || formId!=""){
		    		window.location = "ApplicantReportsForApprovalProcess?formId=" + formId+"&fromDate="+fromDate+"&toDate="+toDate+"&payMode="+payMode+"&transStatus="+transStatus+"&cid="+cid;
				}else{
					window.location = "sessionTerminated";
				}
			}else{
				if(formId!=null || formId!=""){
		    		window.location = "ApplicantReportsForAllClients?formId=" + formId+"&fromDate="+fromDate+"&toDate="+toDate+"&payMode="+payMode+"&transStatus="+transStatus;
				}else{
					window.location = "sessionTerminated";
				}
			}
			
			var date1 = fromDate.split('-');
			var date2 = toDate.split('-');
			  var istartDay=parseInt(date1);
			  var ilstDay=parseInt(date2);
			  var idays= ilstDay-istartDay;
				if(feeType){
					
				
			  
			var x=5;
			var y=idays;
		    if( parseInt(idays) < parseInt(x)){
		    	alert("in second if");
		    	window.location = "ApplicantReportsForAllClients?formId=" + formId+"&fromDate="+fromDate+"&toDate="+toDate+"&payMode="+payMode+"&transStatus="+transStatus;
		   
		    }else{
		    	
		    	return false;
		    }
			
				}else{
					
			    	return false;
				}
			

		} 
		
		
	<%-- 	function getApplicantDetailsBasedONFeeType() {
			document.getElementById("ResultBox").innerHTML = '<center><img title="img/ajax-loaders/ajax-loader-7.gif" src="img/ajax-loaders/ajax-loader-7.gif"></center>';
		
			var formId=document.getElementById("formId").value;
				
			var status = document.getElementById("transStatus").value;
			var mode = document.getElementById("payMode").value;
			var dateFrom = document.getElementById("idFrom").value;
			var dateTo = document.getElementById("idTo").value;
			
			
			var dayCount = daydiff(dateTo, dateFrom);

			if (dateFrom.trim() == "") {
				dateFrom = "all";
			}
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
					document.getElementById("ResultBox").innerHTML = xhttp.responseText;
					$('#transTable').DataTable({
						scrollY : '50vh',
						scrollCollapse : true,
						"scrollX" : true,
						"language" : {
							"search" : "Filter Results:"
						},
						dom : 'Bfrtip',
						buttons : [ 'copy', 'excelHtml5', 'pdf', 'print' ]
					});
				}
			}
			xhttp.open("GET", "ApplicantReportsForAllClients?formId=" + formId+"&fromDate="+dateFrom+"&toDate="+dateTo+"&payMode="+mode+"&transStatus="+status, true);
			xhttp.send();
		}
	<%String currentDate = session.getAttribute("currentDate") != null ? (String) session
					.getAttribute("currentDate") : "";%>
		function assignDate() {

			var startDate ='<%=currentDate%>';
		var endDate ='<%=currentDate%>';
		document.getElementById("idFrom").value = startDate;
		document.getElementById("idTo").value;document.getElementById("idTo").value = endDate;
		} --%>
		function daydiff(endDate, startDate) {

			/* var days = Math.round((endDate - startDate) / (1000 * 60 * 60 * 24)); 
			 
			alert("Payment Cycle having of Day::::::::::::" + days+" : "+endDate+" : "+startDate); */

			// Here are the two dates to compare
			var date1 = startDate;
			var date2 = endDate;

			// First we split the values to arrays date1[0] is the year, [1] the month and [2] the day
			date1 = date1.split('-');
			date2 = date2.split('-');

			// Now we convert the array to a Date object, which has several helpful methods
			date1 = new Date(date1[0], date1[1], date1[2]);
			date2 = new Date(date2[0], date2[1], date2[2]);

			// We use the getTime() method and get the unixtime (in milliseconds, but we want seconds, therefore we divide it through 1000)
			date1_unixtime = parseInt(date1.getTime() / 1000);
			date2_unixtime = parseInt(date2.getTime() / 1000);

			// This is the calculated difference in seconds
			var timeDifference = date2_unixtime - date1_unixtime;

			// in Hours
			var timeDifferenceInHours = timeDifference / 60 / 60;

			// and finaly, in days :)
			var timeDifferenceInDays = timeDifferenceInHours / 24;

			if (timeDifferenceInDays > 5) {
				alert("Please select less than 5 Days");
				return false;
			}

		}
		
///  viewFormlst
		
		function viewFormlstAsApplicantReport(transId) {
			window.open("ViewFormlstForApplicantReport?transId=" +transId, "Preview",
					"width=500,height=768");
		}
		
	</script>
</body>
</html>
