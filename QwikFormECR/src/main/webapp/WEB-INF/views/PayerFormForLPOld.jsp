<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.util.Base64"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>QwikForms Form Old</title>

<link href="css/docs.min.css" rel="stylesheet" type="text/css">
<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="css/wizard.css" rel="stylesheet" />
<link href="css/style-tabbs.css" rel="stylesheet">
<link href="css/style-new.css" rel="stylesheet">
<link rel="shortcut icon" href="img/favicon.ico">
<!--<script src="js/gallery.js"></script> -->

<style>
				.t1{
					background-image: url(images/banneres.jpg);
					margin: 0px;
					padding: 0px;
			
				}
</style>

<%
	Integer payeeformIdQC = (Integer) session.getAttribute("currentFormId");
	Integer sesBid = null, sesCid = null;
	String formId=null;
	
	String bid=null,cid=null;
	Integer currentFormId = null;
	String formInstanceId = null;
	String payeeProfile=null;
	String captchaValue=null;
	Integer optionsFieldsCount = 0;
	CollegeBean collegeBean = new CollegeBean();
	Logger log = LogManager.getLogger("Payer Form Revival");
	AppPropertiesConfig appProperties = new AppPropertiesConfig(); 
	Properties properties = appProperties.getPropValues(); 

	String cidForMaxFilledSeat1 = properties.getProperty("cidForMaxFilledSeat1"); 
	
	
	String clientLogoLink = properties.getProperty("clientLogoLink");
	String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	
	
	SampleFormBean sfb = (SampleFormBean) session.getAttribute("sesCurrentFormData");
	if (null != sfb) {
		log.info("form bean in session found, invalidating it now");
		session.removeAttribute("sesCurrentFormData");
	} else {
		log.info("no form bean in session found");
	}
	
	int pageCtr = 0;
	try {
		formId=(String)request.getParameter("formid");
		bid=(String)request.getParameter("bid");
		cid=(String)request.getParameter("cid");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		
		payeeProfile=(String)request.getParameter("PayeeProfile");
		captchaValue=(String)session.getAttribute("genAlphaNum");
		sesBid = Integer.parseInt(bid);
		sesCid = Integer.parseInt(cid);
		currentFormId = (Integer) session.getAttribute("currentFormId");
		formInstanceId = (String) session.getAttribute("formInstanceId");
		session.setAttribute("captchaValue", captchaValue);
		System.out.println("FormId: PayerFormRevival.jsp is:" + formId);
		System.out.println("sesBid: PayerFormRevival.jsp is:" + sesBid+" ,,,,,,, " +bid);
		System.out.println("sesCid: PayerFormRevival.jsp is:" + sesCid+" ,,,,,,, "+cid);
		System.out.println("payeeProfile: PayerFormRevival.jsp is:" + payeeProfile);
		System.out.println("currentFormId: PayerFormRevival.jsp is:" + currentFormId);
		System.out.println("formInstanceId: PayerFormRevival.jsp is:" + formInstanceId);
		System.out.println("captchaValue: PayerFormRevival.jsp is:" + captchaValue);
		System.out.println("cidForMaxFilledSeat1: PayerFormRevival.jsp is:" + cidForMaxFilledSeat1);
		optionsFieldsCount = (Integer) request.getAttribute("feeFieldCount");
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

	String usercookie = null;
	String sessionID = null;
	String dispchar = "display:none";
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("user"))
				usercookie = cookie.getValue();
			if (cookie.getName().equals("JSESSIONID"))
				sessionID = cookie.getValue();
		}
	} else {
		sessionID = session.getId();
	}
%>
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

</head>
<body>
	


	<script type="text/javascript">

	var values = {};
	


function AddToArray(value, name, id,order) {
	//alert("value : "+value+" : name : "+name+" : id : "+id+" : order : ");
	value = value.split(",").join("");
	value = value.split("`").join("");
	value = value.split("=").join("");
//	values[id] = id + "`" + name + "=" + value+"$"+order;
	values[id] = id + "~" + name + "='" + value+"'$"+order;
	//alert(JSON.stringify(values)); 

}		

