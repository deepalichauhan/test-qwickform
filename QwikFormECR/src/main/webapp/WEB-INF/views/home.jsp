<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.sabpaisa.qforms.daoImpl.LookupRoleDaoImpl"%>
<%
	LookupRoleDaoImpl lookupRoleDImpl=new LookupRoleDaoImpl();		
%>

<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>QwikForms</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Place favicon.ico in the root directory -->
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png">
   <link rel="shortcut icon" href="img/favicon.ico">
    <!-- Plugin-CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <!-- Main-Stylesheets -->
    <link rel="stylesheet" href="css/space.css">
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/overright.css">
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <script src="js/vendor/modernizr-2.8.3.min.js"></script>
    
    
   <!--  //19Mar for login -->
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
<!-- <link href='css/jquery.noty.css' rel='stylesheet'>
<link href='css/noty_theme_default.css' rel='stylesheet'>
<link href='css/elfinder.min.css' rel='stylesheet'>
<link href='css/elfinder.theme.css' rel='stylesheet'>
<link href='css/jquery.iphone.toggle.css' rel='stylesheet'>
<link href='css/uploadify.css' rel='stylesheet'>
<link href='css/animate.min.css' rel='stylesheet'> -->

<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>

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
   <!--  //end  -->
    <style>
    #mainmenu li a {
    	color: #000;
	}
	.dropdown-menu>li>a {border-bottom:1px solid #ccc; background:#;}
	.dropdown-menu{padding:0;}
    </style>
    
</head>
<body data-spy="scroll" data-target="#mainmenu" data-offset="50">
    <!--[if lt IE 8]>
		<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->

    <div class="preloade">
        <span><i class="ti-mobile"></i></span>
    </div>

    <!--Header-Area-->
    <header class="blue-bg relative fix" id="home">
        <div class="section-bg overlay-bg angle-bg ripple ">
            <div class="parallax-image">
                <img src="images/default.jpg" alt="">
            </div>
        </div>
        <!--Mainmenu-->
        <nav class="navbar navbar-default mainmenu-area navbar-fixed-top" data-spy="affix" data-offset-top="60">
            <div class="container">
            		<a href="#" class="navbar-brand">
                        <img src="images/splogo.png" alt="">
                        <h5 class="text-white logo-text">Welcome QwikForms</h5>
                    </a>
                <div class="navbar-header">
                    <button type="button" data-toggle="collapse" class="navbar-toggle" data-target="#mainmenu">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    
                </div>
                <div class="collapse navbar-collapse navbar-right" id="mainmenu">
                    <ul class="nav navbar-nav">
                        <li><a href="#home">Home</a></li>
                        
                        <!--<li><a href="#work">Work</a></li>
                        <li><a href="#feature">Features</a></li>
                        <li><a href="#team">Team</a></li>
                        
                        <li><a href="#client">Client</a></li>
						<li><a href="#contact">Contact</a></li>-->
						<!--<li><a href="#price">Pricing</a></li>-->
						<!-- <li><a href="http://localhost:8081/clientOnBoarding/login">Login</a></li> -->
						<li class="dropdown">
                       		<a href="#" data-toggle="dropdown" class="dropdown-toggle">Login <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<!-- for local QwikForms login -->
								<!-- <li><a href="#adminLogin">QwikForms Admin Login</a></li> -->
								
								<!-- for local cob login -->
								<!-- <li><a href="http://localhost:8081/clientOnBoarding/login">Admin Login</a></li> -->
								
								<!-- for uat cob login -->
								<!-- <li><a href="https://portal.sabpaisa.in/clientOnBoarding/login">Admin Login</a></li> -->
								
								<!-- for live cob login  https://spl.sabpaisa.in/clientOnBoarding/login -->
								<li><a href="https://spl.sabpaisa.in/clientOnBoarding/login">Admin Login</a></li>
								<li><a href="<spring:url value="/cLogin"/>">Client Login</a></li>
								<!-- <li><a href="#userLogin">Client Login</a></li> -->
							</ul>
						</li>
                        
                        <!-- <li><a href="#userLogin">LoginByClient</a></li> -->
                    </ul>
                </div>
            </div>
        </nav>
        <!--Mainmenu/-->
        <div class="space-100"></div>
        <div class="space-20 hidden-xs"></div>
        <!--Header-Text-->
        <div class="container text-white">
            <div class="row text-center">
                <div class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                    <div class="space-40"></div>
                    <div class="space-100"></div>
                    <h1 style=" color: white;">It’s all about Promoting<br> your Business</h1>
                    <div class="space-10"></div>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in </p>
                    <div class="space-20"></div>
                    <a href="#" class="btn btn-white">Google play</a>
                    <!--<a href="#" class="btn btn-white">App store</a>-->
                    <div class="space-100"></div>
                </div>
            </div>
            <div class="space-80"></div>
        </div>
        <!--Header-Text/-->
    </header>
    <!--Header-Area/-->
    <!-- <section>
        <div class="space-80"></div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-4 wow fadeInUp" data-wow-delay="0.2s">
                    <div class="well well-hover text-center">
                        <p class="md-icon"><span class="ti-paint-bucket"></span></p>
                        <div class="space-10"></div>
                        <h5 class="text-uppercase">Easy to use</h5>
                        <p>Lorem ipsum dolor sit amt, consectet adop adipisicing elit, sed do eiusmod tepo raraincididunt ugt labore.</p>
                    </div>
                </div>
                <div class="col-xs-12 col-md-4 wow fadeInUp" data-wow-delay="0.4s">
                    <div class="well well-hover text-center">
                        <p class="md-icon"><span class="ti-cup"></span></p>
                        <div class="space-10"></div>
                        <h5 class="text-uppercase">Awesoem Design</h5>
                        <p>Lorem ipsum dolor sit amt, consectet adop adipisicing elit, sed do eiusmod tepo raraincididunt ugt labore.</p>
                    </div>
                </div>
                <div class="col-xs-12 col-md-4 wow fadeInUp" data-wow-delay="0.6s">
                    <div class="well well-hover text-center">
                        <p class="md-icon"><span class="ti-headphone-alt"></span></p>
                        <div class="space-10"></div>
                        <h5 class="text-uppercase">Easy to customaize</h5>
                        <p>Lorem ipsum dolor sit amt, consectet adop adipisicing elit, sed do eiusmod tepo raraincididunt ugt labore.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-80"></div>
    </section> -->
    <!--Work-Section-->
   <!--  <section class="gray-bg" id="work">
        <div class="space-80"></div>
        <div class="container">
            <div class="row wow fadeInUp">
                <div class="col-xs-12 col-md-6 col-md-offset-3 text-center">
                    <h3 class="text-uppercase">How it work?</h3>
                    <p>Lorem ipsum madolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor coli incididunt ut labore Lorem ipsum madolor sit amet.</p>
                </div>
            </div>
            <div class="space-60"></div>
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-3 text-center wow fadeInUp" data-wow-delay="0.2s">
                    <div class="hover-shadow">
                        <div class="space-60">
                            <img src="images/icon/icon1.png" alt="">
                        </div>
                        <div class="space-20"></div>
                        <h5 class="text-uppercase">Login First</h5>
                        <p>Lorem ipsum dolor sit ameteped consecteadop adipisicing elitab sed eiusmod temporara incident</p>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 text-center wow fadeInUp" data-wow-delay="0.4s">
                    <div class="hover-shadow">
                        <div class="space-60">
                            <img src="images/icon/icon2.png" alt="">
                        </div>
                        <div class="space-20"></div>
                        <h5 class="text-uppercase">DATA ANALYSIS</h5>
                        <p>Lorem ipsum dolor sit ameteped consecteadop adipisicing elitab sed eiusmod temporara incident</p>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 text-center wow fadeInUp" data-wow-delay="0.6s">
                    <div class="hover-shadow">
                        <div class="space-60">
                            <img src="images/icon/icon3.png" alt="">
                        </div>
                        <div class="space-20"></div>
                        <h5 class="text-uppercase">Face Testing</h5>
                        <p>Lorem ipsum dolor sit ameteped consecteadop adipisicing elitab sed eiusmod temporara incident</p>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 text-center wow fadeInUp" data-wow-delay="0.8s">
                    <div class="hover-shadow">
                        <div class="space-60">
                            <img src="images/icon/icon4.png" alt="">
                        </div>
                        <div class="space-20"></div>
                        <h5 class="text-uppercase">SHOW RESULT</h5>
                        <p>Lorem ipsum dolor sit ameteped consecteadop adipisicing elitab sed eiusmod temporara incident</p>
                    </div>
                </div>
            </div>
            <div class="space-60"></div>
            <div class="row">
                <div class="col-xs-12 col-md-8 col-md-offset-2 text-center wow fadeInUp">
                    <div class="down-offset ">
                        <img src="images/mobile1.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section> -->
    <!--Work-Section/-->
    <!--Feature-Section-->
   <!--  <section class="fix">
        <div class="space-60"></div>
        <div class="container" id="feature">
            <div class="space-100"></div>
            <div class="row wow fadeInUp">
                <div class="col-xs-12 col-md-6 col-md-offset-3 text-center">
                    <h3 class="text-uppercase">Special Features</h3>
                    <p>Lorem ipsum madolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor coli incididunt ut labore Lorem ipsum madolor sit amet.</p>
                </div>
            </div>
            <div class="space-60"></div>
            <div class="row feature-area">
                <div class="col-xs-12 col-sm-6 col-md-4 wow fadeInLeft">
                    <div class="space-30"></div>
                    <a href="#feature1" data-toggle="tab">
                        <div class="media single-feature">
                            <div class="media-body text-right">
                                <h5>Creative Design</h5>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididugnt ut labore</p>
                            </div>
                            <div class="media-right">
                                <div class="border-icon">
                                    <span class="ti-light-bulb"></span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <div class="space-30"></div>
                    <a href="#feature2" data-toggle="tab">
                        <div class="media single-feature">
                            <div class="media-body text-right">
                                <h5>UNLIMITED FEATURES</h5>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididugnt ut labore</p>
                            </div>
                            <div class="media-right">
                                <div class="border-icon">
                                    <span class="ti-cup"></span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <div class="space-30"></div>
                    <a href="#feature3" data-toggle="tab">
                        <div class="media single-feature">
                            <div class="media-body text-right">
                                <h5>FULL FREE CHAT</h5>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididugnt ut labore</p>
                            </div>
                            <div class="media-right">
                                <div class="border-icon">
                                    <span class="ti-comments"></span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <div class="space-30"></div>
                </div>
                <div class="hidden-xs hidden-sm col-md-4 text-center fix wow fadeIn">
                    <div class="down-offset relative ">
                        <img src="images/mobile2.png" alt="">
                        <div class="screen_image tab-content">
                            <div id="feature1" class="tab-pane fade in active">
                                <img src="images/feature/1.jpg" alt="">
                            </div>
                            <div id="feature2" class="tab-pane fade">
                                <img src="images/feature/6.jpg" alt="">
                            </div>
                            <div id="feature3" class="tab-pane fade">
                                <img src="images/feature/3.jpg" alt="">
                            </div>
                            <div id="feature4" class="tab-pane fade">
                                <img src="images/feature/4.jpg" alt="">
                            </div>
                            <div id="feature5" class="tab-pane fade">
                                <img src="images/feature/5.jpg" alt="">
                            </div>
                            <div id="feature6" class="tab-pane fade">
                                <img src="images/feature/2.jpg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-4 wow fadeInRight">
                    <div class="space-30"></div>
                    <a href="#feature4" data-toggle="tab">
                        <div class="media single-feature">
                            <div class="media-left">
                                <div class="border-icon">
                                    <span class="ti-eye"></span>
                                </div>
                            </div>
                            <div class="media-body">
                                <h5>Retina ready</h5>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididugnt ut labore</p>
                            </div>
                        </div>
                    </a>
                    <div class="space-30"></div>
                    <a href="#feature5" data-toggle="tab">
                        <div class="media single-feature">
                            <div class="media-left">
                                <div class="border-icon">
                                    <span class="ti-shine"></span>
                                </div>
                            </div>
                            <div class="media-body">
                                <h5>HIGH RESOLUTION</h5>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididugnt ut labore</p>
                            </div>
                        </div>
                    </a>
                    <div class="space-30"></div>
                    <a href="#feature6" data-toggle="tab">
                        <div class="media single-feature">
                            <div class="media-left">
                                <div class="border-icon">
                                    <span class="ti-layout-slider"></span>
                                </div>
                            </div>
                            <div class="media-body">
                                <h5>CLEAN CODES</h5>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididugnt ut labore</p>
                            </div>
                        </div>
                    </a>
                    <div class="space-30"></div>
                </div>
            </div>
        </div>
    </section> -->
    <!--Feature-Section-->
    
    <!--Client-Section-->
    <!-- <section id="client">
        <div class="space-80"></div>
        <div class="container">
            <div class="row wow fadeInUp">
                <div class="col-xs-12 col-md-8 col-md-offset-2 text-center">
                    <div class="well well-lg">
                        <div class="client-details-content">
                            <div class="client_details">
                                <div class="item">
                                    <h3>M S NEWAZ</h3>
                                    <p>Ceative Director</p>
                                    <q>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incubt consectetur aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut com modo consequat. Duis aute irure dolor in reprehenderit.</q>
                                </div>
                                <div class="item">
                                    <h3>M S NEWAZ</h3>
                                    <p>Ceative Director</p>
                                    <q>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incubt consectetur aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut com modo consequat. Duis aute irure dolor in reprehenderit.</q>
                                </div>
                                <div class="item">
                                    <h3>M S NEWAZ</h3>
                                    <p>Ceative Director</p>
                                    <q>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incubt consectetur aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut com modo consequat. Duis aute irure dolor in reprehenderit.</q>
                                </div>
                                <div class="item">
                                    <h3>M S NEWAZ</h3>
                                    <p>Ceative Director</p>
                                    <q>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incubt consectetur aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut com modo consequat. Duis aute irure dolor in reprehenderit.</q>
                                </div>
                                <div class="item">
                                    <h3>M S NEWAZ</h3>
                                    <p>Ceative Director</p>
                                    <q>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incubt consectetur aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut com modo consequat. Duis aute irure dolor in reprehenderit.</q>
                                </div>
                                <div class="item">
                                    <h3>M S NEWAZ</h3>
                                    <p>Ceative Director</p>
                                    <q>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incubt consectetur aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut com modo consequat. Duis aute irure dolor in reprehenderit.</q>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="space-40"></div>
            <div class="row wow fix fadeInUp">
                <div class="col-xs-12 col-md-6 col-md-offset-3 relative">
                    <div class="client-photo-list">
                        <div class="client_photo">
                            <div class="item">
                                <div class="box100">
                                    <img src="images/client/client1.png" alt="">
                                </div>
                            </div>
                            <div class="item">
                                <div class="box100">
                                    <img src="images/client/client2.png" alt="">
                                </div>
                            </div>
                            <div class="item">
                                <div class="box100">
                                    <img src="images/client/client3.png" alt="">
                                </div>
                            </div>
                            <div class="item">
                                <div class="box100">
                                    <img src="images/client/client1.png" alt="">
                                </div>
                            </div>
                            <div class="item">
                                <div class="box100">
                                    <img src="images/client/client2.png" alt="">
                                </div>
                            </div>
                            <div class="item">
                                <div class="box100">
                                    <img src="images/client/client3.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="client_nav">
                        <span class="ti-angle-left testi_prev"></span>
                        <span class="ti-angle-right testi_next"></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-80"></div>
    </section> -->
    <!--Client-Section-->
    
    <!--AdminLogin-Section-->
    <section class="gray-bg" id="adminLogin" style="align-content: center; background-image: url(images/default.jpg)">
        <div class="space-80"></div>
        <div class="container" align="center">
            <div class="ch-container">
			<div class="row">

			<div class="row" align="right">
				<div class="well col-md-5 center login-box">
	 <%
						String msg = (String) request.getAttribute("msg");
						if (msg != null) {
					%>
					<div class="alert alert-info"
						style="font-weight: bold; font-size: medium; color: red;">

						<%=msg%>
					</div>

					<%
						} else {
					%>
					<div class="alert alert-info">Please login with SuperAdmin. Enter your Username
						and Password.</div>
					<%
						}
					%>

								
					
					<form:form id="loginForm" class="form-horizontal" modelAttribute="login" action="saLogin" method="post">
						<fieldset>
							
								<div class="input-group input-group-lg">
								<!-- <span class="input-group-addon"><i
									class="glyphicon glyphicon-user red"></i></span>  -->									
									<%-- <select name="roleSelect">
										<option value="0" selected="selected">--Select Role--</option>
									    <c:forEach var="item" items="${roleBeanMap}" >
									    	<option value="${item.key}" >${item.value}</option>
									        <option value="${item.key}" ${item.key == selectedDept ? 'selected="selected"' : ''}>${item.value}</option>
									    </c:forEach>
									</select> --%>
								</div>
                               <div class="input-group input-group-lg">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-user red"></i></span> <input type="text"
									name="userName" class="form-control"
									required="required" placeholder="Username">
							</div>
							<div class="clearfix"></div>
							<br>

							<div class="input-group input-group-lg">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-lock red"></i></span> <input
									type="password" name="pass" class="form-control"
									required="required" placeholder="Password">
							</div>
							<div class="clearfix"></div>
								
							<p class="center col-md-5">
							
								<button type="submit" class="btn btn-primary">Proceed</button>
								<!-- <button type="submit" onclick='window.open("index")' class="btn btn-primary">Back To Home</button> -->
							</p>

						</fieldset>
					</form:form>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
		</div>
		<!--/fluid-row-->
		<footer class="row"> </footer>
	</div>
        </div>
    </section>
    <!--AdminLogin-Section-->
    
    <%-- <!--userLogin-Section-->
    <section class="gray-bg" id="userLogin" style="align-content: center; background-image: url(images/default.jpg)">
        <div class="space-80"></div>
        <div class="container">
            <div class="ch-container">




		<div class="row">

			<!-- <div class="row">
				<div class="col-md-12 center login-header">


					<h2>Welcome To QwikForms</h2>

				</div>
				/span
			</div>
			/row -->

			<div class="row">
				<div class="well col-md-5 center login-box">

					<%
						String msg1 = (String) request.getAttribute("msg");
						if (msg1 != null) {
					%>
					<div class="alert alert-info"
						style="font-weight: bold; font-size: medium; color: red;">

						<%=msg1%>
					</div>

					<%
						} else {
					%>
					<div class="alert alert-info">Please login with your Username
						and Password.</div>
					<%
						}
					%>

					<form class="form-horizontal" action="clientLogin" method="post" modelAttribute="loginBean">
						<fieldset>

							<div id="input-email" class="input-group input-group-lg">

								<span class="input-group-addon"><i
									class="glyphicon glyphicon-envelope red"></i></span> <input
									type="text" name="userName" id="usrName"
									class="form-control" required="required" placeholder="Username">
							</div>

							<p class="center col-md-5"></p>
							<div id="input-number" class="input-group input-group-lg">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-lock red"></i></span> <input
									type="password" name="password"
									class="form-control" id="pswd" required="required"
									placeholder="Password"> <input type="hidden"
									value="false" name="isfromBank">
							</div>
							<div class="clearfix"></div>



							<div class="clearfix"></div>

							<p class="center col-md-5">
								<button type="submit" class="btn btn-primary">Proceed</button>
							</p>

						</fieldset>
					</form>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
		</div>
		<!--/fluid-row-->
		<footer class="row"> </footer>
	</div>
        </div>
    </section>
    <!--userLogin-Section--> --%>
    
    <!--Question-section-->
<!--     <section class="fix">
        <div class="space-80"></div>
        <div class="container">
            <div class="row wow fadeInUp">
                <div class="col-xs-12 col-md-6 col-md-offset-3 text-center">
                    <h3 class="text-uppercase">Frequently asked questions</h3>
                    <p>Lorem ipsum madolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor coli incididunt ut labore Lorem ipsum madolor sit amet.</p>
                </div>
            </div>
            <div class="space-60"></div>
            <div class="row">
                <div class="col-xs-12 col-md-6 wow fadeInUp">
                    <div class="space-60"></div>
                    <div class="panel-group" id="accordion">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Sedeiusmod tempor inccsetetur aliquatraiy? </a></h4>
                            </div>
                            <div id="collapse1" class="panel-collapse collapse in">
                                <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodas temporo incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrd exercitation ullamco laboris nisi ut aliquip ex comodo consequat. Duis aute dolor in reprehenderit.</div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#collapse2">Tempor inccsetetur aliquatraiy?</a></h4>
                            </div>
                            <div id="collapse2" class="panel-collapse collapse">
                                <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#collapse3">Lorem ipsum dolor amet, consectetur adipisicing ?</a></h4>
                            </div>
                            <div id="collapse3" class="panel-collapse collapse">
                                <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#collapse4">Lorem ipsum dolor amet, consectetur adipisicing ?</a></h4>
                            </div>
                            <div id="collapse4" class="panel-collapse collapse">
                                <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="hidden-xs hidden-sm col-md-5 col-md-offset-1 wow fadeInRight ">
                    <img src="images/2mobile.png" alt="">
                </div>
            </div>
        </div>
        <div class="space-80"></div>
    </section> -->
    <!--Question-section/-->
    <!--Download-Section-->
    <section class="relative fix">
        <div class="space-80"></div>
        <div class="section-bg overlay-bg">
            <img src="images/default.jpg" alt="">
        </div>
        <div class="container">
            <div class="row wow fadeInUp">
                <div class="col-xs-12 col-md-6 col-md-offset-3 text-center text-white">
                    <h3 class="text-uppercase" style="color: white;">Download SP app Taday</h3>
                    <p>Lorem ipsum madolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor coli incididunt ut labore Lorem ipsum madolor sit amet.</p>
                </div>
            </div>
            <div class="space-60"></div>
            <div class="row text-white wow fadeInUp">
                
                <div class="col-xs-12 col-sm-12 text-center">
                    <a href="#" class="big-button alignleft-">
                        <span class="big-button-icon">
                            <span class="ti-android"></span>
                        </span>
                        <span>available on</span>
                        <br>
                        <strong>Play store</strong>
                    </a>
                    <div class="space-10"></div>
                </div>
            </div>
        </div>
        <div class="space-80"></div>
    </section>
    <!--Download-Section/-->
    <!--instagram section-->
    <div class="container">
        <div class="space-80"></div>
        <div class="row">
            <div class="col-xs-12">
                <ul class="instagram instagram-slide list-unstyle list-inline"></ul>
                <div class="space-80"></div>
            </div>
        </div>
    </div>
    <!--instagram section/-->
    <!--Map-->
    <div id="contact"></div>
    <div id="maps"></div>
    <!--Map/-->
    <!--Footer-area-->
    <%-- <footer class="black-bg">
        <div class="container">
            <div class="row">
                <div class="offset-top">
                    <div class="col-xs-12 col-md-8 wow fadeInUp" data-wow-delay="0.2s">
                        <div class="well well-lg">
                            <h3>Get in Touch</h3>
                            <div class="space-20"></div>
                            <form action="process.php" id="contact-form" method="post">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-6">
                                        <div class="form-group">
                                            <label for="form-name" class="sr-only">Name</label>
                                            <input type="text" class="form-control" id="form-name" name="form-name" placeholder="Name" required>
                                        </div>
                                        <div class="space-10"></div>
                                    </div>
                                    <div class="col-xs-12 col-sm-6">
                                        <div class="form-group">
                                            <label for="form-email" class="sr-only">Email</label>
                                            <input type="email" class="form-control" id="form-email" name="form-email" placeholder="Email" required>
                                        </div>
                                        <div class="space-10"></div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label for="form-subject" class="sr-only">Email</label>
                                            <input type="text" class="form-control" id="form-subject" name="form-subject" placeholder="Subject" required>
                                        </div>
                                        <div class="space-10"></div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label for="form-message" class="sr-only">comment</label>
                                            <textarea class="form-control" rows="3" id="form-message" name="form-message" placeholder="Message" required></textarea>
                                        </div>
                                        <div class="space-10"></div>
                                        <button class="btn btn-link no-round text-uppercase" type="submit">Send message</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-4 wow fadeInUp" data-wow-delay="0.4s">
                        <div class="well well-lg">
                            <h3>Address</h3>
                            <div class="space-20"></div>
                            <p>SRS Live Technologies Pvt Ltd. <br/>51, Sant Nagar, Ground Floor,<br/> East of Kailash, <br/>New Delhi - 110065</p>
                            <div class="space-25"></div>
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="border-icon sm"><span class="ti-timer"></span></div>
                                        </td>
                                        <td><a href=""> Mon - Sat: 10:00 - 19:00</a></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="border-icon sm"><span class="ti-email"></span></div>
                                        </td>
                                        <td>
                                            <a href="mailto:marveltheme@gmail.com">sabpaisa@srslive.in</a>
                                        </td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="space-80"></div>
			<div class="space-80"></div>
            <div class="row text-white wow fadeIn">
                <div class="col-xs-12 text-center">
                    <div class="social-menu">
                        <a href="https://www.facebook.com/sabpaisa"><span class="ti-facebook"></span></a>
                        <a href="https://twitter.com/sabpaisa"><span class="ti-twitter-alt"></span></a>
                        <a href="https://www.linkedin.com/company/sabpaisa/"><span class="ti-linkedin"></span></a>
                    </div>
                    <div class="space-20"></div>
                   &copy;
                <script>
                    document.write(new Date().getFullYear())
                </script>  powered by SRS Live Technologies Pvt Ltd<a href="https://www.sabpaisa.in/" target="_blank"> SabPaisa </a>
                </div>
            </div>
            <div class="space-20"></div>
        </div>
    </footer> --%>
    <!--Footer-area-->

    <!--Vendor JS-->
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <!--Plugin JS-->
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/scrollUp.min.js"></script>
    <script src="js/magnific-popup.min.js"></script>
    <script src="js/ripples-min.js"></script>
    <script src="js/contact-form.js"></script>
    <script src="js/spectragram.min.js"></script>
    <script src="js/ajaxchimp.js"></script>
    <script src="js/wow.min.js"></script>
    <script src="js/plugins.js"></script>
    <!--Active JS-->
    <script src="js/main.js"></script>
    <!--Maps JS-->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBTS_KEDfHXYBslFTI_qPJIybDP3eceE-A&sensor=false"></script>
    <script src="js/maps.js"></script>
</body>

</html>




<%-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table align="center" hight="100%" width="100%">
	<tr><td bgcolor="yellow"  ><h1>Welcome to QCLP QForms</h1></td></tr>
	<tr><td align="center"><img alt="This is Home Page" src="images/logosabpaisa.png" align="middle"></td></tr>
	<tr><td>
	<form:form id="loginPage" modelAttribute="showLog" action="loginAdmin" method="post">
		<input type="submit" name="submit" value="Login By Admin">
	
	</form:form>
	</td></tr>
	<tr><td>
	<form:form id="loginPage" modelAttribute="showLog" action="login" method="post">
		<input type="submit" name="submit" value="Login By Client">
	
	</form:form>
	</td></tr>

</table>
	
	
</body>
</html> --%>