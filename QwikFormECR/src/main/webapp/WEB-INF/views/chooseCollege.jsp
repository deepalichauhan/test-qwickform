<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
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

<body onload="makeGetRequest()">
	<!-- topbar starts -->


	<%
		CollegeBean collegeBean = new CollegeBean();
		Integer bid = null;

		try {
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			bid = (Integer) session.getAttribute("BankId");
		} catch (NullPointerException e) {
			System.out.print("JSP Nullpointer Exception...");
	%>
	<script type="text/javascript">
	window.location="timeIntervalPage";
		</script>
	<%
		}
		AppPropertiesConfig quickCollectProperties = new AppPropertiesConfig();
		Properties properties = quickCollectProperties.getPropValues();

		String qFormsIP = properties.getProperty("qFormsIP");
		String clientLogoLink = properties.getProperty("clientLogoLink");
		/* CollegeBean bean=(CollegeBean)session.getAttribute("filteredCollegeBean"); */

		/* String collegeCode="";
		 session.setAttribute("collegeCode", collegeCode); */
	%>
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>

			<div class="btn-group pull-right">
				
			</div>
			<!-- user dropdown ends -->

			<!-- theme selector starts -->

			<a class="navbar-brand" href="#"> <img
				src="<%=collegeBean.getCollegeLogo()%>"></a> <a
				class="navbar-brand" href="<%=clientLogoLink%>"><span> <%=collegeBean.getCollegeName()%>,<br><%=collegeBean.getState()%>
			</span></a> <span style="margin-left: 10%;"></span> <img alt=""
				src="<%=collegeBean.getBankDetailsOTM().getBankLogo()%>"
				style="width: 300px; height: 80px;">

			


		</div>
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">
			<div align="center">
				<!-- left menu starts -->
				<!-- <div class="col-sm-2 col-lg-2">
				<div class="sidebar-nav">
					<div class="nav-canvas">

					</div>
				</div>
			</div> -->
				<!--/span-->
				<!-- left menu ends -->

				<noscript>
					<div class="alert alert-block col-md-12">
						<h4 class="alert-heading">Warning!</h4>

						<p>
							You need to have <a
								href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a>
							enabled to use this site.
						</p>
					</div>
				</noscript>

				<!-- content starts -->




				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i>Quick Collect
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>

								</div>
							</div>
							<div class="box-content">

								<table>
									<tr>
										<td colspan="2">
											<!--style="display: none;  -->
											<div class="control-group">
												<label class="control-label" style="display: none;"
													selectCategoryLabel"  for="selectError">State of
													Corporate/Institution</label>
										</td>
										<td>
											<div class="controls">
												<!-- ,getValue(this.value) -->
												<select id="paymentCategory" style="display: none;"
													makeGetRequest1(this.value)" name="fd.paymentCat"
													id="selectInst" data-rel="chosen" required="required">
													<option selected="selected" disabled="disabled">Select
														An Option</option>
													<option value="Andhra Pradesh">Andhra Pradesh</option>
													<option value="Arunachal Pradesh">Arunachal
														Pradesh</option>
													<option value="Assam">Assam</option>
													<option value="Bihar">Bihar</option>
													<option value="Chhattisgarh">Chhattisgarh</option>
													<option value="Goa">Goa</option>
													<option value="Gujarat">Gujarat</option>
													<option value="Haryana">Haryana</option>
													<option value="Himachal Pradesh">Himachal Pradesh</option>
													<option value="Jammu & Kashmir">Jammu & Kashmir</option>
													<option value="Jharkhand">Jharkhand</option>
													<option value="Karnataka">Karnataka</option>
													<option value="Kerala">Kerala</option>
													<option value="Madhya Pradesh">Madhya Pradesh</option>
													<option value="Maharashtra">Maharashtra</option>
													<option value="Manipur">Manipur</option>
													<option value="Meghalaya">Meghalaya</option>
													<option value="Mizoram">Mizoram</option>
													<option value="Nagaland">Nagaland</option>
													<option value="Odisha">Odisha (Orissa)</option>
													<option value="Punjab">Punjab</option>
													<option value="Rajasthan">Rajasthan</option>
													<option value="Sikkim">Sikkim</option>
													<option value="Tamil Nadu">Tamil Nadu</option>
													<option value="Telangan">Telangan</option>
													<option value="Tripura">Tripura</option>
													<option value="Uttar Pradesh">Uttar Pradesh</option>
													<option value="Uttarakhand">Uttarakhand</option>
													<option value="West Bengal">West Bengal</option>
													<option value="Union Teritorry">Union Teritorry</option>



												</select>
												<td colspan="2">
													<div class="control-group">
														<label class="control-label" for="selectError"> My
															College Code </label>
														<%-- <input type="hidden" id="getColgCodeFromDB" name="collegeCode" value="<%=bean.getCollegeCode() %>"> --%>
														<input type="text" id="searchCode" name="collegeCode"
															placeholder="Enter College Code">
														<button class="btn btn-primary" type="button"
															onclick="searchCollegeCode()">GO</button>
														<!-- onclick="ajaxForm()" searchCollegeCode() -->
													</div>
											</div>



										</td>


										<!-- <label class="control-label" for="selectError">Select
														Corporate/Institute</label> -->
										</td>
										<td>
											<!-- ,getValue(this.value)  -->
										<td colspan="2">
											<div>
												<label class="control-label" for="selectError">Select
													Fee To Pay</label>
										</td>
										<td>

											<div class="controls">
												<select id="codeOfCollege"
													onchange="makeGetRequest(this.value)" name="selectInst"
													id="selectInst" data-rel="chosen" required="required">

													<option selected="selected" disabled="disabled">Select
														An Option</option>
													<c:forEach var="bean" items="${filteredCollegeList}"
														varStatus="count">
														<option value="${bean.collegeId}">ROM Fees
															-2015-16(without fine)</option>
														<!-- <c:out value="${bean.collegeName}"></c:out> -->

													</c:forEach>


												</select>

												
											</div>
											</div>
										</td>
										<td><div id="here"></div></td>
									</tr>
									<tr></tr>
								</table>

								<div id="selected_College"></div>
								<td><div id="isHiddenPayButton" style="display: none;">
										<button type="button" id="submit_button"
											class="btn btn-success">Pay</button>
									</div></td>
								<td><button class="btn btn-default" style="display: none;"Reset()">
										Reset</button></td>

								<script
									src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

								<!-- library for cookie management -->
								<script src="js/jquery.cookie.js"></script>
								<!-- calender plugin -->
								<script src='bower_components/moment/min/moment.min.js'></script>
								<script
									src='bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
								<!-- data table plugin -->
								<script src='js/jquery.dataTables.min.js'></script>

								<!-- select or dropdown enhancer -->
								<script src="bower_components/chosen/chosen.jquery.min.js"></script>
								<!-- plugin for gallery image view -->
								<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
								<!-- notification plugin -->
								<script src="js/jquery.noty.js"></script>
								<!-- library for making tables responsive -->
								<script
									src="bower_components/responsive-tables/responsive-tables.js"></script>
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


								<script type="text/javascript">

