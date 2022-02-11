<%@ page contentType="text/html; charset=UTF-8"%>
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Success: Upload User Image</title>
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
    <h2>Struts2 File Upload Example</h2>
    User Image: <c:out value="userImage"/>
    <br/>
    Content Type: <c:out value="userImageContentType"/>
    <br/>
    File Name: <c:out value="userImageFileName"/>
    <br/>
    Uploaded Image:
    <br/>
    <img src="<c:out value="userImageFileName"/>"/>
</body>
</html>