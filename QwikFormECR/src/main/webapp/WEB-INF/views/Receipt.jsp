<!DOCTYPE html>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<body onload="calcTotalFee()">
<%
	Integer sesBid = null, sesCid = null;
	CollegeBean collegeBean = new CollegeBean();
	try {

		sesBid = (Integer) session.getAttribute("BankId");
		sesCid = (Integer) session.getAttribute("CollegeId");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
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
	<%
		AppPropertiesConfig quickCollectProperties = new AppPropertiesConfig();
			Properties properties = quickCollectProperties.getPropValues();

			String qFormsIP = properties.getProperty("qFormsIP");
			String clientLogoLink = properties.getProperty("clientLogoLink");
			String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
			String tot1="";
	%>

	<div class="ch-container">
		<div class="row">




			<div id="content" class="col-lg-12 col-sm-12">
				<!-- content starts -->




				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">

							<div class="box-content">
								<!-- put your content here -->
								<form id="nitForm" action="payForm" method="post">


									<table id="mainForm1">
										<tbody>
											<tr>
												<th colspan="3">

													<div style="text-align: center;">
														<img
															src="<%=collegeBean.getBankDetailsOTM().getBankLogo()%>"
															width="400px" height="100px">
													</div>





												</th>
											</tr>
											<tr>
												<td rowspan="2"><img
													src="<%=collegeBean.getCollegeLogo()%>" width="100px"
													height="100px"></td>
												<td>
													<%
														if(sesCid==1){
													%> <strong>Council of Higher Secondary Education,
														Odisha</strong> <%
 	} else if(sesCid==2) {
 %> NITJ <%
 	} else if(sesCid==3) {
 %> NICSI <%
 	}
 %>
												</td>

											</tr>
											<tr>
												<td><strong>Date:</strong>${beanTransData.transDate } <%-- <s:date
														name="beanTransData.transDate "/> --%></td>
												<td>
												<%  String statusforchse=(String)request.getAttribute("status");
												/*  Subject to realization of Payment*/
												
												if(!statusforchse.contentEquals("Subject to realization of Payment") ){
													
												
												%>
													
													<button type="button" id="printpagebutton"
														title="Click Here to Print Receipt" onclick="printpage()"
															class="btn btn-sm btn-info" 	>
														
														Print
													</button>
													<%} %>
												</td>
											</tr>
											<tr>

												<td colspan="3">e-Receipt For <%=collegeBean.getBankDetailsOTM().getBankname()%>
													Collect Payment
												</td>






												
											</tr>
											
												<tr>

												<td><strong> Reference Number</strong></td>
												<td>${beanTransData.spTransId }</td>
												<!-- <td>UBI002</td> -->
												<td></td>


											</tr>
											<tr>

												<td><strong>Category</strong></td>
												<%-- <td><c:out value="beanTransData.category"/></td> --%>
												<td> ${beanTransData.feeName }<%-- <c:out value="beanTransData.feeName"/> --%>
												
												<!-- Re-admission in Correspondence Course 2nd Year --></td>
												<td></td>


											</tr>
																						<tr>
												<!--<c:out value="beanTransData.transId"/>  -->
											

											</tr>
											<tr>

												<td><strong>Name of Payee</strong></td>
												<td><c:out value="${beanTransData.name }"/>
												
													</td>
												
												<td></td>


											</tr>

											<tr>

												<td><strong>College Address</strong></td>
												<td>
													<c:out value="${beanTransData.collegeBean.state}"/>
													<%-- <strong><%=collegeBean.getState()%></strong> --%>
												</td>

												<td></td>


											</tr>
											
											<tr>

												<td><strong>Total Amount of Fees</strong></td>

												<td id="totalamount">Rs.&nbsp;${beanTransData.transOgAmount }</td>
												
												<td><input type="hidden" id="tAmount"
													value='<c:out value="${beanTransData.transOgAmount }"/>'></td>


											</tr>
											
											<tr>

												<td><strong>Transaction Status</strong></td>

												<td><c:out value="${beanTransData.transStatus }"/></td>
												
												<td></td>


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
		function calcTotalFee() {
			var totalAmount = document.getElementById("tAmount").value;
			var charges = document.getElementById("transCharges").value == null ? 0
					: document.getElementById("transCharges").value;

			/* var totalafterCalc=parseInt(charges)+parseInt(totalAmount);
			
			totalafterCalc=parseInt(totalafterCalc); */

			if (document.getElementById("transCharges").value == null
					|| document.getElementById("transCharges").value == "") {

				charges = 0;

			}

			var totalafterCalc = parseInt(14) + parseInt(totalAmount);

			totalafterCalc = parseInt(totalafterCalc);

			document.getElementById("totlAmt").value = totalafterCalc;
			document.getElementById("totlAmtID").innerHTML = totalafterCalc;

		}

		function GetForm(x) {
			if (x == "1") {
				document.getElementById("mainForm1").style.display = "block";
				document.getElementById("mainForm2").style.display = "none";
			}
			if (x == "2") {
				document.getElementById("mainForm1").style.display = "none";
				document.getElementById("mainForm2").style.display = "block";
			}
		}

		var fee = 0;
		var totfee = 0;
		var hostel = 0;
		var bus = 0;
		var hostelfee = 0;
		var busfee = 0;
		function GetFees(x) {
			document.getElementById("nitForm").reset();
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
			document.getElementById("total").value = fee;
			document.getElementById("hosfee").value = 0;
			document.getElementById("busfee").value = 0;
			totfee = fee;

		}
		function TotalFee(y) {
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
			document.getElementById("hosfee").value = hostelfee;
			document.getElementById("busfee").value = busfee;
			document.getElementById("total").value = fee + busfee + hostelfee;
		}
		function Pay() {
			var linkadd = 'http://49.50.72.228:8080/SabPaisa/index.jsp?Name=Mr.XYZ&amt=7894&client=QuickCollect';
			window.location.href = linkadd;
		}
		function Reset() {
			document.getElementById("nitForm").reset();
		}

		function GetFee1(x) {
			var fee = document.getElementById("total1");
			var fee2 = document.getElementById("fee1");
			if (x == "BT") {
				fee.value = "7894";
				fee2.value = "7894";
			}
			if (x == "CE") {
				fee.value = "4594";
				fee2.value = "4594";
			}
		}
		function GetFee2(x) {
			var fee = document.getElementById("total2");
			var fee2 = document.getElementById("fee2");
			if (x == "BT") {
				fee.value = "2394";
				fee2.value = "2394";
			}
			if (x == "CE") {
				fee.value = "4294";
				fee2.value = "4294";
			}
		}
	</script>

	<script type="text/javascript">
		function printpage() {

			var printButton = document.getElementById("printpagebutton");

			printButton.style.visibility = 'hidden';

			window.print()
			printButton.style.visibility = 'visible';
		}
	</script>





	<%-- <script type="text/javascript" src="toword.js">
	function calcTotalFee(){
		var charges=document.getElementById("tAmount").value;
		var totalAmount=document.getElementById("tcharges").value;
		
		var totalafterCalc=parseInt(charges)+parseInt(totalAmount);
		
		totalafterCalc=parseInt(totalafterCalc);
		document.getElementById("totlAmt").value=totalafterCalc;
		
		var num=toWords(totalafterCalc);
		
		document.getElementById("totlAmtInWd").value=num;
		
		 
	}
	
	
</script> --%>
</body>
</html>
