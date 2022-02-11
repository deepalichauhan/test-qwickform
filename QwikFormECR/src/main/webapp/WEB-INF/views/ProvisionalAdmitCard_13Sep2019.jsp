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
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
<title>Burdwan University Admit Card</title>
</head>

<style>
table td {
	width: 50%;
}

table td.lft {
	text-align: left;
	padding: 10px 5px;
	border-top: 1px solid #ccc;
	border-right: 1px solid #ccc;
}

table td.lftn {
	text-align: left;
	padding: 10px;
	border-top: 1px solid #ccc;
	border-right: 1px solid #ccc;
}

table td.lftp {
	text-align: center;
	padding: 10px;
	border-top: 1px solid #ccc;
	border-right: 1px solid #ccc;
}

table td.lftbtm {
	border-bottom: 1px solid #ccc;
}

table td.heading {
	font-size: 16px;
	border-top: 1px solid #ccc;
	border-right: 1px solid #ccc;
	border-left: 1px solid #ccc;
	text-align: center;
	font-weight: bold;
	margin-top: 20px;
}

.bord {
	border-left: 1px solid #ccc;
}

.cnt-gap {
	font-weight: bold;
	padding: 15px;
	text-transform: uppercase;
	border-left: 1px solid #ccc;
	border-top: 1px solid #ccc;
	border-right: 1px solid #ccc;
	font-size: 14px;
}

.log-cnt {
	width: 120px;
	height: 120px;
	height: auto;
	margin: 3px;
	padding: 3px;
}

.log-cnt img {
	max-width: 120px;
	height: auto;
}

td.instruction {
	text-align: left;
}

td.instruction ul {
	padding: 8px 20px;
	margin: 0;
}

