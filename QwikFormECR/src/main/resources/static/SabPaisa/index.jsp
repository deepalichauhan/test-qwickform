<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<html lang="en-US" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SabPaisa</title>
<!--RitamSoham-->
<link rel="shortcut icon" href="SabPaisa/images/ico/favicons.ico">
<link rel="stylesheet" href="SabPaisa/css/front.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/bootstrap.min.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/animate.min.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/flexslider.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/style.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/font-awesome.min.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/style-new.css" type="text/css" media="all">
<link rel="stylesheet" href="SabPaisa/css/css-style" type="text/css" media="all">
<script type="text/javascript" src="SabPaisa/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="SabPaisa/js/jssor.slider-21.1.6.mini.js"></script>
<script type="text/javascript">
        jQuery(document).ready(function ($) {

            var jssor_1_options = {
              $AutoPlay: true,
              $AutoPlaySteps: 4,
              $SlideDuration: 160,
              $SlideWidth: 214,
              $SlideSpacing: 3,
              $Cols: 3,
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$,
                $Steps: 3
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$,
                $SpacingX: 1,
                $SpacingY: 1
              }
            };

            var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

            /*responsive code begin*/
            /*you can remove responsive code if you don't want the slider scales while window resizing*/
            function ScaleSlider() {
                var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
                if (refSize) {
                    refSize = Math.min(refSize, 900);
                    jssor_1_slider.$ScaleWidth(refSize);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }
            ScaleSlider();
            $(window).bind("load", ScaleSlider);
            $(window).bind("resize", ScaleSlider);
            $(window).bind("orientationchange", ScaleSlider);
            /*responsive code end*/
        });
    </script>
   
</head>
<body cz-shortcut-listen="true">
<div class="page-loader" style="display: none;">
	<img src="SabPaisa/images/loader.gif" alt="loader">
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
				<a class="navbar-brand" href="#">
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
						<li class="current-menu-item active-tab"><a href="Start.jsp?bid=ALL&cid=ALL">Home</a></li>
						<li><a href="SabPaisa/products.jsp">Modules</a></li>
						<li><a href="SabPaisa/client-f.jsp">Clients</a></li>
						<li><a href="SabPaisa/our-teams.jsp">Team</a></li>						
						<li class="dropdown"><a title="Pages" data-hover="dropdown" class="dropdown-toggle">SabPaisa<span class="caret"></span></a>
						<ul role="menu" class="sub-menu">
							<li><a href="SabPaisa/aboutus.jsp">About Us</a></li>
							<li><a href="SabPaisa/faq.jsp">Faq</a></li>
							<li><a href="SabPaisa/pricing.jsp">Pricing</a></li>
							<li><a href="http://www.sabpaisa.in/blog/" target="_blank">Blogs</a></li>
							<li><a href="SabPaisa/casestudy.jsp">Case Studies</a></li>
							<li><a href="SabPaisa/security.jsp">Security</a></li>
							<li><a href="SabPaisa/careers.jsp">Careers</a></li>
						</ul>
						</li>
						<li><a href="SabPaisa/contact.jsp">Contact Us</a></li>
						<li class="dropdown logbg"><a title="Pages" data-hover="dropdown" class="dropdown-toggle">Client Login<span class="caret"></span></a>
						<ul role="menu" class=" sub-menu">
							<li><a href="https://www.qwikcollect.in/FormLinkLocal/" target="_blank">FormLink</a></li>
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
	
<!-- =========================== SLIDER BEGIN =========================== -->
<section class="margin-bottom30">


<div class="container">

