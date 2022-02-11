<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>QwikForms</title>
	<link href="css/style-new.css" rel="stylesheet" />
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<link href="css/wizard.css" rel="stylesheet" />
	
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
<body onload="invalidatePrevSession('<%=request.getParameter("bid")%>','<%=request.getParameter("cid")%>')">

<%

String redirectedFrom = request.getParameter("redirectedFrom")==null?"":request.getParameter("redirectedFrom");

%>	

</br></br></br>
	<div
		style="color: green; text-align: center; font-weight: bold; font-size: x-large;">
		
	Please Wait...... </br> while we are closing any previous browser sessions.  
	
		
		
	</div>	
	<div style="color: red; text-align: center; font-weight: bold; font-size: x-large;">
	
	
	</br></br></br>
	<div>
	
	
	</div>
	</br></br></br>
	<div align="center" class="col-md-12 cntrs labeling-pad">	 
	  <%-- <button align="center" type="button" class="wizard-goto btn btn-primary" onclick="invalidatePrevSession('<%=request.getParameter("bid")%>','<%=request.getParameter("cid")%>')">Terminate Previous Session and Continue</button> --%>
	</div>

	
	
<script type="text/javascript">

function invalidatePrevSession(bid, cid){
	var appNameExt=window.location.pathname;
	var appName = appNameExt.substring(0,getPosition(appNameExt,'/',2));
	
	//alert('app name is..'+appName);
	//alert('final url is..'+window.location.origin+appName);
    var origin =  window.location.origin;
    //alert('origin is..'+window.location.origin);
    var redirectedFrom = '<%=redirectedFrom %>';
	window.location=""+origin+appName+"/StartUrl?bid="+bid+"&cid="+cid+"&terminatingOldSession=Y&redirectedFrom="+redirectedFrom;
	
}

function getPosition(str, m, i) {
	  return str.split(m, i).join(m).length;
	}

</script>	

</body>
</html>
