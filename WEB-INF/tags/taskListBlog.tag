<%@ tag import="java.util.List"%>
<%@ tag import="java.util.ArrayList"%>
<%@ tag import="java.util.Map"%>
<%@ tag import="gob.shcp.bpm.model.ProcessListItemDTO"%>
<%@ tag import="gob.shcp.bpm.model.TaskListItemDTO"%>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils"%>
<%@ tag import="gob.shcp.bpm.service.ProcessInstanceService"%>
<%@ tag import="org.springframework.util.ClassUtils"%>
<%@ tag import="java.util.Iterator"%>
<%@ tag import="java.text.DateFormat"%>
<%@ tag import="java.text.SimpleDateFormat"%>
<%@ tag import="java.util.Date"%>

<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@ attribute name="headers"%>
<%@ attribute name="columns"%>
<%@ attribute name="dateFormat"%>
<%@ attribute name="showProcessInfo"%>
<%@ attribute name="showTaskInfo"%>
<%@ attribute name="tableWidth"%>
<%@ attribute name="leftPosition"%>
<%@ attribute name="topPosition"%>
<%@ attribute name="heightPopUp"%>
<%@ attribute name="widthPopUp"%>
<%@ attribute name="showPopUp"%>
<%@ attribute name="messageLink"%>
<%@ attribute name="maxLength"%>