<div class="bank-form col-lg-6 pad-none">
	
	<div class="col-lg-11 pad-none">
		<div class="intro-text">
			<ul class="accordion-tabs-minimal">
				<li class="tab-header-and-content">
					<a href="#" class="tab-link is-active"><span class="pay"></span>&nbsp;Pay Fee</a>
					<div class="tab-content">
						<span class="main_header">Pay Your Fee with SabPaisa</span>
						<div class="col-sm-12 labeling no-mpad">
							<label for="exampleInputEmail1" class="col-sm-5 col-form-label labeling no-mlabel">State / City *</label>
							<div class="col-sm-6">
								<select class="form-control valid" id="SelectState"
													name="stateLists" aria-invalid="false"
													onchange="getCollegeList(this.value)">
													<option>---Select State---</option>
													<s:iterator value="stateList">
														<option value="<s:property value="stateId" />"><s:property
																value="stateName" /></option>
													</s:iterator>
												</select>
							</div>
						</div>
						<div class="col-sm-12 labeling no-mpad" id="collegeList">
							<label for="exampleInputEmail1" class="col-sm-5 col-form-label labeling no-mlabel">Educational Institutions Name *</label>
							<div class="col-lg-6 col-md-12 col-sm-12">
								<select class="form-control valid" id="collegeSelect"
													aria-invalid="false">
													<option>---Select Institutions---</option></select>
							</div>
						</div>
						<div class="col-md-12 cntrs labeling">
							<div class="col-sm-5"></div>
							<div class="col-sm-6 cnt">
								<a href="#" onclick="return ValidateSubmit()"><button type="submit" class="btn">Submit</button></a>
							</div>
						</div>
						<div class="col-md-12 labeling impt pad-txt devs">
							<ul>
								<li>Mandatory fields are marked with an asterisk (*)</li>
								<li>SabPaisa is a unique service for paying online to educational institutions, temples, charities and/or any other corporates/institutions who maintain their accounts with the Bank.</li>
							</ul>
						</div>
						
					</div>

				 </li>
			</ul>
		</div>
	</div>
	
</div>

</div>

<div class="customtypewowslider fullwidth flexslider clearfix cayman-slider" style="max-height:490px;">
	<ul class="slides slider-content-style1">
		<li style="background-color: rgb(0, 0, 0); width: 100%; float: left; margin-right: -100%; position: relative; opacity: 1; display: none;" class="flex-active-slide">
		<img src="SabPaisa/images/s1.jpg" alt="" style="opacity:0.5">
		<div class="flex-caption" style="top:2%;">
			<div class="container">
				<div class="row">
					
					<div class="col-md-5 col-md-offset-2- sssl" style="float:right;">
						<h2 class="wow none animated" data-wow-duration="0.5s" data-wow-delay="0.1s" style="visibility: visible; animation-duration: 0.5s; animation-delay: 0.1s;">
						INDIA'S FIRST AND ONLY INTEGRATED PLATFORM FOR BOTH ONLINE AND OFFLINE PAYMENT/COLLECTIONS </h2>
						<h1 class="wow fadeInUp animated" data-wow-duration="1.0s" data-wow-delay="0.6s" style="visibility: visible; animation-duration: 1s; animation-delay: 0.6s; animation-name: fadeInUp;"><span class="accentcolor">SabPaisa</span><br>
						Online / Offline Payment</h1>
						<!--<a href="http://themepush.com/demo/bizconstruct/index.jsp#" class="btn btn-ghost wow none animated" style="visibility: visible;"> OTHER INTEGRATED PRODUCTS FOR COLLECTION AND SETTLEMENT </a>-->
						<span class="btn btn-primary wow none animated" style="visibility: visible; cursor:default;"> OTHER INTEGRATED PRODUCTS FOR COLLECTION AND SETTLEMENT </span>
					</div>
					
					
					
				</div>
			</div>
		</div>
		</li>
	</ul>
	
</div>
</section>
<!-- =========================== SLIDER END =========================== -->

<section class="margin-bottom30-">
			<div class="the-headline text-center">
			<h1><span class="accentcolor">SabPaisa </span>Bank Partners</h1>
			<div class="decoration">
				<div class="decoration-inside">
				</div>
			</div>
			<!--<h3>WE BRING YOU THE AMAZING SERVICES SINCE 1989</h3>-->
		</div>
