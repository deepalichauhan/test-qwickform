<!DOCTYPE html>
<%@page import="java.util.Iterator"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.Base64.Encoder"%>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="favicon.ico">
<link href="Banks/css/styles.min.css" rel="stylesheet">
<link href="Banks/css/bootstrap.min.css" rel="stylesheet">
<link href="Banks/css/jquery.jscrollpane.css" rel="stylesheet">
<link href="Banks/css/font-awesome.min.css" rel="stylesheet">
<link href="Banks/css/owl.carousel.css" rel="stylesheet">
<link href="Banks/css/owl.theme.default.min.css" rel="stylesheet">
<link rel="stylesheet" href="Banks/css/style-new.css">
<link rel="stylesheet" href="Banks/css/feedback.css">

<script src="Banks/js/ie-emulation-modes-warning.js"></script>
<script type='text/javascript' src='Banks/js/jquery.js'></script>

<script type='text/javascript' src='Banks/js/main-toggle.js'></script>
<!-- ANISH -->
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<script type="text/javascript" language="javascript"
	src="Banks/js/jquery-1.12.3.js"></script>
<script type="text/javascript" class="init">
	$(document).ready(function() {
		var table = $('#example').DataTable();

		// Event listener to the two range filtering inputs to redraw on input
		$('#min, #max').keyup(function() {
			table.draw();
		});
	});
</script>
<script>
	var cid=null;
</script>
<link rel="stylesheet" href="Banks/css/jquery.dataTables.min.css">
<script src="Banks/js/jquery.dataTables.min.js"></script>
<style>
::-webkit-scrollbar {
	width: 10px;
} /* this targets the default scrollbar (compulsory) */
::-webkit-scrollbar-track {
	background-color: #34495e;
}
/* the new scrollbar will have a flat appearance with the set background color */
::-webkit-scrollbar-thumb {
	background-color: rgba(0, 0, 0, 0.2);
} /* this will style the thumb, ignoring the track */
::-webkit-scrollbar-button {
	background-color: #b6b6b6;
}
/* optionally, you can style the top and the bottom buttons (left and right for horizontal bars) */
::-webkit-scrollbar-corner {
	background-color: black;
}
/* if both the vertical and the horizontal bars appear, then perhaps the right bottom corner also needs to be styled */
</style>
<%
		List<CollegeBean> collegeList=(List<CollegeBean>)request.getAttribute("collegeList");

String bankName="";
String bankLink=null;
String bankEmailId="anishsingh@srslive.in";
try{
	bankName=collegeList.get(0).getBankDetailsOTM().getBankname();
	bankEmailId=collegeList.get(0).getBankDetailsOTM().getEmailId();
	
	}catch(Exception ex){
	bankName="SabPaisa";
	bankLink="http://www.sabpaisa.in";
	bankEmailId="sabpaisa@srslive.in";	
}

System.out.println("Email Id is= "+bankEmailId);
System.out.println("Email Id is= "+bankName);
%>


