<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>
<%@ tag import="gob.shcp.jcr.service.JcrService" %>
<%@ tag import="gob.shcp.fsn.service.ServiceException"%>

<%@ attribute name="jcrPath"%>    <!--path del nodo en el repositorio jcr -->
<%@ attribute name="bindPath"%>   <!--nombre del campo del formulario que contiene el valor del path -->
<%@ attribute name="name"%>       <!--nombre de la coleccion para mostrar las versiones -->
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    try{
        if(jcrPath==null){
            pageContext.setAttribute("bindPath", bindPath, PageContext.PAGE_SCOPE);
%>
            <spring:bind path="${bindPath}">
                <c:set var="requestValue" value="${status.value}"/>
            </spring:bind>
<%
            String obj =(String)pageContext.getAttribute("requestValue");
            if (obj!=null){
                jcrPath = obj;
            }
        }
        if (jcrPath!=null && !jcrPath.equals("")){
            
            
        List data = ((JcrService)TagUtils.getService(pageContext,JcrService.class )).getVersions(jcrPath);

    if(name == null || "".equals(name)) {
    name = "items";
    }
    request.setAttribute(name, data);
        }
    }catch(Exception e){
        e.printStackTrace();
    }
%>
