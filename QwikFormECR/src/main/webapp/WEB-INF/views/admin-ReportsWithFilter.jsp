<!DOCTYPE html>
<html lang="en">
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@page import="java.util.Properties"%>
<%@page	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="java.util.Base64"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>

<meta charset="utf-8">
<title>QwikForms Transactions</title>
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
<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
<script language="javascript" type="text/javascript"
	src="js/datetimepicker_css_100Year.js">
	<script src="http://cdn.jsdelivr.net/webshim/1.12.4/polyfiller.js">
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

<SCRIPT language="javascript">
$(function(){

// add multiple select / deselect functionality
$("#selectall").click(function () {
 $('.case').attr('checked', this.checked);
});

// if all checkbox are selected, check the selectall checkbox
// and viceversa
$(".case").click(function(){

if($(".case").length == $(".case:checked").length) {
$("#selectall").attr("checked", "checked");
} else {
$("#selectall").removeAttr("checked");
}

});
});
</SCRIPT>
</head>

<body onload="assignDate()">


<%
		LoginBean loginUser = new LoginBean();
	String profile=null;
	Integer collegeID=null;
	CollegeBean collegeBean = new CollegeBean();
	String serviceId = null;
		try
		{
			loginUser = (LoginBean) session.getAttribute("loginUserBean");
			 profile = (String) session.getAttribute("sesProfile");
			 collegeID = (Integer) session.getAttribute("CollegeId");
			 collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			 serviceId = (String) session.getAttribute("serviceId");
			 System.out.println("Service id from jsp "+serviceId);
		}catch(Exception e)
		{
			System.out.print("Nullpointer Exception in JSP...");
			response.sendRedirect("sessionTerminated");
		}
		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String clientLogoLink = properties.getProperty("clientLogoLink");

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
							<table class="table table-striped table-condensed" cellpadding="0" cellspacing="0" style="border:1px solid #ccc; 
							background:#f9f9f9;">
									<tr>
										<td>
										
										<div class="control-group">
												<label class="control-label" for="selectError">Filter
													By Form </label>

												<div class="controls" style="height: 40px; min-weight:220px;">
								
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
												placeholder="DD-MM-YYYY" type="text"  value=""  class="form-control"
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
													<select name="fd.paymentCat" class="form-control" id="payMode" data-rel="chosen"
														required="required">
														<option selected="selected" disabled="disabled" value="">
															Select An Option</option>
														<option value="Net Banking">Net Banking</option>
														<option value="Credit card">Credit Card</option>
														<option value="Debit cards">Debit Card</option>
														
														<option value="Cash">Cash</option>
														<option value="Cheque">Cheque</option>
													</select>
												</div>
											</div></td>
											
