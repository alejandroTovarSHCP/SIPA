<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ attribute name="action"%>
<%@ attribute name="parameters"%>
<%@ attribute name="htmlEscape"%>

<%@ attribute name="href"%>
<%@ attribute name="target"%>
<%@ attribute name="accesskey"%>
<%@ attribute name="alt"%>
<%@ attribute name="cssClass"%>
<%@ attribute name="cssStyle"%>
<%@ attribute name="dir"%>
<%@ attribute name="disabled"%>
<%@ attribute name="id"%>
<%@ attribute name="lang"%>
<%@ attribute name="onblur"%>
<%@ attribute name="onfocus"%>
<%@ attribute name="onclick"%>
<%@ attribute name="ondblclick"%>
<%@ attribute name="onmousedown"%>
<%@ attribute name="onmousemove"%>
<%@ attribute name="onmouseout"%>
<%@ attribute name="onmouseover"%>
<%@ attribute name="onmouseup"%>
<%@ attribute name="tabindex"%>
<%@ attribute name="title"%>
<%@ attribute name="progressBar" %>
<%@ attribute name="progressIcon"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%
    try{
%>
        <c:if test="${empty htmlEscape}">
            <c:set var="htmlEscape" value="false"/>
        </c:if>
        <c:set value="<%=href%>" var="_href" scope="page"/>
        <%
        Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);
        
        String progressType = "icon";
        if(Boolean.valueOf(progressBar)) {
            progressType = "bar";
        }
        if(progressIcon != null && !Boolean.valueOf(progressIcon)){
            progressType = "";
        }
        
        if(href == null || "".equals(href)) {
            if(action != null && !"".equals(action)) {
                if(!action.startsWith("/")) {
                    action = "/" + action;
                }
                if(!action.endsWith(".do")) {
                    action = action + ".do";
                }
                if(parameters != null && !"".equals(parameters)) {
                    if(!parameters.startsWith("?")) {
                        parameters = "?" + parameters;
                    }
                    action = action + parameters.replace(",", "&");
                }
%>
                <c:url value="<%=action%>" var="_href" scope="page"/>
<%
            } else {
%>
                <c:set value="#" var="_href" scope="page"/>
<%
            }
        }
        
        if(onclick != null && !"".equals(onclick)) {
            onclick = onclick + "showLightbox("+ htmlElementUniqueID +");";
        } else {
            onclick = "showLightbox("+ htmlElementUniqueID +");";
        }
        
        if(disabled != null && "true".equals(disabled)) {
%>
            <jsp:doBody />
<%
        } else {
%>
            <a id="<%=htmlElementUniqueID%>" progressType="<%=progressType%>" href="<c:out value='${_href}'/>" onclick="<%=onclick%>">
                <jsp:doBody />
            </a>
<%
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