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
<title>QwikForms Form</title>

<link href="css/docs.min.css" rel="stylesheet" type="text/css">
<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="css/wizard.css" rel="stylesheet" />
<link href="css/style-tabbs.css" rel="stylesheet">
<link href="css/style-new.css" rel="stylesheet">
<!--<script src="js/gallery.js"></script> -->

<%
Logger log = LogManager.getLogger("Requested Summary Page");
String PayeeProfile = null, lifeCycle=null;
Integer sesBid = null, sesCid = null ;
CollegeBean collegeBean = new CollegeBean();
Integer currentFormId=null;
String formInstanceIdSummary=null;
String formid;
String flag=null, flag1=null; 
try {

	sesBid = (Integer) session.getAttribute("bid");
	sesCid = (Integer) session.getAttribute("cid");
	PayeeProfile = (String) session.getAttribute("PayeeProfile");
	lifeCycle= (String) session.getAttribute("lifeCycle");
	/* formid = ((String) session.getAttribute("formid")==null)?"":((String) session.getAttribute("formid")); */			
	/* dob = ((String) session.getAttribute("dob")==null)?"":((String) session.getAttribute("dob"));			
	contact = (String) session.getAttribute("contact")==null?"":(String) session.getAttribute("contact");	 */		
	currentFormId = (Integer) session.getAttribute("formTempId");
	formInstanceIdSummary = (String) session.getAttribute("formInstanceId");
	flag=(String)session.getAttribute("veriflag");
	flag1=(String)session.getAttribute("veriflag1");
	log.info("temtodelet.jsp::currentFormId is:"+currentFormId);
	log.info("temtodelet.jsp::formInstanceId is:"+formInstanceIdSummary);
	log.info("temtodelet.jsp::PayeeProfile is:"+PayeeProfile);
	log.info("temtodelet.jsp::flag for hasInstruction is:"+flag1);
	log.info("temtodelet.jsp::flag for movetoPG is:"+flag);
	/* if(formid==""){				
		formid=formInstanceIdSummary;
	} */

	
} catch (NullPointerException e) {
%>
<script type="text/javascript">
window.location = "paySessionOut";
</script>
<%
}
%>
<%
				AppPropertiesConfig appProperties = new AppPropertiesConfig();
				Properties properties = appProperties.getPropValues();

				String qFormsIP = properties.getProperty("qFormsIP");
				String clientLogoLink = properties.getProperty("clientLogoLink");
				String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
				

				
			%>




