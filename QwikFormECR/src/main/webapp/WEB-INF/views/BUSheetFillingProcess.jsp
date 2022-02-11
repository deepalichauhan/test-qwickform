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
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

		<title>Quick Form</title>
		<style>
				body{
					background-image: url(images/banneres.jpg);
					margin: 0px;
					padding: 0px;
			
				}
				hr{
					background:#fff;
					padding: 2px;	
				}
				html {
  
  margin:0px;
	padding: 0px;
  overflow-x: hidden;
}
			.footer-copyrights {
				text-align: center;
    padding: 10px 8px;
    background: #222222 none repeat scroll 0 0;
    color: #666;
    overflow: hidden;
    position: fixed;
    bottom: 0px;

			
}
img {
	vertical-align: middle;
    border-style: none;
    width: 13%;
    padding: 12px;
}
.form-control{
	width: 80%;
}
	.background-colour {
    background: #fff;
}
.blue{
	background:grey;
}
.size {
    font-size: 20px;
    /* text-transform: uppercase; */
    padding: 12px;
		color: #fff;
}
.size1 {
    font-size: 14px;
    /* text-transform: uppercase; */
    padding: 12px;
		color: #fff;
}
	.square {
		background: aqua;
			margin: 147px 0px 30px 158px;
			width: 50%;
			/* height: 50%; */
			height: 279px;
			box-shadow: 0px 0px 10px 3px grey;
	}
	.rect {
			background: #a2afaf;
			width: 30%;
			margin: 149px 4px 29px 51px;
			box-shadow: 0px 0px 10px 3px grey;
	}
	.h2, h2 {
			font-size: 2rem;
			margin: 35px;
			color: #fff;
	}
	label {
			display: inline-block;
			margin-bottom: .5rem;
			margin: 25px;
			font-weight: bold;
			color: #fff;
			font-size: 25px;
    text-transform: uppercase;
	}
	li {
    color: #fff;
}
p {
    margin-top: 0;
    margin-bottom: 1rem;
    color: #fff;
}
	body {
  
  font-weight: normal;
  font-size: 15px;
  letter-spacing: 0;
  color: #333333;
  line-height: 30px;
 
  -webkit-overflow-scrolling: touch;
  /* Fix for webkit rendering */
  
  font-family: Sailec-Medium,Helvetica,sans-serif !important;

  width: auto!important; overflow-x: hidden!important;
  height: 100% !important;
  padding: 0 !important;
  margin: 0 !important;
}
.col-md-6.the-green-bg {
    background: #e24e17;
   
}
.col-md-6.the-green-bg1 {
    background: #9ba1a7;
}
.classWithPad { margin:33px; padding:10px; 

  /* The image used */
  background-image: url("images/orangebg-px.png");

  

  /* Center and scale the image nicely */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  position: relative;
}
.classWithPad1 { margin:33px; padding:10px; 

/* The image used */
background-image: url("images/bg-px.png");
font-weight: bold;


/* Center and scale the image nicely */
background-position: left;
background-repeat: no-repeat;
background-size: cover;
position: relative;
}
button.btn.btn-primary.pull-right.btn-block {
    width: 30%;
    text-transform: uppercase;
    font-weight: bold;
    background: #fdb933;
}
/* #QFCustData{display:none;} */
		 </style>
	
  </head>
  <body>
  
  <%
	Integer sesBid = null, sesCid = null;
	String formId=null;
	
	String bid=null,cid=null;
	Integer currentFormId = null;
	String formInstanceId = null;
	String payeeProfile=null;
	String msg=null;
	Integer optionsFieldsCount = 0;
	CollegeBean collegeBean = new CollegeBean();
	Logger log = LogManager.getLogger("BUSheetFillingProcess");
	AppPropertiesConfig appProperties = new AppPropertiesConfig(); 
	Properties properties = appProperties.getPropValues(); 

	String cidForMaxFilledSeat1 = properties.getProperty("cidForMaxFilledSeat1"); 
	
	
	String clientLogoLink = properties.getProperty("clientLogoLink");
	String clientLogoLinkSECI = properties.getProperty("clientLogoLinkSECI");
	
	
	int pageCtr = 0;
	try {
		formId=(String)request.getParameter("formid");
		bid=(String)request.getParameter("bid");
		cid=(String)request.getParameter("cid");
		collegeBean = (CollegeBean) session.getAttribute("CollegeBean");
		msg=(String)request.getAttribute("errorMsg");
		payeeProfile=(String)request.getParameter("PayeeProfile");
		/* if(bid==null){
			bid=(String)session.getAttribute("bid");
		}
		if(cid==null){
			cid=(String)session.getAttribute("cid");
		}
		sesBid = Integer.parseInt(bid);
		sesCid = Integer.parseInt(cid); */
				
		System.out.println("FormId: BUSheetFillingProcess.jsp is:" + formId);
		/* System.out.println("sesBid: PayerFormNewForMB.jsp is:" + sesBid+" ,,,,,,, " +bid);
		System.out.println("sesCid: PayerFormNewForMB.jsp is:" + sesCid+" ,,,,,,, "+cid); */
		System.out.println("payeeProfile: BUSheetFillingProcess.jsp is:" + payeeProfile);
		System.out.println("msg: BUSheetFillingProcess.jsp is:" + msg);
		System.out.println("cidForMaxFilledSeat1: BUSheetFillingProcess.jsp is:" + cidForMaxFilledSeat1);
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
<%-- <%
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
%> --%>
<!-- <script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
       top.location = self.location;
   }
