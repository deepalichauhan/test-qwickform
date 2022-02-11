<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.beans.BeanFormDetails"%>
<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="java.util.Base64"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>

<html lang="en">
<head>

<meta charset="utf-8">
<title>QwikForms</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
	
<link href="css/docs.min.css" rel="stylesheet" type="text/css">
<link href="css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="css/wizard.css" rel="stylesheet" />
<link href="css/style-tabbs.css" rel="stylesheet">
<link href="css/style-new.css" rel="stylesheet">
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

<script src="bower_components/jquery/jquery.min.js"></script>

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
<%-- <style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
       top.location = self.location;
   }
</script> --%>
<style>
	table.topheader td, table.topheader td img {text-align:center;}
</style>
</head>


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
	//alert("values is in AddToArray() method ::: "+JSON.stringify(values)); 

}

function addValue(value, id){
	values1[id] = value;
	alert("values1 is in addValue() method ::: "+JSON.stringify(values1));
}

</script>



<body onload="ExecuteFun();">

	<%
			SampleFormBean formBean=new SampleFormBean();
			formBean=(SampleFormBean)session.getAttribute("form");
			
			
				Logger log = LogManager.getLogger("Form Summary Page");
				String PayeeProfile = null, dob=null, contact=null,formid=null;
				Integer sesBid = null, sesCid = null ;
				CollegeBean collegeBean = new CollegeBean();
				Integer currentFormId=null;
				String formInstanceIdSummary=null;
				String flag=null, flag1=null; 
				
				String formnumber=null;
				HashMap<Integer, String> formDataMap=null;
				
				try {
					collegeBean=(CollegeBean) session.getAttribute("CollegeBean");
					sesBid = (Integer) session.getAttribute("BankId");
					sesCid = (Integer) session.getAttribute("CollegeId");
					PayeeProfile = (String) session.getAttribute("PayeeProfile");
					formid = ((String) session.getAttribute("formid")==null)?"":((String) session.getAttribute("formid"));			
					dob = ((String) session.getAttribute("dob")==null)?"":((String) session.getAttribute("dob"));			
					contact = (String) session.getAttribute("contact")==null?"":(String) session.getAttribute("contact");			
					currentFormId = (Integer) session.getAttribute("currentFormId");
					formInstanceIdSummary = (String) session.getAttribute("formInstanceId");
					formnumber = (String) session.getAttribute("formnumber");
					
					formDataMap=(HashMap<Integer, String>)session.getAttribute("sesCurrentFormMap");
					flag=(String)session.getAttribute("veriflag");
					flag1=(String)session.getAttribute("veriflag1");
					/* log.info("FormSummaryNew.jsp::collegeBean.CollegeCode is:"+collegeBean.getCollegeCode());
					log.info("FormSummaryNew.jsp::formBean.FormId is:"+formBean.getFormId());
					log.info("FormSummaryNew.jsp::formBean.Name is:"+formBean.getName());
					log.info("FormSummaryNew.jsp::formBean.Contact is:"+formBean.getContact());
					log.info("FormSummaryNew.jsp::formBean.Email is:"+formBean.getEmail());
					log.info("FormSummaryNew.jsp::formBean.TransAmount is:"+formBean.getTransAmount());
					log.info("FormSummaryNew.jsp::formBean.DobDate is:"+formBean.getDobDate());
					log.info("FormSummaryNew.jsp::formBean.FormId is:"+formBean.getFormId());
					log.info("FormSummaryNew.jsp::currentFormId is:"+currentFormId);
					log.info("FormSummaryNew.jsp::formInstanceId is:"+formInstanceIdSummary);
					log.info("FormSummaryNew.jsp::flag for hasInstruction is:"+flag1);
					log.info("FormSummaryNew.jsp::flag for movetoPG is:"+flag); */
					
					
					
					if(formid==""){				
						formid=formInstanceIdSummary;
					}
				
					
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
	

		<div class="container" align="left" style="background:grey;">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" >
		
		<table width="100%">

			<tr>
				<td width="70%">
					<div class="size" style="font-size: 20px; text-transform: uppercase; padding: 12px; color: #fff;">
						<% if(null!=collegeBean.getCollegeImage()){ %>
						<img
							src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
							alt="" title="" height="80" width="80"></img>
						<%}else{ %>
						<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
							height="60" />
						<%} %>

						<% if(null!=collegeBean.getCollegeName()){ %>

						<%=collegeBean.getCollegeName() %>
						<%}else{ %>
						SRS Live Technologies

						<%} %>
					</div>
				</td>
				<td width="30%" align="right">

					<div class="size1" style="font-size: 18px; padding: 12px; color: #fff;">
						
						<h5 style="font-size: 15px; font-weight: bold; padding: 12px; color: #fff;">
							For any Queries, contact us on:</br> sabpaisa@srslive.in | 01141733223
						</h5>
						
					</div>
				</td>
			</tr>
		</table>

		</div>
	</div>
	
	
		
<div class="background-colour" style="background: #fff;" align="center">

		
				<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
				<img
					src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
					alt="" title="" height="60" width="80"></img>
				<%}else{ %>
				<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
					height="60" />
				<%} %>
		
			</div>



	<%--  --%>

	<div class="container bg-img-x" style="margin: 15px auto;">
		
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 top-main-bg-table"
			style="padding: 0;">
			<div class="form-group-banks-step3">

				<div class="bs-example-td">
				
				<form id="QForm" method="post">
				
					<input type="hidden" name="currentFormId" id="currentFormId"
						value="<%=currentFormId%>"></input>
					<input type="hidden" name="formInstanceId" id="formInstanceId"
						value="<%=formInstanceIdSummary%>"></input>
				
					<%-- <div name="currentFormId" id="currentFormId"
						value="<%=currentFormId%>"></div>
					<div name="formInstanceId" id="formInstanceId"
						value="<%=formInstanceIdSummary%>"></div> --%>
					<input type="hidden" name="isFormBeingRevived" value="Y" />
		
					<%-- <div id="1" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		
						<div class="pan-heading">
							<c:out value="${formDetails.formName}" />
						</div>
					</div> --%>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 box off"
						id="formssection"">
				
					<table class="table-td" style="width: 100%;">
						<tr class="panel-heading">
							<td colspan="2">Please review the Captured Form Data</td>
						</tr>


						<%if(null!=formBean.getPhotograph()){ %>

						<tr class="lightgray">
							<td colspan="2">
								<div class="form-group">
									<div class="university-logo">
										<p class="top-mn-header">Applicant Photograph</p>

										<%
													try {
												%>




										<img
											src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getPhotograph())%>"
											alt="" title="" width="125px" height="150px" class="flleft">





										<%} catch (Exception ex) {
														ex.printStackTrace();
													}
												%>

									</div>
								</div>
							</td>

						</tr>

						<%}%>
					</table>

					<table class="table-td" style="width: 100%; align-items: left" >


						<c:forEach items="${formViewData}" var="formViewData">
							<tr>
								<td class="wd-four">
									<c:set var="nextTab">
										<c:out value="${formViewData.label}" />
									</c:set> 
									<c:choose>
									<c:when test="${nextTab=='PageBreak'}">
									</c:when> 
									<c:when test="${nextTab=='Notification'}">
									</c:when> 
									
									<c:otherwise>
										<strong><c:out value="${formViewData.label}" /></strong>
									</c:otherwise>
									</c:choose>
									</td>
								<td class="wd-six">
									<c:set var="nextTab1">
										<c:out value="${not empty formViewData.value ? formViewData.value.substring(value.indexOf('*')+0) : 'Empty'}" />
									</c:set> 
									<c:choose>
									<c:when test="${nextTab1=='Empty'}">
										<c:out value=" " />
									</c:when> 
									<c:otherwise>
										<c:choose>
											<c:when test="${formViewData.value=='Online Form For Payment' || formViewData.value=='Outstanding and Previous Online Fee Payment'}">
											</c:when>
											<c:otherwise>
												<strong><c:out value="${formViewData.value.substring(value.indexOf('*')+0)}" /></strong>
											</c:otherwise>
										</c:choose>
										
									</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
						
						 <%-- <tr>
							<td class="wd-four">Form Id</td>
							<td class="wd-six"><%=formBean.getFormNumber()%></td>
						</tr>
						
						<tr>
							<td class="wd-four">Name:</td>
							<td class="wd-six"><c:out value="<%=formBean.getName() %>" /></td>
							
						</tr>  --%>
						<%--<tr>
							<td class="wd-four">Contact</td>
							<td class="wd-six"><c:out value="<%=formBean.getContact() %>" /></td>
						</tr>
						<tr>
							<td class="wd-four">Date of Birth</td>
							<td class="wd-six">
								<fmt:formatDate value="<%=formBean.getDobDate() %>" pattern="dd/MM/yyyy" var="parsedDateTime" type="date" />
							
								<c:out value="${parsedDateTime}" />
							
							</td>
						</tr>
						<tr>
							<td class="wd-four">Email</td>
							<td class="wd-six"><c:out value="<%=formBean.getEmail() %>" /></td>
						</tr>
						<tr>
							<td class="wd-four">Form Start Date</td>
							<td class="wd-six"><c:out value="<%=formBean.getFormStartDate() %>" /></td>
						</tr>
						<tr>
							<td class="wd-four">Form End Date</td>
							<td class="wd-six"><c:out value="<%=formBean.getFormEndDate() %>" /></td>
						</tr> --%>
						<%-- <tr>
							<td class="wd-four"><strong>Amount to Pay</strong></td>
							<td class="wd-six"><strong>Rs.
										 <c:out value="<%=formBean.getTransAmount() %>" /> 
										 
							</strong></td>
						</tr> --%>

						<tr>
							<%if(null!=formBean.getSignature()){ %>
							<td class="wd-four">Signature</td>
							<td class="wd-six">
								<%
											try {
										%> <img id="photo"
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(formBean.getSignature())%>"
								alt="" title="" width="120px" height="50px" class="flleft">



								<%
											} catch (Exception ex) {
										}
		 							%>
							</td>

							<%} %>
						</tr>
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
			</div>
		</div>
	</div>


		<!-- external javascript -->

	<script src="bower_components/jquery/jquery.min.js"></script>
	<script>var jq = jQuery.noConflict();</script>
	<script language="javascript" type="text/javascript"
		src="js/datetimepicker_css_100Year.js">
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

		<script type="text/javascript">
		
		
		
				function verifyPages() {

					var cid1 =
			<%=sesCid%>
				;
					var bid1 =
			<%=sesBid%>
				;

					if (cid1 == 1 && bid1 == 1) {
						window.location = "GetForms";
					} else if (cid1 == 2 && bid1 == 2) {
						window.location = "nitjFeesPaymentForm.jsp";
					} else if (cid1 == 3 && bid1 == 3) {
						window.location = "noidaPage.jsp";
					}

				}

				function ExecuteFun() {

					setTimeout(function() {
						ExecuteFun();
						//location.reload();
						var bid =
			<%=sesBid%>
				;
						var cid =
			<%=sesBid%>
				;
						if (bid == '' || bid == null) {
							window.location = "PaySessionOut";
						}

					}, 120000);
				}
				
				
				function gotoProcessTrans(bid){
					//alert("inside gotoProcessTrans(bid) method "+bid);
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
			<%-- alert("window.location=processTransRevivalNew?"+ argument+"&bid="+<%=sesBid%>+"&cid="+<%=sesCid%>+"&formid="+<%=currentFormId%>+"&forminstanceid="+<%=formInstanceIdSummary%>); --%>				
					window.location="processTransRevivalNew?"+ argument+"&bid="+<%=sesBid%>+"&cid="+<%=sesCid%>+"&formid="+<%=currentFormId%>+"&forminstanceid="+<%=formInstanceIdSummary%>;		
							
										
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
				
				//  - This function to be called from formsummaryrevival.jsp
				function backToForms(){
					
					var r = confirm("By Going back you may lose some of the data you want to enter, are you sure?");
					if(r == true){
					 var PayerProfile = '<%=PayeeProfile%>';
					var bid = '<%=sesBid%>';
					var cid = '<%=sesCid%>';	
					var contact ='<%=contact%>';
					var dob='<%=dob%>';
					var formid='<%=currentFormId%>';
					
					if(formid==''){				
						formid='<%=formInstanceIdSummary%>';
					}
				
					//window.location='getPayerFormsById?formid='+formid+'&bid='+bid+'&cid='+cid+'&PayeeProfile='+PayerProfile+'&contact='+contact+'&dob='+dob;
					 
					 //validateFieldFormById?formid=29&bid=2&cid=70&PayeeProfile=TestingPayer
					alert("New URL is ::::::::::: validateFieldFormById?formid="+formid+"&bid="+bid+"&cid="+cid+"&PayeeProfile="+PayerProfile);
					 document.goBackForms.action="validateFieldFormById?formid="+formid+"&bid="+bid+"&cid="+cid+"&PayeeProfile="+PayerProfile;
						document.getElementById("backGo").submit();
					
					}	
					else{
						return false;
					}
				    }
			</script>
</body>


</html>