<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.SampleFormBean"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.util.Base64"%>

<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css1/validateForm.css">
<link rel="shortcut icon" href="img/favicon.ico">
<title>Quick Form</title>


<%
	//Integer payeeformIdQC = (Integer) session.getAttribute("currentFormId");
	Integer sesBid = null, sesCid = null;
	String formId=null;
	
	String bid=null,cid=null;
	//Integer currentFormId = null;
	//String formInstanceId = null;
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
	String cCodeForApproval = properties.getProperty("cCodeForApproval");
	String cIdForApproval = properties.getProperty("cIdForApproval");
	String userDetailApproved = properties.getProperty("userDetailApproved");
	
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
		//currentFormId = (Integer) session.getAttribute("currentFormId");
		//formInstanceId = (String) session.getAttribute("formInstanceId");
		session.setAttribute("captchaValue", captchaValue);
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
	//System.out.println("Winny payeeformIdQC:" + payeeformIdQC);

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
	values[id] = id + "~" + name + "='" + value+"'$"+order;
	//alert(JSON.stringify(values)); 

}		

function ValidateSubmit(id) {
	//alert("use validatesubmit function");
	var formId= id;
	var cid=<%=cid%>;
	var cidForMaxFilledSeat=<%=cidForMaxFilledSeat1%>;
	var cIdForApproval=<%=cIdForApproval%>;
	//var approve="NA";
	var approve="approve";
	var element = document.getElementById('captId').value;
	alert(element);
		
	var dataArray = new Array;
	for ( var value in values) {
		dataArray.push(values[value]);
	}
	var argument = "values=" + dataArray+"&formid="+formId;
	
    var retValue = "true";
    if(argument==null){
    	retValue = "true";
    }
	
    if(retValue=="true"){
    	if(cid===cIdForApproval){   	
	    	window.open("getClientDetailsNew?"+argument+"&approvalStatus="+approve+"&captchaByJsp="+element);
	    	window.close();
		 }else{
			window.open("getClientDetailsNew?"+argument+"&captchaByJsp="+element);
		    window.close();
		 }
    	
    }
    else{        	
    	return false;
    }        
}

</script>
	<!-- <center> -->
	<div class="blue" align="left">


		<table width="100%">

			<tr>
				<td width="70%">
					<div class="size">
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

					<div class="size1">

						<h5>
							For any Queries, contact us on:</br> sabpaisa@srslive.in | 01141733223
						</h5>

					</div>
				</td>
			</tr>
		</table>

	</div>


	<div class="background-colour" align="center">


		<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
		<img
			src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>"
			alt="" title="" height="60" width="80"></img>
		<%}else{ %>
		<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
			height="60" />
		<%} %>

	</div>


	<div class="container">
		<div class="row">
			</br>

			<div class="col-md-6 the-green-bg1">
				<div class="classWithPad1">
					<div class="form-group">

				<% if(collegeBean.getCollegeCode().equalsIgnoreCase(cCodeForApproval)){ %>
						<form class="form-horizontal" action="" method="post">


							<fieldset>
								<table width="100%" border="1" class="qwform">
									<c:forEach items="${beanDataForm.validateFieldOfExcel}"
										var="txt" varStatus="ind">
										<tr>
											<td width="50%" align="left"><span class="size1"><c:out
														value='${txt}' /></span></td>
											<td width="50%" align="left"><input type="text"
												name="<c:out value='${txt}'/>"
												id="<c:out value='${ind.index+1}'/>"
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
												class="form-control" width="100%" required="required"
												placeholder="Enter the validate value"></td>
										</tr>
									</c:forEach>
									
									<tr>

										<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12 cap-toppad"
											id="captcha">
											<td align="left">

												<div class="size1 captcha-txt" style="font-size: medium;">
													Captcha letters are case sensitive --
													<%=session.getAttribute("genAlphaNum")%></div>


											</td>
											<td align="left"><input type='hidden'
												id='captchaFromServer'
												value='<%=session.getAttribute("genAlphaNum")%>' /> <input
												type="text" class="form-control" id="captId"
												name="<c:out value='<%=session.getAttribute("genAlphaNum")%>'/>"
												placeholder="Enter Captcha as it appears on the left">

											</td>
										</div>

									</tr>
								</table>

								<p class="center col-md-5">
									<button type="submit" class="btn btn-primary"
										onClick="return ValidateSubmit( <%=request.getParameter("formid") %>)">Proceed</button>
								</p>
								<input type="hidden" name="formid"
									value="<%=request.getParameter("formid") %>" /> <input
									type="hidden" name="bid"
									value="<%=request.getParameter("bid") %>" /> <input
									type="hidden" name="cid"
									value="<%=request.getParameter("cid") %>" /> <input
									type="hidden" name="PayeeProfile"
									value="<%=request.getParameter("PayeeProfile") %>" />

							</fieldset>
						</form>
						<%}else{ %>
							<form class="form-horizontal" action="" method="post">


							<fieldset>
								<table width="100%" border="1" class="qwform">
									<c:forEach items="${beanDataForm.validateFieldOfExcel}"
										var="txt" varStatus="ind">
										<tr>
											<td width="50%" align="left"><span class="size1"><c:out
														value='${txt}' /></span></td>
											<td width="50%" align="left"><input type="text"
												name="<c:out value='${txt}'/>"
												id="<c:out value='${ind.index+1}'/>"
												onchange='AddToArray(this.value,this.name,this.id,<c:out value="${ind.index}"/>)'
												class="form-control" width="100%" required="required"
												placeholder="Enter the validate value"></td>
										</tr>
									</c:forEach>
									<tr>

										<div class="col-lg-2 col-md-12 col-sm-12 col-xs-12 cap-toppad"
											id="captcha">
											<td align="left">

												<div class="size1 captcha-txt" style="font-size: medium;">
													Captcha letters are case sensitive --
													<%=session.getAttribute("genAlphaNum")%></div>


											</td>
											<td align="left"><input type='hidden'
												id='captchaFromServer'
												value='<%=session.getAttribute("genAlphaNum")%>' /> <input
												type="text" class="form-control" id="captId"
												name="<c:out value='<%=session.getAttribute("genAlphaNum")%>'/>"
												placeholder="Enter Captcha as it appears on the left">

											</td>
										</div>

									</tr>
								</table>

								<p class="center col-md-5">
									<button type="submit" class="btn btn-primary"
										onClick="return ValidateSubmit( <%=request.getParameter("formid") %>)">Proceed</button>
								</p>
								<input type="hidden" name="formid"
									value="<%=request.getParameter("formid") %>" /> <input
									type="hidden" name="bid"
									value="<%=request.getParameter("bid") %>" /> <input
									type="hidden" name="cid"
									value="<%=request.getParameter("cid") %>" /> <input
									type="hidden" name="PayeeProfile"
									value="<%=request.getParameter("PayeeProfile") %>" />

							</fieldset>
						</form>
						<%} %>
					</div>
				</div>


			</div>




			<div class="col-md-6"></div>

		</div>


		<div class="footer-copyrights col-lg-12" align="left">
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



	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
</body>
</html>