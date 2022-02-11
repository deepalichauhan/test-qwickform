<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.sabpaisa.qforms.beans.CollegeBean"%>
<%@page import="com.sabpaisa.qforms.beans.StateBean"%>
<%@page import="java.util.Properties"%>
<%@page
	import="com.sabpaisa.qforms.config.AppPropertiesConfig"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.util.Base64"%>
<!DOCTYPEhtml>
<html>
<head>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />	
	<title></title>	
</head>

<style>
 table td{width:33%;}
 table td.lft{text-align:left; padding:10px 5px; border-top:1px solid #ccc; border-right:1px solid #ccc;}
 table td.lftbtm{border-bottom:1px solid #ccc;}
 .bord{border-left:1px solid #ccc;}
 .cnt-gap{font-weight:bold; padding:15px; text-transform:uppercase; border-left:1px solid #ccc; border-top:1px solid #ccc; border-right:1px solid #ccc; font-size:14px;}
 .log-cnt{ width: 120px; height: 120px; height: auto;  margin: 3px; padding: 3px;}
 .log-cnt img{max-width: 120px; height: auto;}
 td.instruction{text-align:left;}
 td.instruction ul{padding:8px 20px; margin:0;}
 td.instruction ul li{padding:2px 0;}
 .lfttxt{text-align:left;}
 .rgttxt{text-align:right;}
</style>
<body style="background:#fff;">

<div style="width:700px; margin:0 auto; height:930px; font-family:arial; font-size:21px; text-align:center; border:6px solid #000; padding: 0 20px;">
<table cellpadding="10" cellspacing="0" border="0" width="100%">
	
	<tr>
		<td colspan=""><img src="images/pci/PCIlogo.png" width="100%"></td>
	</tr>
		
	<tr valign="top">
		<td style="padding: 5px 0 5px; text-align: center;" colspan="3">
			
			<!--<table border="0" width="100%" cellpadding="15" cellspacing="0" style="background:url(NOC.png) no-repeat center;">-->
			
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="lfttxt"><strong>Pci Ref. No. </strong> <span><c:out value="${admitBean.father_name}" /></span></td>
					
					<td class="rgttxt" colspan="2"><strong>Date :</strong> <span><c:out value="${admitBean.dob}" /></span></td>
				</tr>
				
				<tr>
					<td class="lfttxt" colspan="3" style="font-size:22px; padding:30px 0; text-decoration:underline;"><center><b>No Due Certificate</b></center></td>
					
				</tr>
				<tr>
					<td class="lfttxt" colspan="3" style="text-align:justify;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Certified that <span><c:out value="${admitBean.roll_number}" /></span> Published from <span><c:out value="${admitBean.applied_course}" /></span> with Registration No. <span><c:out value="${admitBean.category}" /></span> has remitted Levy of fee to the Press Council of India till <span><c:out value="${admitBean.gender}" /></span></td>
					
				</tr>
				<!-- <tr>
					
					<td class="lfttxt" style="text-align:left;">Counter Sign.</td>
					<td><img src="images/pci/nocSeal.png" alt="(K.N. Pokhriyal)Under Secretary (Levy)" title="(K.N. Pokhriyal)Under Secretary (Levy)" width="100px"></td>
					<td class="lfttxt" style="text-align:right;">
					<img src="images/pci/pokhriyal.jpg" alt="(K.N. Pokhriyal)Under Secretary (Levy)" title="(K.N. Pokhriyal)Under Secretary (Levy)" width="200px"><br/>
					(K.N. Pokhriyal)<br/>Under Secretary (Levy)<br/>
					
					</td>
					
				</tr> -->
				<tr><td class="lfttxt" colspan="3" style="text-align:justify;height: 25%"></td></tr>
				<tr><td class="lfttxt" colspan="3" style="text-align:justify;"></td></tr>
				<tr>
				</br>
				<td class="lfttxt" style="text-align:left;padding:30px 0; text-decoration:underline;">Counter Sign.</td>
				<td><img src="images/pci/nocSeal.png" alt="(T. Gou Khangin)Under Secretary (Levy)" title="(T. Gou Khangin)Under Secretary (Levy)" width="100px"></td>
				<td class="lfttxt" style="text-align:center;padding:30px 0; text-decoration:underline;">
				<label>Your Faithfully,</label>
			<%--	<img src="images/pci/pciSignUnderSecretary.png" alt="(T. Gou Khangin)Under Secretary (Levy)" title="(T. Gou Khangin)Under Secretary (Levy)" width="200px"><br/> --%>
				<img src="images/pci/T_Gou_Khangin.jpg" alt="(T. Gou Khangin)Under Secretary (Levy)" title="(T. Gou Khangin)Under Secretary (Levy)" width="200px"><br/>
				(T. Gou Khangin)<br/>Under Secretary (Levy)<br/>
				
				</td>

				</tr>
				<tr>
					<td class="lfttxt">
						
						<img src="images/pci/Rajni_Verma_Sign_PCI.png" alt="Rajni Verma Section Officer (Levy)" title="Rajni Verma Section Officer (Levy)"  width="100px"><br/>
			Rajni Verma<br/>
			Section Officer (Levy)<br/>
			</td>
					
					
				</tr>
			</table>
		</td>
	</tr>
	
	
</table>

</div>
<%-- <p style="text-align:center; padding:0;">SP Transaction ID - <s:property value="admitBean.reg_number" /></p> --%>
<footer><p style="text-align:center; padding:0;">This e-Document has been generated from the official website of Press council of India - http://presscouncil.nic.in/ on SabPaisa Platform whose TxnId - <c:out value="${admitBean.reg_number}" /></p> </footer>
</html>
