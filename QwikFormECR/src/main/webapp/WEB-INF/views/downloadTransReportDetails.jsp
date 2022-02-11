<!DOCTYPE html>
<html lang="en">

<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>

<meta charset="utf-8">
<title>SabPaisa Client Panel- Transactions</title>
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
 <%response.setContentType("application/vnd.ms-excel"); 
    response.setHeader("Content-Disposition", "inline; filename=" + "Transactions.xls");
    %>
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-star-empty"></i>Client Transactions
				</h2>
			</div>
			<div class="box-content">
				<!-- put your content here -->
				<table id="transTable" class='display nowrap'>
					<thead>
						<tr>
						<th></th>
				<th>Sr. No.</th>
				<th>Fee Name</th>
				
				<th>Transaction Id</th>
				<th>Amount Paid</th>
				<!-- <th>AtomTransactionID</th> -->
				<th>Transaction Date</th>
				<th>Transaction Type</th>
				<th>Payee Name</th>
				<th>Status</th>
			
							<th></th>
						</tr>
					</thead>
					<tbody>
						<%
							int i = 1;
						%>
						<c:forEach items="${TransData}" var="txnIndex">
						
						
						
							<tr>
								<td></td>
								<td><%=i%></td>
								<td>&zwnj;<c:out value='${txnIndex.feeName }'/></td>
								<td>&zwnj;<c:out value='${txnIndex.spTransId }'/></td>
								
								<td>&zwnj;<c:out value='${txnIndex.transOgAmount }'/></td>
								
								<td>&zwnj;
								<fmt:formatDate value="${transData.transDate}" pattern="dd/MM/yyyy HH:mm:ss a" var="parsedDateTime" type="both" />
								<c:out value='${parsedDateTime }'/>
								
								
								</td>
										
								<%-- <td>&zwnj;<s:date name="transCompleteDate"
										format="dd/MM/yyyy HH:mm:ss a" /></td> --%>
										
										<td>&zwnj;<c:out value='${txnIndex.transPaymode }'/></td>
										<td>&zwnj;<c:out value='${txnIndex.name }'/></td>
								<td>&zwnj;<c:out value='${txnIndex.transStatus }'/></td>
								
								<td>
									
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
</body>
</html>
