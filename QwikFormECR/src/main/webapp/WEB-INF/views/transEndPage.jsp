<!doctype html>
<%@page import="java.util.Properties"%>
<%@page import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<%@page import="com.sabpaisa.qforms.beans.SampleTransBean"%>
<%@page import="java.util.Base64"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>QwikForms</title>
<link rel="stylesheet" href="css/bootstraprecipt.min.css">
<link href="css/easy-responsive-tabs.css" rel="stylesheet" type="text/css">
<link href="css/jquerysctipttoprecipt.css" rel="stylesheet" type="text/css">
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
	Integer sesBid = (Integer) session.getAttribute("BankId");
	 Integer sesCid = (Integer) session.getAttribute("CollegeId");
	 CollegeBean  collegeBean=(CollegeBean)session.getAttribute("CollegeBean");
	 
	 sesBid=collegeBean.getBankDetailsOTM().getBankId();
	 sesCid=collegeBean.getCollegeId();
	 
	 String redirectedFromBank = session.getAttribute("redirectedFrom")==null? "" : (String) session.getAttribute("redirectedFrom");
	 
	 
	 /* if(sesBid==null||sesCid==null)
	 {
		 response.sendRedirect("TimeIntervalPage");
	 } */
	
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
<%
	AppPropertiesConfig quickCollectProperties = new AppPropertiesConfig();
		Properties properties = quickCollectProperties.getPropValues();

		String qFormsIP = properties.getProperty("qFormsIP");
		String clientLogoLink = properties.getProperty("clientLogoLink");
		String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
%>
<div class="top-headers">
<div class="container nopadding">

<div class="col-lg-12 col-md-12 col-sm-12 nopadding">
	<div class="col-lg-6 col-md-3 col-sm-3 nopadding flt-l img-values">
	<% if(null!=collegeBean.getBankDetailsOTM().getBankImage()){ %>
		<img src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getBankDetailsOTM().getBankImage())%>" width="" height="" class=""/>
<%}else{%>
		<img
			src="img\No-logo.jpg"> 
			
		<%}%>	
		</div>
	<div class="col-lg-6 col-md-3 col-sm-3 nopadding flt-r img-values">
		<img src="images/Sab-Paisa-small.png" class=""/>
	</div>
</div>

</div>
</div>
<div class="container payment-section-wishlist">
<div class="col-lg-12 col-md-12 col-sm-12 img-values-col txt-cnt-wait-n">
<% if(null!=collegeBean.getCollegeImage()){ %>
<img src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>" class=""/>
<a class="navbar-brand" href="<%=clientLogoLink%>"><span>
			<%=collegeBean.getCollegeName() %>	<br><%-- <%=collegeBean.StateBean.StateName %> --%>
			
			 </span></a> 
			 <%}else{%>
	<img src="img\No-logo.jpg">
		<a href="<%=clientLogoLink%>"><span>
			<%=collegeBean.getCollegeName() %>,<br><%-- <%=collegeBean.getStateBean().getStateName() %> --%>
			 </span></a>
			 
	<%}%>
</div>
<div class="col-lg-12 col-md-12 col-sm-12">
<div class="col-lg-12 col-md-12 col-sm-12 price-summary">
	<div class="col-lg-12 col-md-12 col-sm-12 txt-cnt-wait-n greenlab">
	Save Transaction receipt for successful Transactions for future use by clicking the 'View receipt' button. <br>
	<c:if test="${status.contentEquals('pending') || status.contentEquals('failure')}">
										If your account has been debited, please come back to view the transaction status within 1 to 2 days.
										</c:if>
	</div>
	<div class="col-lg-12 col-md-12 col-sm-12 price-title no-pad">
		<span class="client-head">Reference No : <span class="flr">
			<c:out value="${beanTransData.spTransId}" />
			<input type="hidden" id="tranId" value='<c:out value="${beanTransData.transId}"/>'>
		</span></span>
		<span class="payee-head">Transaction Date : <span class="flr">
			<fmt:formatDate value="${beanTransData.transDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
			<c:out value="${parsedDateTime}" />
			<%-- <fmt:formatDate pattern="dd.MM.yyyy HH:mm" value="${ parsedDateTime }" /> --%>
		
		
			<%-- <s:date name="${beanTransData.transDate}"/> --%>
		</span></span>
		<span class="client-head">Transaction Status : <span class="flr">
			<c:out value="${beanTransData.transStatus}" />
		</span></span>
	</div>
		<div class="cntrs- labeling-pad" style="float: right;">
			<c:set var="status">
				<c:out value="${beanTransData.transStatus}"></c:out>
			
			</c:set>
											
			<%-- <c:if test="${status.contentEquals('success') }"> --%>
			<c:if test="${status.contentEquals('SUCCESS') || status.contentEquals('FAILED')}">
			
				<span id="btnClicks">
				<input type="submit" id="btnSubmit-first" onclick='viewFormlst("<c:out value='${beanTransData.id}'/>",
					"<c:out value="${beanTransData.transId}" />")' value="View receipt" class="btn btn-grn btm-margs">
				</span>
			</c:if>
			
		</div>
	</div>
				<div align="center">
				
				<button type="button" onclick="goToStart()" class="wizard-goto btn btn-primary">Back to Home</button>
				
				</div>
