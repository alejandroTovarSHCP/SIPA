<%@ tag import="java.util.List" %>
<%@ tag import="java.util.Map" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.Iterator" %>
<%@ tag import="java.util.Collection" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>
<%@ tag import="gob.shcp.bpm.model.support.BpmTaskDTO" %>
<%@ tag import="gob.shcp.bpm.service.TaskInstanceService"%>
<%@ tag import="org.springframework.util.ClassUtils"%>
<%@ tag import="gob.shcp.fsn.control.binder.ControllerWebBindingInitializer" %> 

<%@ attribute name="alertCode"%>
<%@ attribute name="releaseAlertCode"%>
<%@ attribute name="transitionsAlertCode"%>
<%@ attribute name="progressBar" %>
<%@ attribute name="progressIcon" %>
<%@ attribute name="showReleaseFirst"%> <%-- Default false, si es true entonces presenta primero el boton relase task antes que las transiciones --%>
<%@ attribute name="onlyTrackParams"%>  <%-- Default false, si es true entonces solo mantiene los parametros del proceso a traves de campos 'hidden' para reenviarlos al controlador --%>
<%@ attribute name="uppercase"%>        <%-- Default false, si es true convierte a mayusculas el comentario de la tarea --%>
<%@ attribute name="commentLabel"%>     <%-- Define la etiqueta para el campo de comentarios --%>
<%@ attribute name="maxSizeLabel"%>     <%-- Define la etiqueta para el tamaño maximo del campo de comentarios --%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>


<input type="hidden" name="idTaskInstance" value="<c:out value="${bpmTask.idTaskInstance}"/>"/>
<input type="hidden" name="idProcessInstance" value="<c:out value="${bpmTask.idProcessInstance}"/>"/>
<input type="hidden" name="taskController" value="<c:out value="${bpmTask.taskController}"/>"/>

