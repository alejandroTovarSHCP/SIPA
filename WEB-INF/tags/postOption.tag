<%@ tag import="java.util.HashMap"%>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>

<%@ attribute name="key" required="true" %>
<%@ attribute name="value" required="true" %>

<%
    try{
        if (pageContext.getAttribute(DynaContentService.ADD_OPTIONS + "_POST", PageContext.REQUEST_SCOPE )==null ){
            pageContext.setAttribute(DynaContentService.ADD_OPTIONS + "_POST", new HashMap(), PageContext.REQUEST_SCOPE );
        }    
        ((HashMap)pageContext.getAttribute(DynaContentService.ADD_OPTIONS + "_POST", PageContext.REQUEST_SCOPE )).put(key, value);
    }catch(Exception e){
        e.printStackTrace();
    }
%>
