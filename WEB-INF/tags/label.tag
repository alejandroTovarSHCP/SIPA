<%@ tag body-content="scriptless" %>

<%@ attribute name="path" required="true" %>
<%@ attribute name="htmlEscape" required="false" %>

<%@ attribute name="cssClass" required="false" %>
<%@ attribute name="cssStyle" required="false" %>
<%@ attribute name="dir" required="false" %>
<%@ attribute name="id" required="false" %>
<%@ attribute name="lang" required="false" %>
<%@ attribute name="onclick" required="false" %>
<%@ attribute name="ondblclick" required="false" %>
<%@ attribute name="onmousedown" required="false" %>
<%@ attribute name="onmousemove" required="false" %>
<%@ attribute name="onmouseout" required="false" %>
<%@ attribute name="onmouseover" required="false" %>
<%@ attribute name="onmouseup" required="false" %>
<%@ attribute name="tabindex" required="false" %>
<%@ attribute name="title" required="false" %>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty htmlEscape}">
    <c:set var="htmlEscape" value="false"/>
</c:if>

<form:hidden path="${path}" id="${id}" htmlEscape="${htmlEscape}"/>
<form:label path="${path}" id="${id}" htmlEscape="${htmlEscape}" cssClass="content">
    <spring:bind path="${path}">
        <c:out value="${status.value}"/>
    </spring:bind>
</form:label>