<%
try{
%>
    <c:set var="idProcessInstance" scope="page"><c:out value="${param['idProcessInstance']}" escapeXml="true"/></c:set>
<%    
    showProcessInfo = showProcessInfo != null ? showProcessInfo : "true";
    showTaskInfo = showTaskInfo != null ? showTaskInfo : "true";
    
    if(!Boolean.valueOf(showProcessInfo) && !Boolean.valueOf(showTaskInfo)){
        showProcessInfo = "true";
        showTaskInfo = "true";
    }
    
    final String idProcessInstance = (String)pageContext.getAttribute("idProcessInstance", PageContext.PAGE_SCOPE);
    /***  llamado al servicio en ProcessInstanceService para recuperar el processInstance por el id ***/
    ProcessListItemDTO processListItemDTO = ((ProcessInstanceService)TagUtils.getService(pageContext, (Class)ClassUtils.forName("gob.shcp.bpm.service.ProcessInstanceService"))).findProcessInstanceById(idProcessInstance);
    String processName = processListItemDTO.getProcessName();
    Map<String,String> errorDTO = gob.shcp.fsn.util.BeanUtils.transform(processListItemDTO.getErrorDTO());
    Map<String,String> processDTO = gob.shcp.fsn.util.BeanUtils.transform(processListItemDTO.getProcessDTO());
    tableWidth = tableWidth != null ? tableWidth : "50";
    messageLink = messageLink != null ? TagUtils.getPropertyResourcesValue(pageContext, messageLink) : "...";
    heightPopUp = heightPopUp != null ? heightPopUp : "600";
    widthPopUp = widthPopUp != null ? widthPopUp : "800";
    leftPosition  = leftPosition != null  ? leftPosition : "15";
    topPosition = topPosition != null ? topPosition : "15";
    maxLength = maxLength != null ? maxLength : "50";
    
    /*  
    *  Posibles valores para las propiedades a mostrar:
    *        "taskName", "actorId",
    *        "taskStart", "taskEnd", "observaciones"   
    */
    
    String[] tableColumns = {"taskName", "actorId", "taskStart", "taskEnd","observaciones"};
    String[] tableHeaders = tableColumns;
    showPopUp = showPopUp != null ? showPopUp : "false";    
    if(columns != null){
        tableColumns = columns.split(",");
        tableHeaders = columns.split(",");
    }
    
    if(headers != null){
        tableHeaders = headers.split(",");
    }
    
    dateFormat = (dateFormat!=null && !"".equals(dateFormat)) ? dateFormat : "dd/MM/yyyy HH:mm";   
    
    List<String> dateKeys = new ArrayList<String>();        
    dateKeys.add("taskEnd");
    dateKeys.add("taskStart"); 
%>
<c:set var="TAG_CONTENT">

<%      
    /* Tabla con los datos de la Instancia del Proceso */
    if(Boolean.valueOf(showProcessInfo)){
        Date pStartDate = processListItemDTO.getProcessStart();
        Date pEndDate = processListItemDTO.getProcessEnd();
        String pStartString = null;
        String pEndString = null;
        if(pStartDate != null || pEndDate != null){
            DateFormat df = new SimpleDateFormat(dateFormat);
            pStartString = pStartDate != null ? df.format(pStartDate) : null;
            pEndString = pEndDate != null ? df.format(pEndDate) : null;
        }
        Iterator it = null;

        /* Div para mostrar los datos del ErrorDTO   */
        if(!errorDTO.isEmpty()){
            it = errorDTO.entrySet().iterator();
%>
            <div id="ERROR_DTO_CONTENT" class="popup">
                <table border="0" width="250" bgcolor="#3C3C3C" cellspacing="0" cellpadding="5">
                    <tr>
                        <td width="100%">
                            <table border="0" width="100%" cellspacing="0" cellpadding="0" height="36">
                                <tr>
                                    <td style="cursor:move" width="100%" onmousedown="javascript:comienzoMovimiento(event, 'ERROR_DTO_CONTENT');">
                                    </td>
                                    <td style="cursor:hand" valign="top">
                                        <a href="#" onClick="closeDiv('ERROR_DTO_CONTENT');return false"><font color=#ffffff size=2 face=Montserrat-Regular  style="text-decoration:none">X</font></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%" bgcolor="#FFFFFF" style="padding:4px" colspan="2">
                                        <table>
                                            <th colspan="2">
                                                <spring:message code="processDefinitionDTO.errorDetail"/>
                                            </th>
<%
                                            while(it.hasNext()){
                                                Map.Entry pair = (Map.Entry)it.next();
%>
                                                <tr>
                                                    <td class="label">
                                                        <c:out value="<%=pair.getKey()%>"/>
                                                    </td>
                                                    <td>
<%
                                                        if(pair.getKey().toString().equals("messageError")){
%>
                                                            <textarea rows="20" cols="70" readonly="true"><c:out value="<%=pair.getValue()%>"/></textarea>
<%                          
                                                        }else{
%>
                                                            <c:out value="<%=pair.getValue()%>"/>
<%
                                                        }
%>                            
                                                    </td>
                                                </tr>
<%
                                            }
%>
                                        </table>                
                                    </td>
                                </tr>
                            </table> 
                        </td>
                    </tr>
                </table>
            </div>
<%                      
        }
        
        /* Div para mostrar los datos del ProcessDTO   */
        if(!processDTO.isEmpty()){
            it = processDTO.entrySet().iterator();
%>
            <div id="BUSINESS_DTO_CONTENT" class="popup">
                <table border="0" width="250" bgcolor="#3C3C3C" cellspacing="0" cellpadding="5">
                    <tr>
                        <td width="100%">
                            <table border="0" width="100%" cellspacing="0" cellpadding="0" height="36">
                                <tr>
                                    <td style="cursor:move" width="100%" onmousedown="javascript:comienzoMovimiento(event, 'BUSINESS_DTO_CONTENT');">
                                    </td>
                                    <td style="cursor:hand" valign="top">
                                        <a href="#" onClick="closeDiv('BUSINESS_DTO_CONTENT');return false"><font color=#ffffff size=2 face=Montserrat-Regular  style="text-decoration:none">X</font></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%" bgcolor="#FFFFFF" style="padding:4px" colspan="2">
                                        <div style="height:500px;width:300px;background-color: rgb(255,255,255);overflow:auto;">
                                        <table align="center">
                                            <th colspan="2">
                                                <spring:message code="processDefinitionDTO.data"/>
                                            </th>
<%
                                            while(it.hasNext()){
                                                Map.Entry pair = (Map.Entry)it.next();
%>              
                                                <tr>
                                                    <td class="label">
                                                        <c:out value="<%=pair.getKey()%>"/>
                                                  </td>
                                                  <td>
                                                        <c:out value="<%=pair.getValue()%>"/>
                                                  </td>
                                                </tr>
<%
                                            }
%>
                                        </table>
                                        </div>
                                    </td>
                                </tr>
                            </table> 
                        </td>
                    </tr>
                </table>
            </div>
<%                      
        }
%>        
        <table align="center">        
            <tr>
                <td class="label">
                    <spring:message code="processDefinitionDTO.processDefinitionName"/>
                </td>
                <td>
                    <c:out value="<%=processName%>"/>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <spring:message code="processDefinitionDTO.version"/>
                </td>
                <td>
                    <c:out value="<%=processListItemDTO.getVersion()%>"/>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <spring:message code="processDefinitionDTO.key"/>
                </td>
                <td>
                    <c:out value="<%=processListItemDTO.getKey()%>"/>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <spring:message code="processDefinitionDTO.start"/>
                </td>
                <td>
                    <c:out value="<%=pStartString%>"/>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <spring:message code="processDefinitionDTO.end"/>
                </td>
                <td>
                    <c:out value="<%=pEndString%>"/>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <spring:message code="processDefinitionDTO.folio"/>
                </td>
                <td>
                    <c:out value="<%=processListItemDTO.getFolio()%>"/>
                </td>
            </tr>
<%
            if(!errorDTO.isEmpty()){            
%>
                <tr>
                    <td class="label">
                        <spring:message code="processDefinitionDTO.error"/>
                    </td>
                    <td>
                        <a href="javascript:showDivProcessInfo('ERROR_DTO_CONTENT');">Detalle</a>
                    </td>
                </tr>
<%
            }
%>
            <tr>
                <td class="label">
                    <spring:message code="processDefinitionDTO.data"/>
                </td>
                <td>
                    <a href="javascript:showDivProcessInfo('BUSINESS_DTO_CONTENT');">Detalle</a>
                </td>
            </tr> 
        </table>
<%
    }
    
    if(Boolean.valueOf(showTaskInfo)){
%>

    <c:set var="tableWidth" value="<%=tableWidth%>"/>
    
        <!-- Div para el detalle de las tareas -->
        <div id="DETAIL_CONTENT" class="popup">
            <table border="0" width="250" bgcolor="#3C3C3C" cellspacing="0" cellpadding="5">
                <tr>
                    <td width="100%">
                        <table border="0" width="100%" cellspacing="0" cellpadding="0" height="36">
                            <tr>
                                <td style="cursor:move" width="100%" onmousedown="javascript:comienzoMovimiento(event, 'DETAIL_CONTENT');">
                                </td>
                                <td style="cursor:hand" valign="top">
                                    <a href="#" onClick="closeDiv('DETAIL_CONTENT');return false"><font color=#ffffff size=2 face=Montserrat-Regular  style="text-decoration:none">X</font></a>
                                </td>
                            </tr>
                            <tr>
                                <td width="100%" bgcolor="#FFFFFF" style="padding:4px" colspan="2">
                                    <table align="center">        
                                        <th>
                                            <c:out value="Comentarios"/>            
                                        </th>
                                        <tr align="center">
                                            <td>
                                                <textarea id="COMMENT_AREA" rows="12" cols="66" readonly="true"></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table> 
                    </td>
                </tr>
            </table>
        </div>
    
    <!-- Llamado al servicio para la creacion de la lista de tareas -->
        <c:if test="${tagutils:createPagedList(pageContext,'gob.shcp.bpm.service.ProcessTaskService','service','',idProcessInstance)}">
<%
                List data = (List)pageContext.getRequest().getAttribute(pageContext.getAttribute("displaySource").toString());
                if(!data.isEmpty()) {
                    TaskListItemDTO currentRow = null;
                    String format = null;
                    String propertyHeader = null;
                    String propertyName = null;            
%>
                  <!-- Creacion de la lista de tareas asignadas -->
                    <table align="center">
                        <tr>
                            <td>
                                <display:table name="${displaySource}" style="width:${tableWidth}%;" class="displaytag" id="row" sort="list" decorator="gob.shcp.fsn.control.view.decorator.PagedListTableDecorator">
<%
                                    for(int i=0; i<tableColumns.length; i++) {
                                        currentRow = (TaskListItemDTO)pageContext.getAttribute("row");
                                        propertyName = tableColumns[i];
                                        if(propertyName!=null && !"".equals(propertyName.trim())) {
                                            propertyHeader = getTitle(pageContext, tableHeaders, tableColumns, i);
                                            format = "";
                                            if(dateKeys.contains(propertyName.trim())) {
                                                format = "{0,date," + dateFormat + "}";
                                            }                        
%>
                                                <display:column title="<%=propertyHeader%>" property="<%=propertyName%>" format="<%=format%>" maxLength="<%=Integer.valueOf(maxLength)%>"/>
<%
                                        }
                                    }                                
%>
                                    <display:column>
<%
                                           if(currentRow.getObservaciones()!=null) {
                                                String taskComment = changeQuotes(currentRow.getObservaciones().toString());
%>
                                                <input type="hidden" id="message${row_rowNum}" value="<%=taskComment%>">
                                                <a href="javascript:showDivComment('DETAIL_CONTENT','message${row_rowNum}');"><img alt="procesar" src="<spring:theme code="detail.gif"/>" height="20" width="20" /></a>
<%
                                            }
%>
                                    </display:column>                        
                                    <display:setProperty name="basic.msg.empty_list">
                                        <br><span class="pagebanner">&nbsp;</span><span class="norecords"><spring:message text="Lista Vacia"/><br><br></span>
                                    </display:setProperty>
                                </display:table>
                            </td>
                        </tr>
                    </table>
<%
                }else{
%>
                    <display:table name="${displaySource}" style="width:${tableWidth}%;" class="displaytag" id="row" sort="list" decorator="gob.shcp.fsn.control.view.decorator.PagedListTableDecorator">                      
                        <display:setProperty name="basic.msg.empty_list">
                            <br><span class="pagebanner">&nbsp;</span><span class="norecords"><spring:message text="Proceso Sin Tareas"/><br><br></span>
                        </display:setProperty>
                    </display:table>
<%
                }
%>
        </c:if>
<%
    }
%>
</c:set>

<%    
    if(Boolean.valueOf(showPopUp)){
%>      
        <div id="PARENT_DIV" class="popup">
            <table border="0" width="250" bgcolor="#3C3C3C" cellspacing="0" cellpadding="5">
                <tr>
                    <td width="100%">
                        <table border="0" width="100%" cellspacing="0" cellpadding="0" height="36">
                            <tr>
                                <td style="cursor:move" width="100%" onmousedown="javascript:comienzoMovimiento(event, 'PARENT_DIV');">
                                </td>
                                <td style="cursor:hand" valign="top">
                                    <a href="#" onClick="closeDiv('PARENT_DIV');return false"><font color=#ffffff size=2 face=Montserrat-Regular  style="text-decoration:none">X</font></a>
                                </td>
                            </tr>
                            <tr>
                                <td width="100%" bgcolor="#FFFFFF" style="padding:4px" colspan="2">
                                    <div style="height:<%=heightPopUp%>px;width:<%=widthPopUp%>px;overflow:auto;">
                                        <c:out value="${TAG_CONTENT}" escapeXml="false"/>            
                                    </div>
                                </td>
                            </tr>
                        </table> 
                    </td>
                </tr>
            </table>
        </div>        
        <a href="javascript:showDivProcessInfo('PARENT_DIV');"><c:out value="<%=messageLink%>"/></a>
<%
    }else{
%>
        <c:out value="${TAG_CONTENT}" escapeXml="false"/>
<%
    }
%>

<script type="text/javascript">
    
    function showDivComment(divComment,idHidden) {    
       if(idHidden == null){
        idHidden = "";
       }
       document.getElementById("COMMENT_AREA").value = document.getElementById(idHidden).value;          
        showDivProcessInfo(divComment);
    }
    
    function showDivProcessInfo(divId) {
        if (document.getElementById(divId).style.visibility == "visible"){
            closeDiv(divId);
        } else {            
            centerInScreen(document.getElementById(divId), '<%=leftPosition%>', '<%=topPosition%>');
            document.getElementById(divId).style.visibility="visible";
        }
    }
    
    function closeDiv(divId){                
        if(divId == "PARENT_DIV"){
            if(document.getElementById("ERROR_DTO_CONTENT")){                
                document.getElementById("ERROR_DTO_CONTENT").style.visibility="hidden";
            }
            if(document.getElementById("BUSINESS_DTO_CONTENT")){                
                document.getElementById("BUSINESS_DTO_CONTENT").style.visibility="hidden";
            }
            if(document.getElementById("DETAIL_CONTENT")){                
                document.getElementById("DETAIL_CONTENT").style.visibility="hidden";
            }            
            if(document.getElementById("PARENT_DIV")){                
                document.getElementById("PARENT_DIV").style.visibility="hidden";
            }                                         
        }else{
            document.getElementById(divId).style.visibility="hidden";
        } 
    }

    carga();
</script>

<%
} catch(Exception e) {
    e.printStackTrace();
}
%>
<%!
    private String getTitle(PageContext pageContext, String[] tableHeaders, String[] keys, int idx) {
        String title;
        if(idx < tableHeaders.length) {
            title = tableHeaders[idx];
        } else {
            title = keys[idx];
        }
        return TagUtils.getPropertyResourcesValue(pageContext, title);
    }
    
    private String changeQuotes(String comment){
        comment = comment.replaceAll("\"","''");        
        return comment;
    }
%>