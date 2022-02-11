<!DOCTYPEhtml>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>
<%@page import="com.sabpaisa.qforms.beans.AdmitCardBean"%>
<%@page import="com.sabpaisa.qforms.beans.SampleTransBean"%>

<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Base64"%>
<html dir="ltr" lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16"
	href="../../assets/images/favicon.png">
<title>THE UNIVERSITY OF BURDWAN : ADMIT CARD</title>
<style>
.cnt {
	text-align: center;
}

.imgwth {
	width: 80px;
	height: 80px;
}

.fntsz {
	font-size: 24px;
	font-weight: bold;
	padding: 10px 0;
}

.lftfnt {
	text-align: left;
}

.sign {
	width: 100px;
	height: 40px;
}

.tpad {
	padding: 20px;
}

.brd td {
	border: 1px solid #000;
}

.nobrd table {
	border: none;
	padding: 0;
}

.tbsz td {
	width: 20%;
}

.nopad {
	padding: 0;
}

.nopads td {
	border: none;
}

.pads td {
	padding: 0 20px 50px;
}
</style>
</head>

<%
	String center = "";
	SampleFormBean formBean = new SampleFormBean();
	Logger log = LogManager.getLogger("Form Summary Page");
	formBean = (SampleFormBean) session.getAttribute("formDataForAdmitCard");
	log.info("Provisional Admit Card 3May.jsp::formBean.FormId is:" + formBean.getFormId());
%>

<script>
	function myFunction() {
		window.print();
	}
</script>
<button onclick="myFunction()">Print Admit Card</button>

<table cellpadding="10" cellspacing="0" border="0" width="100%"
	class="brd tbsz">
	<tr>
		<td class="cnt" colspan="4"><img
			src="images/buAdmitCard2019/bulogoMay27.png" class="imgwth">
			<h2>THE UNIVERSITY OF BURDWAN</h2>
			<p>OFFICE OF THE SECRETARY, FACULTY COUNCIL (ARTS, COMMERCE, LAW ETC.)</p>
			<p>GOLAPBAG, PURBA BARDHAMAN, WEST BENGAL - 713104</p>
			<p>
				Website : <a href="http://www.buruniv.ac.in/" target="_blank">www.buruniv.ac.in</a>
				; E-mail :<Strong> secretary_arts@buruniv.ac.in</Strong>
			</p>
		<%--	<h3>VIVA-VOCE FOR ADMISSION TO THE Ph.D. PROGRAMME-2019/M. Phil. PROGRAMME-2019-21.</h3></td> --%>
			<h3>VIVA-VOCE FOR ADMISSION TO THE Ph.D. PROGRAMME-2019.</h3></td>
	</tr>
	<tr>
		<td class="cnt fntsz" colspan="4">Admit Card</td>
	</tr>

	<tr>
		<td valign="top">Candidates Name : <c:out
				value="${admitBean.name}" /></td>
		<td valign="top">Roll Number : <c:out
				value="${admitBean.roll_number}" />
		</td>
		<td class="nobrd nopad" valign="top">
			<table width="100%" cellpadding="0" cellspacing="0" class="pads">
				<tr>
					<td valign="top" class="cnt">Subject : <c:out
							value="${admitBean.applied_course}" /></td>
				</tr> 
				<tr rowspan="1">
					<td valign="top" class="cnt" rowspan="2" >Subjects Code : <c:out
							value="${admitBean.category}" /></td>
				</tr>
			</table>
		</td> 
		<td rowspan="2" class="cnt">
			<%
				if(null!=formBean.getPhotograph()){
			%>
			<label><img
				src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getPhotograph())%>"
				width="50%"></label>
			<%}else{ %>
				<label></br>
			<img
				src="data:image/png;"
				width="50%"></label>
			<%} %>
		</td>
	</tr>
	<tr>
		<td valign="top">Course : <c:out value="${admitBean.father_name}" /></td>
		<td valign="top" colspan="2" class="cnt">Date : <c:out
				value="${admitBean.doe}" /><br />
		<br />

		</td>
	</tr>

	<tr>
		<td valign="top" rowspan="2">Examination Center : <c:out
				value="${admitBean.center}" /></td>
		<td valign="top" colspan="2" class="cnt">Time : <c:out
				value="${admitBean.toe}" /><br />
		<br />

		</td>
		<td class="cnt" rowspan="2">Signature : 
		<%
				if(null!=formBean.getSignature()){
			%>
		<label></br>
			<img
				src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getSignature())%>"
				width="50%"></label>
		<%}else{ %>
				<label></br>
			<img
				src="data:image/png;"
				width="50%"></label>
			<%} %>
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2" class="cnt nopads">
			<table width="100%" cellpadding="0" cellspacing="0" border="0"
				class="tpad nopad">
				<tr align="center">
					<!-- <td class="lftfnt">
							<img src="images/buAdmitCard2019/buJtConvenorScience.png" class="sign">
							<p>Jt. Convenor</p>
							<p>P.G. Admission Committee-2019 (Science)</p>
						</td> -->
				<!--	<td class="cnt" colspan="2" align="center"><img
						src="images/buAdmitCard2019/buJtConvenorArts.jpg" class="sign">-->
                                        <td class="cnt" colspan="2" align="center"><img
                                                src="images/buAdmitCard2019/Secretary_Faculty_Council_Arts_Commerce_sign.jpg" class="sign">
						<p>Secretary</p>
						<p>Faculty Council (Arts, Commerce. etc.)</p></td>
				</tr>
			</table>
		</td>
	<%--	<td class="cnt"><p>Signature of the Candidate in presence of
				the invigilator:</p></td> --%>
	</tr>
</table>
<%-- <h4>N.B.: Candidates have to bring a valid photo Id. proof on the
	day of examination.</h4> --%>
<h4>N.B.: Along with the Admit Card, candidates have to bring a valid photo Id. proof on the day of examination.  </h4>

</body>
</html>