</div>
		
</div>


</div>
<footer>
<div id="footer">
	<p>© Copyright 2016. powered by <a href="http://www.sabpaisa.com/" alt="SRS Live Technologies Pvt Ltd" title="SRS Live Technologies Pvt Ltd">SRS Live Technologies Pvt Ltd</a>.</p>
	<ul class="footer-ul">
			<li><a href="ContactUs.html" target="_blank">Contact Us</a></li>
			<li><a href="PrivacyPolicy.html" target="_blank">Privacy Policy</a></li>				
			<li><a href="TermsAndConditions.html" target="_blank">Terms&Conditions</a></li>
			<li><a href="PrivacyPolicy.html" target="_blank">Payment Security</a></li>
			<li><a href="Disclaimer.html" target="_blank">Disclaimer</a></li>
	</ul>
</div>
</footer>

<script src="js/jqueryrecipt.min.js"></script>
<script src="js/jquery.easyResponsiveTabs.js"></script>

<script>
		
	//<%SampleTransBean transData = new SampleTransBean();
		//	transData = (SampleTransBean) session.getAttribute("sesCurrentTransData");
		//	Double transAmount = transData.getTransAmount();%>
		function Pay() {
			
			}
		
		function veiwReceipt(tid){
			
			//alert(tid);
			/* window.location="viewReceiptDetails?tid="+tid; */
			window.open("viewReceiptDetails?tid="+tid, "Preview","width=857,height=768");
			
		}
		
		function viewFormlst(id,transId) {
			window.open("ViewFormlst?transId=" +transId+"&id="+id, "Preview",
					"width=500,height=768");
		}

		
		function goToStart(){
			var redirectedFromBankFlag = '<%=redirectedFromBank%>';
			var bid = '<%=sesBid%>'; 
			if(redirectedFromBankFlag=='Bank'){
				 if(bid=='4'){
					 window.location='http://www.allahabadbank.in';
				 }
				 else{
					window.location='StartUrl?bid=<%=sesBid%>&cid=<%=sesCid%>&redirectedFrom=Bank&currentSessionReturn=Y';
				 }
			}
			else{				
				window.location='StartUrl?bid=<%=sesBid%>&cid=<%=sesCid%>&currentSessionReturn=Y';
			}
					
			
		}
		
		
	</script>


<script type="text/javascript">
    $(document).ready(function () {
	  var scrollTop = function() {
		window.scrollTo(0, 0);
	};
</script>
  <script type="text/javascript">
    $(document).ready(function () {

        $('#parentHorizontalTab').easyResponsiveTabs({
            type: 'default', //Types: default, vertical, accordion
            width: 'auto', //auto or any width like 600px
            fit: true, // 100% fit in a container
            closed: 'accordion', // Start closed if in accordion view
            tabidentify: 'hor_1', // The tab groups identifier
            activate: function (event) { // Callback function if tab is switched
                var $tab = $(this);
                var $info = $('#nested-tabInfo');
                var $name = $('span', $info);

                $name.text($tab.text());

                $info.show();
            }
        });

        $('#ChildVerticalTab_1').easyResponsiveTabs({
            type: 'vertical',
            width: 'auto',
            fit: true,
            tabidentify: 'ver_1', // The tab groups identifier
            activetab_bg: '#fff', // background color for active tabs in this group
            inactive_bg: '#F5F5F5', // background color for inactive tabs in this group
            active_border_color: '#5AB1D0', // border color for active tabs heads in this group
            active_content_border_color: '#5AB1D0' // border color for active tabs contect in this group so that it matches the tab head border
        });
		
		$('#ChildVerticalTab_2').easyResponsiveTabs({
            type: 'vertical',
            width: 'auto',
            fit: true,
            tabidentify: 'ver_2', // The tab groups identifier
            activetab_bg: '#fff', // background color for active tabs in this group
            inactive_bg: '#F5F5F5', // background color for inactive tabs in this group
            active_border_color: '#5AB1D0', // border color for active tabs heads in this group
            active_content_border_color: '#5AB1D0' // border color for active tabs contect in this group so that it matches the tab head border
        });

    });}
</script>



</body>
</html>