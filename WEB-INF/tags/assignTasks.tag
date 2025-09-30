<%@ tag import="java.util.Iterator" %>
<%@ tag import="java.util.Map" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="org.springframework.util.ClassUtils"%>
<%@ tag import="gob.shcp.bpm.model.support.BpmTaskDTO"%>
<%@ tag import="gob.shcp.bpm.model.support.BpmProcessDTO"%>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils"%>
<%@ tag import="gob.shcp.fsn.service.security.SecurityService" %>

<%@ attribute name="uppercase"%>        <%-- Default false, si es true convierte a mayusculas el comentario de la tarea --%>
<%@ attribute name="commentLabel"%>     <%-- Define la etiqueta para el campo de comentarios --%>
<%@ attribute name="maxSizeLabel"%>     <%-- Define la etiqueta para el tamaño maximo del campo de comentarios --%>
<%@ attribute name="alertCode"%>
<%@ attribute name="assignUrl" required="true"%>
<%@ attribute name="rolName"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    try{
    boolean isUppercased = Boolean.valueOf(uppercase);
    String commentCssClass = isUppercased ? "uppercase" : "";
    commentLabel = commentLabel==null ? "comment.label" : commentLabel;
    maxSizeLabel = maxSizeLabel==null ? "comment.size.label" : maxSizeLabel;

    
    BpmTaskDTO taskDTO = (BpmTaskDTO)request.getAttribute("bpmTask");
    BpmProcessDTO processDTO = (BpmProcessDTO)request.getAttribute("bpmProcess");
    
    if (taskDTO.getIdsAssign() != null && taskDTO.getIdsAssign().length > 0)  {
        %>
            <fieldset title="Asignar Tarea"><legend><spring:message code="assignTask.title"/></legend>
            <table align="center">
                <tr>
                    <td class="label"><spring:message code="assignTask.assignTo"/></td>
                <%
                    Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);
                    String onclick = "return doSubmit("+ htmlElementUniqueID +");";
                    String progressType = "icon";
                    String cssClass = "uppercase";
                    String submitLabel = "assignTask.assignTaskSubmit";
                    assignUrl = TagUtils.formatUrl(assignUrl);
                %>
                    <c:url value="<%=assignUrl%>" var="_assignUrl" scope="page"/>
                <%
                    assignUrl = (String)pageContext.getAttribute("_assignUrl", PageContext.PAGE_SCOPE);
                    List<String> users = new ArrayList<String>();
                    if(rolName != null && !"".equals(rolName)){                        
                        final SecurityService securityService = gob.shcp.fsn.control.view.util.TagUtils.security(pageContext);
                        users = securityService.getUsersByRoleName(rolName);                                                  
                %>
                        <td>
                            <select name="assignUser">
                            <%
                                for (final Iterator iter = users.iterator(); iter.hasNext();) {
                                    String usuario = (String)iter.next();                                
                            %>
                                <spring:message code="<%=usuario%>" text="<%=usuario%>" var="usuario"/>
                                <option value="<c:out value='${usuario}'/>"><c:out value='${usuario}'/></option>
                            <%                                            
                                }
                            %>
                            </select>
                            <spring:message code="<%=submitLabel%>" text="<%=submitLabel%>" var="submitLabel"/>
                            <%
                                String alertMsg = null;
                                if(alertCode != null && !"".equals(alertCode)) {
                            %>
                                    <spring:message code="<%=alertCode%>" text="<%=alertCode%>" var="_alertCode" arguments="${submitLabel}" scope="page"/>
                            <%
                                    alertMsg = (String)pageContext.getAttribute("_alertCode", PageContext.PAGE_SCOPE);
                                }
                                    alertMsg = alertMsg != null ? alertMsg : "";
                            %>                
                            <input id="<%=htmlElementUniqueID%>" type="submit" value="<c:out value='${submitLabel}'/>" class="<%=cssClass%>" onclick="<%=onclick%>" progressType="<%=progressType%>" action="<%=assignUrl%>" path="" alertCode="<%=alertMsg%>"/>
                        </td>
                <%} else {
                    %>
                        <td>
                            <input type="text" name="assignUser"/>
                            <spring:message code="<%=submitLabel%>" text="<%=submitLabel%>" var="submitLabel"/>
                            <%
                                String alertMsg = null;
                                if(alertCode != null && !"".equals(alertCode)) {
                            %>
                                    <spring:message code="<%=alertCode%>" text="<%=alertCode%>" var="_alertCode" arguments="${submitLabel}" scope="page"/>
                            <%
                                    alertMsg = (String)pageContext.getAttribute("_alertCode", PageContext.PAGE_SCOPE);
                                }
                                    alertMsg = alertMsg != null ? alertMsg : "";
                            %>                
                            <input id="<%=htmlElementUniqueID%>" type="submit" value="<c:out value='${submitLabel}'/>" class="<%=cssClass%>" onclick="<%=onclick%>" progressType="<%=progressType%>" action="<%=assignUrl%>" path="" alertCode="<%=alertMsg%>"/>
                        </td>
                    <%                    
                    }
                    %>                    
                </tr>            
                <tr>
                    <td class="label" valign="bottom"><spring:message code="<%=commentLabel%>" text="<%=commentLabel%>"/></td>
                    <td rowspan="2"><textarea name="taskComment" cols="60" rows="5" onkeyup="validateTextAreaLength(this, 4000);" class="<%=commentCssClass%>"></textarea></td>
                </tr>
                <tr>
                    <td class="label" valign="top" align="center"><spring:message code="<%=maxSizeLabel%>" text="<%=maxSizeLabel%>"/></td>                
                </tr>
                <tr>
                    <td colspan="3">
                        <table class="displaytag">
                            <tr>
                                <th>&nbsp;</th><th><spring:message code="assignTask.taskName"/></th>
                            </tr>
                    <%
                            int counter = 0;
                            for(String taskItem:taskDTO.getIdsAssign()){
                                String[] properties = taskItem.split(","); //[0]idTaskInstance, [1]taskName, [2]idProcessInstance
                                String idTaskInstance = properties[0].substring(properties[0].lastIndexOf("=") + 1, properties[0].length());
                                String taskName = properties[1].substring(properties[1].lastIndexOf("=") + 1, properties[1].length());
                                counter++;
                                %>
                                <tr class="<%=counter%2 == 0 ? "even" : "odd"%>">
                                    <td width="6%"><input type="checkbox" name="idsAssign" value="<%=idTaskInstance%>"/></td><td width="94%"><%=taskName%></td>
                                </tr>                    
                                <%
                            }       
                    %>
                        </table>                        
                    </td>
                </tr>
            </table>
            </fieldset>
        <%
    }        
} catch(Exception e) {
    e.printStackTrace();
}
%>