<%@ page contentType="text/html; charset=UTF-8"%>
<%-- <%@ taglib prefix="s" uri="/struts-tags"%> --%>
<html>
<head>
<title>Upload User Image</title>
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
<h2>Struts2 File Upload & Save Example</h2>
<actionerror />
<form action="userImage" method="post" enctype="multipart/form-data">
  
    <file name="userImage" label="User Image" />
  <!--   <input type="text" name="clientId" placeholder=" enter the Client Id" /> -->
  
    <submit value="Upload" align="center" />
</form>
</body>
</html>