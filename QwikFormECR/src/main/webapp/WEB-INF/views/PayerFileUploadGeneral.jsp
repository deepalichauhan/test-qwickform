<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms File Upload Box</title>
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
<style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
       top.location = self.location;
   }
</script>
<%
String fieldId = request.getParameter("fieldId");
String fileType = request.getParameter("filetype");
String flag = "0";
try {
	flag = request.getParameter("flag");
} catch (Exception e) {

}
%>
</head>
<body>
<%
	Integer sesBid = null, sesCid = null; 
	CollegeBean collegeBean = new CollegeBean(); 
	Integer currentFormId=null; 
	Logger log = LogManager.getLogger("PayerFileUploadGeneral"); 
	String payeeformIdQC = ""; 
	String PayeeProfile = ""; 
	
	try { 
		payeeformIdQC = (String) request.getParameter("formId"); 
	sesBid = (Integer) session.getAttribute("BankId"); 
	sesCid = (Integer) session.getAttribute("CollegeId"); 
	collegeBean = (CollegeBean) session.getAttribute("CollegeBean"); 
	currentFormId = (Integer) session.getAttribute("currentFormId"); 
	PayeeProfile = (String) session.getAttribute("PayeeProfile"); 
	
	log.info("PayeeProfile: PayerFormNew.jsp is:"+PayeeProfile); 
	log.info("sesCid: PayerFileUploadGeneral.jsp is:"+sesCid); 
	log.info("CollegeBean.getCollegeId(): PayerFileUploadGeneral.jsp is:"+collegeBean.getCollegeCode()); 
	log.info("currentFormId: PayerFileUploadGeneral.jsp is:"+currentFormId); 
	System.out.println("session ID for this form : PayerFileUploadGeneral.jsp is:"+session.getId());
%>
<%
	} catch (java.lang.NullPointerException e) {
%>

<script type="text/javascript"> 
window.location = "paySessionOut"; 
</script>
<%
	}
%>

	<%
		System.out.println("Winny payeeformIdQC:" + payeeformIdQC);
	%>


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
			<div id="content" class="col-lg-12 col-sm-12">
				<!-- content starts -->
				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Upload Your File
									Here
								</h2>
								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form action="documentFileUploadGeneral" enctype="multipart/form-data"	method="post" modelAttribute="formfile">
									
									<input hidden="hidden" value='<%=sesCid %>' type="text"  
													name="cidForNewFile">
									<input hidden="hidden" value='<%=currentFormId %>' type="text"  
													name="currentFormId">
									<input hidden="hidden" value='<%=PayeeProfile %>' type="text"  
													name="PayeeProfile">
									<input hidden="hidden" type="text"
													name="tempFileTypeValue"
													value='<%=request.getParameter("filetype")%>'> <span
													id="spanMsg" style="color: red"></span>
													
									<table id="mainForm1">
										<tbody>
											<tr>
												<td>Select File</td>
												<td><div id="the-basics" class="has-success">
														<input required="required" type="file" name="userFile"
															class="form-control" id="fileUpload">
													</div></td>   
											</tr>
											<tr>
												<td>Please Describe the file your are uploading</td>
												<td><div id="the-basics" class="has-success">
														<input required="required" type="text" name="file_description"
															class="form-control">															
                                                    <span id="spanMsg1" style="color:red"></span>
													</div>
													<input hidden="hidden" value='<%=request.getParameter("fieldId") %>' type="text"  
													name="field_id">
											</tr>
											<tr>
												<td><button type="submit"
														class="btn btn-sm btn-success" onclick="return myFunction()">Upload</button></td>
												<td><button type="button"
														class="btn btn-sm btn-warning" onclick="window.close()">Cancel</button></td>
											</tr>
										</tbody>
									</table>

								</form>

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

		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">

			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>Settings</h3>
					</div>
					<div class="modal-body">
						<p>Here settings can be configured...</p>
					</div>
					<div class="modal-footer">
						<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
						<a href="#" class="btn btn-primary" data-dismiss="modal">Save
							changes</a>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!--/.fluid-container-->

	<!-- external javascript -->

<script type="text/javascript">

function myFunction(){
// alert("Inside checkedMe");
    var oFile = document.getElementById("fileUpload").files[0]; // <input type="file" id="fileUpload" accept=".jpg,.png,.gif,.jpeg"/>

            if (oFile.size > 1000000) // 1 mb.
            {
			 //alert("File size is ="+oFile.size);
              document.getElementById("spanMsg1").textContent="Size of uploaded file exceeds limit";
                return false;
            }
            else
            	{
            	var fieldid = '<%=fieldId%>';
            	var flag = '<%=flag%>';
            	//alert('flag is::'+flag);
            	//alert("01 PayeFileUpload file_upload is made true::");
        		if(flag==1){
            		window.opener.file_upload = true;
        			window.opener.file_uploaded = true;
            	}

               
               
                
                         	
            	return true;
            	}
}
</script>



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
</body>
</html>
