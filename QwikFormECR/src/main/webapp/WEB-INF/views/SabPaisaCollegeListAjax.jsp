<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body>
	
		<label for="exampleInputEmail1"
			class="col-sm-5 col-form-label labeling no-mlabel">Educational
			Institutions Name *</label>
		<div class="col-lg-6 col-md-12 col-sm-12">
			<select class="form-control valid" id="collegeSelect"
				aria-invalid="false" name="instituteName"
				onchange="selectedCollegeId()">
				<option>---Select Institutions---</option>
				<c:forEach items="${collegelst } var="collegelst">
				
					<option
						value="${collegelst.collegeId},${collegelst.bankDetailsOTM.bankId}">${collegelst.collegeName}</option>
				</c:forEach>
			</select>
		</div>

</body>
</html>