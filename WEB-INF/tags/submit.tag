<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ attribute name="path" %>
<%@ attribute name="action" %>
<%@ attribute name="htmlEscape" %>
<%@ attribute name="value" required="true" %>
<%@ attribute name="onclick" %>
<%@ attribute name="progressBar" %>
<%@ attribute name="progressIcon" %>
<%@ attribute name="alertCode" %>
<%@ attribute name="uppercase" %>
<%@ attribute name="image" %>
<%@ attribute name="imageVaadin" %>
<%@ attribute name="imageTheme" %>
<%@ attribute name="title" %>
<%@ attribute name="htmlStyle" %>
<%@ attribute name="cssClass" %>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    try{
%>
<c:if test="${empty htmlEscape}">
    <c:set var="htmlEscape" value="false"/>
</c:if>
<%
    cssClass = cssClass==null ? "" : cssClass.trim();
    htmlStyle = htmlStyle==null ? "" : htmlStyle.trim();
    if(!htmlStyle.endsWith(";")){
        htmlStyle += ";";
    }
    String progressType = "icon";
    if(Boolean.valueOf(progressBar)) {
        progressType = "bar";
    }
    if(progressIcon != null && !Boolean.valueOf(progressIcon)) {
        progressType = "";
    }
    
    boolean upperCased = true;
    if(uppercase != null && !"".equals(uppercase)) {
        upperCased = Boolean.valueOf(uppercase);
    }    
    if(upperCased){
        htmlStyle += "text-transform: uppercase;";
    }
    
    boolean showImg = false;
    if(image != null && !"".equals(image)) {
        showImg = Boolean.valueOf(image);
    }
    boolean themeImg = false;
    boolean shcpImg = true;
    if(imageVaadin != null && !"".equals(imageVaadin)) {
        showImg = Boolean.valueOf(imageVaadin);
        shcpImg = !Boolean.valueOf(imageVaadin);
        themeImg = !Boolean.valueOf(imageVaadin);
    }
    if(imageTheme != null && !"".equals(imageTheme)) {
        showImg = Boolean.valueOf(imageTheme);
        themeImg = Boolean.valueOf(imageTheme);
        shcpImg = !Boolean.valueOf(imageTheme);
    }

    if(path != null && !"".equals(path)) {
%>
        <input type="hidden" id="<%=path%>" name="<%=path%>" value="false"/>
<%
    }
    if(action != null && !"".equals(action)) {
        action = TagUtils.formatUrl(action);        
%>
        <c:url value="<%=action%>" var="_action" scope="page"/>
<%
        action = (String)pageContext.getAttribute("_action", PageContext.PAGE_SCOPE);
    }
    if(alertCode != null && !"".equals(alertCode)) {
%>
        <spring:message code="<%=alertCode%>" text="<%=alertCode%>" var="_alertCode" scope="page"/>
<%
        alertCode = (String)pageContext.getAttribute("_alertCode", PageContext.PAGE_SCOPE);
    }

    Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);

    if(onclick != null && !"".equals(onclick)) {
        onclick = onclick + ";return doSubmit("+ htmlElementUniqueID +");";
    } else {
        onclick = "return doSubmit("+ htmlElementUniqueID +");";
    }

    progressBar = progressBar != null ? progressBar : "false";
    action = action != null ? action : "";
    path = path != null ? path : "";
    alertCode = alertCode != null ? alertCode : "";

    if(!showImg) {
%>
        <spring:message code="${value}" text="${value}" var="value"/>
        <input id="<%=htmlElementUniqueID%>" type="submit" value="<c:out value='${value}'/>" class="<%=cssClass%>" onclick="<%=onclick%>" progressType="<%=progressType%>" action="<%=action%>" path="<%=path%>" alertCode="<%=alertCode%>" style="<c:out value='${htmlStyle}'/>"/>
<%
    } else {
        if(title != null) {
%>
            <spring:message code="${title}" text="${title}" var="title"/>
<%
        } else {
            title = "";
        }
        if(shcpImg) {
%>
            <input id="<%=htmlElementUniqueID%>" type="image" class="submit-icon" alt="<%=value%>" progressType="<%=progressType%>" 
                   action="<%=action%>" path="<%=path%>" alertCode="<%=alertCode%>" 
                   src="<spring:theme code="submit.tag.gif"/>/<%=value%>.gif" 
                   onmouseover="this.src='<spring:theme code="submit.tag.gif"/>/<%=value%>_ov.gif'" 
                   onmouseout="this.src='<spring:theme code="submit.tag.gif"/>/<%=value%>.gif'" 
                   onclick="<%=onclick%>" title="<c:out value='${title}'/>" style="<c:out value='${htmlStyle}'/>"/>
<%
        } else {
            if(themeImg) {
%>
                <input id="<%=htmlElementUniqueID%>" type="image" class="submit-icon" alt="<%=value%>" progressType="<%=progressType%>" 
                       action="<%=action%>" path="<%=path%>" alertCode="<%=alertCode%>" 
                       src="<spring:theme code="<%=value%>"/>" 
                       onclick="<%=onclick%>" title="<c:out value='${title}'/>" style="<c:out value='${htmlStyle}'/>"/>
<%
            } else {
%>
                <input id="<%=htmlElementUniqueID%>" type="image" class="submit-icon" alt="<%=value%>" progressType="<%=progressType%>" 
                       action="<%=action%>" path="<%=path%>" alertCode="<%=alertCode%>" 
                       src="<spring:theme code="submit.tag.png"/>/<%=value%>.png" 
                       onclick="<%=onclick%>" title="<c:out value='${title}'/>" style="<c:out value='${htmlStyle}'/>"/>
<%
            }
        }
    }

    if(progressType.equals("icon")) {
%>
        <img src="<spring:theme code="loader.gif"/>" id="progressIcon<%=htmlElementUniqueID%>" style="visibility:hidden;"/>
<%
    }
    
    }catch(Exception e){
        e.printStackTrace();
    }
%>