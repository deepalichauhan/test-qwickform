<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>	
<%@page import="java.util.Base64"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QwikForms</title>

</head>
<body>

<%
	Integer sesBid = null, sesCid = null;
	CollegeBean collegeBean = new CollegeBean();
	String CollegeName=null, CollegeState=null;
	Logger log = LogManager.getLogger("PayerFormListNew.jsp");

		String verflag = "0";
		try {
			verflag = (String) request.getAttribute("verified");
			log.info("Verified Code :: " + verflag);

		} catch (Exception e) {
		}
		
		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");	
		SampleFormBean sfb = (SampleFormBean) session.getAttribute("sesCurrentFormData");
		log.info("collegeBean.collegeCode :: " + collegeBean.getCollegeCode());
		if(null!=sfb){
			log.info("form bean in session found, invalidating it now");
			session.removeAttribute("sesCurrentFormData");
		}
		else{
			log.info("no form bean in session found");
		}
		
	%>


	<div class="col-sm-12 labeling">
		<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12">
			<div class="university-logo">				
					
			</div>
		</div>
		<div class="col-lg-10 col-md-12 col-sm-12 col-xs-12">

			<div class="title-name">
													
			</div>

			<%
				if (verflag.contentEquals("0")) {
			%>
			
			<%
					String msg = (String) session.getAttribute("msg");					
					if (msg != null && !msg.contentEquals("")) {
			%>

		<!-- 	<div style="color: red; text-align: center; font-weight: bold; font-size: large;"> -->
					<div align="center"><%=msg%></div>
		<!-- 	</div>			-->
			<%} %>
			
			<div class="institue-box councils">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<label for="exampleInputEmail1"
						class="col-sm-3 col-form-label labeling">My College Code *</label>
					<div class="col-lg-7 col-md-12 col-sm-12 col-xs-12">
						<input class="form-control" placeholder="Enter College Code"
							id="collCode">
					</div>
				</div>

			</div>
			
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 cntrs labeling-pad">
					<button type="submit" class="wizard-goto btn btn-primary rht-gap" onClick="goToStart()" id="btnClick">Back</button>
					<span id="stepstwo"><button type="button" onClick="verifyCode()" class="wizard-next btn btn-primary" id="btnSubmit-second">GO</button></span>
			</div>	
			<%
				} else if (verflag.contentEquals("1")) {
			%>
			<div class="individual-box councils" id="individual">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<label for="exampleInputEmail1"
						class="col-sm-3 col-form-label labeling">Select*</label>
					<div class="col-sm-7">


												<select id="formId" class="form-control valid">
                                                        <option value="">--Select an option--</option>
                                                        <c:forEach items="${formsList}" var="formView">
                                                                <c:if test='${formView.validateFieldOfExcel==""}'>
                                                                        <option value='<c:out value="${formView.id}"/>'> <c:out
                                                                                value="${formView.formName}" /></option>
                                                                </c:if>
                                                        </c:forEach>
                                                </select>



						<%-- <select id="formId" class="form-control valid">
							<option value="">--Select an option--</option>
							<c:forEach items="${forms}" var="formView">
								<option value='<c:out value="${formView.id}"/>'> <c:out
										value="${formView.formName}" /></option>
							</c:forEach>
						</select> --%>
					</div>
				</div>
			</div>
		
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 cntrs labeling-pad">
					<button type="submit" class="wizard-goto btn btn-primary rht-gap" onClick="goToStart()">Back</button>
					<span id="stepstwo"><input type="submit" value="Go" onClick="goToForm()" class="wizard-next btn btn-primary" id="btnSubmit-second"/></span>
			</div>			
			<%
				} else if (verflag.contentEquals("2")) {
			%>

			<div class="institue-box councils">

				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<label for="exampleInputEmail1"
						class="col-sm-3 col-form-label labeling">Select Your
						Institute *</label>
					<div class="col-sm-7 ddown">
									<select id="selCode" class="form-control selectpicker">
									<option selected="selected" disabled="disabled" value="">Select
												An Option</option>
									<c:forEach items="subcolleges" var="subcolg">
										<option value='<c:out value="${subcolg.instituteId}"/>'><c:out
												value="${subcolg.instituteCode}" />:
												<c:out value="${subcolg.instituteName}" />(
												<c:out value="${subcolg.instituteType}" />)
										</option>
									</c:forEach>
						</select>
					</div>
				</div>

			</div>
			
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 cntrs labeling-pad">
					<button type="button" class="wizard-goto btn btn-primary rht-gap" onClick="goToStart()">Back</button>
					<span id="stepstwo"><button type="button" class="wizard-goto btn btn-primary rht-gap" onClick="storeCode()">GO</button></span>
			</div>					

			<%
				} else {
			%>


			<%
				}
			%>



		</div>
	</div>

	
</body>
</html>