<%@ tag import="gob.shcp.fsn.service.parameter.ParameterService" %>
<%@ tag import="org.springframework.util.ClassUtils"%>
<%@ tag import="org.springframework.web.util.ExpressionEvaluationUtils" %>
<%@ tag import="org.springframework.web.util.TagUtils"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="name"           required="true"%>
<%@ attribute name="type"           required="true"%>
<%@ attribute name="className"%>
<%@ attribute name="contentType"%>
<%@ attribute name="contentDisposition"%>
<%@ attribute name="var"%>
<%@ attribute name="scope"%>
<%@ attribute name="defaultValue"%>
<%@ attribute name="alt"%>
<%@ attribute name="cssImage"%>
<%@ attribute name="height"%>
<%@ attribute name="width"%>

<%
    try {
        Class clazz = (className!=null && !"".equals(className)) ? ClassUtils.forName(className) : null;
        contentType = (contentType!=null && !"".equals(contentType)) ? contentType : "";
        contentDisposition = (contentDisposition!=null && !"".equals(contentDisposition)) ? contentDisposition : "attachment;";
        scope = (scope!=null && !"".equals(scope)) ? scope : "request";
        alt = alt != null && !"".equals(alt) ? alt : "image";
        cssImage = cssImage != null && !"".equals(cssImage) ? cssImage : "";
        height = (height != null && !"".equals(height)) ? height : "67";
        width = (width != null && !"".equals(width)) ? width : "139";

        final ParameterService parameterService = gob.shcp.fsn.control.view.util.TagUtils.parameter(pageContext);
        if("string".equalsIgnoreCase(type)) {
            String value = null;
            try {
                value = parameterService.getString(name);
                if(name.equalsIgnoreCase(value)){//regreso la llave entonces ponemos el valor default
                	value=defaultValue;
                }
            } catch(Exception e) {
                System.out.println("WARN - Ocurrio un error al invocar el servicio de parametros para obtener [" + name + "], se regresa el valor por defecto [" + defaultValue + "] - [" + e.getMessage() + "]");
            }
            value = (value!=null && !"".equals(value)) ? value : defaultValue;
            final String resolvedVar = ExpressionEvaluationUtils.evaluateString("var", this.var, pageContext);
            if(resolvedVar != null) {
                String resolvedScope = ExpressionEvaluationUtils.evaluateString("scope", this.scope, pageContext);
                pageContext.setAttribute(resolvedVar, value, TagUtils.getScope(resolvedScope));
            }
        } else if("bean".equalsIgnoreCase(type)) {
            Object value = null;
            try {
                value = parameterService.getObject(name, clazz);
            } catch(Exception e) {
                System.out.println("WARN - Ocurrio un error al invocar el servicio de parametros para obtener [" + name + "], se regresa el valor por defecto [" + defaultValue + "] - [" + e.getMessage() + "]");
            }
            value = value!=null ? value : defaultValue;
            final String resolvedVar = ExpressionEvaluationUtils.evaluateString("var", this.var, pageContext);
            if(resolvedVar != null) {        
                String resolvedScope = ExpressionEvaluationUtils.evaluateString("scope", this.scope, pageContext);
                pageContext.setAttribute(resolvedVar, value, TagUtils.getScope(resolvedScope));
            }
        } else if("image".equalsIgnoreCase(type)) {
            byte[] value = null;
            try {
                value = parameterService.getBytes(name);
            } catch(Exception e) {
                System.out.println("WARN - Ocurrio un error al invocar el servicio de parametros para obtener [" + name + "], se regresa el valor por defecto [" + defaultValue + "] - [" + e.getMessage() + "]");
            }
            if(value!=null && value.length > 0) {
%>
                <img src='<c:out value="${pageContext.request.contextPath}/"/>images/renderImage.do?parameterName=<%=name%>&contentType=<%=contentType%>' alt="<%=alt%>" width="<%=width%>" height="<%=height%>" class="<%=cssImage%>">
<%          } else {
%>
                <img src="<%=defaultValue%>" alt="<%=alt%>" width="<%=width%>" height="<%=height%>" class="<%=cssImage%>">
<%          }
        } else if("link".equalsIgnoreCase(type)) {
            byte[] value = null;
            try {
                value = parameterService.getBytes(name);
            } catch(Exception e) {
                System.out.println("WARN - Ocurrio un error al invocar el servicio de parametros para obtener [" + name + "], se regresa el valor por defecto [" + defaultValue + "] - [" + e.getMessage() + "]");
            }
            if(value!=null && value.length > 0) {
%>
                <a href='<c:out value="${pageContext.request.contextPath}/"/>images/renderImage.do?parameterName=<%=name%>&contentType=<%=contentType%>&contentDisposition=<%=contentDisposition%>' class="<%=cssImage%>"><%=defaultValue%></a>
<%          } else {
%>
                <a href="#"><%=defaultValue%></a>
<%          }
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
