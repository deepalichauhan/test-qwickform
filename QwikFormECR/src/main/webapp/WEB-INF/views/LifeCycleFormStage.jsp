<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
</head>

<body>
<c:set var="stgCnt"><c:out value="${stageCount}" /></c:set>
<tr style="display:table-row;">
	<td><input style="width:20%;height:100% " class="form-control" readonly="readonly" value='<c:out value="${stageCount}" />'
		name="formCycles[<c:out value='${stageCount}' />].stage_number"></td>
	<td><select style="width:50%;height:100% " id='selectActors<c:out value="${stageCount}" />' name="formCycles[<c:out value='${stageCount}' />].actor_id">
			<option disabled="disabled" selected="selected" value="">Please Select an Option</option>
			<c:forEach items="${actors}" var="actors">
				<option value='<c:out value="${actors.actor_id}"/>'>
								<c:out value="${actors.actor_alias}" /></option>
			</c:forEach>
	</select></td>
	<td><select style="width:50%;height:100% " id='selectAction<c:out value="${stageCount}" />' name="formCycles[<c:out value='${stageCount}' />].form_action">
			<option disabled="disabled" selected="selected" value="">Please Select an Option</option>
			<c:forEach items="${formactions}" var="formactions">
				<option><c:out value="${formactions.action_name}" /></option>
			</c:forEach>
	</select></td>
	<td><select required="required" style="width: 50%; height: 100%"
		name="formCycles[<c:out value='${stageCount}' />].isEditable">
			<option disabled="disabled" selected="selected" value="">Please Select an Option</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
	</select></td>
</tr>
</body>
</html>