<%
String bid=	request.getParameter("bid");
	session.setAttribute("bid", bid);
	String pagePath = "div_"+ bid +".jsp";

	if(bid.equals("31")){

	%>
<link href="Banks/css/styledcb.css" rel="stylesheet">
<%}else if(bid.equals("32")){ %>
<link href="Banks/css/style-synd.css" rel="stylesheet">
<%}else if(bid.equals("33")){ %>
<link href="Banks/css/styledcb.css" rel="stylesheet">
<%}else if(bid.equals("46")){ %>
<link href="Banks/css/styledcb.css" rel="stylesheet">
<%}else if(bid.equals("47")){ %>
<link href="Banks/css/styledcb.css" rel="stylesheet">
<%}else if(bid.equals("48")){ %>
<link href="Banks/css/stylebob.css" rel="stylesheet">
<%}else if(bid.equals("12")){ %>
<link href="Banks/css/stylevijaya.css" rel="stylesheet">
<%}else if(bid.equals("7")){ %>
<link href="Banks/css/stylevijaya.css" rel="stylesheet">
<%}else if(bid.equals("19")){ %>
<link href="Banks/css/stylevijaya.css" rel="stylesheet">
<%}else if(bid.equals("28")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("1")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("8")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("9")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("34")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("50")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("52")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("53")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("54")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("55")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("58")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else if(bid.equals("59")){ %>
<link href="Banks/css/styleCanaraBank.css" rel="stylesheet">
<%}else{ %>
<link href="Banks/css/style-allbank.css" rel="stylesheet">
<%} %>
<title><%= bankName %> - SabPaisa</title>
</head>
<body class="wide comments example">

	<div class="navbar navbar-inverse navbar-fixed-top wet-asphalt"
		role="banner" style="z-index: 9999; background: #fff;">
		<div class="container">
			<jsp:include page="<%= pagePath %>"></jsp:include>
		</div>
	</div>

	<!-- Navigation -->

	<div class="navbar navbar-default navbar-fixed-top-">
		<div class="container pad-none">
			<div class="col-sm-12 pad-none">
				<div class="col-lg-12 col-md-12 col-sm-12 pad-none">
					<!-- Brand and toggle get grouped for better mobile display -->
					<!-- <div class="navbar-header page-scroll col-lg-3 col-md-6 col-sm-12">
						<a class="navbar-brand page-scroll" href="#page-top">
							<img src="Banks/images/allahabad_logo.jpg" alt="allahabad_logo" width="100%" height="100%">
						</a>
					</div>-->
					<div class="col-lg-12 col-md-6 col-sm-12 pad-none">

						<div class="col-lg-12 col-md-12 col-sm-12 col-fr- pad-none- ">

							<div
								class="header-search pull-right col-lg-5 col-md-12 col-sm-12 col-xs-12 pad-none-">
								<div id="home-button" onclick="myfunction()"
									style="cursor: pointer" class="col-lg-7 rht-bor">

									<span class="cur-pointer"> <img
										src="Banks/images/home-icon.png" alt="Search College"
										title="Home" class="Home-icons"><span>Home</span>
									</span>


								</div>
								<div id="header-search-button" class="col-lg-5 cntrs">
									<span class="cur-pointer"><span>Search Institution</span> <img
										src="Banks/images/search-icons.png" alt="Search Institution"
										title="Search Institution" class="search-icons"></span>
								</div>

							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- /.container-fluid -->

	</div>


	<div id="header-search-form-wrap" class="header-search-form-wrap"
		style="display: none;">
		<div class="result-box">
			<div class="head-bg-color">Search Results</div>
			<form name="CollList" role="search" method="get"
				class="header-search-form search-form container" action="#">
				<div class="row scrollingparts">
					<div class="col-lg-12 col-md-12 col-sm-12">
						<div class="col-lg-12 col-md-12 col-sm-12">

							<div class="col-lg-12 col-md-12 col-sm-12 pand-both">
								<div class="col-lg-12 col-md-12 col-sm-12 pad-none">
									<!-- ANISH -->
									<table id="example" cellspacing="0" style="width: 200%;">
										<thead>
											<tr>
												<th class="srl-no">S. No.</th>
												<th class="col-names">College Name</th>
												<th>Link</th>
											</tr>
										</thead>

										<tbody>
											<%
												int i = 1;
											%>
											<%-- <s:iterator value="collegelst"> --%>
											<%
												Iterator<CollegeBean> it=collegeList.iterator();
											%>
											<%
												while(it.hasNext()){
																																																CollegeBean bean=it.next();
																																																
											
											%>

											<tr>
												<td><%=i%></td>
												<%-- <td class="clnt-logo"><span class="clientlogo">
												<img name="colImg<%=i %>" height="40" width="40"
														src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(bean.getCollegeImage())%>"></span><%=bean.getCollegeName()%></td> --%>
												<td><a
													href="StartUrl?bid=<%=bean.getBankDetailsOTM().getBankId()%>&cid=<%=bean.getCollegeId()%>&redirectedFrom=Bank">
														GO </a></td>
												<%
													i++;
												%>
											</tr>
											<%
												}
											%>
											<%-- 		</s:iterator> --%>
										</tbody>
									</table>

								</div>
							</div>

						</div>
					</div>
				</div>
			</form>
		</div>
	</div>



	<!-- Header -->
	<header>
		<div class="container pad-none">
			<div class="slider-container pad-none">
				<div class="col-sm-12">
					<div class="col-sm-8 pad-none">
						<div class="intro-text">
							<ul class="accordion-tabs-minimal">
								<li class="tab-header-and-content">
								
								<a href="#tab_content1"
									class="tab-link is-active"><span class="pay"></span>&nbsp;Pay
										Fee</a>
								<div class="tab-content" style="display: block;" id="tab_content1">
										<span class="main_header">Pay Your Fee with <%= bankName %></span>



										<%-- <div class="col-sm-12 labeling">
											<label for="exampleInputEmail1"
												class="col-sm-5 col-form-label labeling">Service
												Type <span class="redalert">*</span>
											</label>
											 <div class="col-sm-6">
												<select class="form-control valid" id="SelectService"
													name="stateLists" aria-invalid="false">
													<option>---Select Services---</option>
													<s:iterator value="servicesList">
														<option value="<s:property value="serviceId" />"><s:property
																value="serviceName" /></option>
													</s:iterator>
												</select>
											</div> 
										</div>  --%>
										<div class="col-sm-12 labeling">
											<label for="exampleInputEmail1"
												class="col-sm-5 col-form-label labeling">State of
												Corporate/Institution <span class="redalert">*</span>
											</label>
											<div class="col-sm-6">
												<select class="form-control valid" id="SelectState"
													name="stateLists" aria-invalid="false"
													onchange="getCollegeList(this.value)">
													<option>---Select State---</option>
													<c:forEach items="${stateList}" var="stateBean">
														
															<option value='${stateBean.stateId}'>
															${stateBean.stateName}
															</option>
														</c:forEach>
												</select>
											</div>
										</div>
										<div class="col-sm-12 labeling" id="collegeList">
											<label for="exampleInputEmail1"
												class="col-sm-5 col-form-label labeling">Name of
												Institution <span class="redalert">*</span>
											</label>
											<div class="col-sm-6">
											
											
											
												<select class="form-control valid" id="collegeSelect"
													aria-invalid="false">
													<option>---Select Institutions---</option>

												</select>
											</div>
										</div>

										<div class="col-md-12 cntrs labeling">

											<div id="proceedForward" class="col-md-12 cntrs lft-cor">
												<a href="javascript:call_func();"><button type="submit"
														class="btn">Back</button></a>

												<button type="submit" class="btn"
													onclick="return ValidateSubmit()">Submit</button>
											</div>

										</div>


										<div class="col-md-12 labeling impt">
											<ul>
												<li>Mandatory fields are marked with an asterisk (<span
													class="redalert">*</span>)
												</li>
												<li><b> <%if(bankName.equals("Allahabad Bank")){%>
														ALLBANK <%}else{ %> <%= bankName %> <%} %> QwikForms
												</b>is a unique service for paying online to educational
													institutions, temples, charities and/or any other
													corporates/institutions who maintain their accounts with
													the Bank.</li>
											</ul>
										</div>

									</div>	
								</li>
								
									
									
									
									
							</ul>
						</div>
					</div>

					<div class="col-sm-4">

						<%if(bankName.equals("Allahabad Bank")){%>

						<div class="intro-text">
							<div class="add-section-rhs">
								<!--<img src="Banks/images/adds-1-<%=bid%>.png" class="add-size">-->
								<img src="Banks/images/adds-1-4.png" class="add-size">
							</div>
							<div class="add-section-rhs">
								<img src="Banks/images/smalladd.png" class="add-size">
							</div>
						</div>

						<%}else{ }%>
						
						<%if(bid.equals("31")){%>

						<div class="intro-text">
							<div class="add-section-rhs">
								<!--<img src="Banks/images/adds-1-<%=bid%>.png" class="add-size">-->
								<span>
									<a href="https://services.sabpaisa.in/pages/siddharthcollegemumbai.html" target="_blank" style="color:#fff; padding:25px 0;">
								<img src="Banks/images/DCB/DCBbank.png" alt="For Siddharth College Of Commerce & Economics Click here" title="For Siddharth College Of Commerce & Economics Click here" class="add-size">								
									</a>
								</span>
							</div>
						</div>

						<%}else{ }%>
					</div>

				</div>

			</div>
		</div>
	</header>
	<section id="testimonial" class="alizarin-nth"
		style="margin-bottom: 10px;">
		<div class="container">

			<div class="row ">

				<div class="col-md-4 col-sm-6 sec-color">
					<div class="media">
						<div class="pull-left">
							<!--<i class="icon-windows icon-md"></i>-->
							<span class="icon-windows- icon-md-wht"><img
								src="Banks/images/stepfirst.png" class="sze-"></span>
						</div>
						<div class="media-body">
							<h3 class="media-heading">QwikForms</h3>
							<p>Powerful dymanic form builder for setting collection
								platform in few mins.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->

				<div class="col-md-4 col-sm-6 sec-color">
					<div class="media">
						<div class="pull-left">
							<!--<i class="icon-android icon-md"></i>-->
							<span class="icon-windows- icon-md-wht"><img
								src="Banks/images/stepsecond.png" class="sze-"></span>
						</div>
						<div class="media-body">
							<h3 class="media-heading">SabPaisa</h3>
							<p>Payment Gateway with Online and Offline Mode.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->

				<div class="col-md-4 col-sm-6 sec-color">
					<div class="media">
						<div class="pull-left">
							<!--<i class="icon-apple icon-md"></i>-->
							<span class="icon-windows- icon-md-wht"><img
								src="Banks/images/stepthird.png" class="sze-"></span>
						</div>
						<div class="media-body">
							<h3 class="media-heading">Settlement</h3>
							<p>Settle millions of transaction in one click.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->

			</div>

		</div>
	</section>
	
	<%if(bid.equals("19") || bid.equals("4")){%>
	<section>
			<div class="container">
				<div class="row">
					<div class="col-md-7 col-sm-7">
						<h3>Demo Center</h3>
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
						  <li class="nav-item active">
							<a class="nav-link" data-toggle="tab" href="#QCPG" role="tab">Payment Gateway</a>
						  </li>
						  <li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#QCFORM" role="tab">Q Form</a>
						  </li>
						  <li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#QCReports" role="tab">Reports</a>
						  </li>
						  <li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#SPApp" role="tab">Mobile App.</a>
						  </li>
						  <%if(bid.equals("19")){%>
						  <li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#BOI" role="tab">BOI QwikCollect Presentation</a>
						  </li>
						  <%}%>
						  
						</ul>
						
						<!-- Tab panes -->
						<div class="tab-content">
						  <div class="tab-pane active" id="QCPG" role="tabpanel">
							<h4>Payment Gateway</h4>
							<ul class="listmarg">
								<li><a href="https://securetest.sabpaisa.in/SabPaisaClientTest/payLink?clientCode=JNCM1" target="_blank">Payment Gateway Demo</a></li>								
							</ul>
						  </div>
						  <div class="tab-pane" id="QCFORM" role="tabpanel">
							<h4>Q Form</h4>
							<ul class="listmarg">
							<%--	<li><a href="https://qwikforms.in/QwikForms/StartUrl?bid=19&cid=2602" target="_blank">Q Form Demo</a></li> --%>
								<li><a href="https://www.qwikcollect.in/QwikCollect/Start.jsp?bid=19&cid=2602" target="_blank">Q Form Demo</a></li>
							</ul>
						  </div>
						  <div class="tab-pane" id="QCReports" role="tabpanel">
							<h4>Reports</h4>
							<ul class="listmarg">
								<li><a href="https://qwikforms.in/QwikForms/" target="_blank">Q Form Report</a></li>
								<li><strong>UserID</strong> - Jnc710@sp<br/><strong>Password</strong> - 5e3XaNg1cG </li>
								<li><a href="https://securepay.sabpaisa.in/SabPaisa/getClientTransactions" target="_blank">Payment Gateway Report</a></li>
								<li><strong>UserID</strong> - Jnc710@sp<br/><strong>Password</strong> - 5e3XaNg1cG </li>
								
							</ul>
						  </div>
						  <div class="tab-pane" id="SPApp" role="tabpanel">
							<h4>Mobile App.</h4>
							<ul class="listmarg">
								<li><a href="https://linkpaisa.in/KqH5" target="_blank">Social Payment App <br/><img src="https://www.sabpaisa.in/images/googleplay.png"/></a></li>
							</ul>
						  </div>
						  
						  <%if(bid.equals("19")){%>
						  <div class="tab-pane" id="BOI" role="tabpanel">
							<h4>BOI QwikCollect Presentation</h4>
							<ul class="listmarg">
								<li><a href="Banks/images/BOI-QwikCollect-Presentation-0919.pdf" download>Click here for download Presentation <img src="Banks/images/download.png" style="width:20px;"/></a></li>
							</ul>
						  </div>
						   <%}%>
						  
						  
						</div>
					</div>
					
					<div class="col-md-5 col-sm-5">
						<h3>Support Center</h3>
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
						  <li class="nav-item active">
							<a class="nav-link" data-toggle="tab" href="#Enquiry" role="tab">Request Callback/Enquiry</a>
						  </li>
						  <li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#Ticket" role="tab">Raise a Ticket</a>
						  </li>
						</ul>
						
						<!-- Tab panes -->
						<div class="tab-content">
						  <div class="tab-pane active" id="Enquiry" role="tabpanel">
							<!--First form start here-->
								<h4>Request Callback/Enquiry</h4>								
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="form-group col-lg-12 col-md-6 col-sm-6 col-xs-12">
										<label>Name</label>
										<input class="form-control" name="text" id="fname" autofocus
											placeholder="Your Name *" type="Name" required />

									</div>
									<div class="form-group col-lg-12 col-md-6 col-sm-6 col-xs-12">
										<label>Email</label>
										<input class="form-control" name="email" id="femail" autofocus
											placeholder="Your e-mail *" type="email" />
									</div>
									<div class="form-group col-lg-12 col-md-6 col-sm-6 col-xs-12">
										<label>Phone</label>
										<input class="form-control" name="number" id="fmno" autofocus
											placeholder="Phone Number *" type="number" pattern="[0-9]{5}[-][0-9]{7}[-][0-9]{1}" />
									</div>
									<div class="form-group col-lg-12 col-md-12 col-sm-12 col-xs-12">
										<label>Requirment</label>
										<textarea class="form-control" name="comment" id="fbody" required
											placeholder="Please write your message here..." rows="3"></textarea>
									</div>
								<% if(bid == "19"){ %>
								
									<input type="hidden" class="form-control" name="RequestsupportEmail" id="RequestsupportEmailID" value="sanjay.kapri@sabpaisa.in"/>
								<% }else if(bid == "4"){ %>	
									<input type="hidden" class="form-control" name="RequestsupportEmail" id="RequestsupportEmailID" value="sourav.ghosh@sabpaisa.in"/>
								<% }else if(bid == "28"){ %>	
									<input type="hidden" class="form-control" name="RequestsupportEmail" id="RequestsupportEmailID" value="sanjay.kapri@sabpaisa.in"/>
								<% }else { %>	
									<input type="hidden" class="form-control" name="RequestsupportEmail" id="RequestsupportEmailID" value="noreply@sabpaisa.in"/>
									<%}%>
									<input type="hidden" class="form-control" name="RequestnoreplyEmail" id="RequestnoreplyEmailID" value="noreply@sabpaisa.in"/>
									
									<button class="btn btn-primary pull-right" name="submit" type="submit" onclick="callBackEnquiryRequest()">Send</button>
									<center>
									<h3>
										<font color="GREEN"><span id="callBackEnquiryMsg"></span></font>
									</h3>
								</center>
									
								</div>
							
							<!--First form End here-->	
						</div>
						  
						  <div class="tab-pane" id="Ticket" role="tabpanel">
							
							<!--Start second form -->
							<h4>Raise a Ticket</h4>								
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="form-group col-lg-12 col-md-6 col-sm-6 col-xs-12">
										<label>Name</label>
										<input class="form-control" name="text" id="name" autofocus
											placeholder="Your Name *" type="Name" />

									</div>
									<div class="form-group col-lg-12 col-md-6 col-sm-6 col-xs-12">
										<label>Email</label>
										<input class="form-control" name="email" id="email" autofocus
											placeholder="Your e-mail *" type="email" />
									</div>
									<div class="form-group col-lg-12 col-md-6 col-sm-6 col-xs-12">
										<label>Phone</label>
										<input class="form-control" name="number" id="mno" autofocus
											placeholder="Phone Number *" type="number" pattern="[0-9]{5}[-][0-9]{7}[-][0-9]{1}"  />
									</div>
									<div class="form-group col-lg-12 col-md-6 col-sm-6 col-xs-12">
										<label>Institution/Department Name</label>
										<input class="form-control" name="text" id="btype" autofocus
											placeholder="Institution/Department Name *" type="Name" />

									</div>
									<div class="form-group col-lg-12 col-md-12 col-sm-12 col-xs-12">
										<label>Other details</label>
										<textarea class="form-control" name="comment" id="body" required
											placeholder="Please write your message here..." rows="3"></textarea>
									</div>
									<input type="hidden" class="form-control" name="supportEmail" id="supportEmailID" value="support@sabpaisa.in"/>
									<input type="hidden" class="form-control" name="noreplyEmail" id="noreplyEmailID" value="support@sabpaisa.in"/>
									
									<button class="btn btn-primary pull-right" name="submit"
										type="submit" onclick="raiseTicket()" style='margin-bottom: 10px;'>Send</button>
								</div>
								<div class="form-group col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<center>
										<h3>
											<font color="GREEN"><span id="riseTicketMsg"></span></font>
										</h3>
									</center>
									</div>								
							<!--End second form -->
						  </div>
						 

						</div>
					</div>
					
					
				</div>
			</div>
	</section>	
	
	<%}else{ }%>
	<footer>
		<div class="container text-center">
		
			<p>Copyright &copy;<script>document.write(new Date().getFullYear());</script> powered by <a href="http://www.sabpaisa.in/" alt="SabPaisa" title="SRS Live Technologies Pvt Ltd - SabPaisa">SabPaisa.</a>.</p>
			<ul class="footer-ul">
				<li><a href="https://www.sabpaisa.in/#Contact" target="_blank">Contact Us</a></li>
				<li><a href="https://www.sabpaisa.in/privacypolicy.html" target="_blank">Privacy Policy</a></li>
				<li><a href="https://www.sabpaisa.in/termscondition.html" target="_blank">Terms & Conditions</a></li>
				<li><a href="https://www.sabpaisa.in/disclaimer.html" target="_blank">Disclaimer</a></li>
			</ul>
		</div>
	</footer>




	<!-- Bootstrap core JavaScript
			================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->

	<!--<script src="Banks/js/jquery.easing.min.js"></script>-->

	
	<script src="Banks/js/jquery.min.js"></script>
	<script src="Banks/js/bootstrap.min.js"></script>
	<script src="Banks/js/owl.carousel.min.js"></script>
	<script src="Banks/js/cbpAnimatedHeader.js"></script>
	<script src="Banks/js/theme-scripts.js"></script>
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="Banks/js/ie10-viewport-bug-workaround.js"></script>
	<script src="Banks/js/index.js"></script>
	<script>
		$(document).ready(function() {
			$(".slidingDiv").hide();
			$(".show_hide").show();

			$('.show_hide').click(function() {
				$(".slidingDiv").slideToggle();
			});

		});
	</script>
	<script>
		$('#feedback-form').hide();
		$('#feedback-tab').click(function() {
    	$('#feedback-form').slideToggle(400);
    		return false;
		});
	</script>

	<script>
		$(function() {
			$("#feedback-tab").click(function() {
					$("#feedback-form").toggle("slide");
			});

			$("#feedback-form form").on('submit', function(event) {
				var $form = $(this);
				$.ajax({
					type: $form.attr('method'),
					url: $form.attr('action'),
					data: $form.serialize(),
					success: function() {
						$("#feedback-form").toggle("slide").find("textarea").val('');
					}
				});
				event.preventDefault();
			});
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("select").change(function(){
				$(this).find("option:selected").each(function(){
					if($(this).attr("value")=="individual-box"){
						$(".councils").not(".individual-box").hide();
						$(".individual-box").show();
					}
					else if($(this).attr("value")=="institue-box"){
						$(".councils").not(".institue-box").hide();
						$(".institue-box").show();
					}
					
				});
			}).change();
		});
		</script>


	<script type="text/javascript">
		$(document).ready(function() {
			if (!$.browser.webkit) {
				$('.scrollingparts').jScrollPane();
			}
		});
	</script>
	


	<%-- <script>
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-35669820-1' ]);
		_gaq.push([ '_trackPageview' ]);

		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl'
					: 'http://www')
					+ '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
	</script> --%>
	<script>
		(function() {
			var po = document.createElement('script');
			po.type = 'text/javascript';
			po.async = true;
			po.src = 'Banks/js/plusone.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(po, s);
		})();
	</script>



	<script>
		$(document).ready(function() {
			$(function() {
				$("#search").autocomplete({
					source : function(request, response) {
						$.ajax({
							url : "SearchController",
							type : "GET",
							data : {
								term : request.term
							},
							dataType : "json",
							success : function(data) {
								response(data);
							}
						});
					}
				});
			});
		});
		
		
		

