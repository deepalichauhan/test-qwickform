<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="java.util.Base64"%>	
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

<meta charset="utf-8">
<title>Please Review the Captured Form Data</title>
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

<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
<style>
.container{background-color:#f8fbff; padding-top:10px;}
table.table-td tr.panel-heading{background:#0072bc;}
table.table-td tr.panel-heading td{color:#fff; font-weight:bold; text-align:center; font-size:14px;}
.table-td td{border:1px solid #eaeaea;}
.table-td{border-right:1px solid #0072bc; border-left:1px solid #0072bc; border-bottom:1px solid #0072bc;}
.logoparts {
    width: 100%;
    padding: 20px 8px 0 8px;
    margin: 0;
    display: inline-block;
    vertical-align: middle;
    line-height: 16px;
}
.clientlogo {
    text-align: left;
}
.providerlogo {
    text-align: right;
    float: right;
}
.form-check-label{text-align:center; display:block;}
</style>
<style id="antiClickjack">body{display:none !important;}</style>
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
		CollegeBean colBean = new CollegeBean();
     try{		
		    colBean = (CollegeBean) session.getAttribute("CollegeBean");
			
     } catch (NullPointerException e) {
		%>
		<script type="text/javascript">
		window.location="timeIntervalPage";
	</script>
	<%
		}
	%>

<div class="container">
		<div class="logoparts">
			<span class="clientlogo">
			
				
				
				
				</span> <span
				class="providerlogo"><img src="images/sabpaisa-logo.png"
				alt="" title="" width="120px" height="80px"></span>
		</div>
	</div>


<jsp:directive.include file="formSummaryNewForReview.jsp" />



</body>
</html>
