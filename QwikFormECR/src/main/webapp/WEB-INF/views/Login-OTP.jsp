<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>QwikForms</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
<meta name="author" content="Muhammad Usman">

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

<body>



<%String otp1=(String)request.getAttribute("oTPCode");
String sessPayeeProfil=(String)session.getAttribute("PayeeProfile");
System.out.println("sessPayeeProfil :"+sessPayeeProfil);
int bid=Integer.parseInt((String)session.getAttribute("bid"));
String sessactionType=(String)session.getAttribute("actionType");
int cid=Integer.parseInt((String)session.getAttribute("cid"));
if ((String)session.getAttribute("bid") == null && (String)session.getAttribute("bid")=="" && (String)session.getAttribute("cid")==null && (String)session.getAttribute("cid")=="") {
	response.sendRedirect("Login.jsp");
	return;
}
%>
	<div class="ch-container">
	
		<div class="row">

			<div class="row">
				<div class="col-md-12 center login-header">Please Enter the OTP received on your email/mobile number</h2>
				</div>
				
			</div>
			
			<div class="row">
				<div class="well col-md-5 center login-box">

						<fieldset>
						
							<div id="input-email" class="input-group input-group-lg">
							
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-lock red"></i></span> <input type="password"
									 class="form-control" id="otp"
									required="required" placeholder="One Time Password">
									<input type="hidden" id="hiddenOTPCode" value="<%=otp1%>">
									<input type="hidden" id="sessPayeeProfilId" value="<%=sessPayeeProfil%>">
									<input type="hidden" id="sessactionTypeId" value="<%=sessactionType%>">
									
							</div>
							<p class="center col-md-5">
							<div class="clearfix"></div>
							<div class="clearfix"></div>
							<p class="center col-md-5">
 							<button type="button" class="btn btn-primary"  onclick="verifyOTP()">Proceed</button>
							</p>
							
						</fieldset>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
		</div>
		<!--/fluid-row-->

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
function ToggleInput(x)
{
	var a=document.getElementById("input-email");
	var b=document.getElementById("input-number");
	
	if(x=="email")
		{
		a.style.display="block";
		b.style.display="none";
		}
	if(x=="number")
		{
		a.style.display="none";
		b.style.display="block";
		}
	
	}
	
function verifyOTP(){
	
	
	
	 var code=document.getElementById("hiddenOTPCode").value;
	var userOTP=document.getElementById("otp").value;
	
	
	 var cid1=<%=cid%>;
	 var bid1=<%=bid%>;
	 var PayeeProfile=document.getElementById("sessPayeeProfilId").value;
	 var actionType=document.getElementById("sessactionTypeId").value;
	 
	 
	 if(userOTP==code){
			// alert("your entered code is correct:"+PayeeProfile); 
			
			if(cid1==2 && bid1==2){
				window.location="nitjFeesPaymentForm.jsp";	
			}else if(cid1==3 && bid1==3){
				window.location="noidaPage.jsp";
			
			} else if(cid1==1 && bid1==1 && PayeeProfile=="Student" && actionType=="pay"){
				window.location="choosePaymentForm.jsp";
			
			}else if(cid1==1 && bid1==1 && PayeeProfile=="College" && actionType=="pay"){
				
				window.location="chooseCollege.jsp";
			
			}else if(cid1==1 && bid1==1 && PayeeProfile=="Student" && actionType=="prevtrans"){
				
				window.location="PreviousTransactions.jsp";
			
			}else if(cid1==1 && bid1==1 && PayeeProfile=="College" && actionType=="prevtrans"){
				
				window.location="PreviousTransactions.jsp";
			
			}	
		}else{
			alert("your entered code is incorrect");
		} 
}

	
</script>

</body>
</html>