function getCollegeList(stateId) {	
			
			//var e = document.getElementById("SelectService");
			//var serviceId = e.options[e.selectedIndex].value;
			var bid2 = document.getElementById("bankId");			
			var bankId ='<%=bid%>';
			//lert("BankId >> "+bid2+", Bankkkkkk Id >> "+bankId );
			var query = "?stateId="+stateId+"&bid="+bankId;
			
			var xmlhttp;
			if (window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			} else {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					//alert("Response >> "+xmlhttp.responseText);
					document.getElementById("collegeList").innerHTML = xmlhttp.responseText;
				}
			}
			//alert("Url >> bankClientbysid"+query);
			//xmlhttp.open("GET", "getCollegeListBasedOnStateId" + query, true);
			xmlhttp.open("GET", "bankClientbysid" + query, true);
			xmlhttp.send();

		}
		function selectedCollegeId(){
			
			cid=document.getElementById("collegeSelect").value;
			
		}
		
		function redirectFunction(){
		var bid1 ='<%=bid%>';
	     window.location="StartUrl?bid="+bid1+"&cid="+cid;	
	     
		}

	
	</script>

	<script type="text/javascript">
    function ValidateSubmit() {
        var ddlstate = document.getElementById("SelectState");
        var ddlcollege = document.getElementById("collegeSelect");
        if (ddlstate.value == ""||ddlstate.value == "---Select State---") {
            //If the "Please Select" option is selected display error.
            alert("Please select State!");
            return false;
          
        }
        if (ddlcollege.value == ""||ddlcollege.value == "---Select Institutions---") {
            //If the "Please Select" option is selected display error.
            alert("Please select an Institutions!");
            return false;
        }
        var bid1 ='<%=bid%>';
        
        window.open('StartUrl?bid='+bid1+'&cid='+cid+'&redirectedFrom=Bank', '_self');
        return true;
    }
    
    
    function populateBankLogos(){
    	
    	var elements = document.forms["CollList"].elements;
    	for(i=0;i<elements.length;i++){
    		alert('trying');
    		alert('element name is'+elements[i].name);
    		
    		if(elements[i].id=='colImg'+(i+1))
    		alert('ok'+i);
    	}
    	
    }
    
    function call_func(){
		
		var bankLink ='<%=bankLink%>';

			window.location.href = bankLink;

		}
	
		
	</script>
	
	<script type="text/javascript">
		function myfunction() {

			var dvPassport = document.getElementById("header-search-form-wrap");
			dvPassport.style.display = "none";
		}
	</script>


	
	<script type="text/javascript">
	
	function raiseTicket() {
			//alert("Start of raiseTicket()");
			var toBankEmailId='<%=bankEmailId%>';
			var bankName='<%=bankName%>';
			var toMailId = "support@sabpaisa.in";
			var name = document.getElementById("name").value;
			var btype = document.getElementById("btype").value;
			var userMailId = document.getElementById("email").value;
			var body = document.getElementById("body").value;
			var mob = document.getElementById("mno").value;

			if (name == "" || btype == "" || body == "" || mob == "" || userMailId == "") {
				alert("Please fill Ticket Form !!!")
				return false;
			}
			//alert("fromMail " +userMailId+", bankName "+bankName);
			var url = "raiseTicket?fromMail="+userMailId+"&toMail="+toMailId+"&nameOfUser="+name
					+"&mailBodyContent="+body+ "&businessType="+btype
					+"&userMobile="+mob+"&bankHodMailId="+toBankEmailId+"&bankName="+bankName;

			var xmlhttp;
			if (window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			} else {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					hello2();

					alert("Your Ticket is Submitted Succesfully");
					document.getElementById("riseTicketMsg").innerHTML = xmlhttp.responseText;
				}
			};
			try {
				//	alert("url=" + url);
				xmlhttp.open("GET", url, true);
				xmlhttp.send();

			} catch (e) {
				alert("unable to connect to server");
			}
		}//end of raiseTicket
	
	function hello2() {
		document.getElementById("name").value = "";
		document.getElementById("btype").value = "";
		document.getElementById("email").value = "";
		document.getElementById("body").value = "";
		document.getElementById("mno").value = "";

	}
		
	</script>
	
	<script type="text/javascript">
	
	function callBackEnquiryRequest() {
			var toBankEmailId ='<%=bankEmailId%>';
			var bankName='<%=bankName%>';
			var RequestsupportMailId ="support@sabpaisa.in";
			var requestnoReplyFromMailId="noreply@sabpaisa.in";
			requestsupportMailId =document.getElementById("RequestsupportEmailID").value;
			requestnoReplyFromMailId=document.getElementById("RequestnoreplyEmailID").value;
			var firstName = document.getElementById("fname").value;
			var requestuserMailId = document.getElementById("femail").value;
			var mailBody = document.getElementById("fbody").value;
			var mobNo = document.getElementById("fmno").value;
			var responseMsg="Your enquiry has been successfully submitted!!";
			if (firstName == "" || requestsupportMailId == "" || mailBody == "" || mobNo == "" || requestuserMailId == "") {
				alert("Please fill Request Callback/Enquiry!")
				return false;
			}
			
			/*alert("fromMail " +requestuserMailId+" to " +requestsupportMailId+", bankName "+bankName+", nameMail  "+firstName+", bodyMail  "+mailBody+", mobile  "+mobNo); */
			
			/* var url = "callBackEnquery?fromMail=" +requestuserMailId+ "&nameMail="
					+firstName+ "&bodyMail=" +mailBody+ "&to=" +requestsupportMailId + "&mobile=" 
					+ mobNo + "&bankname=" +bankName+"&toBankEmailId="+toBankEmailId; */
			
			var url = "callBackEnquery?fromMail="+requestuserMailId+"&toMail="+requestsupportMailId+"&nameOfUser="+firstName
				+"&mailBodyContent="+mailBody+"&userMobile="+mobNo
				+"&bankHodMailId="+toBankEmailId+"&bankName="+bankName;
			var xmlhttp;
			if (window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			} else {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					hello2();
					alert("Your Enquery Submitted, You Will Get reply mail soon");
					callBackEnqueryReply(bankName,requestuserMailId,requestnoReplyFromMailId);
					document.getElementById("callBackEnquiryMsg").innerHTML = responseMsg;
				}

			};
			try {
				//	alert("First Time Mail >> url=" + url);
				xmlhttp.open("GET", url, true);
				xmlhttp.send();
			} catch (e) {
				alert("unable to connect to server");
			}

		}
	
	function callBackEnqueryReply(bankName,to,fromMail) {
		
		//alert(" Reply to User >>> bankName" +bankName+" to "+ to+ " fromMail "+fromMail  );
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				//document.getElementById("Requestmessage").innerHTML = xmlhttp.responseText;
			}

		};
		try {
			//alert("Reply Mail >>>> fromMail " +fromMail+" tomail " +to+", bankName "+bankName);			
			var url1 = "sendReplyMailRequest?fromMail="+fromMail+"&toMail="+to+"&bankName="+bankName;
			xmlhttp.open("GET", url1, true);
			xmlhttp.send();

		} catch (e) {
			alert("unable to connect to server");
		}
		
	}
	
	</script>
		
	</body>

	</html>
