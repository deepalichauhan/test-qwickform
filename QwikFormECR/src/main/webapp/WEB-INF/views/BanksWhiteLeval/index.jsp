<!DOCTYPE html>
<%@page import="org.apache.log4j.Logger"%>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="icon" href="images/ico/favicon.ico">
		<title>Disclaimer - SabPaisa</title>
		<!-- Bootstrap core CSS -->
		<link href="Banks/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="Banks/css/font-awesome.min.css">
		<!-- Custom styles for this template -->
		<link href="Banks/css/owl.carousel.css" rel="stylesheet">
		<link href="Banks/css/owl.theme.default.min.css"  rel="stylesheet">
		
		<link href="Banks/css/style.css" rel="stylesheet">
		
		<link href="Banks/css/styledcb.css" rel="stylesheet">
		
		<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
		<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
		<script src="js/ie-emulation-modes-warning.js"></script>
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body id="page-top">
	
	<%
	Logger log = Logger.getLogger("index");
	String bid=	request.getParameter("bid");
	log.info("index.jsp:redirectedFrom value is::"+request.getParameter("redirectedFrom")+", Bid is >> "+bid);
	
	%>
		<!-- Navigation -->
		<!--<nav class="navbar navbar-default navbar-fixed-top">
			<div class="container">
				<div class="navbar-header page-scroll">
					<a class="navbar-brand page-scroll" href="#page-top"><img src="images/allahabad_logo.jpg" alt="allahabad_logo" width="100%" height="100%"></a>
				</div>
			</div>
		</nav>-->
		<!-- Header -->
		
		<section class="light-bg">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="skills-text">
							<h2>You have been redirected to other website.</h2>
							<p>At your request, you are being re-directed to a third party site. Please acknowledge the disclaimer before proceeding further.</p>
							
							<h2><center>Disclaimer</center></h2>
							<p><u><strong>QwikForms</strong></u> : This link is provided on our website for the convenience of the Client and The Bank does not control or endorse this website and The Bank shall not be  responsible for its contents nor for any consequential loss (direct or indirect).</p>
							<p>Before using this website, users must read and understand the user agreement of website and may proceed further only if they agree to abide by the same.  The website may ask to disclose personal information and other details online and therefore the users shall read and understand the privacy policy available on the website, prior to providing such details.</p>
							<p>Any disclosure is at the sole discretion of the users and Bank will not be responsible in any manner for any misuse of the same. In the event of any of the terms arising in conflict to the terms of intermittent websites the terms of such intermittent websites shall prevail. 
							</p>
							<p> Bank shall not be liable for any failure or delay for any cause beyond the control of the bank which may include technology failure, network failure, mechanical breakdown, power disruption, force majeure etc. 
							</p>
							
							<label class="form-check-label"><input class="form-check-input" type="checkbox" id="termsagreement" onclick="showProceed()"> I accept your <a href="https://www.sabpaisa.in/termscondition.html" target="_blank">Terms & Condition</a></label>
							</p>
							
						</div>
						
					</div>
					<center>
					<table>
					
					<tr>
					
					<td>
						<div id="backToBank" class="col-md-12 cntrs">
							<a href="javascript:goBackToBankSite();"><button type="submit" class="btn">Back</button></a>
						</div>
					</td>
					
					
					<td>
						<div id="proceedForward" class="col-md-12 cntrs" style="display:none">
							<%if(null==bid){ %>
							<button onclick="proceedForward('4')" type="submit" class="btn">Proceed</button>
							<%} else {%>
							<button onclick="proceedForward('<%=bid%>')" type="submit" class="btn">Proceed</button>
							<%}%>						

						</div>
					</td>
					
					
					
					
					</tr>
					
					</table>
					
						</center>	
						
					
					
					
				
				</div>
			</div>
		</section>
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
		<script src="Banks/js/bootstrap.min.js"></script>
		<script src="Banks/js/owl.carousel.min.js"></script>
		<script src="Banks/js/cbpAnimatedHeader.js"></script>
		<script src="Banks/js/theme-scripts.js"></script>
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="Banks/js/ie10-viewport-bug-workaround.js"></script>
		
		<script type="text/javascript">
		
		function showProceed(){
			
			  if (document.getElementById('termsagreement').checked) 
			  {
				  
			      document.getElementById('proceedForward').style.display = 'block';
			      
			  } else {

				  
				  document.getElementById('proceedForward').style.display = 'none';
			  }
		}
		
		function proceedForward(bankid){
			
			window.location.href='/QwikForms/StartUrl?bid='+bankid + '&cid=ALL';
			
		}
		
		
		function goBackToBankSite(){
			
			var bid1 ='<%=bid%>';
			
			if (bid1==4) 
			  {
				  
				 window.location.href = 'https://www.allahabadbank.in/';
			      
			  } else {

				  window.location.href = 'https://www.google.co.in/';
				  
			  }
		}
		</script>
	</body>
</html>
