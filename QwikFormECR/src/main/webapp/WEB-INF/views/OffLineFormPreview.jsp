<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms Page Break Form</title>
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
</head>

<body onload="document.getElementById('PageTitle').focus();">

	<% 
	Logger log = LogManager.getLogger("Payer Form New"); 
	ArrayList<String> fieldLookupList=new ArrayList<String>();
	try{
		
		fieldLookupList=(ArrayList<String>)session.getAttribute("fieldLookupList");
		//log.info("columnListOfFirstRow for offlineformpreview jsp ::::::: "+fieldLookupList.toString());
		/* String fieldList = String.join(",", fieldLookupList);
		//String fieldList=fieldLookupList.toString();
		log.info("fieldList for offlineformpreview jsp ::::::: "+fieldList);  */
	}catch (NullPointerException e) {
		System.out.print("Nullpointer Exception in JSP...SA");
	%>
	<script type="text/javascript">
			
			window.location="timeIntervalPage"
			</script>
<% } 
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
									<i class="glyphicon glyphicon-star-empty"></i> Add New Page Break
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form id="OffLineForm" action="" method="POST">
									
									<input id="fieldLookupList" name="fieldLookupList" hidden="hidden" type="text" value="<%=fieldLookupList.toString() %>"/>
									<table class="table table-striped table-condensed" id="mainForm1">
										<tbody>

												<c:forEach items="${columnListOfFirstRow}" var="columnNameList" varStatus="index">
													<tr>
														<td><label id="lookUp_Name"><c:out value='${columnNameList}'/></label></td>
														<td><input id="lookUp_Type" hidden="hidden" type="text" placeholder="Show PreField Values"/></td>
														<td><input type="checkbox" name="validatefieldcheck" 
																	onchange="window.opener.AddToValidateField(this.value)"
																	id="flag" value="<c:out value='${columnNameList}'/>"> Validate Flag
														</td>
														
														<!-- <td> <input type="checkbox" name="editablecheck" 
																onchange="window.opener.EditFields(this.value)"
																id="flag1" value="yes"> Editable Field
														</td> -->
													</tr>
												</c:forEach>
												
												

												
												<tr>
												<td><button class="btn btn-sm btn-success" onclick="addFieldsToForm()">OK</button></td>
												<td><button class="btn btn-sm btn-warning" onclick="window.close()">Cancel</button></td>
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
	
	/* function checkboxes(){
	    var inputElems = document.getElementsByTagName("input"),
	    count = 0;
	    for (var i=0; i<inputElems.length; i++) {
		    if (inputElems[i].type === "checkbox" && inputElems[i].checked === true){
		        count++;
		        if(count>3){
		        	alert(count);
		        	alert("Maximum 3 CheckBox Allowed !!!")
		        	return false;
		        }
		    }else{
		    	alert("Please select any 2 fields for validate !!!")
		    	return false;
		    }
		}
	    if(count==2){
	    	addFieldsToForm()
	    }
	} */
	
		function addFieldsToForm(){			
		
			id=document.getElementById("lookUp_Name").value;
			
			window.opener.renderPreview(id);
			window.close();
			
		}
		function blockSpecialChar(value,id){
			var yourInput = value;
		
			re = /[`~!#$%^&*()_|+\-=?;:'",<>\{\}\[\]\\\/]/gi;
			var isSplChar = re.test(yourInput);
			if(isSplChar){
					var no_spl_char = yourInput.replace(/[`~!#$%^&*()|+\=?;:'",<>\{\}\[\]\\\/]/gi, '');
					document.getElementById(id).value=no_spl_char;
	
				}
			}

			$(document).ready(function(){
			    $('#fieldName').bind("cut copy paste",function(e) {
			        e.preventDefault();
			    });
			});
	</script>
</body>
</html>