<div id="jssor_1" style="position: relative; margin: 0 auto; top: 0;  width: 900px; height: 130px; overflow: hidden; background:#fff; ">
		
        <!-- Loading Screen -->
        <div data-u="slides" style="cursor: default; position: relative; top: 0px; left: 16px; width: 900px; height: 100px; ">
            <div>
                <img data-u="image" src="SabPaisa/images/bank/01.png" />
            </div>
            <div style="display: none;">
                <img data-u="image" src="SabPaisa/images/bank/02.png" />
            </div>
            <div style="display: none;">
                <img data-u="image" src="SabPaisa/images/bank/03.png" />
            </div>
            <div style="display: none;">
                <img data-u="image" src="SabPaisa/images/bank/04.png" />
            </div>
            <div style="display: none;">
                <img data-u="image" src="SabPaisa/images/bank/05.png" />
            </div>
            <div style="display: none;">
                <img data-u="image" src="SabPaisa/images/bank/06.png" />
            </div>
			<div style="display: none;">
                <img data-u="image" src="SabPaisa/images/bank/07.png" />
            </div>
			<div style="display: none;">
                <img data-u="image" src="SabPaisa/images/bank/08.png" />
            </div>
           
        </div>
        <!-- Bullet Navigator -->
        
        <!-- Arrow Navigator -->
        <span data-u="arrowleft" class="jssora03l" style="top:0px;left:8px;width:55px;height:55px;" data-autocenter="2"></span>
        <span data-u="arrowright" class="jssora03r" style="top:0px;right:8px;width:55px;height:55px;" data-autocenter="2"></span>
    </div>
    <!-- #endregion Jssor Slider End -->

</section>


<!-- =========================== Products BEGIN =========================== -->
<!--<section class="margin-bottom50">

	
	<div class="container">

		<div class="the-headline text-center">
			<h1><span class="accentcolor">UPI</span> Partner Bank</h1>
			<div class="decoration">
				<div class="decoration-inside">
				</div>
			</div>
			
		</div>

		<div class="sow-services-list">
			<div class="our-services service-icon-list">
				
				<ul class="ubipartner">
					<li><img src="SabPaisa/images/bank/dena.png" alt="Dena Bank" title="Dena Bank"></li>
					<li><img src="SabPaisa/images/bank/088.png" alt="DCB Bank" title="DCB Bank"></li>
					<li><img src="SabPaisa/images/bank/axis.png" alt="Axis Bank" title="Axis Bank"></li>
				</ul>
				

			</div>

		</div>

	</div>

</section>-->
<!-- =========================== Products END =========================== -->



<!-- =========================== Products BEGIN =========================== -->
<section class="margin-bottom50">

	
	<div class="container">

		<div class="the-headline text-center">
			<h1><span class="accentcolor">SabPaisa</span> Modules</h1>
			<div class="decoration">
				<div class="decoration-inside">
				</div>
			</div>
			<h3>Products That Integrate With SabPaisa To Provide Seamless Collection & Settlement</h3>
		</div>

		<div class="sow-services-list">
			<div class="our-services service-icon-list">

				<div class="col-md-6 sow-services-service">
					<div class="content">
						<div class="row">
							<div class="col-md-3">
								<div class="type">
									<span class="sow-icon-fontawesome"><img src="SabPaisa/images/prologo/SabPaisaLite.png" alt="SabPaisa" title="SabPaisa"></span>
								</div>
							</div>
							<div class="col-md-9">
								
								<h3>SabPaisa Lite</h3>
								<p>
									 SabPaisa IPG with integrated card and net banking payment option
								</p>
								
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-6 sow-services-service">
					<div class="content">
						<div class="row">
							<div class="col-md-3">
								<div class="type">
									<span class="sow-icon-fontawesome"><img src="SabPaisa/images/prologo/SabPaisaSuper.png" alt="FormLink" title="FormLink"></span>
								</div>
							</div>
							<div class="col-md-9">
								
								<h3>SabPaisa Super</h3>
								<p>
									SabPaisa IPG with integrated cards,net banking, e-Challan, NEFT/RTGS payment options
								</p>
								
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-6 sow-services-service">
					<div class="content">
						<div class="row">
							<div class="col-md-3">
								<div class="type">
									<span class="sow-icon-fontawesome"><img src="SabPaisa/images/prologo/SabPaisaPremium.png" alt="LINKPAISA" title="LINKPAISA"></span>
								</div>
							</div>
							<div class="col-md-9">
								
								<h3>SabPaisa Premium</h3>
								<p>
									 Start collecting payments and send links for any kind of payments collections in minutes with power of FormLink and LinkPaisa, with pre-integrated SabPaisa IPG and offered payments modes are integrated cards, net banking, e-Challan, NEFT/RTGS payment options
								</p>
								
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-6 sow-services-service">
					<div class="content">
						<div class="row">
							<div class="col-md-3">
								<div class="type">
									<span class="sow-icon-fontawesome"><img src="SabPaisa/images/prologo/SabPaisaUltimate.png" alt="SETTLEPAISA" title="SETTLEPAISA"></span>
								</div>
							</div>
							<div class="col-md-9">
								
								<h3>SabPaisa Ultimate</h3>
								<p>
									A rapid deployment application engine to launch a fee collection for any industry vertical. This will assist you to start collecting payments right from the bank/customer portal.  Both open form and data & Link based payment form options are available. A Link based payment solution which can help you to collect payment from a known/unknown database of payers through payment links sent through sms and email .
								</p>
								
							</div>
						</div>
					</div>
				</div>
				
				

			</div>

		</div>

	</div>

