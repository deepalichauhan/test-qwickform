<!DOCTYPE html>
<html lang="en-US" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SabPaisa</title>
<link rel="shortcut icon" href="SabPaisa/imges/ico/favicons.ico">
<link rel="stylesheet" href="SabPaisa/css/front.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/bootstrap.min.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/animate.min.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/flexslider.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/style.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/font-awesome.min.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/css-style" type="text/css" media="all">
</head>
<body cz-shortcut-listen="true">
<div class="page-loader" style="display: none;">
	<img src="SabPaisa/images/logo.png" alt="loader">
</div>

<!--[if lt IE 8]>
<div class="alert alert-warning">
	You are using an <strong>outdated</strong> browser. Please upgrade your browser</a> to improve your experience.
</div>
<![endif]-->


<!-- Header
================================================== -->
<header id="header">
	<div class="container">
		<div class="logoarea">
			<div class="col-md-4">
				<a class="navbar-brand" href="index.jsp">
				<img src="SabPaisa/images/logo.png" alt="logo">
				</a>
			</div>
			<div class="col-md-8 text-right">
				<div class="headMiddInfo">
					<div class="">
						<div class="hidden-xs singMiddInfo phone">
							<i class="fa fa-phone" aria-hidden="true"></i>
							<h4>PHONE</h4>
							<p>
								011-41733223
							</p>
						</div>
						<div class="hidden-xs singMiddInfo email">
							<i class="fa fa-envelope-o"></i>
							<h4>EMAIL</h4>
							<p>
								sabpaisa@srslive.in
							</p>
						</div>
						
					</div>
					<div class="clearfix">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="mega-menu" class="header header-sticky primary-menu icons-no default-skin fadeIn">
		<nav class="navbar navbar-default redq">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				</button>
			</div>
			<div class="collapse navbar-collapse" id="navbar">
				<a class="mobile-menu-close"><i class="fa fa-close"></i></a>
				<div class="menu-top-menu-container">
					<ul id="menu-top-menu" class="nav navbar-nav nav-list">
						<li class="current-menu-item active"><a href="index.jsp">Home</a></li>
						<li><a href="products.jsp">Modules</a></li>
						<li><a href="client-f.jsp">Clients</a></li>
						<li><a href="our-teams.jsp">Team</a></li>						
						<li class="dropdown"><a title="Pages" data-hover="dropdown" class="dropdown-toggle">SabPaisa<span class="caret"></span></a>
						<ul role="menu" class="sub-menu">
							<li><a href="aboutus.jsp">About Us</a></li>
							<li><a href="faq.jsp">Faq</a></li>
							<li><a href="pricing.jsp">Pricing</a></li>
							<li><a href="http://www.sabpaisa.in/blog/" target="_blank">Blogs</a></li>
							<li><a href="casestudy.jsp">Case Studies</a></li>
							<li><a href="security.jsp">Security</a></li>
							<li><a href="careers.jsp">Careers</a></li>
						</ul>
						</li>
						<li class=" active-tab"><a href="contact.jsp">Contact Us</a></li>
						<li class="dropdown logbg"><a title="Pages" data-hover="dropdown" class="dropdown-toggle">Client Login<span class="caret"></span></a>
						<ul role="menu" class=" sub-menu">
							<li><a href="https://www.qwikcollect.in/FormLinkLlocal/" target="_blank">FormLink</a></li>
							<li><a href="http://clientportal.sabpaisa.in/" target="_blank">SabPaisa</a></li>
							
						</ul>
						</li>
						
					</ul>
				</div>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
		</nav>
	</div>
</header>


