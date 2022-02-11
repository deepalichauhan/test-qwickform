<!DOCTYPE html>
<html lang="en">
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
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
	<table class="table table-striped table-condensed datatable"
		id="mainForm1">
		<thead>
			<tr>
				<th>Sr. No.</th>
				<th>Fee Name</th>
				<th>Amount Paid</th>
				<th>Transaction Id</th>
				<!-- <th>AtomTransactionID</th> -->
				<th>Transaction Date</th>
				<th>Transaction Type</th>
				<th>Payee Name</th>
				<th>Status</th>
			</tr>
		</thead>
		<c:forEach items="${TransData}" var="transData">
		
			<tr>
				<td><c:out value=${transData.id } /></td>
				<td><c:out value=${transData.feeName } /></td>
				<td><c:out value=${transData.transAmount } /></td>
				<td><c:out value=${transData.spTransId } /> </td>
				<td><c:out value="${transData.bankReferenceNo}" /></td>
				<td><c:out value=${transData.transDate } /></td>
				<td><c:out value=${transData.transPaymode } /></td>
				<td><c:out value=${transData.name } /></td>
				<td><c:out value=${transData.transStatus } /></td>
				
			</tr>
		
		</c:forEach>
	</table>







</body>
</html>