function ValidateSubmit(id) {
	//alert("use validatesubmit function");
	var formId= id;
	var cid=<%=cid%>;
	var cidForMaxFilledSeat=<%=cidForMaxFilledSeat1%>;
	var element = document.getElementById('captId').value;
	alert(element);
	//alert("formId is :::: "+formId);
	//var globalTamacha = 0;
	
	var dataArray = new Array;
	for ( var value in values) {
		dataArray.push(values[value]);
	}
	var argument = "values=" + dataArray;
	
	/* var argument = "values=" + dataArray + "&rcname=" + rcname
	+ "&rcdob=" + rcdob + "&rccontact=" + rccontact + "&rcPayerID=" + rcPayerID
	+ "&rcemail=" + rcemail + "&rcStartDate=" + rcStartDate
	+ "&rcEndDate=" + rcEndDate + "&payeeformIdQC="
	+
	payeeformIdQC+"&rccode="+rccode + "&submitShot="+submitShot; */
	
	
    //alert("argument value in array is ::: "+argument);
    var retValue = "true";
    if(argument==null){
    	//alert("it is in if block with blank arguments");
	 retValue = "true";
    }
	 /* var n = argument.indexOf('=');
     var result = argument.substring(n + 1);
     var a = result.split(","), i;

 		for (i=0; i<fieldsCount; i++) {
 			if(!a[i]){ if(globalTamacha==0) alert("Please fill in all fields!!!");}
 			var b = a[i].split("=");
 	         var k = b[1].indexOf('$');
 	         var proofresult = b[1].substring(0,k);
 			if(proofresult==""){
 				retValue="false"; 
 				globalTamacha=1;
 				alert("Please fill in all fields!!!")
 			}
      }          */
	//alert("Validate Data is "+argument);
    if(retValue=="true"){
    	if(cid==cidForMaxFilledSeat){
    		alert("cidForMaxFilledSeat1 : "+cidForMaxFilledSeat+", and cid is : "+cid);
    		window.open("getClientDetailsForBURD?"+argument+"&captchaByJsp="+element);
    	}else{
    		/* window.open("getClientDetails?"+argument+"&captchaByJsp="+element); */
    		window.open("getClientDetailsNew?"+argument+"&captchaByJsp="+element);
    	}
    		
    	//window.open("getClientDetails?"+argument);
    	
    	window.close();
    	//xhttp.open("GET", window.location.origin+result+"/processForm?"+ argument + "&forminstanceid="+forminstanceid, true);
    }
    else{        	
    	return false;
    }        
}

</script>

	<!-- external javascript -->


	<script src="bower_components/jquery/jquery.min.js"></script>
	<script>var jq = jQuery.noConflict();</script>

	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>


	<!-- calender plugin -->
	<script src='bower_components/moment/min/moment.min.js'></script>
	<script src='bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
	<!-- data table plugin -->
	<script src='js/jquery.dataTables.min.js'></script>

	<!-- select or dropdown enhancer -->

	<!-- plugin for gallery image view -->
	<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
	<!-- notification plugin -->
	<script src="js/jquery.noty.js"></script>
	<!-- library for making tables responsive -->

	<!-- tour plugin -->


	<!-- star rating plugin -->

	<!-- for iOS style toggle switch -->

	<!-- autogrowing textarea plugin -->
	<script src="js/jquery.autogrow-textarea.js"></script>
	<!-- multiple file upload plugin -->

	<!-- history.js for cross-browser state change on ajax -->
	<script src="js/jquery.history.js"></script>
	<!-- application script for Charisma demo -->
	<!--<script src="js/charisma.js"></script> -->
	<s:if test='%{form.getJsEnabled().contentEquals("Y")}'>
		<script src="js/formjs/myScriptN.js"></script>
		<script src="js/formjs/myScriptArts.js"></script>
		<script src="js/formjs/myScriptScience.js"></script>
	</s:if>
	<script language="javascript" type="text/javascript"
		src="js/datetimepicker_css_100Year.js">
	</script>

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>



	<script>
 
 <%-- var captcha_match = false;
 var submitShotFlag = "fresh";
 var options = {};
 
 