<%-- 											<td><div class="control-group">
												<label class="control-label" for="selectError">Status
													</label>

												<div class="controls">
													<select name="fd.paymentCat" id="transStatus" data-rel="chosen"
														required="required">
														<option selected="selected" disabled="disabled" value="">
															Select An Option</option>
														<option value="pending">pending</option>
														<option value="success">success</option>
														<option value="cancelled">cancelled</option>
														<option value="failure">failure</option>
														</select>
												</div>
											</div></td> --%>
										
										<td style="padding:33px 10px;"><div class="controls">
										
												<button type="button" onclick="getTransactionDetailsBasedOnFilters()"
														class="btn btn-success btn-sm">Search</button>
														
											</div>
											</td>
											<td></td>
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
								<%
									int i = 1;
								%>
								<table id="transTable" class='table display nowrap'>
									<thead>
										<tr>
											<th>Sr. No.</th>
											<th>Category</th>
											<th>Amount Paid</th>
											<th>Txn Id</th>
											<th>Txn Date</th>
											<th>Txn Type</th>
											<th>Payee Name</th>
											<th>Status</th>
											<th>Receipt Number</th>
											<th>Actions </th>
											<!-- <th><input type="checkbox" id="selectall"/>
											<button type="button"
														onclick='initiateRefundProcess2("")'
														class="btn btn-success btn-sm">Initiate Refund</button>
											</th> -->
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${transData}" var="transData" varStatus="txnIndex">
											<tr>
												
												<td><%=i%>
												</td>

												<td>&zwnj;<c:out value="${formName}" /></td>
												<td>&zwnj;<c:out value="${transData.transOgAmount}" /></td>
												<td>&zwnj;<c:out value="${transData.spTransId}" /></td>
												<%-- <td>Rs. <s:property
														value="getText('{0,number,#,##0.00}',{actAmount})" /></td> --%>
												<td>&zwnj;<c:out value="${transData.transDate}"/></td>
												<%-- <td>&zwnj;<s:date name="transCompleteDate"
														format="dd/MM/yyyy HH:mm:ss a" /></td> --%>
												<td>&zwnj;<c:out value="${transData.transPaymode}" /></td>
												<td>&zwnj;<c:out value="${transData.name}" /></td>
												<td>&zwnj;<c:out value="${transData.transStatus}" /></td>
											   <td>&zwnj;<c:out value="${transData.transId}" /></td>
												<td>&zwnj;<button type="button"
														onclick='viewFormlst("<c:out value='${transData.id}'/>","<c:out value="${transData.transId}" />")'
														class="btn btn-success btn-sm">View Receipt</button> 
														
														<button type="button"
														onclick='viewForm2("<c:out value='${transData.id}'/>")'
														class="btn btn-info btn-sm">View Form</button>
														
												<% if(null!=collegeBean.getIsRefundEnabled() && collegeBean.getIsRefundEnabled().equalsIgnoreCase("true")){ %>
														<button type="button"
														onclick='initiateRefundProcess("<c:out value='${transData.transId}'/>",
														"<c:out value="${transData.spTransId}" />",
														"<c:out value="${transData.transOgAmount}" />",
														"<c:out value="${transData.transPaymode}" />",
														"<c:out value="${transData.transStatus}" />",
														"<c:out value="${transData.cid}" />")'
														class="btn btn-success btn-sm">Initiate Refund</button>
												<% } %>
												</td>
												<!-- <td class="a-center">
                             						<input type="checkbox" class="case" name="case" />
                             					</td> -->		
														
												<%-- <td>&zwnj;<s:property value="payeeAdd" /></td>
												<td>&zwnj;<s:property value="clientName" /></td> --%>
												<%-- <td>&zwnj;<s:property value="paymentMode" /></td> --%>
												<%
													i++;
												%>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<script>
								$(document).ready(function(){
									   $('.check:button').toggle(function(){
									       $('input:checkbox').attr('checked','checked');
									       $(this).val('uncheck all')
									   },function(){
									       $('input:checkbox').removeAttr('checked');
									       $(this).val('check all');        
									   })
									})
								
								</script>
							</div>
						</div>
						<%-- <table>

							<tr>
								<s:iterator value="pageList">
									<td><a
										href="getClientTransactions?pageIndex=<s:property/>"
										style="size:8px;"><font size="2"><s:property />
										</font></a></td>
								</s:iterator>
							</tr>


						</table> --%>

					</div>
				</div>
				</div>
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
	<!-- -For multiple select checkbox start -->
	<!-- <script type="text/javascript"
				src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript"
				src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
				src="https://cdn.datatables.net/select/1.3.0/js/dataTables.select.min.js"></script> -->
				
	<!-- -For multiple select checkbox End -->
	
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
	<script type="text/javascript" src="DataTables/buttons.html5.min.js"></script>
	<script type="text/javascript" src="DataTables/buttons.print.min.js"></script>

	
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
				columnDefs: [ {
		            orderable: false,
		            className: 'select-checkbox',
		            targets:   0
		        } ],
		        select: {
		            style:    'os',
		            selector: 'td:first-child'
		        },
		        order: [[ 1, 'asc' ]],
				dom : 'Bfrtip',
				buttons : [ 'copy', 'excel', 'pdf', 'print' ]
			});
		});
		function getFilteredResult() {
			document.getElementById("ResultBox").innerHTML = '<center><img title="img/ajax-loaders/ajax-loader-7.gif" src="img/ajax-loaders/ajax-loader-7.gif"></center>';
			var status = document.getElementById("selectStatus").value;
			var mode = document.getElementById("selectMode").value;
			var dateFrom = document.getElementById("dateFrom").value;
			var dateTo = document.getElementById("dateTo").value;
			var clientTxnId = document.getElementById("clientTxnId").value;
			var spTxnId = document.getElementById("spTxnId").value;
			
			var emailId = document.getElementById("emailId").value;
			var mobileId = document.getElementById("mobile").value;
			
			var payerId = document.getElementById("payerNameId").value;
			
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
						columnDefs: [ {
				            orderable: false,
				            className: 'select-checkbox',
				            targets:   0
				        } ],
				        select: {
				            style:    'os',
				            selector: 'td:first-child'
				        },
				        order: [[ 1, 'asc' ]],
						dom : 'Bfrtip',
						buttons : [ 'copy', 'excelHtml5', 'pdf', 'print' ]
					});
				}
			}
			xhttp.open("GET", "getFilteredTransactions?status=" + status
					+ "&mode=" + mode + "&dateFrom=" + dateFrom + "&dateTo="
					+ dateTo + "&clientTxnID=" + clientTxnId + "&spTxnId="
					+ spTxnId+"&emailId="+emailId+"&payerName="+payerId+"&mobileNo="+mobileId, true);
			xhttp.send();
		}
	<%String currentDate = session.getAttribute("currentDate") != null ? (String) session
					.getAttribute("currentDate") : "";%>
		function assignDate() {

			var startDate ='<%=currentDate%>';
		var endDate ='<%=currentDate%>';
			document.getElementById("dateFrom").value = startDate;
			document.getElementById("dateTo").value = endDate;
		}
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
			var timeDifferenceInHours =( timeDifference / 60 )/ 60;

			// and finaly, in days :)
			var timeDifferenceInDays = timeDifferenceInHours / 24;

			if (timeDifferenceInDays > 5) {
				alert("Please select less than 5 Days");
				return false;
			}

		}
		// View Form
		function viewForm2(x) {
			window.open("viewForm?transId=" + x, "Preview",
					"width=500,height=768");
		}
