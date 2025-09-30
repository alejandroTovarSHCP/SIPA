<%@ tag import="gob.shcp.fsn.control.binder.ControllerWebBindingInitializer" %> 

<%@ attribute name="path" required="true" %>
<%@ attribute name="cols" %>
<%@ attribute name="disabled" %>
<%@ attribute name="htmlEscape" %>
<%@ attribute name="readonly" %>
<%@ attribute name="rows" %>
<%@ attribute name="title" %>
<%@ attribute name="uppercase" %>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
    try{
%>

<c:if test="${empty htmlEscape}">
    <c:set var="htmlEscape" value="false"/>
</c:if>
<%
    boolean upperCased = true;
    if(uppercase != null && !"".equals(uppercase)) {
        upperCased = Boolean.valueOf(uppercase);
    }
    String cssClass = upperCased ? "uppercase" : "";
    cols = cols==null? "" : cols;
    disabled = Boolean.valueOf(disabled).toString();
    readonly = Boolean.valueOf(readonly).toString();
    rows = rows==null ? "" : rows;
    title = title==null ? "" : title;
    
    if(upperCased) {
%>
        <input type="hidden" name="<%=ControllerWebBindingInitializer.UPPER_CASE_PREFIX%><%=path%>" value="true"/>
<%
    }
%>

<html:textarea path="<%=path%>" cols="<%=cols%>" rows="<%=rows%>" title="<%=title%>" disabled="<%=disabled%>" readonly="<%=readonly%>" cssClass="<%=cssClass%>"/>

<%
    }catch(Exception e){
        e.printStackTrace();
    }
%>