<%
try {
    boolean isTrackParams = Boolean.valueOf(onlyTrackParams);
    if(!isTrackParams) {
        commentLabel = commentLabel==null ? "comment.label" : commentLabel;
        maxSizeLabel = maxSizeLabel==null ? "comment.size.label" : maxSizeLabel;

        String progressType = "icon";
        if(Boolean.valueOf(progressBar)) {
            progressType = "bar";
        }
        if(progressIcon != null && !Boolean.valueOf(progressIcon)) {
            progressType = "";
        }

        boolean isReleaseFirst = Boolean.valueOf(showReleaseFirst);
        BpmTaskDTO taskDTO = (BpmTaskDTO)request.getAttribute("bpmTask");
        List transitions = ((TaskInstanceService)TagUtils.getService(pageContext, (Class)ClassUtils.forName("gob.shcp.bpm.service.TaskInstanceService"))).getTaskAvailableTransitions(taskDTO.getIdTaskInstance());

        boolean isUppercased = Boolean.valueOf(uppercase);
        String commentCssClass = isUppercased ? "uppercase" : "";
        if(isUppercased) {
%>
            <input type="hidden" name="<%=ControllerWebBindingInitializer.UPPER_CASE_PREFIX%>taskComment" value="true"/>
<%
        }
%>
        <table>
            <tr>
                <td valign="bottom"><spring:message code="<%=commentLabel%>" text="<%=commentLabel%>"/></td>
                <td rowspan="2"><textarea name="taskComment" cols="60" rows="5" onkeyup="validateTextAreaLength(this, 4000);" class="<%=commentCssClass%>"></textarea></td>
            </tr>
            <tr>
                <td valign="top" align="center"><spring:message code="<%=maxSizeLabel%>" text="<%=maxSizeLabel%>"/></td>                
            </tr>
        </table>
        <table>
            <tr>
<%
            String controller = TagUtils.formatUrl(taskDTO.getTaskController());

            //Release button first
            if(transitions.size() > 0 && isReleaseFirst) {
                String action = controller + "?transitionName=unlockTask";
%>
                <c:url value="<%=action%>" var="_action" scope="page"/>
<%
                action = (String)pageContext.getAttribute("_action", PageContext.PAGE_SCOPE);
                Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);
                String onclick = "return doSubmit("+ htmlElementUniqueID +");";
                String cssClass = "uppercase";
                String value = "submit.releaseTask";
%>
                <td>
                    <spring:message code="<%=value%>" text="<%=value%>" var="value"/>
<%
                String alertReleaseFirstMsg = null;
                
                if(releaseAlertCode != null && !"".equals(releaseAlertCode)) {
%>
                    <spring:message code="<%=releaseAlertCode%>" text="<%=releaseAlertCode%>" var="_releaseAlertCode" arguments="${value}" scope="page"/>
<%
                     alertReleaseFirstMsg = (String)pageContext.getAttribute("_releaseAlertCode", PageContext.PAGE_SCOPE);
                }
                
                if(alertCode != null && !"".equals(alertCode)) {
%>
                    <spring:message code="<%=alertCode%>" text="<%=alertCode%>" var="_alertCode" arguments="${value}" scope="page"/>
<%
                     alertReleaseFirstMsg = (String)pageContext.getAttribute("_alertCode", PageContext.PAGE_SCOPE);
                }
                
                alertReleaseFirstMsg = alertReleaseFirstMsg != null ? alertReleaseFirstMsg : "";
%>                
                    <input id="<%=htmlElementUniqueID%>" type="submit" value="<c:out value='${value}'/>" class="<%=cssClass%>" onclick="<%=onclick%>" progressType="<%=progressType%>" action="<%=action%>" path="" alertCode="<%=alertReleaseFirstMsg%>"/>
                </td>
<%
            }

            //Transition buttons
            for (final Iterator iter = transitions.iterator(); iter.hasNext();) {
                String transition = (String)iter.next();
                String action = controller + "?transitionName="+transition;
%>
                <c:url value="<%=action%>" var="_action" scope="page"/>
<%
                action = (String)pageContext.getAttribute("_action", PageContext.PAGE_SCOPE);
%>
                <td>
<%
                Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);
                String onclick = "return doSubmit("+ htmlElementUniqueID +");";
                String cssClass = "uppercase";
%>
                    <spring:message code="<%=transition%>" text="<%=transition%>" var="value"/>
<%
                String alertTransitionMsg = null;
                
                if(transitionsAlertCode != null && !"".equals(transitionsAlertCode)) {
                    String[] alertsArray  = transitionsAlertCode.trim().split(",");
                    final Map alertsMap = new HashMap();
                    for(String alert:alertsArray){
                        final String[] alertArray = alert.split("-");
                        alertsMap.put(alertArray[0],alertArray[1]);
                    }
                    if(alertsMap.containsKey(transition)){
%>                  
                        <spring:message code="<%=alertsMap.get(transition).toString()%>" text="<%=alertsMap.get(transition).toString()%>" var="_alertCode" arguments="${value}" scope="page"/>
<%
                        alertTransitionMsg = (String)pageContext.getAttribute("_alertCode", PageContext.PAGE_SCOPE);
                    }
                }
                
                if(alertCode != null && !"".equals(alertCode)) {
%>
                    <spring:message code="<%=alertCode%>" text="<%=alertCode%>" var="_alertCode" arguments="${value}" scope="page"/>
<%
                    alertTransitionMsg = (String)pageContext.getAttribute("_alertCode", PageContext.PAGE_SCOPE);
                }
                alertTransitionMsg = alertTransitionMsg != null ? alertTransitionMsg : "";
%>                
                    <input id="<%=htmlElementUniqueID%>" type="submit" value="<c:out value='${value}'/>" class="<%=cssClass%>" onclick="<%=onclick%>" progressType="<%=progressType%>" action="<%=action%>" path="" alertCode="<%=alertTransitionMsg%>"/>
                </td>
<%
            }

            //Release button last
            if(transitions.size() > 0 && !isReleaseFirst) {
                String action = controller + "?transitionName=unlockTask";
%>
                <c:url value="<%=action%>" var="_action" scope="page"/>
<%
                action = (String)pageContext.getAttribute("_action", PageContext.PAGE_SCOPE);
                Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);
                String onclick = "return doSubmit("+ htmlElementUniqueID +");";
                String cssClass = "uppercase";
                String value = "submit.releaseTask";
%>
                <td>
                    <spring:message code="<%=value%>" text="<%=value%>" var="value"/>
<%
                String alertReleaseMsg = null;
                
                if(releaseAlertCode != null && !"".equals(releaseAlertCode)) {
%>
                    <spring:message code="<%=releaseAlertCode%>" text="<%=releaseAlertCode%>" var="_releaseAlertCode" arguments="${value}" scope="page"/>
<%
                    alertReleaseMsg = (String)pageContext.getAttribute("_releaseAlertCode", PageContext.PAGE_SCOPE);
                }
                
                if(alertCode != null && !"".equals(alertCode)) {
%>
                    <spring:message code="<%=alertCode%>" text="<%=alertCode%>" var="_alertCode" arguments="${value}" scope="page"/>
<%
                    alertReleaseMsg = (String)pageContext.getAttribute("_alertCode", PageContext.PAGE_SCOPE);
                }
                alertReleaseMsg = alertReleaseMsg != null ? alertReleaseMsg : "";
%>                 
                    <input id="<%=htmlElementUniqueID%>" type="submit" value="<c:out value='${value}'/>" class="<%=cssClass%>" onclick="<%=onclick%>" progressType="<%=progressType%>" action="<%=action%>" path="" alertCode="<%=alertReleaseMsg%>"/>
                </td>
<%
            }
%>            
            </tr>
        </table>
<%
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>