function createRequestObject() {
    var tmpXmlHttpObject;
    
    //depending on what the browser supports, use the right way to create the XMLHttpRequest object
    if (window.XMLHttpRequest) { 
        // Mozilla, Safari would use this method ...
        tmpXmlHttpObject = new XMLHttpRequest();
	
    } else if (window.ActiveXObject) { 
        // IE would use this method ...
        tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
    }
    
    return tmpXmlHttpObject;
}

//call the above function to create the XMLHttpRequest object
var http = createRequestObject();

function choosePaymentPage(wordId) {
	 var wordId=wordId;
	 var ip="<%=qFormsIP%>";
	if(wordId==1){
		 
		window.location=ip+"demoForm4.jsp";
		/* http.open('get', 'paymentFormOfCHSE1.jsp'); */
		/*  $("#isHiddenPayButton").show(); */
	 }else if(wordId==2){
		 http.open('get', ip+'demoForm2.jsp');
		/*  $("#isHiddenPayButton").show(); */
	 }else if(wordId==3 ){
		 http.open('get', ip+'demoForm3.jsp');
		 /* $("#isHiddenPayButton").show(); */
	 }else if(wordId=="College"){
		 http.open('get', ip+'paymentFormCHSE2.jsp');
		/*  $("#isHiddenPayButton").show(); */
	 }	 else if(wordId==4 ){
		 http.open('get', ip+'paymentFormCHSE2.jsp');
		/*  $("#isHiddenPayButton").show(); */
	 }else
		 document.getElementById('paymentCategory').disabled = 'disabled';
		  document.getElementById('selectCategoryLabel').style.visibility = "visible";
		  document.getElementById('selectCategoryLabel').style.visibility = "block";
		  document.getElementById('submit_button').style.visibility="visible";
	
   http.onreadystatechange = processResponse;
   http.send();
}


