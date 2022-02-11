<!DOCTYPE html>
<html lang="en">
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left animated flip">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			
				<a class="navbar-brand" href="index.html">  <span>QwikForms</span></a>



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
							<div class="box-content">
								<!-- put your content here -->
							<table class="table table-striped table-condensed" style="overflow: auto;">
									<tr>
										<td><div class="control-group">
												<label class="control-label" for="selectError">Filter
													By Form </label>

												<div class="controls">
								
													<select name="fd.paymentCat" id="formId" data-rel="chosen"
													
														required="required">
														<option selected="selected" disabled="disabled" value="">Select
															An Option</option>
														
														<c:forEach items="${forms}" var="bean">
															
															<option value='${bean.id}'>
																<c:out value="${bean.formName}"></c:out>
															</option>
														</c:forEach>
														
													</select>
												</div>
											</div></td>
											<td><label class="control-label" for="dob">From</label>
												<input name="fromDate" id="idFrom" required="required"
												placeholder="DD-MM-YYYY" type="text" class="form-control"
												style="height: 30px;"><img src="img/cal.gif"
												onclick="javascript:NewCssCal('idFrom','ddmmyyyy')"
												style="cursor: pointer" /></td>
											<td></td>
											<td><label class="control-label" for="dob">To</label> <input
												name="toDate" id="idTo" required="required" type="text"
												placeholder="DD-MM-YYYY" class="form-control"
												style="height: 30px;"><img src="img/cal.gif"
												onclick="javascript:NewCssCal('idTo','ddmmyyyy')"
												style="cursor: pointer" /></td>
										<td><div class="controls">
												<button type="button" onclick="getApplicantDetailsBasedONFeeType()"
														class="btn btn-success btn-sm">Search</button>
														
											</div>
											
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
								<table id="transTable" class='display nowrap'>
									<thead>
										<tr>
											
										</tr>
										<tr>
											<th>Sr. No.</th>
											<c:forEach items="${headerSet}" var='headerSet'>
												<th><c:out value="${headerSet}" /></th>
												
											</c:forEach>
										</tr>
									</thead>
									<%
										int j = 1;
									%>
									<!--aplDetailsrmspl  aplDetails -->
									<c:forEach items="${aplDetails}" var="Outer">
										<tr>
											<td><%=j%></td>
											 <c:forEach items="${Outer}">
										
												<td> <c:out value="${Outer}"/> </td> 
											</c:forEach>
											
											<%
												j++;
											%>
											
										</tr>
									</c:forEach>
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

		

		function getApplicantDetailsBasedONFeeType() {
								
			var formId=document.getElementById("formId").value;
			var fromDate=document.getElementById("idFrom").value;
			var toDate=document.getElementById("idTo").value;
			
			var date1 = fromDate.split('-');
			var date2 = toDate.split('-');
			  var istartDay=parseInt(date1);
			  var ilstDay=parseInt(date2);
			  var idays= ilstDay-istartDay;
				if(feeType){
					
				
			  
			var x=5;
			var y=idays;
		    if( parseInt(idays) < parseInt(x)){
		    
		    	window.location = "ApplicantReportsAllClients?formId=" + formId+"&fromDate="+fromDate+"&toDate="+toDate;
		    }else{
		    	
		    	alert("please select less than 5 days")
		    	return false;
		    }
			
				}else{
					alert("please select the form from dropdown")
			    	return false;
				}
			

		}
	</script>
</body>
</html>
