<!DOCTYPEhtml>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="java.util.Base64"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
<title>E-receipt</title>
<link rel='stylesheet' type='text/css' href='css/stylerecipt.css' />
<link rel='stylesheet' type='text/css' href='css/print.css'
	media="print" />
<script type='text/javascript' src='js/jquery-1.3.2.min.js'></script>
<script type='text/javascript' src='js/example.js'></script>

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
<body>
	<%
Logger log = LogManager.getLogger("Consolodate data");
	Integer sesBid = null, sesCid = null;
	CollegeBean collegeBean = new CollegeBean();
	SampleFormBean formBean=new SampleFormBean();
	
	Integer valClientId=1;
	try {
		formBean=(SampleFormBean)session.getAttribute("sampleFormForView");
		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
%>
	<%
	} catch (java.lang.NullPointerException e) {
%>

	<script type="text/javascript">
			window.location = "PaySessionOut";
			</script>
	<%
	}
%>
	<%
		
		 

			
			String usercookie = null;
			String sessionID = null;
			String dispchar = "display:none";
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
		for (Cookie cookie : cookies) {

			if (cookie.getName().equals("user"))
		usercookie = cookie.getValue();
			if (cookie.getName().equals("JSESSIONID"))
		sessionID = cookie.getValue();
		}
			} else {
		sessionID = session.getId();
			}
	%>
	<%
		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String qFormsIP = properties.getProperty("qFormsIP");
		String clientLogoLink = properties.getProperty("clientLogoLink");
		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
		String fileUploadPathNew=properties.getProperty("fileUploadPathNew");
		String imageFileURL = properties.getProperty("cobImage");
		String tot1="";
		String documentDownloadLink = properties.getProperty("documentDownloadLink");
		String filePath="null",fileName="";
		if(null!=formBean.getFile_Path1()){
			filePath=documentDownloadLink+formBean.getFile_Path1();
			fileName=formBean.getFile_Path1().substring(formBean.getFile_Path1().lastIndexOf("\\")+1, formBean.getFile_Path1().length());
		}
	%>

	<div class="bg print"></div>
	<div id="page-wrap">

		<div id="header">E-Receipt</div>
		<div id="identity" class="flt full">
			<div class="main-logo">

				<span class="picturecontainer flt"> <%
				if (null != collegeBean.getCollegeImage()) {
			%> <img
					src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
					class="horizontalcenter" /> <%}else{%> <img
					src="images\sabpaisa-logo.png" class="horizontalcenter" /> <%}%>

				</span> <span class="headingtxt"><%=collegeBean.getCollegeName()%><br><%=collegeBean.getStateBean().getStateName()%></span>
				<span class="picturecontainer"> <% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
					<img
					src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
					class="horizontalcenter" /> <%}else{%> <img
					src="images\sabpaisa-logo.png" class="horizontalcenter" /> <%}%>

				</span>


			</div>


		</div>
		<div style="clear: both"></div>
		<c:set var="feeName">
			<c:out value="${beanTransData.feeName}" />
		</c:set>
		<form id="nitForm" action="payForm" method="POST" modelAttribute="sampleFormData">
			<div id="customer">
				<table id="meta-heads" width="100%">
					<tr>
						<td colspan="3" class="meta-head stund">E-Receipt For <%=collegeBean.getBankDetailsOTM().getBankname()%>
							Collect Payment
							<div style="clear: both"></div> <span class="timetable">Date:
								<fmt:formatDate value="${beanTransData.transDate}"
									pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime1" type="both" />
								<c:out value="${parsedDateTime1}" /></td>
					</tr>
					<tr>
						<td colspan="2">
							<table class="table-td" style="width: 100%;">
								<%if(null!=formBean.getPhotograph()){ %>
								<tr class="lightgray">
									<td colspan="2">
										<div class="form-group">
											<div class="university-logo">
												<p class="top-mn-header">Applicant Photograph</p>
												<%
														try {
													%>
												<img
													src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getPhotograph())%>"
													alt="" title="" width="125px" height="150px" class="flleft">
												<%} catch (Exception ex) {
															ex.printStackTrace();
														}
													%>
											</div>
										</div>
									</td>
								</tr>
								<%}%>
							</table>
						</td>
					</tr>
					<tr>
						<td>Reference Number</td>
						<td><c:out value="${beanTransData.spTransId}" /></td>
					</tr>
					<tr>
						<td>Receipt Number</td>
						<td><c:out value="${beanTransData.transId}" /></td>
					</tr>
					<tr>
						<td>Category Name</td>
						<td><c:out value="${beanTransData.feeName}" /></td>
					</tr>

					<c:forEach items="${formViewData}" var="formViewData">
						<tr>
							<td class="wd-four"><c:set var="nextTab">
									<c:out value="${formViewData.label}" />
								</c:set> <c:choose>
									<c:when test="${nextTab=='PageBreak'}">
									</c:when>
									<c:otherwise>
										<strong><c:out value="${formViewData.label}" /></strong>
									</c:otherwise>
								</c:choose></td>
							<td class="wd-six">
									
									<c:set var="nextTab1">
										<c:out
											value="${not empty formViewData.value ? formViewData.value.substring(value.indexOf('*')+0) : 'Empty'}" />
									</c:set> 
									
									<c:set var="fieldValue">
										<c:out
											value="${formViewData.value.substring(value.indexOf('*')+0)}" />
									</c:set> 
									
									<c:set var="fileURL">
										<c:out value='<%=imageFileURL%>' />
									</c:set> 
									
									<c:choose>
										<c:when test="${nextTab1=='Empty'}">
											<c:out value=" " />
										</c:when>
										
										<c:when test="${fieldValue.indexOf('QwikFormContent')==-1}">
											<c:choose>											
													<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload1'}">
																										
													<%if(null!=formBean.getFile_Path1()){ 
													%>
														<c:set var="fileName1"
															value='<%=formBean.getFile_Path1().substring(formBean.getFile_Path1().lastIndexOf("/") + 1,formBean.getFile_Path1().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path1()%>" />' target="_blank" >
														<strong><c:out
																	value="${fileName1}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload2'}">
													<%if(null!=formBean.getFile_Path2()){ 
													%>
														<c:set var="fileName2"
															value='<%=formBean.getFile_Path2().substring(formBean.getFile_Path2().lastIndexOf("/") + 1,formBean.getFile_Path2().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path2()%>" />' target="_blank">
														<strong><c:out
																	value="${fileName2}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload3'}">
													<%if(null!=formBean.getFile_Path3()){ 
													%>
														<c:set var="fileName3"
															value='<%=formBean.getFile_Path3().substring(formBean.getFile_Path3().lastIndexOf("/") + 1,formBean.getFile_Path3().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path3()%>" />' target="_blank">
														<strong><c:out
																	value="${fileName3}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload4'}">
													<%if(null!=formBean.getFile_Path4()){ 
													%>
														<c:set var="fileName4"
															value='<%=formBean.getFile_Path4().substring(formBean.getFile_Path4().lastIndexOf("/") + 1,formBean.getFile_Path4().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path4()%>" />' target="_blank">
														<strong><c:out
																	value="${fileName4}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload5'}">
																										
													<%if(null!=formBean.getFile_Path5()){
														%>
														<c:set var="fileName5"
															value='<%=formBean.getFile_Path5().substring(formBean.getFile_Path5().lastIndexOf("/") + 1,formBean.getFile_Path5().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path5()%>" />' target="_blank"><strong><c:out
																	value="${fileName5}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload6'}">
													<%if(null!=formBean.getFile_Path6()){ 
													%>
														<c:set var="fileName6"
															value='<%=formBean.getFile_Path6().substring(formBean.getFile_Path6().lastIndexOf("/") + 1,formBean.getFile_Path6().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path6()%>" />' target="_blank"><strong><c:out
																	value="${fileName6}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload7'}">
													<%if(null!=formBean.getFile_Path7()){ 
													%>
														<c:set var="fileName7"
															value='<%=formBean.getFile_Path7().substring(formBean.getFile_Path7().lastIndexOf("/") + 1,formBean.getFile_Path7().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path7()%>" />' target="_blank"><strong><c:out
																	value="${fileName7}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload8'}">
													<%if(null!=formBean.getFile_Path8()){ 
													%>
														<c:set var="fileName8"
															value='<%=formBean.getFile_Path8().substring(formBean.getFile_Path8().lastIndexOf("/") + 1,formBean.getFile_Path8().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path8()%>" />' target="_blank"><strong><c:out
																	value="${fileName8}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload9'}">
													<%if(null!=formBean.getFile_Path9()){ 
													%>
														<c:set var="fileName9"
															value='<%=formBean.getFile_Path9().substring(formBean.getFile_Path9().lastIndexOf("/") + 1,formBean.getFile_Path9().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path9()%>" />' target="_blank"><strong><c:out
																	value="${fileName9}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:when
													test="${formViewData.value.substring(value.indexOf('*')+0)=='File Upload10'}">
													<%if(null!=formBean.getFile_Path10()){ 
													%>
														<c:set var="fileName10"
															value='<%=formBean.getFile_Path10().substring(formBean.getFile_Path10().lastIndexOf("/") + 1,formBean.getFile_Path10().length())%>' />
														<a href='<c:out value="<%=formBean.getFile_Path10()%>" />' target="_blank"><strong><c:out
																	value="${fileName10}" /></strong></a>
													
													<% } %>
													
												</c:when>
												<c:otherwise>
													<strong><c:out value="${fieldValue}" /></strong>
												</c:otherwise>
											</c:choose>
										</c:when>
										
										<c:otherwise>
											<a  href='<c:out value="${fileURL}${fieldValue}" />'  target="_blank">
									<c:out value='${fieldValue.substring((fieldValue.lastIndexOf("/")+1), fieldValue.length())}' />
									</a>

											
										</c:otherwise>
									</c:choose></td>
						</tr>
					</c:forEach>




					<tr>
						<td>Payment Mode</td>
						<td>&nbsp;<c:out value="${beanTransData.getTransPaymode()}" /></td>
					</tr>

					<tr>
						<td>Total Amount of Fees</td>
						<td>Rs.&nbsp;<c:out value="${beanTransData.transOgAmount}" /></td>
					</tr>
					<tr>
						<td>Payment Status</td>
						<td><c:out value="${beanTransData.transStatus}" /></td>
					</tr>
					<tr>
						<td colspan="2">
							<table class="table-td" style="width: 100%;">
								<%if(null!=formBean.getSignature()){ %>
								<tr class="lightgray">
									<td colspan="2">
										<div class="form-group">
											<div class="university-logo">
												<p class="top-mn-header">Applicant Signature</p>
												<%
														try {
													%>
												<img
													src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getSignature())%>"
													alt="" title="" width="125px" height="150px" class="flleft">
												<%} catch (Exception ex) {
															ex.printStackTrace();
														}
													%>
											</div>
										</div>
									</td>
								</tr>
								<%}%>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<%-- </c:otherwise>
		</c:choose> --%>
		</form>

		<button type="button" id="printpagebutton"
			title="Click Here to Print Receipt" onclick="printpage()"
			class="btn btn-sm btn-info">Print</button>
		<div id="terms">
			<p class="tnm-cond">Terms & Condition</p>
			<ul>
				<li>An E-Receipt is an electronic document with a unique
					confirmation number given to remitter in place of a paper receipt</li>
				<li>For details, rules and terms & conditions of E-Receipt,
					please visit <a
					href="http://43.252.89.79/QForms/TermsAndConditions.html"
					target="_blank">www.sabpaisa.in.</a>
				</li>
				<li>Payers are advised to carry transaction e-reciept for
					future reference</li>
				<li>When you register with above college/bank/, we or any of
					our partners/affiliate/staff may contact you from time to time to
					provide the details/information of such payments/services that we
					believe may benefit you.</li>

			</ul>
		</div>
		<div class="copright">
			© COPYRIGHT 2016. Powered by SRS Live Technologies Pvt Ltd.<br /> <a
				href="http://www.sabpaisa.in/" target="_blank"><img id="image"
				src="images/SabPaisa-logo.png" alt="SabPaisa" title="SabPaisa" /></a>
		</div>
	</div>
</body>
<script type="text/javascript">
		function printpage() {

			var printButton = document.getElementById("printpagebutton");

			printButton.style.visibility = 'hidden';

			window.print()
			printButton.style.visibility = 'visible';
		}
	</script>
</html>