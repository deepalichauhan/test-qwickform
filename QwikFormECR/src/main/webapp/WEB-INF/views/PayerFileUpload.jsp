<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
								<!-- <form action="payerFileUpload" enctype="multipart/form-data" method="post"> -->
								<form action="photoSignatureUpload" enctype="multipart/form-data"	method="post" modelAttribute="formfile">

									<table id="mainForm1">
										<tbody>

											<tr>

												<td>Select File
												
												</td>
												<td><div id="the-basics" class="has-success">
														<input required="required" type="file" name="userImage"
															class="form-control" id="imgUpload">
													</div> <input hidden="hidden" type="text"
													name="tempFileTypeValue"
													value='<%=request.getParameter("filetype")%>'> <span
													id="spanMsg" style="color: red"></span>
													</br>
													<span style="color: red;">*Please select only jpg, jpeg and png file for upload </span>
												</td>

											</tr>

											<tr>
												<td><button type="submit"
														class="btn btn-sm btn-success"
														onclick="return myFunction1()">Upload</button></td>
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
function myFunction1(){
	//Save Transaction receipt for successful Transactions for future use by clicking the 'View receipt' button
//alert("Inside myFunction1");
    var oFile = document.getElementById("imgUpload").files[0]; // <input type="file" id="fileUpload" accept=".jpg,.png,.gif,.jpeg"/>
    var filetype = '<%=fileType%>';
            if (oFile.size > 500000) // 500 kb.
            {
			   //alert("File size is ="+oFile.size);
               document.getElementById("spanMsg").textContent="Size of uploaded file exceeds limit";
               return false;
            }
            else
        	{
            	
            	var fieldid = '<%=fieldId%>';
            	var flag = '<%=flag%>';
                //alert('flag is::'+flag);
            	var filetype = '<%=fileType%>';
            	//alert("here signature_upload is set to true and filetype is::"+filetype);
            	
            	if (filetype == "sign" && flag==1)
   			 {
   			        //alert("02 signature_upload & signature_uploaded is made true ");
					window.opener.signature_upload = true;
					window.opener.signature_uploaded = true;
   			 }
   		       if(filetype == "photo" && flag==1)
   		    {
   		    	 //alert("03 photo_upload & photo_uploaded is made true ");
   	            	window.opener.photo_upload = true;
				    window.opener.photo_uploaded = true;
   		    }
            	

        	 //alert("PayeFileUploadGeneral flag is::"+flag);
        	 /* if(flag!=null)
        		 {
        		 
        		 if (flag == 1 && filetype == "sign") {
 					alert("here signature_upload is set to true");
 					window.opener.signature_upload = true;
 					window.opener.signature_uploaded = true;

 				}
 				if (flag == 1 && filetype == "photo") {
 					alert("here photo_upload is set to true");
 					window.opener.photo_upload = true;
 					window.opener.photo_uploaded = true;
 				}
        		 
        		 }
        	 if(flag==null || flag=="")
        		 {
        		 alert("signature_upload flag is::"+flag);
        		 if (filetype == "sign")
        			 {
        			 alert("here signature_upload is set to true");
  					window.opener.signature_upload = true;
  					window.opener.signature_uploaded = true;
        			 }
        		 if(filetype == "photo")
        		 {
        	    	window.opener.photo_upload = true;
 					window.opener.photo_uploaded = true;
        		 }
        		 } */
        	    
				

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
