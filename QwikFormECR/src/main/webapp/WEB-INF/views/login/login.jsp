<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@page import="com.sabpaisa.qforms.daoImpl.LookupRoleDaoImpl"%>
<%
	LookupRoleDaoImpl lookupRoleDImpl=new LookupRoleDaoImpl();
		
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>QwikForms SuperAdmin Portal</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="images/favicons.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/themify-icons.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body style="background-color: #666666;">

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
			<form:form id="loginForm" class="login100-form validate-form" modelAttribute="login" action="loginProcess" method="post">
						<fieldset>
				
					<span class="login100-form-title p-b-43">
						Login to continue
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
						<!--<input  type="text" name="email" placeholder="Email Id">-->
						
						
						<select name="roleSelect">
										<option value="0" selected="selected">--Select Role--</option>
									    <c:forEach var="item" items="${roleBeanMap}" >
									    	<option value="${item.key}" >${item.value}</option>
									        <%-- <option value="${item.key}" ${item.key == selectedDept ? 'selected="selected"' : ''}>${item.value}</option> --%>
									    </c:forEach>
									</select>
					</div>
					<!-- <div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
						<input class="input100" type="text" name="email" placeholder="Email Id">
						<span class="focus-input100"></span>
						<span class="label-input100">Email</span>
					</div> -->

					<div class="wrap-input100 validate-input">
						<input type="text"
									name="userName" class="form-control"
									required="required" placeholder="Username">
						<!--<span class="focus-input100"></span>
						<span class="label-input100">Email</span>-->
					</div>
					<div class="clearfix"></div>
					<div class="wrap-input100 validate-input" data-validate="Password is required">
						<input
									type="password" name="pass" class="form-control"
									required="required" placeholder="Password">
						<!--
						<span class="focus-input100"></span>
						<span class="label-input100">Password</span>-->
					</div>
					<div class="clearfix"></div>
					<div class="flex-sb-m w-full p-t-3 p-b-32">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
							<label class="label-checkbox100" for="ckb1">
								Remember me
							</label>
						</div>
						<!--
						<div>
							<a href="#" class="txt1">
								Forgot Password?
							</a>
						</div>-->
					</div>


					<div class="container-login100-form-btn">
						<p class="center col-md-5">
								
								<button type="submit" class="btn btn-primary">Proceed</button>
							</p>
					</div>
					</fieldset>
					</form:form>
				

				<div class="login100-more" style="background-image: url('images/header-bg.jpg');">
					<h1>sdlfkjsd</h1>
				</div>
			</div>
		</div>
	</div>





<!--===============================================================================================-->
	<script src="js/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="js/popper.js"></script>
	<script src="js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="js/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="js/moment.min.js"></script>
	<script src="js/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="js/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'UA-23581568-13');
	</script>
</body>
</html>