<!-- =========================== MAP BEGIN =========================== -->
<section class="margin-bottom50">
	<script src='https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyBkDMVzpxbZJzzWZxjLAQmsk8QnBeO5czQ'></script><div style='overflow:hidden;height:400px;width:100%;'><div id='gmap_canvas' style='height:400px;width:100%;'></div><style>#gmap_canvas img{max-width:none!important;background:none!important}</style></div> <a href='https://www.add-map.net/'>adding google maps to website</a> <script type='text/javascript' src='https://embedmaps.com/google-maps-authorization/script.js?id=8ffd2fdffc9c82eda8d2e8a6aca7ad113aa31675'></script><script type='text/javascript'>function init_map(){var myOptions = {zoom:12,center:new google.maps.LatLng(28.5541775,77.25129170000002),mapTypeId: google.maps.MapTypeId.ROADMAP};map = new google.maps.Map(document.getElementById('gmap_canvas'), myOptions);marker = new google.maps.Marker({map: map,position: new google.maps.LatLng(28.5541775,77.25129170000002)});infowindow = new google.maps.InfoWindow({content:'<strong>SabPaisa</strong><br>H 51,2nd Floor, Sant Nagar , East of Kailash<br>110065 New Delhi<br>'});google.maps.event.addListener(marker, 'click', function(){infowindow.open(map,marker);});infowindow.open(map,marker);}google.maps.event.addDomListener(window, 'load', init_map);</script>
</section>
<!-- =========================== MAP END =========================== -->

<!-- =========================== Contact BEGIN =========================== -->
<section>
	<div class="container">
			<div class="row">
				<div class="col-md-4">
					<div class="the-headline">
								<h1 style="font-size:20px;">DETAILS</h1>
					</div>
					<div class="textwidget"><p><i class="fa fa-map-marker"></i> SRS Live Technologies Pvt Ltd. 51, Sant Nagar, Second Floor, 
East of Kailash, New Delhi - 110065</p>
					<p><i class="fa fa-phone"></i> 011-41733223</p>
					<p><i class="fa fa-envelope"></i> sabpaisa@srslive.in</p>
					<!--<p><i class="fa fa-fax"></i> (106) 4762 8264</p>-->
					<p><i class="fa fa-clock-o"></i> Mon - Sat: 10:00 - 19:00</p>
					</div>
				</div>
				<div class="col-md-8">
					<div class="the-headline">
								<h1 style="font-size:20px;">GET IN TOUCH</h1>
					</div>
					<div class="textwidget">
						<div class="done">
							<div class="alert alert-success">
								<button type="button" class="close" data-dismiss="alert">×</button>
								Your message has been sent. Thank you!
							</div>
						</div>
						<form class="wpcf7-form" method="post" action="http://themepush.com/demo/bizconstruct/main-contact.php" id="pagecontactform">
							<div class="row">
									<div class="col-md-6">
										<input type="text" name="mainname" placeholder="Name" class="form-control">
									</div>
									<div class="col-md-6">
										<input type="text" name="mainemail" placeholder="E-mail" class="form-control">
								  </div>
							</div>
							<br>
							<textarea name="maincomment" rows="4" placeholder="Message" class="form-control"></textarea>
							<br>
							<input type="submit" id="submitmaincontact" class="btn btn-primary" value="Send">
						</form>
					</div>
				</div>
			</div>
		</div>
</section>
<!-- =========================== Contact End =========================== -->


