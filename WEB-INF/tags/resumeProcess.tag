<%@ tag import="gob.shcp.bpm.model.support.BpmProcessDTO" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@ attribute name="alertCode"%>
<%@ attribute name="resumeUrl" required="true"%>

<%
    try{
%>

<table>
    <tr>
<%
        if(alertCode != null && !"".equals(alertCode)) {
%>
            <spring:message code="<%=alertCode%>" text="<%=alertCode%>" var="_alertCode" scope="page"/>
<%
            alertCode = (String)pageContext.getAttribute("_alertCode", PageContext.PAGE_SCOPE);
        }
            alertCode = alertCode != null ? alertCode : "";
            BpmProcessDTO bpmProcess = (BpmProcessDTO)request.getAttribute("bpmProcess");
            long idProcess = bpmProcess.getIdProcessInstance();
            String controller = TagUtils.formatUrl(resumeUrl);
            String action = controller+ "?idProcessInstance=" + idProcess;
%>
            <c:url value="<%=action%>" var="_action" scope="page"/>
<%
            action = (String)pageContext.getAttribute("_action", PageContext.PAGE_SCOPE);
            Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);
            String onclick = "return doSubmit("+ htmlElementUniqueID +");";
            String progressType = "icon";
            String cssClass = "uppercase";
            String value = "submit.resumeProcess";
        

%>
        <td align="center">
            <spring:message code="<%=value%>" text="<%=value%>" var="value"/>
            <input id="<%=htmlElementUniqueID%>" type="submit" value="<c:out value='${value}'/>" class="<%=cssClass%>" onclick="<%=onclick%>" progressType="<%=progressType%>" action="<%=action%>" path="" alertCode="<%=alertCode%>"/>
        </td>
    </tr>
</table>

<%
    }catch(Exception e){
        e.printStackTrace();
    }
%>