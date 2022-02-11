<%@page import="com.sabpaisa.qforms.beans.CompanyBean"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<%@page import="com.sabpaisa.qforms.beans.SuperAdminBean"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
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
<!-- <link href='bower_components/chosen/chosen.min.css' rel='stylesheet'> -->
<link href='css/chosen.css' rel='stylesheet'>
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
<link href="select2/select2.css" rel="stylesheet" />

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

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
<script src="https://www.google.com/recaptcha/api.js"></script>
<!-- cdn for modernizr, if you haven't included it already -->
<script
	src="http://cdn.jsdelivr.net/webshim/1.12.4/extras/modernizr-custom.js"></script>
<!-- polyfiller file to detect and load polyfills -->
<script src="http://cdn.jsdelivr.net/webshim/1.12.4/polyfiller.js"></script>
<script>
	webshims.setOptions('waitReady', false);
	webshims.setOptions('forms-ext', {
		types : 'date'
	});
	webshims.polyfill('forms forms-ext');
</script>

</head>

<body onload="ExecuteFun()">

	<%
		LoginBean loginBean = new LoginBean();
		CollegeBean collegeBean = new CollegeBean();
		SuperAdminBean saBean = new SuperAdminBean();
		CompanyBean cbean=new CompanyBean();
		Integer companyID = null;
		Integer collegeID = null;
		try {

			companyID = (Integer)session.getAttribute("sesCID");
			saBean = (SuperAdminBean) session.getAttribute("sABean");
			loginBean = (LoginBean) session.getAttribute("loginUserBean");
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			//System.out.println("collegeBean  :"+collegeBean.getCollegeName());
			/* System.out.println("collegeBean  :" + collegeBean.getCollegeName() + " : "
					+ loginBean.getCollgBean().getCollegeId()); */
			collegeID = loginBean.getCollgBean().getCollegeId();
		} catch (NullPointerException e) {

			//response.sendRedirect("TimeIntervalPage");
	%>
	<script type="text/javascript">
			
			window.location="timeIntervalPage";
			</script>
	<%
		}

		//System.out.println("college Id:" + loginUser.getCollgBean().getCollegeId());

		AppPropertiesConfig appProperties = new AppPropertiesConfig();
		Properties properties = appProperties.getPropValues();

		String clientLogoLink = properties.getProperty("clientLogoLink");
		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	%>


	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">
		<div class="navbar-inner">

			<!-- user dropdown ends -->
			<jsp:include page="menu_clientDetails.jsp"></jsp:include>
			<!-- theme selector starts -->

		</div>
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">
			<!-- left menu starts -->
			<div class="col-sm-2 col-lg-2">
				<div class="sidebar-nav">
					<div class="nav-canvas">
						<jsp:include page="menu-SA.jsp"></jsp:include>
					</div>
				</div>
			</div>
			<!--/span-->
			<!-- left menu ends -->

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
					<div class="box col-md-5">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> FormLink Form
									Builder
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<!-- put your content here -->
								<form id="nitForm" action="saveForm" method="post"
									modelAttribute="{saveFormData,feeData,lateFeeData}">

									<input id="comId" name="companyBean.id" type="hidden"
										value="<%=companyID%>">
									<table class="table table-striped table-condensed">
										<tr>
											<td colspan="2"><label for="nameinput">Form Name</label>
												<input type="text" name="formName" id="nameinput"
												placeholder="Form Name" required="required"></td>
										</tr>
										<!-- 8Apr work for move to pg -->

										<tr>
											<td colspan="2"><label for="moveToPg">Basic Info
													not Required</label> <!-- Not to use Payment Process? <input type="checkbox" name="form.moveToPg" id="moveToPg"
												placeholder="" ></td> --> <select data-rel="chosen"
												required="required" name="moveToPg"><option
														disabled selected value="">Please Select an
														Option</option>
													<option value="yes">Yes</option>
													<option value="no">No</option>
											</select> &nbsp;
										</tr>

										<tr>
											<td colspan="2"><label for="formResponseUrl">Response
													URL</label> <input type="text" name="formResponseUrl"
												id="formResponseUrl" placeholder="Response URL"></td>

										</tr>


										<tr>
											<td>
												<div class="control-group">
													<label class="control-label" for="selectFee">Select
														Fee</label>

													<div class="controls">

														<select theme="simple" style="width: 100%"
															requiredLabel="required" name="selectedFees"
															data-rel="chosen" id="selectFees" headerKey="-1"
															onchange="showFormBaseAmount()" headerValue="Select Fee">
															<option disabled selected value="">Please Select
																an Option</option>
															<c:forEach items="${fees}" var="fee">
																<option value="<c:out value='${fee.id}'/>"><c:out
																		value='${fee.feeName}' /></option>
															</c:forEach>
														</select> &nbsp;

													</div>
												</div>
											</td>
											<td><button type="button" onclick="showFormFee()"
													class="btn btn-sm btn-info pull-right">Add New Fee</button></td>
										</tr>
										<tr>
											<td><label for="frominput">Form Start Date</label> <input
												id="frominput" type="date" placeholder="Form Start Date"
												name="fromDateStr" required="required"
												onchange="compareDates()"></td>

											<td><label for="toinput">Form End Date</label> <input
												id="toinput" type="date" placeholder="Form End Date"
												required="required" name="toDateStr"
												onchange="compareDates()"></td>

										</tr>
										<tr>
											<td><label for="toinput">Form End Date (With
													Late Fee)</label></td>
											<td><input id="toinput2" type="date"
												placeholder="Form End Date" name="toLateDateStr"
												onchange="compareDates()"></td>
										</tr>
										<tr>
											<td colspan="2"><label hidden="hidden">Disable
													Date Validity</label> <input id="validitychbx" type="hidden">
												<input hidden="hidden" type="text" id="formvalidity"
												name="validityflag" value="1"></td>
										</tr>
										<tr>
											<td>
												<div class="control-group">
													<label class="control-label" for="selectFee">Form
														Life Cycle</label>

													<div class="controls">
														<select onchange="showOptions(this.value)"
															data-rel="chosen" required="required" name="life_cycle">
															<option disabled selected value="">Please Select
																an Option</option>
															<option value="no">Plain Form</option>
															<option value="yes">Multi-Stage Form</option>
														</select> &nbsp;
													</div>
												</div>
											</td>
											<td>Note:- The form life cycle for multi-stage forms
												should be configured after the form has been defined in the
												menu option "Forms Pending For Configuration"</td>
										</tr>
										<tr id="payerDiv" style="display: none">
											<td>
												<div class="control-group">
													<label class="control-label" for="selectPayer">Form
														Payer</label>

													<div class="controls">
														<select theme="simple" list="payers" headerKey=""
															headerValue="Select an Option" listValue="payer_type"
															listKey="payer_id" style="width: 100%" name="payer_type"
															id="selectPayer">
															<option disabled selected value="">Please Select
																an Option</option>
															<c:forEach items="${payers}" var="payer">
																<option value="<c:out value='${payer.payer_id}'/>"><c:out
																		value='${payer.payer_type}' /></option>
															</c:forEach>
														</select> &nbsp;
													</div>
												</div>
											</td>

											<td>
												<!-- <button type="button" onclick="addNewFormTargetToPayer()"
													class="btn btn-sm btn-info pull-right">Add New Form Payer</button> -->
											</td>

										</tr>

									</table>
									<table style="display: none" id="baseAmountDiv">

										<tr>
											<td>
												<div class="control-group">
													<label class="control-label" for="selectFee">Enter
														Base Amount for Fee</label>

													<div id="input-number" class="input-group">
														<input type="number" class="form-control"
															name="feeBaseAmount" value="0" readonly="readonly"
															required="required" id="feeBaseAmount"
															placeholder="Enter Amount in Rupees"> <span
															class="input-group-addon"><button type="button"
																onclick="showFormBuilder()" class="btn btn-info btn-xs">OK</button></span>
													</div>
												</div>
											</td>
											<td></td>

										</tr>
										<tr>
											<td><button id="LateFeeButton" onclick="ToggleLateFee()"
													type="button" class="btn btn-info btn-xs">Configure
													Late Fee</button>
											<td></td>
										</tr>

									</table>
									<table style="display: none" id="LateFeeBox">
										<tr>
											<td>Late Fee Type</td>
											<td><select name="latefeeType"><option>Fixed</option>
													<option>Daily_Update</option>
													<option>Periodic</option>
													<option>Monthly_Fixed</option>
													<option>Monthly_Daily</option>
													<option>Monthly_Periodic</option>
													<option>Monthly_Periodic_Daily</option>
											</select></td>
										</tr>
										<tr>
											<td>Late Fee Amount</td>
											<td><div id="input-number" class="input-group">
													<input type="number" class="form-control" required="false"
														id="latefeeAmount" name="latefeeAmount" value="0"
														placeholder="Enter Amount in Rupees">
												</div></td>
										</tr>
									</table>
									<table style="display: none" id="formBuilderTable">
										<tr>
											<td>Payer Verification Required? <label>Yes <input
													onchange="ShowVerificationOptions(this.value)"
													id="verificationRadioYes" type="radio"
													name="verificationFlag" value="Y">
											</label> <label>No <input
													onchange="ShowVerificationOptions(this.value)"
													id="verificationRadioNo" type="radio"
													name="verificationFlag" checked value="N">
											</label>

											</td>
										</tr>
										<tr style="display: none" id="verificationOptionsDiv">
											<td>Select the Verification Options: <label
												for="aadhaarCheck">Verify by Aadhaar Number</label> <input
												type="checkbox" id="aadhaarCheck" name="isAadhaarVerified"
												value="Y"> <label for="PANCheck">Verify by
													PAN</label> <input type="checkbox" id="PANCheck"
												name="isPANVerified" value="Y"> <label
												for="IFSCCheck">Verify by IFSC</label> <input
												type="checkbox" id="IFSCCheck" name="isIFSCVerified"
												value="Y">
											</td>

										</tr>
										<tr id="formFieldsDiv">
											<td colspan="2">
												<div class="control-group">
													<label class="control-label" for="selectFields">Select
														Form Fields</label>
													<div class="controls">
														<select theme="simple" Style="width: 100%"
															required="required" name="selectedFields"
															onchange="renderPreview(this.value)" id="selectFields"
															multiple="${fields}">
															<!-- <option disabled selected value="">please select any one</option>		 -->
															<c:forEach items="${fields}" var="field">
																<option value='<c:out value="${field.lookup_id}" />'><c:out
																		value="${field.lookup_name}" />:
																	<c:out value="${field.lookup_type}" /> (
																	<c:out value="${field.lookup_subtype}" />)
																</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2"><button type="button"
													onclick="showFormField()" class="btn btn-info btn-sm">Add
													Custom Field</button>

												<button type="button" onclick="uploadOffLineForm()"
													class="btn btn-info btn-sm">Upload OffLine Form
													(Excel Document)</button></td>

										</tr>

										<tr>
											<td colspan="2">
												<div class="btn-group">
													<button type="button" onclick="addPageBreak()"
														class="btn btn-info btn-sm">Add Page Break</button>
													<!-- <button type="button" onclick="uploadInstruction()"
														class="btn btn-info btn-sm">Upload Optional
														Instruction Document</button> -->
												</div>
											</td>
										</tr>
										<tr>
											<td><input name="hasInstructions" id="flagCheckBox"
												type="checkbox" value="yes">If you don't want to use
												payment process.</td>
										</tr>
										<tr>
											<td>
												<button type="submit" onclick="saveForm()"
													class="btn btn-success">Save Form</button>
											</td>
										</tr>
									</table>

									<%-- <s:token/> --%>

								</form>
							</div>
						</div>
					</div>

					<div class="box col-md-7">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Form Preview
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content" id="renderBox">
								<!-- put your content here -->



							</div>
						</div>
					</div>
				</div>
				<!--/row-->
				<button class="btn btn-sm btn-warning"
					onclick='window.location="initBuilder"'>Back</button>

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
						<button type="button" class="close" data-dismiss="modal">\D7</button>
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
		<footer class="row">

			<div style="text-align: center;">

				<a href=""
					onclick="window.open('ContactUs.html','mywindowtitle',
											'width=500,height=550')">Contact
					Us </a> <span> |&nbsp;&nbsp;</span> <a href=""
					onclick="window.open('PrivacyPolicy.html','mywindowtitle',
											'width=500,height=550')">Privacy
					Policy </a> <span> |&nbsp;&nbsp;</span> <a href=""
					onclick="window.open('Terms And Conditions.html','mywindowtitle',
											'width=500,height=550')">Terms
					&amp; Conditions </a> <span> |&nbsp;&nbsp;</span> <a href=""
					onclick="window.open('Disclaimer.html','mywindowtitle',
											'width=500,height=550')">Disclaimer
				</a>

			</div>


		</footer>
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
	<%-- <script src="bower_components/chosen/chosen.jquery.min.js"></script>
	<script src="bower_components/chosen/chosen.jquery.js"></script> --%>
	<script src="js/chosen.jquery.min.js"></script>
	<script src="js/chosen.jquery.js"></script>
	<script src="select2/select2.min.js"></script>
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
		var pageBreakCounter=-1;
		var pageBreakArray = new Array;
		var seqArray= {};
		var mandArray = {};
		var mandNameMobileEmailAmount={};
		var mandName="";
		var mandMobileNumber="";
		var mandEmail="";
		var mandAmount="";
		var values2 = {};
		var values = {};
		var changeOrder = 0;
		var saveFlag = 0;
		var seqcounter=1;
		
		function clickForPayment() {
			
		}
		
		function GetForm(x) {
			if (x == "1") {
				document.getElementById("mainForm1").style.display = "block";
				$("#fieldSelect").chosen();
			}

		}
		$('#nitForm').submit(function(event) {//Code to use HTML5 form validation but prevent it from submitting
			event.preventDefault();
			saveFlag = 1;
			renderPreview(1);
			var conf = confirm("Are you sure you want to save this form?");
			if (conf) {
				document.getElementById("nitForm").submit();
			}
		});

		function Reset() {
			document.getElementById("nitForm").reset();
			document.getElementById("customTags").innerHTML = " ";
		}

		function showFormFee() {
			window.open("formFee", "Preview", "width=640,height=480");
		}
		function showFormField() {
		
			//?fieldarray=" + selected1 +
			var cid=<%=collegeID%>;
			//alert("college id is :::: "+cid);
			window.open("formCustomField?cid="+cid, "Preview",
					"width=640,height=480");
		}
		function addPageBreak() {
			window.open("formPageBreak", "Preview",
					"width=640,height=480");
		}		
		
		function addNewFormTargetToPayer() {
			window.open("addNewFormTarget", "Preview",
					"width=640,height=480");
		}
		function showFormBaseAmount() {
			document.getElementById("baseAmountDiv").style.display = "block";
		}

		function AddToArray(value, name, id) {
			value = value.split(",").join("");
			value = value.split("`").join("");
			value = value.split("=").join("");
			values[id] = id + "`" + name + "=" + value;
			/* alert(JSON.stringify(values)); */

		}
		function AddToOrder(id, order) {

			var orderArr = id + "~" + order;
			changeOrder = 1;
			renderPreview(orderArr);
			//alert(JSON.stringify(orderArr)); 

		}
		
		var excelColumnName='';
		function AddToValidateField(value){
			
			//alert(value+"excelColumnName>>>"+excelColumnName);
			excelColumnName =excelColumnName+value+",";
			//alert("ccccc>>>>>"+excelColumnName)
		}
		
		var flag='';
		function EditFields(value){			
			alert("value is :: "+value);
			if(""!=value && null!=value){
				flag=flag+value+",";
				alert("Editable value is :: "+flag);
			}
			else{
				alert("Please select any one or two validation fields.");
				return false;
			}
			
		}
		
		function renderPreview(x) {
			//alert("Start of renderPreview(), vakue of x is ::::: "+x);
			//alert("columnName is in render Preview() of JS ::::: "+columnName);
			var fieldOrder = "-1";
			var lastCall = "0";
			if (changeOrder == 1) {
				fieldOrder = x;
			}
			if (saveFlag == 1) {
				lastCall = "Y";
			}
			var select1 = document.getElementById("selectFields");
			//alert($("selectFields values >> "+"#selectFields").select2("val"));
			//alert($("selectFields data >> "+"#selectFields").select2("data"));
			var sel2data=$("#selectFields").select2("data");
			//alert(JSON.stringify(sel2data));
			//seqArray.push(seqcounter+"`"+x);
			var selected1 = new Array;
			//for(var)
			/*  for (var i = 0; i < select1.length; i++) {
				if (select1.options[i].selected)
					if(select1.options[i].value!='PageBreak'){
						selected1.push(select1.options[i].value);
					}
			}  */
		
			  for (var i = 0; i < sel2data.length; i++) {
				//alert(sel2data[i].id);
				   if(sel2data[i].text!='PageBreak'){
					selected1.push(sel2data[i].id); 
		}  }
			
			// Adding to selected1 array explicitly the Page Breaks Chosen, so to hamdle this even as they do not appear in the listbox
			for (var j = 0; j < pageBreakArray.length; j++) {				
				// Contingent on the definition of the PageBreak ids starting from -1 and decrementing further down towards the negative	
				selected1.push((-1-j));
			}
			
			var validateField=excelColumnName;
			
			var mandNameMNumber=new Array;
			for ( var value in mandNameMobileEmailAmount) {
				mandNameMNumber.push(mandNameMobileEmailAmount[value]);
			}
			
			var mandaArray = new Array;
			for ( var value in mandArray) {
				mandaArray.push(mandArray[value]);
			}
			var pageTitelsString = "";
			for(i=0;i<pageBreakArray.length;i++){
				pageTitelsString=pageTitelsString+pageBreakArray[i]+"~";
			}
			//alert(JSON.stringify(selected1));
			//alert(JSON.stringify(mandaArray));
			//alert(JSON.stringify(mandNameMNumber));
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
					document.getElementById("renderBox").innerHTML = xhttp.responseText;
					changeOrder = 0;
					saveFlag = 0;
				}
			}
			
			 /* alert("value of selected1, >>> fieldarray=" + selected1
					+ "&feeAmount=" + baseAmount + "&mandatoryList="
					+ mandaArray + "&mandNameMNumber="+mandNameMNumber+"&orderchange=" + fieldOrder + "&lastCall="
					+ lastCall + "&definedFieldValues="+pageTitelsString + "&validateFields="+validateField); */ 
			
			 xhttp.open("GET", "renderPreview?fieldarray=" + selected1
					+ "&feeAmount=" + baseAmount + "&mandatoryList="
					+ mandaArray + "&mandNameMNumber="+mandNameMNumber+"&orderchange=" + fieldOrder + "&lastCall="
					+ lastCall + "&definedFieldValues="+ pageTitelsString + "&validateFields="+validateField, true);
			xhttp.send();

		}
		var baseAmount = "";
		function showFormBuilder() {
			baseAmount = document.getElementById("feeBaseAmount").value;
			if (baseAmount == "") {
				alert("Please Enter the Base Amount for the Fee");
				return;
			} else {
				document.getElementById("formBuilderTable").style.display = "block";
				//$("#selectFields").chosen();	
				 $("#selectFields").select2();
				
			}
		}

		function AddToArray2() {
			var value = document.getElementById("optionInput").value;
			var amount = document.getElementById("optionAmount").value;
			if (amount == "") {
				amount = "0";
			}
			value = value.split(",").join("");
			amount = amount.split(",").join("");
			values2[value] = value + "=" + amount;
			/* alert(JSON.stringify(values2));  */
			var presentTags = document.getElementById("tagDiv").innerHTML;
			document.getElementById("tagDiv").innerHTML = presentTags
					+ '<br> <span id="'+value+'">'
					+ value
					+ ' for Rs.'
					+ amount
					+ '  <a title="Remove This Option" href="#"><i id="'
					+ value
					+ '" onclick="RemoveFromValues2(this.id)" class="glyphicon glyphicon-remove"> </i></a></span>';

			document.getElementById("optionInput").value = "";
			document.getElementById("optionAmount").value = "";

		}

		function RemoveFromValues2(value) {
			delete values2[value];
			var parent = document.getElementById("tagDiv");
			var child = document.getElementById(value);
			parent.removeChild(child);

		}

		function saveValues(id) {
			var id = document.getElementById("optionId").value;
			var dataArray = new Array;
			for ( var value in values2) {
				dataArray.push(values2[value]);
			}
			if (dataArray == "") {
				alert("Please Enter Atleast One Option");
				return;
			}
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
					document.getElementById("renderBox").innerHTML = xhttp.responseText;
				}
			}
			xhttp.open("GET", "saveOptions?optionArray=" + dataArray
					+ "&fieldId=" + id, true);
			xhttp.send();
			renderPreview(1);
			values2 = {};
		}

		function AddToMandatoryArray(x) {
			//alert("id of mandatoryField is "+x);
			var box = document.getElementById(x);
			if (box.checked) {
				mandArray[x] = x;
			} else {
				delete mandArray[x];
			}
			// alert(JSON.stringify(mandArray)); 
		}

		
		// use for Payer Name for PG
		function AddToValidFieldName(x) {
			
			var mand=x;
			//alert("id of mandatoryField is :::::: 1 ::::: "+mand);
			var rates = document.getElementsByName('rcName');
			
			for(var i = 0; i < rates.length; i++){
				//alert("in for "+i);
				if(rates[i].checked){
			    	//alert("in if");
			        mandNameMobileEmailAmount[x] = x+rates[i].value;
			    }
			}
	     // alert(JSON.stringify(mandNameMobileEmailAmount)); 
		}
		
		// use for Payer Mobile for PG
		function AddToValidFieldMobile(x) {
			
			var mand=x;
			//alert("id of mandatoryField is :::::: 1 ::::: "+mand);
			var rates = document.getElementsByName('rcMobile');
			var rate_value;
			for(var i = 0; i < rates.length; i++){
				//alert("in for "+i);
				if(rates[i].checked){
			    	//alert("in if");
			        mandNameMobileEmailAmount[x] = x+rates[i].value;
			    }
			}
	       
	       // alert(JSON.stringify(mandNameMobileEmailAmount)); 
		}
		
		// use for Payer Email for PG
		function AddToValidFieldEmail(x) {
			
			var mand=x;
			//alert("id of mandatoryField is :::::: 1 ::::: "+mand);
			var rates = document.getElementsByName('rcEmail');
			var rate_value;
			for(var i = 0; i < rates.length; i++){
				//alert("in for "+i);
				if(rates[i].checked){
			    	//alert("in if");
			        mandNameMobileEmailAmount[x] = x+rates[i].value;
			    }
			}
	        
	       // alert(JSON.stringify(mandNameMobileEmailAmount)); 
		}
		
		// use for Payer Amount for PG
		function AddToValidFieldAmount(x) {
			
			var mand=x;
			//alert("id of mandatoryField is :::::: 1 ::::: "+mand);
			var rates = document.getElementsByName('rcAmount');
			var rate_value;
			for(var i = 0; i < rates.length; i++){
				//alert("in for "+i);
				if(rates[i].checked){
			    	//alert("in if");
			        mandNameMobileEmailAmount[x] = x+rates[i].value;
			    }
			}
	        
	        //alert(JSON.stringify(mandNameMobileEmailAmount)); 
		}
		
		function ToggleLateFee() {
			var e = document.getElementById("LateFeeBox");
			var btn = document.getElementById("LateFeeButton");
			if (e.style.display == 'block') {
				e.style.display = 'none';
				document.getElementById("feeLateAmount").value = "0";
				document.getElementById("feeLateAmount").required = false;
				btn.innerHTML = "Configure Late Fee";
			} else {
				e.style.display = 'block';
				document.getElementById("feeLateAmount").required = "required";
				document.getElementById("feeLateAmount").value = "";
				btn.innerHTML = "Remove Late Fee";
			}
		}

		function compareDates() {
			var fromdate = document.getElementById("frominput").value;
			var todate1 = document.getElementById("toinput").value;
			var todate2 = document.getElementById("toinput2").value;
			var datefrom = new Date(fromdate);
			var dateTo1 = new Date(todate1);
			var dateTo2 = new Date(todate2);
			if (datefrom > dateTo1) {
				alert("Form Start Date should be before Form End Date!");
				document.getElementById("toinput").value = "";
			}
			if (dateTo1 > dateTo2) {
				//alert("Form End Date w/o Penalty should be before Form End Date with Penalty!");
				document.getElementById("toinput2").value = "";
			} 
		}
		
		
		
		function ToggleDateInput() {
			var checkbx = document.getElementById("validitychbx");
			if (checkbx.checked) {
				//alert("checked");'
				document.getElementById("formvalidity").value = "0";
				document.getElementById("frominput").disabled = "disabled";
				document.getElementById("toinput").disabled = "disabled";
				document.getElementById("toinput2").disabled = "disabled";
				document.getElementById("LateFeeButton").disabled = "hidden";
				document.getElementById("frominput").required = false;
				document.getElementById("toinput").required = false;
				document.getElementById("toinput2").required = false;
			} else {
				//alert("not checked");
				document.getElementById("formvalidity").value = "1";
				document.getElementById("frominput").disabled = false;
				document.getElementById("toinput").disabled = false;
				document.getElementById("toinput2").disabled = false;
				document.getElementById("LateFeeButton").disabled = false;
				document.getElementById("frominput").required = "required";
				document.getElementById("toinput").required = "required";
				document.getElementById("toinput2").required = "required";

			}
		}
		function getFreshFields() {

			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
					document.getElementById("formFieldsDiv").innerHTML = xhttp.responseText;
					$("#selectFields").chosen();
				}
			}
			xhttp.open("GET", "getFreshFields", true);
			xhttp.send();

		}

		function getChosen() {
			//alert("Chosing");
			$(".selectFields").chosen();
			//alert("Chosed");
		}

		function ExecuteFun() {			
			setTimeout(function() {
				ExecuteFun();
				//location.reload();
				var id =
	<%=collegeID%>
		;

				if (id == '' || id == null) {
					window.location = "timeIntervalPage";
				}

			}, 12000);
		}

		function showOptions(opt) {
			//alert(opt);
			if (opt == "no") {
				//alert(opt);
				document.getElementById("payerDiv").style.display = "table-row";

				document.getElementById("selectPayer").required = "required";
				
				
				
				$("#selectPayer").chosen();
				
			} else {
				document.getElementById("payerDiv").style.display = "none";

				document.getElementById("selectPayer").required = false;
				
			}
		}

		function ShowVerificationOptions(selVal) {
			if (document.getElementById("verificationRadioYes").checked == true) {
				document.getElementById("verificationOptionsDiv").style.display="table-row";

			} else if (document.getElementById("verificationRadioNo").checked == true) {
				document.getElementById("verificationOptionsDiv").style.display="none";
			}
		}

		function uploadInstruction() {
			window.open("FormInstructionUplo", "Preview",
					"width=640,height=480");
		}
		function uploadOffLineForm() {
			window.open("offLineFormUpload", "Preview",
					"width=640,height=480");
		}
		
	</script>
</body>
</html>