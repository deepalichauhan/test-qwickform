<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
<%-- <style id="antiClickjack">body{display:none !important;}</style>
<script type="text/javascript">
   if (self === top) {
       var antiClickjack = document.getElementById("antiClickjack");
       antiClickjack.parentNode.removeChild(antiClickjack);
   } else {
       top.location = self.location;
   }
</script> --%>
</head>
<!-- //QForms JSP Page -->
<body>
	<table>
		<%
			//   Fix to handle the absence of Page Breaks / Titles 
			int i = 0;
			String[] temp = null;
			if (null != request.getParameter("definedFieldValues")
					&& !"".equals(request.getParameter("definedFieldValues"))) {
				temp = request.getParameter("definedFieldValues").split("~");
			} else {
				temp = new String[1];
			}
		%>


		<c:forEach items="${sesRenderList}" var="renderLookups"
			varStatus="lookupInd">
			<tr>
				<td><c:out value="${renderLookups.lookup_name}" /></td>
				<td><c:set var="fieldType">
						<c:out value="${renderLookups.lookup_type}" />
					</c:set> <c:set var="fieldSubtype">
						<c:out value="${renderLookups.lookup_subtype}" />
					</c:set> <c:set var="mandFlag">
						<c:out value="${renderLookups.isMandatory}" />
					</c:set>
					<c:set var="mandFieldForSp">
						<c:out value="${renderLookups.isMandFieldForSp}" />
					</c:set> <c:choose>
						<c:when
							test='${fieldType.contentEquals("Input")&&fieldSubtype.contentEquals("Number")}'>
							<input type="number"
								pattern="<c:out value="${renderLookups.validation_expression }"/>">
						</c:when>
						<c:when
							test='${fieldType.contentEquals("Input")&&fieldSubtype.contentEquals("Hidden")}'>
							<input type="password"
								pattern="<c:out value="${renderLookups.validation_expression }"/>">
						</c:when>
						<c:when
							test='${fieldType.contentEquals("Input")&&fieldSubtype.contentEquals("Text")}'>
							<input type="text"
								pattern="<c:out value="${renderLookups.validation_expression }"/> ">
						</c:when>
						<c:when
							test='${fieldType.contentEquals("Input")&&fieldSubtype.contentEquals("Alpha")}'>
							<input type="text" pattern="[A-Za-z]{*}"
								placeholder="Alphabets Only">
						</c:when>
						<c:when
							test='${fieldType.contentEquals("Input")&&fieldSubtype.contentEquals("Email")}'>
							<input type="email">
						</c:when>
						<c:when
							test='${fieldType.contentEquals("Input")&&fieldSubtype.contentEquals("Date")}'>
							<input type="date">
						</c:when>
						<c:when test='${fieldType.contentEquals("Form Notification")}'>
							<label><c:out
									value="${renderLookups.notification_content }" /> </label>
						</c:when>


						<c:when
							test='${fieldType.contentEquals("PageBreak")&&fieldSubtype.contentEquals("Text")}'>
							<label> <%=temp[i++]%>
							</label>
						</c:when>

						<c:when
							test='${fieldType.contentEquals("E-Receipt Notification")}'>
							<label><c:out
									value="${renderLookups.notification_content}" /> </label> 
						*This content will be shown on the e-receipt.
					</c:when>
						<c:when test='${fieldType.contentEquals("Multiplier")}'>
							<c:set var="key">
								<c:out value="${renderLookups.lookup_id}" />
							</c:set>
							<input type="number" placeholder='per entry'>
						</c:when>

						<c:when test='${fieldType.contentEquals("Select Box")}'>
							<c:set var="key1">
								<c:out value="${renderLookups.lookup_id}" />
							</c:set>

							<select id='selectObj' name='selectObj'>

								<c:forEach items="${optionsMap}" var="mapValue">
									<c:if test="${mapValue.key == key1 }">
										<c:forEach items="${mapValue.value}" var="item"
											varStatus="loop">
											<option value='<c:out value="${item}" />'><c:out
													value="${item}" /></option>
										</c:forEach>
									</c:if>
								</c:forEach>
							</select>

						</c:when>


						<c:when test='${fieldType.contentEquals("Section")}'>
							<center>
								<strong>New Form Section Here: </strong>
							</center>
						</c:when>
						<c:when test='${fieldType.contentEquals("Check Box")}'>
							<input type="checkbox">
						</c:when>
						<c:when test='${fieldType.contentEquals("Text Area")}'>
							<textarea></textarea>
						</c:when>
						<%-- <c:when test='${fieldType.contentEquals("File Upload Field")}'>
							<input type="file">
						</c:when> --%>
						<c:when test='${fieldType.contentEquals("Document1")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Document2")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Document3")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Document4")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Document5")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Document6")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Document7")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Document8")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Document9")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Document10")}'>
							<input type="file">
						</c:when>
						<c:when test='${fieldType.contentEquals("Photograph")}'>
							<input type="file"> Only Image formats accepted (png,jpeg) upto 3 MB
					</c:when>
						<c:when test='${fieldType.contentEquals("Signature")}'>
							<input type="file"> Only Image formats accepted (png,jpeg) upto 3 MB
					</c:when>
						<c:when test='${fieldType.contentEquals("Radio Button Group")}'>
							<c:set var="key1">
								<c:out value="${renderLookups.lookup_id}" />
							</c:set>
							<c:forEach items='${optionsMap}' var="mapValue">
								<c:if test="${mapValue.key == key1 }">
									<c:forEach items="${mapValue.value}" var="item"
										varStatus="loop">
										<c:out value="${item}" />
										<input type="radio"
											id='<c:out value="${renderLookups.lookup_id}"/>'>
									</c:forEach>
								</c:if>
							</c:forEach>



						</c:when>
					</c:choose></td>
				<td><c:choose>
						<c:when
							test='${fieldType.contentEquals("PageBreak") || fieldType.contentEquals("Form Notification") || fieldType.contentEquals("E-Receipt Notification")}'>
							<c:choose>
								<c:when test='${fieldType.contentEquals("PageBreak")}'>
							New Page Starts
						</c:when>
								<c:otherwise>
							Notification Message
						</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test='${mandFlag==1} '>
									<input type="checkbox" checked="checked"
										onchange="AddToMandatoryArray(this.id)" name='mandatorycheck'
										id="<c:out value='${renderLookups.lookup_id}' />">Mandatory Field  
						</c:when>
								<c:otherwise>
									<input type="checkbox" onchange="AddToMandatoryArray(this.id)"
										name='mandatorycheck'
										id="<c:out value='${renderLookups.lookup_id}' />">Mandatory Field
						</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose></td>

				<td><c:choose>
						<c:when test='${fieldType.contentEquals("PageBreak") || fieldType.contentEquals("Form Notification") || fieldType.contentEquals("E-Receipt Notification")}'>
							Payer Name
						
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test='${mandFieldForSp==1 || mandFieldForSp==2 || mandFieldForSp==3 || mandFieldForSp==4}'>
									<input type="radio" id="<c:out value='${renderLookups.lookup_id}' />" name="rcName" 
									onchange="AddToValidFieldName(this.id)" value="1">
								</c:when>
								<c:otherwise>
									<input type="radio" id="<c:out value='${renderLookups.lookup_id}' />" name="rcName" 
									onchange="AddToValidFieldName(this.id)" value="1">
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td><c:choose>
						<c:when test='${fieldType.contentEquals("PageBreak") || fieldType.contentEquals("Form Notification") || fieldType.contentEquals("E-Receipt Notification")}'>
							Mobile Number
						
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test='${mandFieldForSp==1 || mandFieldForSp==2 || mandFieldForSp==3 || mandFieldForSp==4}'>
									<input type="radio" id="<c:out value='${renderLookups.lookup_id}' />" name="rcMobile" 
									onchange="AddToValidFieldMobile(this.id)" value="2">
								</c:when>
								<c:otherwise>
									<input type="radio" id="<c:out value='${renderLookups.lookup_id}' />" name="rcMobile" 
									onchange="AddToValidFieldMobile(this.id)" value="2">
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td><c:choose>
						<c:when test='${fieldType.contentEquals("PageBreak") || fieldType.contentEquals("Form Notification") || fieldType.contentEquals("E-Receipt Notification")}'>
							Email
						
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test='${mandFieldForSp==1 || mandFieldForSp==2 || mandFieldForSp==3 || mandFieldForSp==4}'>
									<input type="radio" id="<c:out value='${renderLookups.lookup_id}' />" name="rcEmail" 
									onchange="AddToValidFieldEmail(this.id)" value="3">
								</c:when>
								<c:otherwise>
									<input type="radio" id="<c:out value='${renderLookups.lookup_id}' />" name="rcEmail" 
									onchange="AddToValidFieldEmail(this.id)" value="3">
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td><c:choose>
						<c:when test='${fieldType.contentEquals("PageBreak") || fieldType.contentEquals("Form Notification") || fieldType.contentEquals("E-Receipt Notification")}'>
							Amount
						
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test='${mandFieldForSp==1 || mandFieldForSp==2 || mandFieldForSp==3 || mandFieldForSp==4}'>
									<input type="radio" id="<c:out value='${renderLookups.lookup_id}' />" name="rcAmount" 
									onchange="AddToValidFieldAmount(this.id)" value="4">
								</c:when>
								<c:otherwise>
									<input type="radio" id="<c:out value='${renderLookups.lookup_id}' />" name="rcAmount" 
									onchange="AddToValidFieldAmount(this.id)" value="4">
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td><c:if test="${lookupInd.index !=0}">
						<a href="#" class="btn btn-xs btn-round btn-default"
							title="Push Field Up"
							onclick="AddToOrder('<c:out value="${lookupInd.index}"  />','U')"><i
							class="glyphicon glyphicon-chevron-up"></i></a>
					</c:if> <%-- <c:if test='${lookupInd.index !=fn:length(renderLookups)-1}'> --%>

					<c:if test="${lookupInd.index!=formBuild.renderLookups.size()-1}">
						<a href="#" class="btn btn-xs btn-round btn-default"
							title="Push Field Down"
							onclick="AddToOrder('<c:out value="${lookupInd.index}"  />','D')"><i
							class="glyphicon glyphicon-chevron-down"></i></a>
					</c:if> <%-- <c:if test="${fn:length(renderLookups) gt 0}">
						<a href="#" class="btn btn-xs btn-round btn-default"
							title="Push Field Down"
							onclick="AddToOrder('<c:out value="${lookupInd.index}"  />','D')"><i
							class="glyphicon glyphicon-chevron-down"></i></a>
					</c:if>   --%> <script>
						
					</script></td>
			</tr>

		</c:forEach>
	</table>
</body>
</html>