<%@ tag import="java.util.Properties"%>
<%@ tag import="gob.shcp.fsn.model.support.FilterDTO"%>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils"%>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>

<%@ attribute name="property" required="true" %>
<%@ attribute name="condition" %>
<%@ attribute name="path" %>
<%@ attribute name="value" type="java.lang.Object" %>
<%@ attribute name="type" %>
<%@ attribute name="id" %>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    try {
        if(id==null || "".equals(id)) {
            id = DynaContentService.PAGED_LIST_FILTER;
        }

        /* Se genera la instancia del FilterDTO y se coloca en el pageContext */
        if(pageContext.getAttribute(id, PageContext.REQUEST_SCOPE )==null) {
            pageContext.setAttribute(id , new FilterDTO(), PageContext.REQUEST_SCOPE);
        }

        /* Se genera la instancia del Properties de columnas de negocio y se coloca en el pageContext*/
        if(pageContext.getAttribute(TagUtils.BUSINESS_COLUMNS_TYPES, PageContext.REQUEST_SCOPE )==null) {
            pageContext.setAttribute(TagUtils.BUSINESS_COLUMNS_TYPES , new Properties(), PageContext.REQUEST_SCOPE);
        }

        if(value==null) {
            if(path==null) {
                path = property;
            }
            pageContext.setAttribute("path", path, PageContext.PAGE_SCOPE);
%>
            <spring:bind path="${path}">
                <c:set var="requestValue" value="${status.value}"/>
            </spring:bind>
<%
            Object obj = pageContext.getAttribute("requestValue");
            if(obj!=null) {
                value = obj;
            }
        }
        if(value!=null && !value.equals("")) {
            ((FilterDTO)pageContext.getAttribute(id, PageContext.REQUEST_SCOPE)).addFilter(property, condition, value);
        }
        if(type!=null && !type.equals("")) {
            ((Properties)pageContext.getAttribute(TagUtils.BUSINESS_COLUMNS_TYPES, PageContext.REQUEST_SCOPE)).put(property, type);
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