//To get the substring before nth character in a string 
 function getPosition(str, m, i) {
 	   return str.split(m, i).join(m).length;
 	}
 
 function GetFee(x, id) {
		AddToOptionsArray(x, id)
		var dataArray = new Array;
		for ( var value in options) {
			dataArray.push(options[value]);
		}
		//alert(dataArray);
		var optionsFieldsCount = '<%=optionsFieldsCount%>';
		//alert('optionsFieldsCount is:'+optionsFieldsCount);
		if(dataArray.length==optionsFieldsCount){
			//alert('optionsFieldsCount is:'+optionsFieldsCount + 'so going ahead with ajax');
		
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				//alert("Fee is "+xhttp.responseText);
				//document.getElementById("FeeBox").innerHTML = xhttp.responseText;
			}
		}
		var appName = window.location.pathname;
		//alert(appName);
		var result = appName.substring(0,getPosition(appName,'/',2));	
		//alert('final url is:'+window.location.origin+result+'/getFee');		
		xhttp.open("GET", window.location.origin+result+"/getFee?optionArray=" + dataArray, true);
		xhttp.send();
		}
	}
 
 function AddToOptionsArray(value, id) {
		
		options[id] = value;
			
		//	alert(JSON.stringify(options));

		} --%>
 </script>

	<style>
	table.qwform{background:#fff; margin-bottom:10px;}
	.qwform td{padding:10px; border:1px solid #ccc;}
	.captcha-label{color:#cc0000; font-weight:bold;}
	</style>

</head>

<body style="margin: auto 0;">
	<div class="ch-container">
	<!-- <div class="navbar navbar-default" role="navigation"> -->
		<div class="container">
		
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="color: #3399ff;">
			
				<table align="center" width="100%">
				<tr>
					<td width="20%" align="center">
						<div class="university-logo- fl-logo">
							<% if(null!=collegeBean.getCollegeImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
								alt="" title="" height="60" width="80"></img>
							<%}else{ %>
								<img src="images/sabpaisa-logo.png" alt="" title="" width="80" height="60" />
							<%} %>
	
							<!-- 	<img src="<c:out value="collegeBean.collegeLogo"/>" alt="" title="" class="border-img" width="120" height="100" /> -->
						</div>
					</td>
					<td width="60%" align="center">
						<% if(null!=collegeBean.getCollegeName()){ %>
						<%-- <img
							src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
							alt="" title="" height="60" width="80"></img> --%>
							<h1><%=collegeBean.getCollegeName() %></h1>
						<%}else{ %>
							<h1>SRS Live Technologies</h1>
							<!-- <img src="images/sabpaisa-logo.png" alt="" title="" width="80" height="60" /> -->
						<%} %>
					</td>
					<td width="20%" align="center">
						<div class="university-logo- fr-logo">
					
							<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
								alt="" title="" height="60" width="80"></img>
							<%}else{ %>
								<img src="images/sabpaisa-logo.png" alt="" title="" width="80" height="60" />
							<%} %>
						
					</div>
					</td>
					
				</tr>
				</table>
		</div>
	 </div>
	<!--</div> -->
	
	<!-- <div class="container-fluid t1"> -->
	<div class="container">
	<div id="1" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

				<div class="pan-heading">
					<c:out value="${beanDataForm.formName}" />
				</div>


			</div>
	
	
			<div class="row">

			
			<!--/row-->

			<div class="row">
			
				<div class="col-md-4"></div>			
				<div class="well col-md-4 center login-box">
	<%
						String msg = (String) request.getAttribute("msg");
						if (msg != null) {
					%>
					<div class="alert alert-info"
						style="font-weight: bold; font-size: medium; color: red;">

						<%=msg%>
					</div>

					<%
						} else {
					%>
					<div class="alert alert-info">Please fill all validate fields and file captcha field as shown in block.
						</div>
					<%
						}
					%>

					

					<form class="form-horizontal" action="" method="post">
						<%-- <input id="bid" name="bid" hidden="hidden" type="text" value="<%=bid.toString() %>"/>
						<input id="cid" name="cid" hidden="hidden" type="text" value="<%=cid.toString() %>"/>
						<input id="payeeProfile" name="payeeProfile" hidden="hidden" type="text" value="<%=payeeProfile.toString() %>"/> --%>
						
						<fieldset>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="qwform">
							<c:forEach items="${beanDataForm.validateFieldOfExcel}" var="txt" varStatus="ind">
								<tr>
								<td width="50%" align="left">
								<div id="input-email" class="input-group input-group-lg">
	
									<!-- <span class="input-group-addon"><i
										class="glyphicon glyphicon-envelope red"></i></span> -->
										<label><c:out value='${txt}'/></label> 
										<!-- <input
										type="text" name="contact" id="contact"
										class="form-control" required="required" placeholder="Mobile Number"> -->
								</div>
								</td>
								<td width="50%" align="left">
								<!-- <p class="center col-md-5"></p>-->
								<div id="input-number" class="input-group input-group-lg">
									<!-- <span class="input-group-addon"><i
										class="glyphicon glyphicon-lock red"></i></span> --> <input
										type="text" name="<c:out value='${txt}'/>" id="<c:out value='${ind.index+1}'/>"
										onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)' 
										class="form-control" width="100%" required="required" placeholder="Enter the validate value">
								</div>
								
								</td>
								</tr>
							</c:forEach>
								<tr>
								<div class="form-group">
									<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12 cap-toppad" id="captcha">
										<td align="left"> <div id="input-number" class="input-group input-group-lg">
												<span class="captcha-txt">
													<label>Captcha letters are case
														sensitive</label>
												</span>
											 </div>
										</td>
										<td align="left">
											 <div id="input-number" class="input-group input-group-lg">
										  		<label class="captcha-label"><%=session.getAttribute("genAlphaNum")%>&nbsp;</label> 
												<input type='hidden' id='captchaFromServer' 
														value='<%=session.getAttribute("genAlphaNum")%>' /> 
												<input type="text" class="form-control" id="captId"
													name="<c:out value='<%=session.getAttribute("genAlphaNum")%>'/>" placeholder="Enter Captcha as it appears on the left">
											</div>
										</td>
									</div>
									<div class="clearfix"></div>
								</div>
								</tr>
							</table>

							<p class="center col-md-5">
								<button type="submit" class="btn btn-primary" 
								onClick="return ValidateSubmit( <%=request.getParameter("formid") %>)">Proceed</button>
							</p>
							<input type="hidden" name="formid" value="<%=request.getParameter("formid") %>" />
							<input type="hidden" name="bid" value="<%=request.getParameter("bid") %>" />
							<input type="hidden" name="cid" value="<%=request.getParameter("cid") %>" />	
							<input type="hidden" name="PayeeProfile" value="<%=request.getParameter("PayeeProfile") %>" />
							
						</fieldset>
					</form>
				</div>
				<!--/span-->
				<div class="col-md-4"></div>
			</div>
			<!--/row-->
		</div>
		
		<!--/fluid-row-->
		</div>
		<div class="container">
		<hr>
		<footer class="row">

			<div style="text-align: center;">

				<a href=""
					onclick="window.open('ContactUs.html','mywindowtitle',
											'width=500,height=550')">Contact
					Us </a> <span> |&nbsp;&nbsp;</span> <a href=""
					onclick="window.open('PrivacyPolicy.html','mywindowtitle',
											'width=500,height=550')">Privacy
					Policy </a> <span> |&nbsp;&nbsp;</span> <a href=""
					onclick="window.open('TermsAndConditions.html','mywindowtitle',
											'width=500,height=550')">Terms
					& Conditions </a> <span> |&nbsp;&nbsp;</span> <a href=""
					onclick="window.open('Disclaimer.html','mywindowtitle',
											'width=500,height=550')">Disclaimer
				</a>







			</div>


		</footer>
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

</body>
</html>