///  viewFormlst
		
		function viewFormlst(id,transId) {
			window.open("ViewFormlst?transId=" +transId+"&id="+id, "Preview",
					"width=500,height=768");
		}
		
		function viewReceipt(id) {
			/* Receipt.jsp */

			/*viewReceiptDetailsForDashBoard  */
			/* alert("testing code...");
			alert("testing code..."+id); */
			window.open("viewReceiptDetails?tid=" + id, "Preview",
					"width=600,height=768");
		}	
		
		
		function searchBasedOnConditions() {

			var feeId = document.getElementById("feeId").value;
			var frmDate = document.getElementById("fromDate").value;

			var tDate = document.getElementById("toDate").value;

			var payMode = document.getElementById("payMode").value;

			if (feeId == '' || (frmDate == '' && tDate == '') || payMode == '') {

				if (feeId != '' && frmDate != '' && tDate != '') {

					var query = "?payCart=" + feeId + "&payMode=" + payMode
							+ "&frmDate=" + frmDate + "&tDate=" + tDate;
					window.location = "searchBasedOnCriteria" + query;
					return true;

				}
				if (feeId != '' && payMode != '') {

					var query = "?payCart=" + feeId + "&payMode=" + payMode
							+ "&frmDate=" + frmDate + "&tDate=" + tDate;
					window.location = "searchBasedOnCriteria" + query;
					return true;

				}

				if (frmDate != '' && tDate != '' && payMode != '') {

					var query = "?payCart=" + feeId + "&payMode=" + payMode
							+ "&frmDate=" + frmDate + "&tDate=" + tDate;
					window.location = "searchBasedOnCriteria" + query;
					return true;

				}
				if (feeId != '') {

					var query = "?payCart=" + feeId + "&payMode=" + payMode
							+ "&frmDate=" + frmDate + "&tDate=" + tDate;
					window.location = "searchBasedOnCriteria" + query;
					return true;

				}
				if (payMode != '') {

					var query = "?payCart=" + feeId + "&payMode=" + payMode
							+ "&frmDate=" + frmDate + "&tDate=" + tDate;
					window.location = "searchBasedOnCriteria" + query;
					return true;

				}
				if (frmDate != '' && tDate != '') {

					var query = "?payCart=" + feeId + "&payMode=" + payMode
							+ "&frmDate=" + frmDate + "&tDate=" + tDate;
					window.location = "searchBasedOnCriteria" + query;
					return true;

				}
				alert("Please Select options to Search record");
				return false;
			} else {

				var query = "?payCart=" + feeId + "&payMode=" + payMode
						+ "&frmDate=" + frmDate + "&tDate=" + tDate;
				window.location = "searchBasedOnCriteria" + query;
			}

		}
		
		function getTransactionDetailsBasedOnFilters() {
			
			var formId=document.getElementById("formId").value;
			var fromDate=document.getElementById("idFrom").value;
			var toDate=document.getElementById("idTo").value;
			var payMode=document.getElementById("payMode").value;
			//alert("formId {"+formId+"}, fromDate {"+fromDate+"}, toDate {"+toDate+"}, payMode {"+payMode+"}");
		
	    
				if(formId){
					//alert("It is in if block for searchBasedOnCriteria");
				
					window.location = "searchBasedOnCriteria?formId=" + formId+"&fromDate="+fromDate+"&toDate="+toDate+"&payMode="+payMode;
			
		
				}else{
					alert("Please Select Form");
			    	return false;
				}
		} 
				
		function initiateRefundProcess(txnId, spTxnId, transAmount, transPaymode,transStatus,clientId){
			/* alert("TransactionId fro Refund :- "+txnId+", spTxnId : "+spTxnId
					+", transAmount : "+transAmount+", transPaymode : "+transPaymode+", transStatus : "+transStatus+", clientId : "+clientId); */  
			var confirmResponse = confirm("Are you sure to initiate a refund for transactionId : "+txnId);
			if(confirmResponse){
				//refundApiFromReports
				//alert("click confirm");
				//------------------------//
				var refundMessage ="Refund Request is initiated for "+spTxnId+", whose amount is "+transAmount+" and current Status is "+transStatus;
				/* var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (xhttp.readyState == 4 && xhttp.status == 200) {
						document.getElementById("ResultBox").innerHTML = xhttp.responseText;
						alert("Refund Request Is succefully Submited"); */
						/* $('#transTable').DataTable({
							scrollY : '50vh',
							scrollCollapse : true,
							"scrollX" : true,
							"language" : {
								"search" : "Filter Results:"
							},
							dom : 'Bfrtip',
							buttons : [ 'copy', 'excelHtml5', 'pdf', 'print' ]
						}); */
					/* }else{
						alert("Refund Request Is not Submited, Because of some issue, So Please try after Some time");
					}
				}
				xhttp.open("GET", "refundApiFromReports?txnId=" +txnId
						+ "&spTxnId=" +spTxnId+ "&transAmount=" +transAmount+ "&transPaymode="
						+transPaymode+ "&transStatus=" +transStatus+ "&clientId="
						+ clientId+"&message="+refundMessage, true);
				xhttp.send(); */
				//------------------------//
				<%-- $.ajax({
					type : 'GET',
					dataType : 'json',
					url : "/clientOnBoarding/checkSubscriptionstatus?appId=3&&roleid="+roleid+"&&loginId="+loginId,
					success : function(data) {
						spAppSubscriptionStatus = data.response;
						//alert("spAppSubscriptionStatus"+spAppSubscriptionStatus)
						if(spAppSubscriptionStatus == "Verified"){
							$(".modal-dialog").addClass("hide");
							$(".modal-backdrop.in").css("opacity","0");
							var url="<%=sabpaisaUrlname%>clientLogin?username="+ userName+"&&password="+ password;
							window.open(url, '_blank');
						}
						else 
							window.location.replace("sabpaisa.jsp");
					},
					error : function(data) {
						alert("error " + JSON.stringify(data));

					},
				}); --%>
				
				$.ajax({
					type : 'GET',
					dataType : 'json',
					url : "refundApiFromReports?txnId=" +txnId
						+ "&spTxnId=" +spTxnId+ "&transAmount=" +transAmount+ "&transPaymode="
						+transPaymode+ "&transStatus=" +transStatus+ "&clientId="
						+ clientId+"&message="+refundMessage ,
					success : function(data) {
					/* $("#tranTable tbody").empty(); */
					if (data.response=='refund_not_enable') {
							alert("Refund is not enable, So please contact with SabPaisa Admin "+data.response);
	                        /* $("#tranTable tbody").append("<tr><td style='text-align: center;' colspan='10'>No Data Found</td></tr>"); */
	                        /* $('#loadingImage').hide(); */  // Hide the loading message.
	                    }else {
	                    	alert("Your refund is Submitted Succesfully, the same will be credited back to your account in 7-10 days. For more details on the status of the payment, please check the Report Section.");
	                    	/* var row = '';					  
						 $.each(data.response, function(index, value) {
							var DDMMYY_Date_Format = timeConverter(value.transDate);						
							//alert("Humant Redable DDMMYY_Date_Format >>>>>>> "+DDMMYY_Date_Format);
							
							row += "<tr><td>" + value.txnId + "</td><td>" + value.clientTxnId +
		                    "</td><td>" + value.paidAmount + "</td>"+
		                    "<td>" +DDMMYY_Date_Format+ "</td>"+			                    
		                    "<td>" + value.status + "</td>"+
		                    "<td>" + value.paymentMode + "</td>"+
		                    "<td>" + value.payeeFirstName + "</td>"+
		                    "<td>" + value.payeeMob + "</td>"+
		                    "<td>" + value.payeeEmail + "</td></tr>"
		                    ;
		                   // alert(row);
		                   
		                });
		 				//alert(row);
		 				
		                $("#tranTable tbody").append(row);
		                $('#loadingImage').hide(); */  // Hide the loading message.
	                    }
					},
					error : function(data) { // if error occured
						alert("Error occured.please try again");

					},
				});
				
				
				
				
			}else {
				alert("click cancel");
			}			
			
		}
		
		function initiateRefundProcess2(){
			alert("initiateRefundProcess2 is called");
		}
		
		
	</script>
	<script type="text/javascript" src="DataTables/custom.js"></script>	
	<script type="text/javascript" src="DataTables/custom.min.js"></script>
	

</body>
</html>
