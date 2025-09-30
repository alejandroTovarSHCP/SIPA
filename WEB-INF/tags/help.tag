<%@ tag import="gob.shcp.fsn.service.parameter.ParameterService" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>
<%@ tag import="org.apache.commons.lang.WordUtils"%>
<%@ tag import="org.apache.commons.lang.ArrayUtils"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="name"%>
<%@ attribute name="type"%>
<%@ attribute name="contentType"%>
<%@ attribute name="icon"%>
<%@ attribute name="showLink"%>
<%@ attribute name="showInline"%>
<%@ attribute name="onclick" %>

<%
    try {
        String requestURI = request.getAttribute("gob.shcp.fsn.web.request.uri") != null ? String.valueOf(request.getAttribute("gob.shcp.fsn.web.request.uri")) : null; // path=/controller/method.do
        String path = (requestURI!=null && !"".equals(requestURI)) ? requestURI.substring(1) : request.getRequestURI().substring(request.getContextPath().length()+1); // path=controller/method.do
        String paramName1 = "GUIDE_"+path.replace("/", "_").replace(".do", "").toUpperCase(); // paramName1=GUIDE_CONTROLLER_METHOD

        path = path.substring(0, path.lastIndexOf("/")); // path=controller
        String paramName2 = "GUIDE_"+path.replace("/", "_").replace(".do", "").toUpperCase(); // paramName2=GUIDE_CONTROLLER

        path = request.getContextPath().substring(1); // path=webcontext
        String paramName3 = "GUIDE_"+path.replace("/", "_").replace(".do", "").toUpperCase(); // paramName3=GUIDE_WEBCONTEXT

        type = (type!=null && !"".equals(type)) ? type : "pdf";
        contentType = (contentType!=null && !"".equals(contentType)) ? contentType : "application/pdf";
        icon = (icon!=null && !"".equals(icon)) ? icon : "ayuda";
        boolean showImage = !Boolean.valueOf(showLink);
        boolean showAttachment = !Boolean.valueOf(showInline);

        Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);
        if(onclick != null && !"".equals(onclick)) {
            onclick = onclick + ";return doOpen("+ htmlElementUniqueID +");";
        } else {
            onclick = "return doOpen("+ htmlElementUniqueID +");";
        }

        final ParameterService parameterService = TagUtils.parameter(pageContext);
        String parameterName = null;
        if(name!=null && !"".equals(name)) {
            parameterName = name;
        } else if(!ArrayUtils.isEmpty(parameterService.getBytes(paramName1))) {
            parameterName = paramName1;
        } else if(!ArrayUtils.isEmpty(parameterService.getBytes(paramName2))) {
            parameterName = paramName2;
        } else if(!ArrayUtils.isEmpty(parameterService.getBytes(paramName3))) {
            parameterName = paramName3;
        } else {
            parameterName = "PARAMETER_UNDEFINED";
        }
        final String description = parameterService.getDescription(parameterName);

        final String title = (description!=null && !"".equals(description)) ? WordUtils.capitalizeFully(description) : WordUtils.capitalizeFully(parameterName.replace("_", " "));
        final String contentDisposition = showAttachment ? "attachment;filename=\""+title+"."+type+"\"" : "inline;filename=\""+title+"."+type+"\"";
        final String url = "images/renderImage.do?parameterName="+parameterName+"&contentType="+contentType+"&contentDisposition="+contentDisposition;

        if("pdf".equalsIgnoreCase(type)) {
            if(showImage) {
%>
                <input id="<%=htmlElementUniqueID%>" type="image" class="submit-icon" alt="<%=icon%>"
                       action='<c:out value="${pageContext.request.contextPath}/"/><%=url%>'
                       log="[<%=requestURI%>][<%=paramName1%>][<%=paramName2%>][<%=paramName3%>][<%=parameterName%>]"
                       src="<spring:theme code="submit.tag.gif"/>/<%=icon%>.gif" 
                       onmouseover="this.src='<spring:theme code="submit.tag.gif"/>/<%=icon%>_ov.gif'" 
                       onmouseout="this.src='<spring:theme code="submit.tag.gif"/>/<%=icon%>.gif'" 
                       onclick="<%=onclick%>" title="<%=title%>" style=""/>
<%
            } else {
%>
                <img src='<spring:theme code="submit.tag.gif"/>/pdf.gif' alt="PDF" width="20" height="20" title="<%=title%>"/>
                <a id="<%=htmlElementUniqueID%>" href="#"
                   action='<c:out value="${pageContext.request.contextPath}/"/><%=url%>'
                   log="[<%=requestURI%>][<%=paramName1%>][<%=paramName2%>][<%=paramName3%>][<%=parameterName%>]"
                   onclick="<%=onclick%>"><%=title%></a>
<%
            }
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
