<%@page import="com.sabpaisa.qforms.beans.SuperAdminBean"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<title>QwikForms Form Preview</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The styles -->
<link id="bs-css" href="css/bootstrap-cerulean.min.css" rel="stylesheet">

<link href="css/charisma-app.css" rel="stylesheet">
<link href='bower_components/fullcalendar/dist/fullcalendar.css'
	rel='stylesheet'>
<link href='bower_components/fullcalendar/dist/fullcalendar.print.css'
	rel='stylesheet' media='print'>
<link href='bower_components/chosen/chosen.min.css' rel='stylesheet'>
<link href='bower_components/colorbox/example3/colorbox.css'
	rel='stylesheet'>
<link href='bower_components/responsive-tables/responsive-tables.css'
	rel='stylesheet'>
<link
	href='bower_components/bootstrap-tour/build/css/bootstrap-tour.min.css'
	rel='stylesheet'>
<link href='css/jquery.noty.css' rel='stylesheet'>
<link href='css/noty_theme_default.css' rel='stylesheet'>
<link href='css/elfinder.min.css' rel='stylesheet'>
<link href='css/elfinder.theme.css' rel='stylesheet'>
<link href='css/jquery.iphone.toggle.css' rel='stylesheet'>
<link href='css/uploadify.css' rel='stylesheet'>
<link href='css/animate.min.css' rel='stylesheet'>
<style type="text/css">
#tags {
	float: left;
	border: 1px solid #ccc;
	padding: 5px;
	font-family: Arial;
}

#tags span.tag {
	cursor: pointer;
	display: block;
	float: left;
	color: #fff;
	background: #689;
	padding: 5px;
	padding-right: 25px;
	margin: 4px;
}

#tags span.tag:hover {
	opacity: 0.7;
}

#tags span.tag:after {
	position: absolute;
	content: "x";
	border: 1px solid;
	padding: 0 4px;
	margin: 3px 0 10px 5px;
	font-size: 10px;
}

#tags input {
	background: #eee;
	border: 0;
	margin: 4px;
	padding: 7px;
	width: auto;
}
</style>
<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
<%-- <style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
       top.location = self.location;
   }
</script> --%>
</head>

