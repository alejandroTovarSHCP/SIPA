<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>
<%@ tag import="gob.shcp.jcr.query.JcrCondition"%>
<%@ tag import="org.springframework.util.ClassUtils" %>
<%@ tag import="gob.shcp.jcr.service.JcrService" %>
<%@ tag import="gob.shcp.jcr.node.JcrConstants" %>

<%@ attribute name="name" %>    <%--Nombre del atributo en el request donde se sube la lista de datos si no es por beanName o service, por default es igual a "items" --%>
<%@ attribute name="nodeType" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
    String nodeTypeName = nodeType!=null?nodeType:JcrConstants.NT_RESOURCE;
    try{
    ArrayList conditions  = (ArrayList)pageContext.getAttribute("jcr-conditions", PageContext.REQUEST_SCOPE);
    if (conditions==null){
        conditions= new ArrayList();
    }
    List data = ((JcrService)TagUtils.getService(pageContext,JcrService.class )).getFilesByCondition(nodeType,conditions);

    if(name == null || "".equals(name)) {
    name = "items";
    }
    request.setAttribute(name, data);
    pageContext.removeAttribute("jcr-conditions", PageContext.REQUEST_SCOPE);
} catch(gob.shcp.fsn.service.ServiceException se) {
    TagUtils.saveError(pageContext, se);
%>
    <jsp:include page="/WEB-INF/jsp/layout/message.jsp" />
<%
} catch(Exception e) {
    e.printStackTrace();
}
%>