function makeGetRequest(wordId) {
	
	
	 var collegePage;
	 var wordId=wordId;
	 var bid=<%=bid%>;
	 var ip="<%=qFormsIP%>";
	if(wordId==1 && bid==1 ){
		 /* collegePage="index.jsp"; */
	 window.location=ip+"getCollegeDetails?cid=" + wordId;
	 /* window.location="demoForm4.jsp?cid=" + wordId; */
		 /* http.open('get', 'nitjFeesPaymentForm.jsp?cid=' + wordId); */
		
		/*  $("#isHiddenPayButton").show(); */
	 }else if(wordId==1 && bid==2 ){
		 /* collegePage="index.jsp"; */
		 window.location=ip+"getCollegeDetails?cid=" + wordId;
		 /* window.location="demoForm4.jsp?cid=" + wordId; */
			 /* http.open('get', 'nitjFeesPaymentForm.jsp?cid=' + wordId); */
			
			/*  $("#isHiddenPayButton").show(); */
		 }else if(wordId==1 && bid==3 ){
			 /* collegePage="index.jsp"; */
			 window.location=ip+"getCollegeDetails?cid=" + wordId;
			 /* window.location="demoForm4.jsp?cid=" + wordId; */
				 /* http.open('get', 'nitjFeesPaymentForm.jsp?cid=' + wordId); */
				
				/*  $("#isHiddenPayButton").show(); */
			 }else if(wordId==2 && bid==1 ){
		 /* collegePage="index.jsp"; */
		 window.location=ip+"getCollegeDetails?cid=" + wordId;
		 /* window.location="demoForm4.jsp?cid=" + wordId; */
			 /* http.open('get', 'nitjFeesPaymentForm.jsp?cid=' + wordId); */
			
			/*  $("#isHiddenPayButton").show(); */
		 }else  if(wordId==2 && bid==2 ){
		 window.location=ip+"nitjFeesPaymentForm.jsp?cid=" + wordId;
		
		 /* http.open('get', 'choosePaymentForm.jsp?cid=' + wordId); */
		/*   $("#isHiddenPayButton").show(); */
		
	 }else if(wordId=="College" && bid==1){
		 window.location=ip+"demoForm4.jsp?cid=" + wordId;
		
		 /* http.open('get', 'choosePaymentForm.jsp?cid=' + wordId); */
		/*   $("#isHiddenPayButton").show(); */
		
	 }
	 
	 else if(wordId==3 && bid==3 ){
		 
		 window.location=ip+"noidaPage.jsp?cid=" + wordId;
		 
		/*  http.open('get', 'noidaPage.jsp?cid=' + wordId); */
		/*  $("#isHiddenPayButton").show(); */
	 }else
		 
		 /* collegePage="nitjFeesPaymentForm.jsp"; */
		 /* http.open('get', 'nitjFeesPaymentForm.jsp?id=' + wordId); */
		 document.getElementById('paymentCategory').disabled = 'disabled';
		  document.getElementById('selectCategoryLabel').style.visibility = "visible";
		  document.getElementById('selectCategoryLabel').style.visibility = "block";
		  document.getElementById('submit_button').style.visibility="visible";
	
		   
	 
	
	
    //make a connection to the server ... specifying that you intend to make a GET request 
    //to the server. Specifiy the page name and the URL parameters to send
   /*  http.open('get', 'collegePage?id=' + wordId); */
	
    //assign a handler for the response
    http.onreadystatechange = processResponse;
	
    //actually send the request to the server
    http.send();
}

function processResponse() {
    //check if the response has been received from the server
    if(http.readyState == 4){
	
        //read and assign the response from the server
        var response = http.responseText;
		
        //do additional parsing of the response, if needed
		
        //in this case simply assign the response to the contents of the <div> on the page. 
        document.getElementById('selected_College').innerHTML = response;
		
        //If the server returned an error message like a 404 error, that message would be shown within the div tag!!. 
        //So it may be worth doing some basic error before setting the contents of the <div>
    }
}
var fee = 0;
var totfee = 0;
var hostel = 0;
var bus = 0;
var hostelfee = 0;
var busfee = 0;
function GetFees(x) {
	//alert("testing fee");
	/* document.getElementById("nitForm").reset(); */
	if (x == "BT3" || x == "MT3GEN" || x == "MB14GEN") {
		fee = 42450;
		hostel = 2500;
		bus = 1800;
	}
	if (x == "BT5" || x == "BT7") {
		fee = 24950;
		hostel = 2500;
		bus = 1800;
	}
	if (x == "MT15SC" || x == "MB15SC" || x == "MS15SC"
			|| x == "PD15SCFT" || x == "PD15SCPT") {
		fee = 12550;
		hostel = 2500;
		bus = 1800;
	}
	if (x == "MS14GEN" || x == "PDGEN") {
		fee = 14950;
		hostel = 2500;
		bus = 1800;
	}
	if (x == "MT14SC" || x == "MB14SC" || x == "MS14SC"
			|| x == "MT12SC" || x == "MT14SC") {
		fee = 7450;
		hostel = 2500;
		bus = 1800;
	}
	if (x == "MT12GENPT") {
		fee = 17450;
	}
	if (x == "MT14GENPT") {
		fee = 27450;
	}
	if (x == "BT1" || x == "MT15GEN" || x == "MB15GEN") {
		fee = 47550;
		hostel = 2500;
		bus = 1800;
	}
	if (x == "MS15GEN" || x == "PD15GENFT" || x == "PD15GENPT") {
		fee = 20050;
		hostel = 2500;
		bus = 1800;
	}
	document.getElementById("fee").value = fee;
//	alert("fee"+fee);
	//document.getElementById("total").value = fee;
	document.getElementById("total").value = fee;
	document.getElementById("hostelfee").value = 0;
	document.getElementById("busfee").value = 0;
	totfee = fee;

}