td.instruction ul li {
	padding: 2px 0;
}
</style>
<body style="background: #f7f6f6;">


	<%
	SampleFormBean formBean=new SampleFormBean();
	Logger log = LogManager.getLogger("Form Summary Page");
	formBean=(SampleFormBean)session.getAttribute("formDataForAdmitCard");
	log.info("Provisional Admit Card 3May.jsp::formBean.FormId is:"+formBean.getFormId());
	%>

	<div
		style="width: 980px; margin: 0 auto; font-family: arial; font-size: 14px; text-align: center;">
	
		<table cellpadding="10" cellspacing="0" border="0" width="100%">

		<TR><td
					style="padding: 12px 0; font-size: 16px; font-family: verdana; text-align: right; font-weight: bold;"
					colspan="3">
		<a href="javascript:window.print()" style="text-decoration: none; color: #333;" title="View Status Page"> <span style="background: #fff; border-radius: 4px; border: 1px solid #ccc; padding: 10px 20px; font-size: 15px;">
										<img src="images/printer.png" style="width: 18px;">Print
								</span></a>
								</td>
		
		</TR>
		
			<tr>
				<td colspan="3" class="log-cnt"><img src="images/verdhman.png"></td>
			</tr>
			<tr>
				<td
					style="padding: 12px 0; font-size: 16px; font-family: verdana; text-align: center; font-weight: bold;"
					colspan="3"><p><h4>THE UNIVERSITY OF BURDWAN</h4></p>
					<p><h5>OFFICE OF THE SECRETARY, FACULTY COUNCIL (ARTS, COMMERCE. ETC.)</br>
					GOLAPBAG, PURBA BARDHAMAN, WEST BENGAL - 713104</h5>
					<h6>Website : www.buruniv.ac.in, Email: secretary_arts@buruniv.ac.in</h6>
					<h5>WRITTEN ADMISSION TEST (RET-2019) FOR ADMISSION TO THE Ph.D. PROGRAMME-2019/M.Phil. PROGRAMME-2019-21.</h5></p></td>
			</tr>
			<tr>
				<td colspan="4" class="heading">Admit Card</td>

			</tr>
			<tr>
				<td class="lftn bord" width="35%">Student's Name</td>
				<td class="lftn" width="35%"><c:out value="${admitBean.name}" /></td>

				<td class="lftp lftbtm" rowspan="10" valign="top" width="30%">Photographs &
					Signature <%
					if (formBean.getPhotograph() != null) {
				%> <img
					src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getPhotograph())%>"
					width="90" height="100"
					style="border: 1px solid #ccc; margin-bottom: 5px;"> <%
 	}
 %> <%
 	if (formBean.getSignature()!=null) {
 %>
					<img
					src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getSignature())%>"
					style="background: #fff; border: 1px solid #ccc;" width="90px"
					height="35px"> <!-- <img src="images/sign-stud.gif" style="background:#fff; border:1px solid #ccc;" width="90px" height="35px"> -->
					<%
						}
					%>
				</td>
				<%-- <td class="lftp lftbtm" rowspan="10" valign="top"><label>Photographs
						& Signature</label> <span
					style="background: #fff; border: 1px solid #ccc; padding: 18px; display: block; margin-bottom: 20px;">Please
						fix your current photograph</span> <span
					style="background: #fff; border: 1px solid #ccc; padding: 10px 45px;"></span>

				</td> --%>
			</tr>
			
			<tr>
				<td class="lftn bord" width="35%">Transaction ID:</td>
				<td class="lftn" width="35%"><c:out value="${admitBean.reg_number}" /></td>
			</tr>
			<tr>
				<td class="lftn bord" width="35%">Roll Number</td>
				<td class="lftn" width="35%"><c:out value="${admitBean.roll_number}" /></td>
			</tr>
			<!--<tr>
				<td class="lftn bord">Father's Name</td>
				<td class="lftn"><c:out value="${admitBean.father_name}" /></td>
			</tr>
			<tr>
				<td class="lftn bord">Date of birth</td>
				<td class="lftn"><c:out value="${admitBean.dob}" /></td>
			</tr>-->
			<tr >
				<td class="lftn bord" width="35%">Course</td>
				<td class="lftn" width="35%"><c:out value="${admitBean.applied_course}" /></td>
			</tr>
			<tr>
				<td class="lftn bord" width="35%">Exam Date</td>
				<td class="lftn" width="35%"><c:out value="${admitBean.doe}" /></td>
			</tr>
			<tr>
				<td class="lftn bord" width="35%">Exam Centre</td>
				<td class="lftn" width="35%"><c:out value="${admitBean.center}" /></td>
			</tr>


			<tr>
				<td class="lftn bord lftbtm" width="35%">Exam Timing</td>
				<td class="lftn lftbtm" width="35%"><c:out value="${admitBean.toe}" /></td>
			</tr>
			
			<tr>
                                <td class="lftn bord lftbtm" width="38%">Form Application No </td>
                               <%-- <td class="lftn lftbtm"><c:out value="formBean.getFormNumber()" /></td>--%>
                                <td class="lftn lftbtm" width="37%"><c:out value="${form.formNumber}" /></td>
                        </tr>


		</table>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			style="padding-top: 20px;">
			<tr>
				<td style="width: 33%;" valign="top"><label>Signature
						of invigilator</label> <span
					style="background: #fff; border: 1px solid #ccc; padding: 40px 50px; display: block; margin: 10px;"></span></td>
				<!--<td style="width: 33%" valign="top"><label>Stamp of
						Center</label> <span
					style="background: #fff; border: 1px solid #ccc; padding: 40px 50px; display: block; margin: 10px;"></span></td>-->
					
					<c:set var="applied_course">
						<c:out value="${admitBean.applied_course}" />
						</c:set>
						<c:choose>
						<c:when test="${applied_course=='Zoology' || applied_course=='Botany' || applied_course=='Computer Sc and Appl' || applied_course=='Geospatial' 
							|| applied_course=='Chemistry' || applied_course=='CHEMISTRY'|| applied_course=='Physiology' || applied_course=='Geology' || applied_course=='Maths' 
							|| applied_course=='Statistics' || applied_course=='MicroBiology' || applied_course=='Physics' || applied_course=='Geography' || applied_course=='Environmental Sc' 
							|| applied_course=='Biotechnology'}">
				<td style="width: 45%" valign="top"><label>Secretary Council (Sc) for Science </label><span
					style="background: #fff; border: 1px solid #ccc; padding: 15px 50px; display: block; margin: 10px;"><img src="images/SecretaryScience.jpg"></span>
					</td>
                    </c:when>
					<c:otherwise>
				<td style="width: 45%" valign="top"><label>Secretary Council (Arts)</label><span
					style="background: #fff; border: 1px solid #ccc; padding: 15px 50px; display: block; margin: 10px;"><img src="images/SecretaryArts.jpg"></span>
					</td>
                    </c:otherwise>
                    </c:choose>
			</tr>
		</table>

		<br />

		<!--<table width="100%" border="0">
			<tr>
				<td class="instruction" colspan="3"><strong>Declaration
				</strong>
					<p>I declare that I have verified the eligibility criteria of
						the course and information uploaded by me as mentioned above is
						true.</p> <!--<p>??? ??? ?????? ?? ????? ???? ??? / ???? ??? ?? ???? ?? ??????? ?? ??????? ????????? ??????? ??????? ?? ??????? ??????? ?? ?? ?? ??? ???? ?????? ????? ???? ?? ??????? ????? ??? ??? </p>-->
					<!--<p><img src="images/pu-admit.jpg" alt="" title=""></p>
					</td>
			</tr>
		</table>-->
		
		
		
</html>