<%
	
	Integer optionsFieldsCount = 0;
	int pageCtr = 0;
	try {
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
	<%
		//collegeBean = (CollegeBean) session.getAttribute("CollegeBean");

		SampleFormBean sfb = (SampleFormBean) session.getAttribute("sesCurrentFormData");
		if (null != sfb) {
			log.info("form bean in session found, invalidating it now");
			session.removeAttribute("sesCurrentFormData");
		} else {
			log.info("no form bean in session found");
		}
	%>

	<%
		//	int bid = Integer.parseInt((String) session.getAttribute("bid"));
		//System.out.print("BID ::" + bid);
		/* String collegeCode="";
		 session.setAttribute("collegeCode", collegeCode); */
	%>

	<script type="text/javascript">

var values = {};
var values1 ={};


function AddToArray(value, name, id,order) {
	//alert('inside rebuildArray and adding to array');
	value = value.split(",").join("");
	value = value.split("`").join("");
	value = value.split("=").join("");
		addValue(value, id);
	values[id] = id + "~" + name + "='" + value+"'$"+order;
	//values1[id]= id + "~" + name + "=" + value+"$"+order;
	//alert(JSON.stringify(values)); 

}

function addValue(value, id){
	values1[id] = value;
	//alert(JSON.stringify(values1));
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
 
 var captcha_match = false;
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

		}
 </script>

	<%
		/* 
		Integer sesBid = null;
		Integer sesCid = null;
		CollegeBean collegeBean = new CollegeBean();
		 */
		Integer payeeformIdQC = (Integer) session.getAttribute("currentFormId");
		
		String clgName = "";
		String insCode = "";

		try {
			sesBid = (Integer) session.getAttribute("bid");
			sesCid = (Integer) session.getAttribute("cid");
			collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
			PayeeProfile = (String) session.getAttribute("PayeeProfile");
			if (null == PayeeProfile || "".equals(PayeeProfile)) {
				PayeeProfile = (String) request.getParameter("PayeeProfile");
			}

			Double amount = (Double) session.getAttribute("feeAmt");
			clgName = (String) session.getAttribute("SelectedInstitute");
			insCode = (String) session.getAttribute("InstituteCode");

		} catch (java.lang.NullPointerException e) {
			System.out.println("null pointer exception");
	%>
	<script type="text/javascript">
			window.location="PaySessionOut.jsp";
			</script>

	<%
		}
	%>



	<%
		System.out.println("Winny payeeformIdQC:" + payeeformIdQC);
	%>
	<div class="container">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
			style="color: #3399ff;">

			<table align="center" width="100%">
				<tr>
					<td width="20%" align="center">
						<div class="university-logo- fl-logo">
							<% if(null!=collegeBean.getCollegeImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
								alt="" title="" height="60" width="80"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
								height="60" />
							<%} %>

							<!-- 	<img src="<c:out value="collegeBean.collegeLogo"/>" alt="" title="" class="border-img" width="120" height="100" /> -->
						</div>
					</td>
					<td width="60%" align="center">
						<% if(null!=collegeBean.getCollegeName()){ %> <%-- <img
							src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
							alt="" title="" height="60" width="80"></img> --%>
						<h1><%=collegeBean.getCollegeName() %></h1> <%}else{ %>
						<h1>SRS Live Technologies</h1> <!-- <img src="images/sabpaisa-logo.png" alt="" title="" width="80" height="60" /> -->
						<%} %>
					</td>
					<td width="20%" align="center">
						<div class="university-logo- fr-logo">

							<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
								alt="" title="" height="60" width="80"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
								height="60" />
							<%} %>

						</div>
					</td>

				</tr>
			</table>
		</div>
	</div>
	<div class="container bg-img-x" style="margin: 15px auto;">
		<form id="QForm" method="post">
			<div name="currentFormId" id="currentFormId"
				value="<%=currentFormId%>"></div>
			<div name="formInstanceId" id="formInstanceId"
				value="<%=formInstanceIdSummary%>"></div>
			<input type="hidden" name="isFormBeingRevived" value="Y" />

			<div id="1" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

				<div class="pan-heading">
					<c:out value="${formDetails.formName}" />
				</div>


			</div>


			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off"
				id="formssection"">


				<table class="table-td" style="width: 100%;">

					<c:forEach items="${clientDisplayFieldsList}" var="fieldList"
						varStatus="ind">
						<tr id="mapFile">
							<c:forEach items='${payerBeanMap}' var="mapKey">
								<c:if test='${fieldList.equals(mapKey.key) }'>
									<td class="lft"><b><label><c:out
													value="${mapKey.key.replaceAll('_', ' ')}" /></label></b></td>
									<td><c:choose>
											<c:when test='${mapKey.value!="" && mapKey.value!=null }'>
												<input type="text" name='<c:out value="${mapKey.key }"/>'
													id='<c:out value="${ind.index+1 }"/>'
													value='<c:out value="${mapKey.value }"/>'
													required="required"
													placeholder='<c:out value="${mapKey.value }"/>'
													class="form-control" readonly="readonly"
													onchange="AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)">

											</c:when>
											<c:otherwise>

												<input type="text" name='<c:out value="${mapKey.key }"/>'
													id='<c:out value="${ind.index+1 }"/>'
													value='<c:out value="${mapKey.value }"/>'
													required="required"
													placeholder='<c:out value="${mapKey.value }"/>'
													class="form-control"
													onchange="AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)">
											</c:otherwise>

										</c:choose></td>
								</c:if>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</div>
		</form>

		<div class="form-check" style="padding-top: 20px;">
			<label class="form-check-label"> <input
				class="form-check-input" type="checkbox" id="termsagreement"
				onclick="showProceed()"> Please agree with the <a
				href="TermsAndConditions.html" target="_new"> terms & condition
			</a>, and check the checkbox to proceed further
			</label>
		</div>
		<div class="form-group">
			<div class="offset-sm-2 col-sm-12"
				style="padding-bottom: 20px; text-align: center;">
				

				<div>

					<span> &nbsp;&nbsp;&nbsp; </span>
					<div>
						<c:choose>
							<c:when test='${lifeCycle.contentEquals("yes")}'>
								<span>
									<button type="submit"
										onclick='window.location="submitFormData?bid=<%=sesBid%>&cid=<%=sesCid%>&formid=<%=currentFormId%>&forminstanceid=<%=formInstanceIdSummary%>"'
										class="wizard-goto btn btn-primary smbuttonss">Submit</button>
								</span>
							</c:when>
							<c:otherwise>
								<span style="padding-left: 30px;"><button type="button"
										class="wizard-goto btn btn-primary smbuttonss"
										onClick="window.print()">Print</button></span>

								<span id="proceedForward" class="blcking" style="display: none">
									<span id="ProceedForPayment">
									<%
												if(flag.contentEquals("yes") && flag1.contentEquals("yes"))
												{
												%>
												<button type="submit" onclick="gotoProcessTrans1(<%=sesBid %>)"
											class="wizard-goto btn btn-primary smbuttonss">Save Record</button>
												<%
												}else{
												%>	
												<button type="submit" onclick="gotoProcessTrans(<%=sesBid %>)"
											class="wizard-goto btn btn-primary smbuttonss">Proceed</button>
												<% } %>
									
									
									
										<%-- <button type="submit" onclick="gotoProcessTrans(<%=sesBid %>)"
											class="wizard-goto btn btn-primary smbuttonss">Proceed</button> --%>
										<!--	<button class="btn btn-info smbuttonss" type="button" onclick='AddTransToCart("<%=formInstanceIdSummary%>")'>Add To Cart</button> -->
								</span>
								</span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>


	</div>

