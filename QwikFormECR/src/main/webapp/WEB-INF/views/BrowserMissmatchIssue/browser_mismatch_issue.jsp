<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Base64"%>
<!DOCTYPEhtml>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
<title>Form is successfully submited</title>

</head>

<style>
table.e-receipt td {
	border-bottom: 1px solid #ccc;
	border-right: 1px solid #ccc;
}

table.e-receipt td.lft {
	border-left: 1px solid #ccc;
}
</style>
<body style="background: #fff; color: green;">
	<%
		CollegeBean collegeBean = new CollegeBean();
		try {
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
	%>
	<%
		} catch (java.lang.NullPointerException e) {
	%>

	<script type="text/javascript">
		window.location = "paySessionOut";
	</script>
	<%
		}
	%>

	<div class="container">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
			style="color: #3399ff;">

			<table align="center" width="100%">
				<tr>
					<td width="20%" align="center">
						<div class="university-logo- fl-logo">
							<%-- <% if(null!=collegeBean.getCollegeImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
								alt="" title="" height="60" width="80"></img>
							<%}else{ %> --%>
							<img src="images/logo.png" alt="" title="" width="80" height="60" />
							<%-- <%} %> --%>

							<!-- 	<img src="<c:out value="collegeBean.collegeLogo"/>" alt="" title="" class="border-img" width="120" height="100" /> -->
						</div>
					</td>
					<td width="60%" align="center">
						<%
							if (null != collegeBean.getCollegeName()) {
						%> <%-- <img
							src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
							alt="" title="" height="60" width="80"></img> --%>
						<h3 style="font: bolder, cursive;"><%=collegeBean.getCollegeName()%></h3>
						<%
							} else {
						%>
						<h1>SRS Live Technologies</h1> <!-- <img src="images/sabpaisa-logo.png" alt="" title="" width="80" height="60" /> -->
						<%
							}
						%>
					</td>
					<td width="20%" align="center">
						<div class="university-logo- fr-logo">

							<%-- <% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
								alt="" title="" height="40" width="60"></img>
							<%}else{ %> --%>
							<img src="images/allahabad_logo.jpg" alt="" title="" width="80"
								height="60" />
							<%-- <%} %> --%>

						</div>
					</td>

				</tr>
			</table>

			<hr>
		</div>
	</div>




	<div
		style="width: 1024px; margin: 0 auto; font-family: arial; font-size: 14px; text-align: center;">
		<table cellpadding="10" cellspacing="0" border="0" width="100%">
			<!-- <tr>
		<td style="text-align:center;" colspan="3"><img src="images/Sab-Paisa-small.png"></td>
	</tr> -->
			<tr>
				<td
					style="padding: 32px 12px; font-size: 62px; font-family: verdana; text-align: center; font-weight: bold;"
					colspan="3">&nbsp;</td>
			</tr>
			
			<tr>
				<td>
					<%
						String msg = (String) session.getAttribute("msgData");
					%> <%
					 	if (msg != null)
					
					 	{
 					%>
						<div
							style="color: green; text-align: center; font-weight: bold; font-size: medium;">
							<%=msg%>
						</div> <%
 					} else {
 					%>
						<div
							style="color: green; text-align: center; font-weight: bold; font-size: medium;">
							<h2>SuccessFull</h2>
						</div> <%
 					}
 					%>
				</td>
			</tr>
			
			<tr>
				<td>
					<%
						String linkForDownload = (String) session.getAttribute("downloadLink");
					%> <%
					 	if (linkForDownload != null)
					
					 	{
 					%>
						<div
							style="color: green; text-align: center; font-weight: bold; font-size: medium;">
							<a href="<%=linkForDownload%>">Download and install latest version from here!</a> 
						</div> <%
 					} else {
 					%>
						<div
							style="color: green; text-align: center; font-weight: bold; font-size: medium;">
							<h2>linkForDownload</h2>
						</div> <%
 					}
 					%>
				</td>
			</tr>

		</table>
</html>