<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
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
				<s:iterator value="collegelst">
					<option
						value="<s:property value="collegeId" />,<s:property value="bankDetailsOTM.bankId" />"><s:property
							value="collegeName" /></option>
				</s:iterator>
			</select>
		</div>

</body>
</html>