<hr><br/><br/>
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

	<script type="text/javascript">
	
	function gotoProcessTrans(bid){
		//alert("inside gotoProcessTrans");
		rebuildArray()
		//alert("Back to gotoProcessTrans after ending " );
		
		var dataArray = new Array;
		var dataArray1 = new Array;
		
		for ( var value in values) {
			dataArray.push(values[value]);
		}
		//alert("dataArray is :::: "+dataArray);
		
		for ( var value in values1) {
			dataArray1.push(values1[value]);
		}
		//alert("dataArray1 is :::: "+dataArray1);
		//alert("dataArray is :::: "+dataArray+" ::::::::: dataArray1 is :::: "+dataArray1);
		
		/* var argument = "values=" + dataArray + "&rcname=" + rcname
				+ "&rcdob=" + rcdob + "&rccontact=" + rccontact
				+ "&rcemail=" + rcemail + "&rcStartDate=" + rcStartDate
				+ "&rcEndDate=" + rcEndDate; */
				var argument = "values=" + dataArray + "&values1=" + dataArray1 ;
<%-- alert("window.location=processTransRevival?"+ argument+"&bid="+<%=sesBid%>+"&cid="+<%=sesCid%>+"&formid="+<%=currentFormId%>+"&forminstanceid="+<%=formInstanceIdSummary%>); --%>				
		window.location="processTransRevival?"+ argument+"&bid="+<%=sesBid%>+"&cid="+<%=sesCid%>+"&formid="+<%=currentFormId%>+"&forminstanceid="+<%=formInstanceIdSummary%>;		
				
							
	}
	
	function gotoProcessTrans1(bid){
		//alert("inside gotoProcessTrans");
		rebuildArray()
		//alert("Back to gotoProcessTrans after ending " );
		
		var dataArray = new Array;
		var dataArray1 = new Array;
		
		for ( var value in values) {
			dataArray.push(values[value]);
		}
		//alert("dataArray is :::: "+dataArray);
		
		for ( var value in values1) {
			dataArray1.push(values1[value]);
		}
		//alert("dataArray1 is :::: "+dataArray1);
		//alert("dataArray is :::: "+dataArray+" ::::::::: dataArray1 is :::: "+dataArray1);
		
		/* var argument = "values=" + dataArray + "&rcname=" + rcname
				+ "&rcdob=" + rcdob + "&rccontact=" + rccontact
				+ "&rcemail=" + rcemail + "&rcStartDate=" + rcStartDate
				+ "&rcEndDate=" + rcEndDate; */
				var argument = "values=" + dataArray + "&values1=" + dataArray1 ;
<%-- alert("window.location=processTransRevival?"+ argument+"&bid="+<%=sesBid%>+"&cid="+<%=sesCid%>+"&formid="+<%=currentFormId%>+"&forminstanceid="+<%=formInstanceIdSummary%>); --%>				
		window.location="SaveViewForm?"+ argument+"&bid="+<%=sesBid%>+"&cid="+<%=sesCid%>+"&formid="+<%=currentFormId%>+"&forminstanceid="+<%=formInstanceIdSummary%>;		
				
							
	}
	
	function showProceed(){
		//alert('in the function');
		
		  if (document.getElementById('termsagreement').checked) 
		  {
			 // alert('checked is'+document.getElementById('termsagreement').checked);
		      document.getElementById('proceedForward').style.display = 'inline-block';
		      
		  } else {

			//  alert('in else checked is'+document.getElementById('termsagreement').checked);
			  document.getElementById('proceedForward').style.display = 'none';
		  }
	}
	
	
	
		var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-36251023-1']);
	  _gaq.push(['_setDomainName', 'jqueryscript.net']);
	  _gaq.push(['_trackPageview']);

	  (function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();

</script>

	<script type="text/javascript">

jq(document).ready(function() {
    jq("div.bhoechie-tab-menu>div.list-group>a").click(function(e) {
        
    	//e.preventDefault();
        jq(this).siblings('a.active').removeClass("active");
        jq(this).addClass("active");
        var index = $(this).index();
        jq("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
        jq("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
    });
});







// funtion to be executed whenever the next button is called from a form page that is not the last page

function formPageNextAction(nextpageid){


   //alert('nextpageid is::'+nextpageid);
   var currentpagectr = nextpageid-1;
   var validationpass = true;
  //alert('currentpagectr is::'+currentpagectr);
	var elements = document.forms["QForm"].elements;
	  for (i=0; i<elements.length; i++){
	   
	    if(elements[i].title<=currentpagectr){
	    	//alert('validating the field');
	    if(null!=elements[i].tabindex){
	    	if(elements[i].tabindex=='required'){
	    		if(elements[i].value==""){
	    			//alert('field '+elements[i].name + ' cannot be empty');
	    			elements[i].focus();
	    			validationpass=false;
	    			break;
	    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
	    		}
	    		else{
	    			//alert('field '+elements[i].name + ' can be empty');
	    		}
	    	}
	      }
	    	
	    }
	    
	    	
	    	if(elements[i].pattern && elements[i].pattern!=''){
	    		//alert('pattern found and it is::'+elements[i].pattern);
	    		//alert('element value is::'+elements[i].value)
	    		//alert('pattern comparsion result is::'+new RegExp(elements[i].pattern).test(elements[i].value))
	    		
	    		if(elements[i].value!="" && !new RegExp(elements[i].pattern).test(elements[i].value)){
	    			//alert("fields '"+ elements[i].name +"' does not match the allowed pattern");
	    			elements[i].focus();
	    			//alert("focussed");
	    			validationpass=false;
	    			break;
	    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
	    		}
	    		else{
	    			//nothing
	    		}
	    	}	    
	    
	    
	    
	  }	



	/* Make ajax call below to save form data passing form id, data string etc and flag 
	 to send form direct link to the payer when currentpagectr =1  */		
	var returnFlag=false;
	//alert('currentpagectr is.. '+currentpagectr);
	//alert('submitShotFlag before is.. '+submitShotFlag);		
	if(currentpagectr==1){		
		submitShotFlag="fresh";
	}
	//alert('submitShotFlag after is.. '+submitShotFlag);	
	if(validationpass==true){
		//alert('proceeding to submit the page...'+currentpagectr);
		submitFormUsingAjax(submitShotFlag, currentpagectr);		

		if(submitShotFlag=="fresh"){
			submitShotFlag="update";
		}
	}
	
	 
	return returnFlag;

		
}





// funtion to be executed whenever the next button is called from the Payer Basic Information page
function goToFormPages(){

	   var currentpagectr=0;
	   var validationpass = true;
	   // alert('currentpagectr is::'+currentpagectr);
	 	var elements = document.forms["QForm"].elements;
	 	 
	 	  for (i=0; i<elements.length; i++){
	 	   
	 	    if(elements[i].title<=currentpagectr){
	 	    	var e = elements[i].name;
	 	    	
	 	    if(elements[i].required!=null){
	 	    	
	 	    	if(elements[i].required){
	 	    		
	 	    		if(elements[i].value==""){
	 	    			alert("fields '"+ elements[i].name +"' with red asterisk must be filled in");
	 	    			elements[i].focus();
	 	    			//alert("focussed");
	 	    			validationpass=false;
	 	    			break;
	 	    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
	 	    		}
	 	    		else{
	 	    			//alert('field '+elements[i].name + ' can be empty');
	 	    		}
	 	    	}
	 	      }
	 	    	
	 	    }
	 	    
	 	  }	
	 	  
		 	 // regular expression to match required date format and mobile number format
		 	
	 	  
	 	    if(document.getElementById("demo1").value != '' && !document.getElementById("demo1").value.match(/^\d{1,2}\-\d{1,2}\-\d{4}$/)) {
	 	      alert("Invalid Date Format: " + document.getElementById("demo1").value);
	 	     document.getElementById("demo1").focus();
	 	     validationpass = false;
	 	    }
	 	    if(document.getElementById("rc_contact").value != '' && !document.getElementById("rc_contact").value.match(/^[0-9]{10}$/)) {
		 	      alert("Invalid Mobile Number Format: " + document.getElementById("rc_contact").value);
		 	     document.getElementById("rc_contact").focus();
		 	     validationpass = false;
		 	}
	 	    if(document.getElementById("rc_email").value != '' && !document.getElementById("rc_email").value.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)) {
		 	     alert("Invalid Email Format: " + document.getElementById("rc_email").value);
		 	     document.getElementById("rc_email").focus();
		 	     validationpass = false;
		 	}		 	  
	  

	if (validationpass){
	
	var captID_val=document.getElementById("captchaFromServer").value;
	var captId=document.getElementById("captId").value;


	if(captID_val != captId)
	{
		alert("You got the Captcha wrong, try again !");
		ja("#captcha").load(location.href + " #captcha");	
		captcha_match=false;
		
	} 
	
	else{
		
	captcha_match=true;
	
	jq("#tab-10-1-1").removeClass('is-active');
	
	jq("#tab-10-1").hide();
	
	jq("#tab-10-1").removeClass('is-open');
	
	jq("#tab-11-1-1").addClass('is-active');
	jq("#tab-11-1").addClass('is-open');
	jq("#tab-11-1").show();
	
	}
	/* No save calls at this time but builds form data based on the Basic Information data*/
	//rebuildArray();	
	}
	return false;
	
}


 	

// funtion to be executed whenever the next button is called on the last page of the form
function formSubmitAction(){
	
	/* 	show the summary page, hide the current page */
	//alert('starting formSubmitAction ');
	
	//alert('finishing formSubmitAction ');
	/*submit t	he form to fetch the form summary page */
	var validationpass=true;
	var currentpagectr="last";

	var elements = document.forms["QForm"].elements;	
	  for (i=0; i<elements.length; i++){
	    	//alert('validating the field');
	    if(null!=elements[i].tabindex){
	    	if(elements[i].tabindex=='required'){
	    		if(elements[i].value==""){
	    			alert('field '+elements[i].name + ' cannot be empty');
	    			elements[i].focus();
	    			elements[i].style.color = "red";
	    			validationpass=false;
	    			break;
	    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
	    		}
	    		else{
	    			//alert('field '+elements[i].name + ' can be empty');
	    		}
	    	}
	      }
	    
	    
    	if(elements[i].pattern && elements[i].pattern!=''){
    		//alert('pattern found and it is::'+elements[i].pattern);
    		//alert('element value is::'+elements[i].value)
    		//alert('pattern comparsion result is::'+new RegExp(elements[i].pattern).test(elements[i].value))
    		
    		if(elements[i].value!="" && !new RegExp(elements[i].pattern).test(elements[i].value)){
    			alert("fields '"+ elements[i].name +"' does not match the allowed pattern");
    			elements[i].focus();
    			//alert("focussed");
    			validationpass=false;
    			break;
    			// exit on the first occurrence, move to the currentpagectr page and focus the field failing validation
    		}
    		else{
    			//nothing
    		}
    	}	    
	    
	    
	    
	  }
	    
	
	//alert('currentpagectr is.. '+currentpagectr);
//	alert('submitShotFlag is.. '+submitShotFlag);
if(validationpass==true){
	submitFormUsingAjax(submitShotFlag, currentpagectr);
	
}
	
	return false;
	
}


function rebuildArray()
{
	var elements = document.forms["QForm"].elements;
	  for (i=0; i<elements.length; i++){
		  
		 // alert(elements[i].tagName+" and type is:"+elements[i].type+ ".. and value is "+elements[i].value);
	  // alert(elements[i].value);
	    var eid=elements[i].id;
	    
	  
	    if(eid==("")||eid==("captId")||eid==("captchaFromServer")||eid==("rc_name")||eid==("demo1")||eid==("rc_code")||eid==("rc_email")||eid==("rc_contact")||eid==("rc_formStartDate")||eid==("rc_formEndDate")||eid==("hiddenIdval")||eid==("currentFormId")||eid==("formInstanceId"))
	    {
	    
	  } 
	    else
	    	{
	    	
	    	  if(eid==("tcCheckID") ||eid==("sendNewSms") ){
			    }else{
			    	if(elements[i].type=='radio' || elements[i].type=='checkbox'){													    		
			    		//alert('element type is ..'+  elements[i].type + '..and selected is...' + elements[i].checked);
			    	}
			    	if(!(elements[i].tagName=='INPUT' && elements[i].type=='radio' && (elements[i].type!='checkbox' && elements[i].checked==false))){	
			    		//alert('id is..'+elements[i].id +'.. types is..'+elements[i].type + '..and value is .. '+elements[i].value );
				    		if(elements[i].type=='checkbox'){
				    			if(elements[i].checked){
			    					AddToArray("on", elements[i].name,elements[i].id,i);
				    			}
				    			else{
				    				AddToArray("off", elements[i].name,elements[i].id,i);
				    			}
				    		}	
				    		else{
			    				AddToArray(elements[i].value, elements[i].name,elements[i].id,i);
				    		}
				       	}
				    else{
				    		//alert('case of radio unselected option and the unselected option is..'+elements[i].type + '...and value is.. .'+elements[i].value );
				       }
			    }
	    	
	    	}
	  }		
}

function confirmExit(){ 

	if(confirm('Are you sure you want to exit?','Yes', 'No')){
		
		window.location='getPayerFormsById?formid=<%=request.getParameter("formid")  %>&bid=<%=request.getParameter("bid") %>&cid=<%=request.getParameter("cid")%>';
		
		
	}
	return false;
	
}

function makeGetRequest() {
	 var checker = document.getElementById('tcCheckID');
	 var sendbtn = document.getElementById('sendNewSms');
	 // when unchecked or checked, run the function
	 checker.onchange = function(){
	if(this.checked){
	    sendbtn.disabled = false;
	} else {
	    sendbtn.disabled = true;
	}

	}


}






// funtion to be executed whenever the back button is called from a form page 

function formPageBackAction(nextpageid){
	//alert('nextpageid is::'+nextpageid);
	var currentpagectr = nextpageid-1;
	//alert('currentpagectr is::'+currentpagectr);
	
	if(currentpagectr==1){		
		
		
		
		jq("#tab-11-1-"+currentpagectr).removeClass('is-active');
		jq("#tab-11-"+currentpagectr).hide();
		jq("#tab-11-"+currentpagectr).removeClass('is-open');
	
		jq("#tab-10-1-1").addClass('is-active');
		jq("#tab-10-1").show();
		jq("#tab-10-1").addClass('is-open');			
	}
	else{
		
		var prevpagectr = currentpagectr-1;
		
		jq("#tab-11-1-"+currentpagectr).removeClass('is-active');
		jq("#tab-11-"+currentpagectr).hide();
		jq("#tab-11-"+currentpagectr).removeClass('is-open');

		jq("#tab-11-1-"+prevpagectr).addClass('is-active');
		jq("#tab-11-"+prevpagectr).addClass('is-open');
		jq("#tab-11-"+prevpagectr).show();
	}
	
	return false;

}	

function refreshTheCaptch() {
	alert('about to refresh captcha');
	jq("#captcha").load(location.href + " #captcha");
	alert('after refreh captcha');
}
function refreshPageRfCode() {
    jq("#pageRfCode").load(location.href + " #pageRfCode");
}







</script>


</body>
</html>