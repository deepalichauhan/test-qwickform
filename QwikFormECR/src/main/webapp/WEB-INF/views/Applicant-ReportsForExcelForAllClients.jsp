<!DOCTYPE html>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
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







	<!-- topbar ends -->


	<table class="table table-striped table-condensed datatable"
		id="mainForm1">

		<%
			response.setContentType("application/vnd.ms-excel");
			/* PrintWriter out1 = response.getWriter();  
			 PDF p = new PDF(out1);
			Page p1 = new Page(p);
			p1.add(new MoveTo(p, 200, 700));
			p1.add(new Text(p, "www.javatpoint.com"));
			p1.add(new Text(p, "by Sonoo Jaiswal"));

			p.add(p1);
			p.setAuthor("Ian F. Darwin");

			p.writePDF();								
			
			response.setContentType("application/pdf");
			response.setHeader("Content-disposition","inline; filename='javatpoint.pdf'"); */
			response.setHeader("Content-Disposition", "inline; filename=" + "applicantReport.xls");
		%>
		<thead>
			<tr>
				<c:forEach items="${headerSet}" var="header">
					<th><c:out value="${header}" /></th>
				</c:forEach>
			</tr>
		</thead>
		<c:forEach items="${aplDetails}" var="Outer">
			<tr>
				<c:forEach items="${Outer}" var="outter">
					<td>&zwnj;<c:out value="outter" /></td>
				</c:forEach>
			</tr>
		</c:forEach>

	</table>











</body>
</html>
