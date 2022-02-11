<%@page import="com.sabpaisa.qforms.beans.LoginBean"%>
<!DOCTYPE html>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>

<meta charset="utf-8">
<title>QwikForms-Please Wait..</title>
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

<body onload="submitForm()">

	<%
		String payeeProfile = session.getAttribute("PayeeProfile").toString();
		String cid = session.getAttribute("cid").toString();
		String bid = session.getAttribute("bid").toString();
		String feeName = session.getAttribute("feeName").toString();
		String transId = session.getAttribute("transId").toString();
		String transAmounts = session.getAttribute("transAmounts").toString();
		
		try{
		System.out.print("profie is :profile:"+payeeProfile);
		} catch (NullPointerException e) {
	%>
		<script type="text/javascript">
		window.location="timeIntervalPage";
	</script>
	<%
		}
	%>
	
	
	
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
					<div class="box-content">
						<h2>Please Wait while we forward you to Sabpaisa</h2>
					</div>


					<form action="TestClient" id="spForm" method="get"
						style="display: none">
						<table>
						<c:choose>
						<c:when test='${null!=beanTransData}'>
						
							<tr>
								<td>Client Code</td>
								<td><input type="text" name="clientCode"
									required="required" value="QWK"></td>
							</tr>
							<tr>
								<td>Username</td>
								<td><input type="text" name="username" required="required"
									value=""></td>
							</tr>
							<tr>
								<td>Password</td>
								<td><input type="text" name="pass" required="required"
									value=""></td>
							</tr>
							<tr>
								<td>Transaction ID</td>
								<td><input type="text" name="txnid" required="required"
									value='<c:out value="${beanTransData.transId}"/>'></td>
							</tr>
							<tr>
								<td>Transaction Amount</td>
								<td><input type="text" name="amt" required="required"
									value='<c:out value="${beanTransData.transAmount}"/>'></td>
							</tr>
							<tr>
								<td>Success URL</td>
								<td><input type="text" name="success"></td>
							</tr>
							<tr>
								<td>Failure URL</td>
								<td><input type="text" name="failure"></td>
							</tr>
							<tr>
								<td>Payee First Name</td>
								<td><input type="text" name="fn"
									value='<c:out value="${beanTransData.transForm.name}"/>'></td>
							</tr>
							<tr>
								<td>Payee Contact</td>
								<td><input type="text" name="con"
									value='<c:out value="${beanTransData.transForm.contact}"/>'></td>
							</tr>
							<tr>
								<td>Payee Email</td>
								<td><input type="text" name="email"
									value='<c:out value="${beanTransData.transForm.email}"/>'></td>
							</tr>
							<tr>
								<td>Form Start Date</td>
								<td><input type="text" name="formStartDate"
									value='<c:out value="${beanTransData.transForm.formStartDate}"/>'></td>
							</tr>

							<tr>
								<td>Form End Date</td>
								<td><input type="text" name="formEndDate"
									value='<c:out value="${beanTransData.transForm.formEndDate}"/>'></td>
							</tr>
							
							<tr>
								<td>Payee Profile</td>
								<td><input type="text" name="payeeProfile"
									value='<%=payeeProfile%>'></td>
							</tr>
							<tr>
								<td>client Id</td>
								<td><input type="text" name="cid"
									value='<c:out value="${beanTransData.cid}"/>'></td>
							</tr>
							<tr>
								<td>Banker Id</td>
								<td><input type="text" name="bid"
									value='<c:out value="${beanTransData.bid}"/>'></td>
							</tr>
							<tr>
								<td>Fee Name</td>
								<td><input type="text" name="feeName"
									value='<c:out value="${beanTransData.feeName}"/>'></td>
							</tr>
							<tr>
								<td>Form Id</td>
								<td><input type="text" name="currentFormIdForReviewed"
									value='<c:out value="${currentFormId}"/>'></td>
							</tr>
						</c:when>
						<c:otherwise>
							
							<tr>
								<td>Client Code</td>
								<td><input type="text" name="clientCode"
									required="required" value="QWK"></td>
							</tr>
							<tr>
								<td>Username</td>
								<td><input type="text" name="username" required="required"
									value=""></td>
							</tr>
							<tr>
								<td>Password</td>
								<td><input type="text" name="pass" required="required"
									value=""></td>
							</tr>
							<tr>
								<td>Transaction ID</td>
								<td><input type="text" name="txnid" required="required"
									value='<%=transId%>'></td>
							</tr>
							<tr>
								<td>Transaction Amount</td>
								<td><input type="text" name="amt" required="required"
									value='<%=transAmounts%>'></td>
							</tr>
							
							<tr>
								<td>Success URL</td>
								<td><input type="text" name="success"></td>
							</tr>
							<tr>
								<td>Failure URL</td>
								<td><input type="text" name="failure"></td>
							</tr>
							<tr>
								<td>Payee First Name</td>
								<td><input type="text" name="fn"
									value='<c:out value="${beanTransData.transForm.name}"/>'></td>
							</tr>
							<tr>
								<td>Payee Contact</td>
								<td><input type="text" name="con"
									value='<c:out value="${beanTransData.transForm.contact}"/>'></td>
							</tr>
							<tr>
								<td>Payee Email</td>
								<td><input type="text" name="email"
									value='<c:out value="${beanTransData.transForm.email}"/>'></td>
							</tr>
							<tr>
								<td>Form Start Date</td>
								<td><input type="text" name="formStartDate"
									value='<c:out value="${beanTransData.transForm.formStartDate}"/>'></td>
							</tr>

							<tr>
								<td>Form End Date</td>
								<td><input type="text" name="formEndDate"
									value='<c:out value="${beanTransData.transForm.formEndDate}"/>'></td>
							</tr>
							<tr>
								<td>client Id</td>
								<td><input type="text" name="cid"
									value='<%=cid%>'></td>
							</tr>
							<tr>
								<td>Banker Id</td>
								<td><input type="text" name="bid"
									value='<%=bid%>'></td>
							</tr>
							<tr>
								<td>Fee Name</td>
								<td><input type="text" name="feeName"
									value='<%=feeName%>'></td>
							</tr>
							<tr>
								<td>Payee Profile</td>
								<td><input type="text" name="payeeProfile"
									value='<%=payeeProfile%>'></td>
							</tr>
							<tr>
								<td>Form Id</td>
								<td><input type="text" name="currentFormIdForReviewed"
									value='<c:out value="${currentFormId}"/>'></td>
							</tr>
						</c:otherwise>
						</c:choose>
						</table>
					</form>
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
		function submitForm() {
			document.getElementById("spForm").submit();
		}
	</script>
</body>
</html>