</script> -->
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
  
</script>

<form>
			<center>
				<div class="blue">
					<!-- MagicBricks, India's No.1 Property Site‎ </div> -->
					<% if(null!=collegeBean.getCollegeName()){ %> 
						<div class="size"><%=collegeBean.getCollegeName() %></div> <%}else{ %>
						<div class="size">MagicBricks, India's No.1 Property Site</div> 
						<%} %>
					
					
				</div>
				</center>
				
				<center>
					<div class="background-colour">
							
							<% if(null!=collegeBean.getCollegeImage()){ %>
							<img
								src="data:image/png;base64,<%=Base64.getEncoder().encodeToString(collegeBean.getCollegeImage())%>"
								alt="" title="" height="60" width="80"></img>
							<%}else{ %>
							<img src="images/sabpaisa-logo.png" alt="" title="" width="80"
								height="60" />
							<%} %>
							
							<!-- <img src="img/exide-logo.png"> -->
					</div>
					
					</center>
			<div class="container">
					<div class="row">
						
						<div class="col-md-4  the-green-bg">
								<div class="classWithPad1">
								
								<div class="form-group">
										<div class="size">
										
										<%
										if(null!=request.getAttribute("errorMsg") ){
									%>
										<h5>	<%= request.getAttribute("errorMsg") %></h5>
									<% } else{ %>
										<h5>Please enter details in correct format</h5>
									<% } %> 
										
										
										
										
										<!-- Validate Password --></div>
										
										<input type="text" class="form-control" id="usrFormId" value="<%=formId %>" hidden="hidden" readonly="readonly">
										<input type="text" class="form-control" id="usrBid" value="<%=bid %>" hidden="hidden" readonly="readonly">
										<input type="text" class="form-control" id="usrCid" value="<%=cid %>" hidden="hidden" readonly="readonly">
										<c:choose>
										<c:when test='${ null!=linkPassFieldNames|| !linkPassFieldNames.equals("null") || !linkPassFieldNames.equals("") }'>
											<input type="text"
												name='<c:out value="${beanDataForm.validateFieldOfExcel }"/>'
												id="12"
												onchange='AddToArray(this.value,this.name,this.id,0)'
												class="form-control" width="100%" required="required"
												value='<c:out value="${linkPassFieldNames }"/>' placeholder="Enter your Password here">
										</c:when>
										<c:otherwise>
											<input type="text"
												name='<c:out value="${beanDataForm.validateFieldOfExcel }"/>'
												id="12"
												onchange='AddToArray(this.value,this.name,this.id,0)'
												class="form-control" width="100%" required="required"
												placeholder="Enter your Password here">
										</c:otherwise>
										</c:choose>
									</div>
									 <div class="form-group">
										<button class="btn btn-primary pull-right btn-block" onClick="return ValidateSubmit()"> Submit</button>
										<!-- <button class="btn btn-primary pull-right btn-block" onClick="show ('QFCustData');"> Submit</button> -->
									</div>
									
									<!-- <script type="text/javascript">
										function show(elementId) { 
											document.getElementById("QFCustData").style.display="none";
											document.getElementById(elementId).style.display="block";
										}
									</script> -->
								</div>
					
			
						</div>
						<div class="col-md-8 the-green-bg1">
								<div class="classWithPad1 size1" >
								<c:choose>
								<c:when test='${null==linkPassFieldNames|| linkPassFieldNames.equals("null") || linkPassFieldNames.equals("") }'>
											<label>MERCHANT ONESTOP</label>
										
									<ul>
										<li>
												World's first hybrid online and offline payment gateway in the world.
										</li>
										<li>
												Single dashboard with real-time reconciliation on even offline modes.
										</li>
									</ul>
								</c:when>
								<c:otherwise>
									<!-- <h1>KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK</h1> -->
									<table border="1">
										<tr>
											<!-- <td>Validate Password</td> -->
											<td>Approved College Name</td>
											<td>Subject Name</td>
											<td>Maximum Sheet</td>
											<td>Filled Sheet</td>
											<c:choose>
												<c:when test="${sfBeanForBu.subject_max_seat > sfBeanForBu.subject_filled_seat }">
													<td>Payment Link</td>
												</c:when>
											<c:otherwise>
												<td>Not Applicable</td>
											</c:otherwise>
											</c:choose>
										</tr>
										<tr>
											<%-- <td><c:out value='${linkPassFieldNames }'/></td> --%>
											<td><c:out value='${approvedCollegeName }'/></td>
											<td><c:out value='${subject }'/></td>
											<td><c:out value='${sfBeanForBu.subject_max_seat }'/></td>
											<td><c:out value='${sfBeanForBu.subject_filled_seat }'/></td>
											<c:choose>
												<c:when test="${sfBeanForBu.subject_max_seat > sfBeanForBu.subject_filled_seat }">
													<td id="qfId">
														<a href="<c:out value='${sfBeanForBu.paymentUrl }'/>">
															<c:out value='${linkPassFieldNames }'/></a>
													</td>
												</c:when>
											<c:otherwise>
												<td>
													<h5 style="color: red"> Seats are full on this subject </h5>
												</td>
											</c:otherwise>
											</c:choose>
										</tr>
									</table>
								
								</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="col-md-2"></div>
						<div class="col-md-6">
						
									
							
						</div>
					
					</div>
					<div class="footer-copyrights col-lg-12">
						
								<p class="footer-copyrights-text">Copyright ©Sabpaisa 2019. All Rights Reserved</p>  
				
				</div>
					
					</div>
				
		</form>		

    <!-- Optional JavaScript -->
    <script type="text/javascript">
    function ValidateSubmit(id) {
    	var formId= id;
    	var cid=<%=cid%>;
    	   		
    	var dataArray = new Array;
    	for ( var value in values) {
    		dataArray.push(values[value]);
    		//alert(dataArray);
    	}
    	var argument = "values=" + dataArray;
    	var retValue = "true";
        if(argument==null){
        	retValue = "true";
        }
    	if(retValue=="true"){
    			
        		window.open("requestedForUpdatedSheet?"+argument);     	
        }
       /*  else{        	
        	return false;
        }   */      
    }
    </script>
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>