<body>

	<div class="ch-container">
		<div class="row">

			<noscript>
				<div class="alert alert-block col-md-12">
					<h4 class="alert-heading">Warning!</h4>

					<p>
						You need to have <a href="http://en.wikipedia.org/wiki/JavaScript"
							target="_blank">JavaScript</a> enabled to use this site.
					</p>
				</div>
			</noscript>

			<div id="content" class="col-lg-10 col-sm-12">
				<!-- content starts -->

				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i>
									<c:out value="${previewOfForm.formName}" />
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>



							<div class="box-content">
								<!-- put your content here -->
								<table class="table table-striped table-condensed">
									<c:forEach items="${previewOfForm.structureList}" var="formStrList">
										<tr>
											<td><strong><c:out value="${formStrList.formField.lookup_name}" /></strong></td>
											<td><c:set var="fieldType">
													<c:out value="${formStrList.formField.lookup_type}" />
												</c:set> 
												<c:set var="fieldSubtype">
													<c:out value="${formStrList.formField.lookup_subtype}" />
												</c:set> 
												<c:set var="mandFlag">
													<c:out value="${formStrList.isMandatory}" />
												</c:set> 
												<label id="formName">
												<c:out value="" />
												 
												</label> 
												<c:choose>
												<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Number")}'>
													<input type="number" pattern='<c:out value="${formStrList.formField.validation_expression}"/>'>
												</c:when> 
												<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Hidden")}'>
													<input type="password">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Text")}'>
													<input type="text" pattern='<c:out value="${formStrList.formField.validation_expression}"/>'>
												</c:when> 
												<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Alpha")}'>
													<input type="text" pattern="[A-Za-z]{*}" placeholder="Alphabets Only">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Email")}'>
													<input type="email">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Input") && fieldSubtype.contentEquals("Date")}'>
													<input type="date">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Form Notification")}'>
													<label><c:out value="${formStrList.formField.notification_content}" /> </label>
												</c:when> 
												<c:when test='${fieldType.contentEquals("E-Receipt Notification")}'>
													<label><c:out value="${formStrList.formField.notification_content}" /> </label> 
															*This content will be shown on the e-receipt.
												</c:when> 
												<c:when test='${fieldType.contentEquals("Multiplier")}'>
													<c:set var="key">
														<c:out value="${formStrList.id}" />
													</c:set>
													<input type="number" placeholder='Multiplier Field'>
													<div class='pull-right'>
														<c:forEach items="${optionsMap}" var="mapValue">
	    													<c:if test="${mapValue.key == key1 }"> 
															        <c:out value=" " />
														    </c:if>
														    <c:out value="${formStrList.fieldValues}" />
														</c:forEach>
													</div>
												</c:when> 
												<c:when test='${fieldType.contentEquals("Select Box")}'>
													<c:set var="key1">
														<c:out value="${formStrList.id}" />
													</c:set>
													<select id='selectObj' name='selectObj'>
														<c:forEach items="${optionsMap}" var="mapValue">
	    													<c:if test="${mapValue.key == key1 }"> 
															    <c:forEach items="${mapValue.value}" var="item" varStatus="loop">
															        <option value='<c:out value="${item}" />'><c:out value="${item}" /></option>
															    </c:forEach>
														    </c:if>
													</c:forEach>
													</select>
												</c:when> 
												<c:when test='${fieldType.contentEquals("Section")}'>
													<center>
														<strong>New Form Section Here: </strong>
													</center>
												</c:when> 
												<c:when test='${fieldType.contentEquals("Check Box")}'>
													<input type="checkbox">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Text Area")}'>
													<textarea></textarea>
												</c:when> 
												<%--  <c:when test='${fieldType.contentEquals("File Upload Field")}'>
													<input type="file">
												</c:when>  --%>
												<c:when test='${fieldType.contentEquals("Document1")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Document2")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Document3")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Document4")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Document5")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Document6")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Document7")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Document8")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Document9")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Document10")}'>
													<input type="file">
												</c:when> 
												<c:when test='${fieldType.contentEquals("Photograph")}'>
													<input type="file"> Only Image formats accepted (png,jpeg) upto 3 MB
												</c:when> 
												<c:when test='${fieldType.contentEquals("Signature")}'>
													<input type="file"> Only Image formats accepted (png,jpeg) upto 3 MB
												</c:when> 
												
												<c:when test='${fieldType.contentEquals("Radio Button Group")}'>
													<c:set var="key1">
														<c:out value="${formStrList.id}" />
													</c:set>
													<c:forEach items='${optionsMap}' var="mapValue">
														<c:if test="${mapValue.key == key1 }"> 
														<c:forEach items="${mapValue.value}" var="item" varStatus="loop">
															<c:out value="${item}" />
															<input type="radio" id='<c:out value="${formStrList.formField.lookup_id}"/>'>
														</c:forEach>
														</c:if>
													</c:forEach>
												</c:when>
												</c:choose>
												<c:if test='${mandFlag==1}'> &nbsp;
													Mandatory
												</c:if></td>
											<td></td>
										</tr>

									</c:forEach>
									<tr>
										<td colspan="3"><button class="btn btn-warning btn-sm"
												onclick="window.close()">Close Preview</button></td>
									</tr>
								</table>

								<!-- put your content here -->

							</div>


						</div>
					</div>
				</div>
				<!--/row-->


				<!-- content ends -->
			</div>
			<!--/#content.col-md-0-->
		</div>
		<!--/fluid-row-->


		<hr>
	</div>
	<!--/.fluid-container-->

	<!-- external javascript -->

	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>
	<!-- calender plugin -->
	<script src='bower_components/moment/min/moment.min.js'></script>
	<script src='bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
	<!-- data table plugin -->
	<script src='js/jquery.dataTables.min.js'></script>

	<!-- select or dropdown enhancer -->
	<script src="bower_components/chosen/chosen.jquery.min.js"></script>
	<!-- plugin for gallery image view -->
	<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
	<!-- notification plugin -->
	<script src="js/jquery.noty.js"></script>
	<!-- library for making tables responsive -->
	<script src="bower_components/responsive-tables/responsive-tables.js"></script>
	<!-- tour plugin -->
	<script
		src="bower_components/bootstrap-tour/build/js/bootstrap-tour.min.js"></script>
	<!-- star rating plugin -->
	<script src="js/jquery.raty.min.js"></script>
	<!-- for iOS style toggle switch -->
	<script src="js/jquery.iphone.toggle.js"></script>
	<!-- autogrowing textarea plugin -->
	<script src="js/jquery.autogrow-textarea.js"></script>
	<!-- multiple file upload plugin -->
	<script src="js/jquery.uploadify-3.1.min.js"></script>
	<!-- history.js for cross-browser state change on ajax -->
	<script src="js/jquery.history.js"></script>
	<!-- application script for Charisma demo -->
	<script src="js/charisma.js"></script>

	<script>
		
	</script>
</body>
</html>