<!-- =========================== FOOTER BEGIN  =========================== -->
<footer id="footer" class="footer2">
	<div class="scrolltop">
		<div class="scroll icon">
			<a href="index.jsp" id="back-to-top"><i class="fa fa-angle-up"></i></a>
		</div>
	</div>
	<div class="inner sep-bottom-md">
		<div class="container">
			<div class="footer-ribbon">
				<a href="contact.jsp">Get in Touch !</a>
			</div>
			<div class="row">
				<div class="col-md-6 col-sm-6">
					<div class="text-2 widget_text">
						<div class="widget sep-top-lg">
							<div class="textwidget">
								<p>
									<img src="SabPaisa/images/footerlogo-1.png" alt="">
								</p>
								<p>
									SabPaisa (SP) is India’s 1st superaggregating collection and settlement techosystem. We partner with banks and payment companies to help businesses collect money from their customers smoothly, and get realtime reconciliation and reports, whether online or offline. 
								</p>
								
							</div>
						</div>
					</div>
					<div class="socialwidget-2 SocialWidget">
						<div class="widget sep-top-lg">
							<div class="social-widget">
								<a target="_blank" href="https://twitter.com/sabpaisa">
								<div class="social-bg">
									<i class="fa fa-twitter"></i>
								</div>
								</a><a target="_blank" href="https://www.facebook.com/sabpaisa/?fref=ts">
								<div class="social-bg">
									<i class="fa fa-facebook"></i>
								</div>
								</a>
								<a target="_blank" href="https://www.linkedin.com/in/sab-paisa-3b3410100">
								<div class="social-bg">
									<i class="fa fa-linkedin"></i>
								</div>
								</a>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-md-3 col-sm-6">
					<div class="text-3 widget_text">
						<div class="widget sep-top-lg">
							<h3 class="upper widget-title">Business Hours</h3>
							<div class="textwidget">
								<p>
									Monday - Saturday: 10am to 7pm<br>
									Sunday: Closed
								</p>
							</div>
						</div>
					</div>
					<div class="text-4 widget_text">
						<div class="widget sep-top-lg">
							<h3 class="upper widget-title">Company Location</h3>
							<div class="textwidget">
								<p>
									SRS Live Technologies Pvt Ltd.<br>
									51, Sant Nagar, Second Floor, <br>
									East of Kailash, New Delhi - 110065
									
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="text-5 widget_text">
						<div class="widget sep-top-lg">
							<h3 class="upper widget-title">Quick Contact</h3>
							<div class="textwidget">
								<div class="done">
									<div class="alert alert-success">
										<button type="button" class="close" data-dismiss="alert">×</button>
										Your message has been sent. Thank you!
									</div>
								</div>
								<form method="post" action="http://themepush.com/demo/bizconstruct/footer-contact.php" id="contactform">
									<div class="form wpcf7-form .form-control">
										<div class="controls controls-row">
											<input type="text" name="name" placeholder="Name" class="form-control"><br>
											<input type="text" name="email" placeholder="E-mail" class="form-control"><br>
										</div>
										<div class="controls">
											<textarea name="comment" rows="4" placeholder="Message" class="form-control"></textarea><br>
										</div>
										<input type="submit" id="submit" class="btn btn-primary" value="Send">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="copyright sep-top-xs sep-bottom-xs">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<small>
					© COPYRIGHT 2016. powered by SRS Live Technologies Pvt Ltd </small>
				</div>
				<div class="col-md-6 text-right">
				</div>
			</div>
		</div>
	</div>
</footer>
<!-- =========================== FOOTER END  =========================== -->

<!-- =========================== SCRIPTS BEGIN  =========================== -->
<script type="text/javascript" src="SabPaisa/js/jquery.js"></script>
<script type="text/javascript" src="SabPaisa/js/jquery.touchSwipe.min.js"></script>
<script type="text/javascript" src="SabPaisa/js/carousel.min.js"></script>
<script type="text/javascript" src="SabPaisa/js/modernizr-2.8.3.min.js"></script>
<script type="text/javascript" src="SabPaisa/js/bootstrap.min.js"></script>
<script type="text/javascript" src="SabPaisa/js/mason.js"></script>
<script type="text/javascript" src="SabPaisa/js/popup.js"></script>
<script type="text/javascript" src="SabPaisa/js/common.js"></script>
<script type="text/javascript" src="SabPaisa/js/flexslider.js"></script>
<script type="text/javascript" src="SabPaisa/js/portfolio.js"></script>
<script type="text/javascript" src="SabPaisa/js/countto.js"></script>
<script type="text/javascript" src="SabPaisa/js/testimonial.js"></script>
<script type="text/javascript" src="SabPaisa/js/main-contact.js"></script>
<!-- =========================== SCRIPTS END  =========================== -->




</body></html>