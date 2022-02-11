<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<label for="exampleInputEmail1"
			class="col-sm-5 col-form-label labeling">Name of Institution </label>
		<div class="col-sm-6">
			<select class="form-control valid" id="collegeSelect"
				aria-invalid="false" name="instituteName" onchange="selectedCollegeId()">
					<option>---Select Institutions---</option>		
					<c:forEach items="${collegelst}" var="collegeBeanlst">		
						<option value='${collegeBeanlst.collegeId}'>
							${collegeBeanlst.collegeName}
						</option>
					</c:forEach>
			</select>
			<input >
		</div>
	
</body>
</html>