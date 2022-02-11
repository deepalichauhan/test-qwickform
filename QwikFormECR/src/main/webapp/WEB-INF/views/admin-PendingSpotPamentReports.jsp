<!DOCTYPE html>
<html lang="en">
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
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

<body onload="assignDate()">

	<%
		LoginBean loginBean = new LoginBean();
		try {
			loginBean = (LoginBean) session.getAttribute("loginUserBean");
			if(null==loginBean){
				    response.sendRedirect("sessionFailurePage.jsp");
			}

		} catch (NullPointerException e) {
	%>		<script type="text/javascript">
			
			window.location="timeIntervalPage"
			</script>
<%		}
	%>

	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left animated flip">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<!-- <img
				alt="Charisma Logo" src="img/logo20.png" class="hidden-xs" /> --><a class="navbar-brand" href="index.html">  <span>QwikForms</span></a>

			<!-- theme selector starts -->
			<div class="btn-group pull-right theme-container">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-tint"></i><span
						class="hidden-sm hidden-xs"> Change Theme / Skin</span> <span
						class="caret"></span>
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
			<!-- theme selector ends -->



		</div>
	</div>
	<!-- topbar ends -->
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

			<div id="content" class="col-lg-10 col-sm-12">
				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i>Transaction
									Search Filters
								</h2>
							</div>
							<!-- Filter code Ravi junior Begin -->
							
							
							<div class="box-content">
								<!-- put your content here -->
							<table class="table table-striped table-condensed">
									<tr>
										<td style="width: 400px;">
										
										<div class="control-group">
												<label class="control-label" for="selectError">Filter
													By Form </label>

												<div class="controls" style="height: 40px;width: 380px;">
								
													<select name="${fd.paymentCat}" id="formId" data-rel="chosen"
													
														required="required" style="width: 50px !important; min-width: 300px; max-width: 50px;">
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
											<td></td>
											<td><label class="control-label" for="dob">To</label> <input
												name="idTo" id="idTo" required="required" type="text" value=""
												placeholder="DD-MM-YYYY" class="form-control"
												style="height: 30px;"><img src="img/cal.gif"
												onclick="javascript:NewCssCal('idTo','ddmmyyyy')"
												style="cursor: pointer" /></td>

										<td><div class="control-group">
												<label class="control-label" for="selectError">Transaction
													Type</label>

												<div class="controls">
													<select name="${fd.paymentCat}" id="payMode" data-rel="chosen"
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
											
										<td><div class="controls">
										<br>
												<button type="button" onclick="getTransactionDetailsBasedOnFilters()"
														class="btn btn-success btn-sm">Search</button>
														
											</div>
											</td>
											
									</tr>

								</table>


							
							</div>
							
							
							
							
							<!-- !!!!Filter code Ravi junior End -->
							
							
							
							
							
				<%-- 			<div class="box-content">
							
								<table class="table table-striped table-condensed">
									<tr>
										<td><div class="control-group">
												<label class="control-label" for="selectError">Filter
													By Fee Name</label>

												<div class="controls">
													<select name="fd.paymentCat" id="feeId" data-rel="chosen"
														required="required" style="width: 200px;">
														<option selected="selected" disabled="disabled" value="">Select
															An Option</option>
														<option value="All">All</option>

													<s:iterator value="feeLookupList">
															<option value='<c:out value="id"/>'><c:out
																	value="feeName" />
															</option>
														</s:iterator>
													
														

													</select>
												</div>
											</div></td>


										<td><div class="control-group">
												<label class="control-label" for="selectError">From
													Date</label>

												<div>
												
													<input id="fromDate" type="text" placeholder="DD/MM/YYYY" name="Date of Birth" size="25" class="form-control"><a href="javascript:NewCal('fromDate','ddmmyyyy')"><img src="img/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>



													
												</div></td>

										<td>
										
											</div>

											<div>
												<label class="control-label" for="selectError">To
													Date</label>

												<div class="controls">
												<input id="toDate" type="text" placeholder="DD/MM/YYYY" name="Date of Birth" size="25" class="form-control"><a href="javascript:NewCal('toDate','ddmmyyyy')"><img src="img/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
												
												</div>
											</div>
										</td>

										<td><div class="control-group">
												<label class="control-label" for="selectError">Transaction
													Type</label>

												<div class="controls">
													<select name="fd.paymentCat" id="payMode" data-rel="chosen"
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

										<td><div>
											
												<div class="controls">
													<a href="#" type="button" data-toggle="popover"
														onclick="searchBasedOnConditions()"
														class="btn btn-success btn-sm">Search</a>



													
												</div>
											</div></td>

									</tr>

								</table>


							
							</div> --%>
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
								<table id="transTable" class='display nowrap'>
									<thead>
										<tr>

											<th></th><th>Sr. No.</th>
											<th>Category</th>
											<th>Amount Paid</th>
											<th>Txn Id</th>
											<th>Txn Date</th>
											<th>Txn Type</th>
											<th>Payee Name</th>
											<th>Status</th>
											<th>Receipt Number</th>
											<th>Actions </th>
												<!-- <th>AtomTransactionID</th> -->
											<!-- <th>Payer Contact No.</th>
											<th>Payer Email</th>
											<th>Payer Address</th> -->
										<!-- 	<th>Client ID</th>
											<th>Mode</th> -->
											<th></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="{transData}" var="transData" varStatus="txnIndex">
											<tr>
											<td></td>
												<td><%=i%>
												</td>

												<td>&zwnj;<c:out value="${transData.feeName}" /></td>
												<td>&zwnj;<c:out value="${transData.transOgAmount}" /></td>
												<td>&zwnj;<c:out value="${transData.spTransId}" /></td>
												<%-- <td>Rs. <c:out
														value="getText('{0,number,#,##0.00}',{actAmount})" /></td> --%>
												<td>&zwnj;
												<%-- <fmt:parseDate value="${transData.transDate}" pattern="dd/MM/yyyy hh:mm:ss" var="parsedDateTime" type="both" /> --%>
												<fmt:formatDate pattern="dd/MM/yyyy hh:mm:ss" value="${ transData.transDate } var="parsedDateTime" type="both" />
												<c:out value="${parsedDateTime}" />
												</td>
												<!-- <s:date name="transDate" format="dd/MM/yyyy hh:mm:ss" /></td> -->
												<%-- <td>&zwnj;<s:date name="transCompleteDate" format="dd/MM/yyyy HH:mm:ss a" /></td> --%>
												
												<td>&zwnj;<c:out value="${transData.transPaymode}" /></td>
												<td>&zwnj;<c:out value="${transData.name}" /></td>
												<td>&zwnj;<c:out value="${transData.transStatus}" /></td>
											   <td>&zwnj;<c:out value="${transData.transId}" /></td>
												<td>&zwnj;<button type="button"
														onclick='viewFormlst("<c:out value='${transData.id}'/>","<c:out value="${transData.transId}" />")'
														class="btn btn-success btn-sm">View Receipt</button> 
														&zwnj;
														<button type="button"
														onclick='viewForm2("<c:out value='${transData.id}'/>")'
														class="btn btn-info btn-sm">View Form</button>
														&zwnj;
														<button type="button"
														onclick='updateChallanTransaction("<c:out value='${transData.spTransId}'/>")'
														class="btn btn-info btn-sm">Update</button>
														</td>
												<%-- <td>&zwnj;<c:out value="payeeAdd" /></td>
												<td>&zwnj;<c:out value="clientName" /></td> --%>
												<%-- <td>&zwnj;<c:out value="paymentMode" /></td> --%>

												<td>
													<!-- <button class="btn btn-info btn-sm">Get
														Details</button> -->
												</td>
												<%
													i++;
												%>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
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
			var timeDifferenceInHours = timeDifference / 60 / 60;

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
		
		
		// update challan transaction  updateChallanTransaction(
		
		function updateChallanTransaction(x) {
			
			window.open("updateSpotChallanTransaction?spTransId=" + x, "Preview",
					"width=500,height=500");
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
			/* var transStatus=document.getElementById("transStatus").value;   +"&transStatus="+transStatus */
			
		
	    
	   
			/* var date1 = fromDate.split('-');
			var date2 = toDate.split('-');
			  var istartDay=parseInt(date1);
			  var ilstDay=parseInt(date2);
			  var idays= ilstDay-istartDay; */
				if(formId){
					
				
					window.location = "searchBasedOnCriteria?formId=" + formId+"&fromDate="+fromDate+"&toDate="+toDate+"&payMode="+payMode;
			
		/*     if(formId){
		    	
		    	window.location = "ApplicantReportsForAllClients?formId=" + formId+"&fromDate="+fromDate+"&toDate="+toDate+"&payMode="+payMode+"&transStatus="+transStatus;
		   
		    }else{
		    	
		    	return false;
		    }
			 */
				}else{
					alert("Please Select Form");
			    	return false;
				}
			

		} 
		
		
		
		
	</script>
</body>
</html>
