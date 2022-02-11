<!DOCTYPE html>
<%@page import="org.eclipse.jdt.internal.compiler.ast.ForeachStatement"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.logging.log4j.LogManager, org.apache.logging.log4j.Logger"%>

<%@page import="com.sabpaisa.qforms.beans.SampleTransBean"%>
<%@page import="com.sabpaisa.qforms.beans.SampleFormView"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%@page import="java.util.Iterator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms</title>
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

<body onload="validateCollege()">
</br></br></br></br></br></br></br></br>

<div align="center"><b>Your Request is being Processed.....</b></div>
	<%
	
	Logger log = LogManager.getLogger("Start.jsp");

	
	String bid = (String) request.getParameter("bid");

	String cid = (String) request.getParameter("cid");

	log.info("bid from request is ::"+bid);
	log.info("cid from request is ::"+cid);

	if (bid == null || cid == null) {
		response.sendRedirect("timeIntervalPage");
		return;
	}
	
	else {
		
	 if(cid.equals("ALL")||bid.equals("ALL")){
		
		log.info("Bank's flow start, ignoring checks of session");
		if(null!=request.getParameter("redirectedFrom") && "Bank".equals(request.getParameter("redirectedFrom"))){
			session.setAttribute("redirectedFrom", request.getParameter("redirectedFrom"));
		}		
	 }
	
	else{
		
	
	
		Integer bidFromSession =  (Integer)session.getAttribute("BankId")==null?Integer.parseInt("0"):(Integer)session.getAttribute("BankId");
		log.info("bidFromSession is"+bidFromSession);

		Integer cidFromSession = (Integer) session.getAttribute("CollegeId")==null?Integer.parseInt("0"):(Integer) session.getAttribute("CollegeId");	
		log.info("cidFromSession is"+cidFromSession);
		
		log.info("redirectedFrom value is::"+request.getParameter("redirectedFrom"));
		
		if(bidFromSession==0 && cidFromSession==0){
			
			log.info("starting from scratch, no session history of bid and cid..., forward to server and process");
			if(null!=request.getParameter("redirectedFrom") && "Bank".equals(request.getParameter("redirectedFrom"))){
				
				session.setAttribute("redirectedFrom", request.getParameter("redirectedFrom"));
				
			}
			log.info("use for removing session of formviewdata");
			/* session.removeAttribute("formViewData"); */
			
		}else{
			
			if(null!=request.getParameter("currentSessionReturn") && "Y".equals(request.getParameter("currentSessionReturn"))){
				
				log.info("user pressed back button to go to start, so forgiving...");
				if(null!=request.getParameter("redirectedFrom") && "Bank".equals(request.getParameter("redirectedFrom"))){
					session.setAttribute("redirectedFrom", request.getParameter("redirectedFrom"));
				}		
				session.removeAttribute("currentFormId");
				session.removeAttribute("formInstanceId");
				session.removeAttribute("formid");				
				session.removeAttribute("formid");		
				/*remove session for formviewdata*/
				/* session.removeAttribute("formViewData"); */
				/* session.removeAttribute("form"); */
			}
			
			else{
			
			
		
		
			if(null!=request.getParameter("terminatingOldSession") && request.getParameter("terminatingOldSession").equals("Y")){
				log.info("client wants to terminate old session and proceed with new, so removing old session attribiutes");
				session.removeAttribute("BankId");
				session.removeAttribute("CollegeId");
				session.removeAttribute("redirectedFrom");
				session.removeAttribute("currentFormId");
				session.removeAttribute("formInstanceId");
				session.removeAttribute("formid");
				session.removeAttribute("formid");	
				//session.removeAttribute("CollegeBean");
				//session.removeAttribute("SelectedInstitute");
				//session.removeAttribute("InstituteCode");
				//session.removeAttribute("PayeeProfile");			
				//session.removeAttribute("formid");
				/* session.removeAttribute("formViewData"); */
				/* session.removeAttribute("form"); */
				
				if(null!=request.getParameter("redirectedFrom") && "Bank".equals(request.getParameter("redirectedFrom"))){
					session.setAttribute("redirectedFrom", request.getParameter("redirectedFrom"));
				}					
			
			
			}
		
			else{
		
				if( request.getParameter("bid").equals(session.getAttribute("BankId")) && request.getParameter("cid").equals(session.getAttribute("CollegeId"))){
			
					log.info("same bid and cid opening attempt in another window, still do not allow it");	
					if(null!=request.getParameter("redirectedFrom") && "Bank".equals(request.getParameter("redirectedFrom"))){
						response.sendRedirect("DuplicateSession?bid="+request.getParameter("bid")+"&cid="+request.getParameter("cid")+"&redirectedFrom=Bank");
					}
					else{
						response.sendRedirect("DuplicateSession?bid="+request.getParameter("bid")+"&cid="+request.getParameter("cid"));
					}
					return;	
			
				}
				else
				{
					log.info("a different bid and cid opening attempt in another window, do not allow it");
					
					if(null!=request.getParameter("redirectedFrom") && "Bank".equals(request.getParameter("redirectedFrom"))){
						response.sendRedirect("DuplicateSession?bid="+request.getParameter("bid")+"&cid="+request.getParameter("cid")+"&redirectedFrom=Bank");
					}
					else{
						response.sendRedirect("DuplicateSession?bid="+request.getParameter("bid")+"&cid="+request.getParameter("cid"));
					}
					return;	
	
	   			}
	 	  	}
		
	 	 }
		
	 	}
		
	}
	  
	}	
	%>





	<form name="startQForm" action="" method="post" id="validateForm">
		<input type="hidden" value="<%=cid%>" name="cid">
		<input type="hidden" value="<%=bid%>" name="bid"> 
		<input type="hidden" value="true" name="isfromBank">
	</form>
	<footer class="row">

		<div style="text-align: center;">
		
		</div>


	</footer>

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



	<script type="text/javascript">
		function validateCollege() {
		var cid='<%=cid%>';
		var bid='<%=bid%>';
		
		//alert("value of cid is:>>>>>>>>>>>>>>>>"+cid+" in validateCollege");
		//alert("value of cid is:>>>>>>>>>>>>>>>>"+bid+" in validateCollege");
		
			if(cid=='ALL'){
				if(cid=='ALL' && bid=='ALL'){
					document.startQForm.action="sabpaisa";
					document.getElementById("validateForm").submit();
				}else
					{
					//ocument.startQForm.action="loadCollegesDetail";
					document.startQForm.action="bankClients";
					document.getElementById("validateForm").submit();
					}
		}
		else{
			document.startQForm.action="validateCollegeAndBank";
			document.getElementById("validateForm").submit();			
		}
		}

		function Pay() {

			var bid1 =
	<%=bid%>
		var cid1 =
	<%=cid%>
		if (bid1 == 1 && cid1 == 1) {

				var linkadd = "chooseStudentOrCollegeOption.jsp"
			} else if (bid1 == 2 && cid1 == 1) {

				var linkadd = "chooseStudentOrCollegeOption.jsp"
			} else if (bid1 == 3 && cid1 == 1) {

				var linkadd = "chooseStudentOrCollegeOption.jsp"
			} else if (bid1 == 3 && cid1 == 3) {

				var linkadd = "chooseStudentOrCollegeOption.jsp"
			} else if (bid1 == 4 && cid1 == 1) {

				var linkadd = "Allahabad Bank- home.html"
			} else {
				var linkadd = "Login.jsp"
			}

			/*  var linkadd = "Login.jsp" */

			window.location.href = linkadd;
		}
	</script>
</body>
</html>
