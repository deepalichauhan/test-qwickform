<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<html lang="en">
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>

<meta charset="utf-8">
<title>FomrLink</title>
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
<style id="antiClickjack">
body {
	display: none !important;
}
</style>
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
		Integer sesBid = null, sesCid = null;
		try {
			sesBid = (Integer) session.getAttribute("BankId");
			sesCid = (Integer) session.getAttribute("CollegeId");
			CollegeBean collegeBean = (CollegeBean) session.getAttribute("CollegeBean");

		} catch (NullPointerException e) {
	%>
	<script type="text/javascript">
		window.location = "paySessionOut";
	</script>
	<%
		}
	%>

	<table class="table table-striped table-condensed datatable"
		id="mainForm1">


		<input style="float: right; margin-right: 35px;" type="button"
			class="btn btn-info" onclick="window.history.back(-1);" value="Back">
		<c:choose>
			<c:when test="${payerHistory.isEmpty()}">
				<div
					style="color: red; text-align: center; font-size: large; font-weight: bold; margin-top: 10px;">NO
					TRANSACTIONS</div>
			</c:when>
			<c:otherwise>

				<thead>
					<tr>
						<th>Sr. No.</th>
						<th>Fee Name</th>
						<th>Amount Paid</th>
						<th>Transaction Id</th>
						<th>Transaction Date</th>
						<th>Transaction Type</th>
						<th>Payee Name</th>
						<th>Status</th>
						




					</tr>
				</thead>
				<%
				int id = 1;
			%>
				<c:forEach items="${payerHistory}" var="payerHistory">
					<!-- transData payerHistory-->


					<tr>
						<td><%=id%></td>

						<td><c:out value="${payerHistory.feeName}" /></td>
						<td><c:out value="${payerHistory.transOgAmount}" /></td>
						<td><c:out value="${payerHistory.spTransId}" /> 
							<input type="hidden"
							id="tranId" value='<c:out value="${payerHistory.transId}" />'></td>
							
						<td><s:date name="transDate" format="dd/MM/yyyy hh:mm:ss" /></td>
						
						<td><c:out value="${payerHistory.transPaymode}" /></td>
						<td><c:out value="${payerHistory.name}" /></td>
						<td><c:out value="${payerHistory.transStatus}" /></td>
						<td>
							<% if(sesCid==11){%> 
							<button type="button"
								onclick='viewFormlst("<c:out value='${payerHistory.id}'/>","<c:out value="${payerHistory.transId}" />")'
								class="btn btn-info btn-sm">View Receipt</button> 
							<% 	}
							else{ %>

							<button type="button"
								onclick='viewFormlst("<c:out value='${payerHistory.id}'/>","<c:out value="${payerHistory.transId}" />")'
								class="btn btn-info btn-sm">View Receipt</button> 
								<% 	} 
								%>
						</td>
						<%
						id++;
						%>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<script type="text/javascript">
		function viewReceipt() {
			var tid = document.getElementById("tranId").value;

			window.open("viewReceiptDetails?tid=" + tid, "Preview",
					"width=700,height=768");
			//window.location = "viewReceiptDetails?tid=" + tid;
		}

		function ExecuteFun() {

			setTimeout(function() {
				ExecuteFun();
				//location.reload();
				var bid =
	<%=sesBid%>
		;
				var cid =
	<%=sesBid%>
		;
				if (bid == '' || bid == null) {
					window.location = "TimeIntervalPage";
				}

			}, 120000);
		}
		
		
		function viewFormlst(id,transId) {
			window.open("ViewFormlst?transId=" +transId+"&id="+id, "Preview",
					"width=500,height=768");
		}
		
	</script>

</body>
</html>