function TotalFee(y) {
	//	alert("In TotalFee ");
		if (y == "HostelYes") {
			hostelfee = hostel;
		}
		if (y == "HostelNo") {
			hostelfee = 0;
		}
		if (y == "BusYes") {
			busfee = bus;
		}
		if (y == "BusNo") {
			busfee = 0;
		}
		document.getElementById("hostelfee").value = hostelfee;
		document.getElementById("busfee").value = busfee;
		document.getElementById("total").value = fee + busfee + hostelfee;
	}
var values = {};

function AddToArray(value, name, id) {
	value = value.split(",").join("");
	value = value.split("`").join("");
	value = value.split("=").join("");
	values[id] = id + "`" + name + "=" + value;
	var total1=document.getElementById("total1").value; 
	var id1="18";
	var name1="Total Amount";
	values[id1] = id1 + "`" + name1 + "=" + total1;
	var branch1=document.getElementById("55").value;
	values[19] = 19 + "`" + "Branch" + "=" + branch1;
	
	/* alert(JSON.stringify(values)); */

}

function formSubmit() {
	
	/*  var inst_id = document.getElementById("1").value;
	var fee_id = document.getElementById("7").value;  
*/

	
	var dataArray = new Array;
	for ( var value in values) {
		dataArray.push(values[value]);
	}
	var argument = "values=" + dataArray;/*  + "&instId=" + inst_id
			+ "&feeId=" + fee_id;  */
	window.location = "processForm?"+argument;
			


}
 $("#submit_button").click(function(){ 
	 
	 
	 var emailI=$("#224").val();
	 var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	 var mobNum= $("#16").val();
	 var patternMobNum = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;
	 /*  var patternSem = /^\[0-9]+$/;
		 var sem=$("#6").val();
			 */ var rollN=$("#2").val();
			
			  if ($("#1").val() == ""&&$("#222").val() == ""&&$("#223").val() == ""&&$("#4").val() == ""&&$("#55").val() == ""&&$("#77").val() == ""&&$("#88").val() == ""&&$("#13").val() == ""&&$("#14").val() == ""){
			    alert('please fill the required field')
			    return false;
			  } /* else if ($("#6").val() == ""||sem.length != 1 || sem.match(patternSem )){
				    alert('please fill the vaild Semester')
				    return false;
				  } */
		 else if ($("#2").val() == ""){
			    alert('please fill the vaild Roll Number')
			    return false;
			  }
			  
			  
			  else if ($("#15").val() == ""){
			    alert('please fill the required field')
			    return false;
			  }
			  else if ($("#16").val() == ""|| mobNum.length != 10 || !mobNum.match(patternMobNum) ){
				    alert('please fill the valid Mobile Number')
				    return false;
				  }
			  else if (!emailI.match(emailReg)||$("#224").val() == ""){
				    alert('please fill the Email Id')
				    return false;
				  }
			  else
				  
				  formSubmit();
			   
			}
	 );
 function viewHistory() {
	 var ip="<%=qFormsIP%>";
		window
				.open("payer-History.jsp", "Preview",
						"width=1024,height=768");
	}
 
 function searchCollegeCode(){
	 var ip="<%=qFormsIP%>
									";
										var clgCode = document
												.getElementById("searchCode").value;

										window.location = ip
												+ "searchCollegeBasedOnCode?clgCode="
												+ clgCode;

										/*  ajaxForm(); */

									}

									function ajaxForm() {
										var clgCode = document
												.getElementById("searchCode").value;

										var xhttp = new XMLHttpRequest();
										xhttp.onreadystatechange = function() {

											if (xhttp.readyState == 4
													&& xhttp.status == 200) {
												document.getElementById("here").innerHTML = xhttp.responseText;
											}

										};

										xhttp.open("GET",
												"searchCollegeBasedOnCode?clgCode="
														+ clgCode, true);
										xhttp.send();

									}

									function GetFee1(x) {
										var fee = document
												.getElementById("total1");
										var fee2 = document
												.getElementById("fee1");
										if (x == "BT") {
											fee.value = "7894";
											fee2.value = "7894";
										}
										if (x == "CE") {
											fee.value = "4594";
											fee2.value = "4594";
										}
										if (x == "2250") {
											fee.value = "2250";
											fee2.value = "2250";
										}

										if (x == "2750") {
											fee.value = "2750";
											fee2.value = "2750";
										}

									}
								</script>
</body>
</html>