</section>
<!-- =========================== Products END =========================== -->


<!-- =========================== COUNTER BEGIN =========================== -->
<section class="darkarea margin-bottom50 padding110" style="background-size:cover; background-image: url(SabPaisa/images/data_small.jpg);background-position: center center; background-repeat: no-repeat; opacity:1.2;">
	<div class="container">

		<div class="row">

		<div class="col-md-4">
			<div class="funfacts text-center">
				<div class="icon">
					<span class="sow-icon-fontawesome"><i class="fa fa-life-ring"></i></span>
				</div>
				<h2 class="numbe-txt" style="">5+ Lacs</h2>
				<h4>Monthly Transactions</h4>
			</div>
		</div>

		<div class="col-md-4">
			<div class="funfacts text-center">
				<div class="icon">
					<span class="sow-icon-fontawesome"><i class="fa fa-cube"></i></span>
				</div>
				<h2 class="numbe-txt" style="">550+ MN &#x20b9;</h2>
				<h4>Total Settlement</h4>
			</div>
		</div>

		<div class="col-md-4">
			<div class="funfacts text-center">
				<div class="icon">
					<span class="sow-icon-fontawesome"><i class="fa fa-globe"></i></span>
				</div>
				<h2 class="numbe-txt" style="">90+</h2>
				<h4>Total Number of Clients</h4>
			</div>
		</div>

		</div>

	</div>
</section>
<!-- =========================== COUNTER END =========================== -->




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
				
				<div class="col-md-6 col-sm-6">
					<div class="col-md-6 col-sm-6 text-3 widget_text">
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
					<div class="col-md-6 col-sm-6 text-4 widget_text">
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
				
			</div>
		</div>
	</div>
	<div class="copyright sep-top-xs sep-bottom-xs">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<small>
					&#169; COPYRIGHT 2016. powered by SRS Live Technologies Pvt Ltd </small>
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
<!-- =========================== SCRIPTS END  =========================== -->


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
		//	alert("Hello! I am an alert box!!");
			/* var e = document.getElementById("SelectService");
			var serviceId = e.options[e.selectedIndex].value; */
			//alert("stateId = "+stateId);
			var query = "?stateId=" + stateId;
			//alert("Value = "+query);
			var xmlhttp;
			if (window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			} else {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
					document.getElementById("collegeList").innerHTML = xmlhttp.responseText;
				}
			}
			xmlhttp.open("GET", "getCollegeListBasedOnStateIdForSabPaisa" + query, true);
			xmlhttp.send();

		}
		
	</script>
	
	<script type="text/javascript">
	function selectedCollegeId(){
		
		cid=document.getElementById("collegeSelect").value;
		
	}
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
        //alert("College ID is = "+cid);
       
        var splits = cid.split(",");
        /* alert("CID == "+ splits[0]);
        alert("BID == "+ splits[1]); */
        var bid=splits[1];
        cid=splits[0];
         window.open('Start.jsp?bid='+bid+'&cid='+cid+'', '_blank');
        return true;
    }
    
    </script>
	
	
	<script type="text/javascript">
		function sendMail() {
		alert("qwertyuiop");
		var xmlhttp = new XMLHttpRequest();
		var name = document.getElementById("name").value;
		var by = document.getElementById("emailid").value;
		var body = document.getElementById("body").value;
		alert(name);
		alert(body);
		var url = "SendMail.jsp?fromMail=" + by + "&nameMail=" + name
				+ "&bodyMail=" + body;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				document.getElementById("isE").innerHTML = xmlhttp.responseText;
			}

		};
		try {

			xmlhttp.open("GET", url, true);
			xmlhttp.send();
		} catch (e) {
			alert("unable to connect to server");
		}
	}
	</script>

</body></html>