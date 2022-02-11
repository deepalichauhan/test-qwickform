<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms Custom Field Form</title>
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

<body>
	<%
		String cid=request.getParameter("cid");
	System.out.println("College Id is in formCustomField ::::: "+cid);
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
									<i class="glyphicon glyphicon-star-empty"></i> Add New Custom
									Field
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form id="FeeForm" action="saveFieldLookup" method="POST" modelAttribute="saveField">

  									<input hidden="hidden" type="text" value="<%=cid%>" name="cid" id="cid">
									<table class="table table-striped table-condensed"
										id="mainForm1">
										<tbody>
											<tr>
												<td>Field Type</td>
												<td><select required="required"
													name="lookup_type"
													onchange="GetSubTypeDD(this.value),ChangeFieldName(this.value)">
														<option value="" disabled="disabled" selected="selected">Please Select an Option</option>
														<option value="Input">Input</option>
														<option value="Select Box">Select Box</option>
														<option value="Check Box">Check Box</option>
														<option value="Radio Button Group">Radio Button	Group</option>
														<!-- <option value="File Upload Field">General Purpose File
															Upload Field</option> -->
														<option value="Document1">Document1</option>
														<option value="Document2">Document2</option>
														<option value="Document3">Document3</option>
														<option value="Document4">Document4</option>
														<option value="Document5">Document5</option>
														<option value="Document6">Document6</option>
														<option value="Document7">Document7</option>
														<option value="Document8">Document8</option>
														<option value="Document9">Document9</option>
														<option value="Document10">Document10</option>
														<option value="Photograph">Photograph</option>
														<option value="Signature">Signature</option>
														<option value="Text Area">Text Area</option>
														<option value="Multiplier">Multiplier</option>
														<option value="Form Notification">Form Notification</option>
														<option value="E-Receipt Notification">E-Receipt Notification</option>
														<option value="Section">New Form Section</option>
												</select></td>
											</tr>
											<tr>
												<td id="fieldname">Field Name</td>
												<td><div id="the-basics" class="has-success">
														<input required="required" id="fieldName"
															name="lookup_name" placeholder="Field Name"
															type="text" class="form-control" onkeyup="return blockSpecialChar(this.value,this.id)" 
															oncopy="return false" onpaste="return false">
													</div></td>
											</tr>
											
											<tr id="subTypeBox" style="display: none;">
												<td>Field Sub Type</td>
												<td><select
													onchange="enableValidationInput(this.value)"
													name="lookup_subtype">
														<option value="" disabled="disabled" selected="selected">Please
															Select an Option</option>
														<option value="Text">AlphaNumeric</option>
														<option value="Alpha">Alphabets Only</option>
														<option value="Number">Number</option>
														<option value="Date">Date</option>
														<option value="Email">Email</option>
														<option value="Hidden">Hidden</option>
														
												</select></td>
											</tr>
											<tr id="notification_content_box" style="display: none;">
												<td>Write the Notification Content to Display</td>
												<td><textarea name="notification_content"
														maxlength="250"></textarea></td>
											</tr>
											<tr>
												<td>Optional Validation Pattern:</td>
												<td><input id="validationInput" disabled="disabled"
													type="text" name="validation_expression"></td>
											</tr>


											<tr>
												<td><button class="btn btn-sm btn-success"
														type="submit">Save</button></td>
												<td><button class="btn btn-sm btn-warning"
														onclick="window.close()">Cancel</button></td>
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

	 <script type="text/javascript">
	 function blockSpecialChar(value,id){
        	var yourInput = value;
    		
			re = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi;
			var isSplChar = re.test(yourInput);
			if(isSplChar){
					var no_spl_char = yourInput.replace(/[`~!@#$%^&*()|+\=?;:'",.<>\{\}\[\]\\\/]/gi, '');
					document.getElementById(id).value=no_spl_char;
	
				}
        }
    
		function GetSubTypeDD(value) {
			alert("sub type value "+value);
			if (value == "Input" || value=="readonly") {
				document.getElementById("subTypeBox").style.display = "table-row";
				document.getElementById("subTypeBox").required = "required";
				document.getElementById("notification_content_box").style.display = "none";
				document.getElementById("notification_content_box").required = false;
			}

			else if (value == "Form Notification"
					|| value == "E-Receipt Notification") {
				document.getElementById("subTypeBox").style.display = "none";
				document.getElementById("subTypeBox").required = false;
				document.getElementById("notification_content_box").style.display = "table-row";
				document.getElementById("notification_content_box").required = "required";
			} else {
				document.getElementById("subTypeBox").style.display = "none";
				document.getElementById("subTypeBox").required = false;
				document.getElementById("notification_content_box").style.display = "none";
				document.getElementById("notification_content_box").required = false;
			}
		}

		function saveForm() {
			document.getElementById("FeeForm").submit();
			alert("Fee Successfully Added");
			window.close();
		}
		function enableValidationInput(x) {
			//alert("enableValidationInput is "+x);
			if (x == "Text") {
				document.getElementById("validationInput").disabled = false;
			} else if(x=="readonly"){
				alert("inside read oonly");
				document.getElementById("validationInput").disabled = "false";
				document.getElementById("validationInput").readOnly = true;
				document.getElementById("validationInput").value = "";
			}  
			
			else {
				alert("else cond "+x);
				document.getElementById("validationInput").value = "";
				document.getElementById("validationInput").disabled = "disabled";
			}
		}
		ChangeFieldName(type)
		{
			alert("change field name is "+type);
			if(type=="Section")
				{
				document.getElementById("fieldname").innerHTML="Section Title ";
				}
			else
				{
				document.getElementById("fieldname").innerHTML="Field Name ";
				}
		}
		
	
	</script>
	
	<script type="text/javascript">
	
	$(document).ready(function(){
	    $('#fieldName').bind("cut copy paste",function(e) {
	        e.preventDefault();
	    });
	});
	
	</script>
</body>
</html>
