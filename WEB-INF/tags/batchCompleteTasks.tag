<%@ tag import="java.util.List"%>
<%@ tag import="java.util.ArrayList"%>
<%@ tag import="java.util.Iterator"%>
<%@ tag import="java.util.Map"%>
<%@ tag import="java.util.HashMap"%>
<%@ tag import="java.util.Properties"%>
<%@ tag import="gob.shcp.fsn.model.support.FilterDTO"%>
<%@ tag import="gob.shcp.fsn.model.support.SortCriteriaDTO"%>
<%@ tag import="gob.shcp.bpm.model.TaskListItemDTO"%>
<%@ tag import="gob.shcp.bpm.service.TaskInstanceService"%>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>
<%@ tag import="gob.shcp.fsn.model.support.DynaDTO" %>
<%@ tag import="org.springframework.util.ClassUtils"%>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils"%>
<%@ tag import="org.springframework.web.servlet.support.RequestContext"%>
<%@ tag import="gob.shcp.fsn.control.binder.ControllerWebBindingInitializer"%>
<%@ tag import="gob.shcp.fsn.control.view.decorator.CheckboxTableDecorator" %>

<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@ attribute name="url"%>
<%@ attribute name="pagedUrl" required="true"%>
<%@ attribute name="imageUrl"%>
<%@ attribute name="headers"%>
<%@ attribute name="columns"%>
<%@ attribute name="dateFormat"%>
<%@ attribute name="height"%>
<%@ attribute name="width"%>
<%@ attribute name="maxLength"%>
<%@ attribute name="showActionFirst"%>
<%@ attribute name="dispatchToolTip" %>
<%@ attribute name="gridSize"%>
<!-- Campos para la atencion de las tareas -->
<%@ attribute name="taskName" required="true"%>
<%@ attribute name="processName" required="true"%>
<%@ attribute name="transitionsAlertCode"%>
<%@ attribute name="showComment"%>
<%@ attribute name="uppercase"%>        <%-- Default false, si es true convierte a mayusculas el comentario de la tarea --%>
<%@ attribute name="commentLabel"%>     <%-- Define la etiqueta para el campo de comentarios --%>
<%@ attribute name="maxSizeLabel"%>     <%-- Define la etiqueta para el tamaño maximo del campo de comentarios --%>


<%
try {
    /*  
    *  Posibles valores para las propiedades a mostrar:
    *        "processKey", "folio", "taskName", "taskCreate",
    *        "taskStart", "taskDueDate", "processName", "processStart"   
    */        
    List data = null;    
    commentLabel = commentLabel==null ? "comment.label" : commentLabel;
    maxSizeLabel = maxSizeLabel==null ? "comment.size.label" : maxSizeLabel;
    String[] tableColumns = {"processKey", "folio", "taskName", "taskCreate", "taskStart", "taskDueDate", "processName", "processStart"};
    String[] tableHeaders = tableColumns;
    Map parentValuesMap = new HashMap();
    String parentValues = null;
    String tableDecorator = "";
    boolean isMultiple = true;
    boolean isMultipleDispatch = false;
    boolean isMultipleAssign = false;
    boolean addComment = (showComment != null && !"".equals(showComment)) ? Boolean.valueOf(showComment) : false;

    ((FilterDTO)pageContext.getAttribute(DynaContentService.PAGED_LIST_FILTER, PageContext.REQUEST_SCOPE )).addFilter("taskName", "=", taskName);        
    ((FilterDTO)pageContext.getAttribute(DynaContentService.PAGED_LIST_FILTER, PageContext.REQUEST_SCOPE )).addFilter("processName", "=", processName);

    String checkProperty = "idsAssign"; 
    dispatchToolTip = dispatchToolTip != null ? dispatchToolTip : "dispatch";
    gridSize = gridSize != null ? gridSize : "10";

    if(columns != null) {
        Map tableColumnsMap = new HashMap();
        for (int i = 0; i < tableColumns.length; i++) {
            tableColumnsMap.put(tableColumns[i], tableColumns[i]);
        }
        tableColumns = columns.split(",");

        final String defaultType = "stringvalue_";
        final Map supportedDataTypes = new HashMap();
        supportedDataTypes.put("STRING", "stringvalue_");
        supportedDataTypes.put("SHORT", "longvalue_");
        supportedDataTypes.put("INTEGER", "longvalue_");
        supportedDataTypes.put("LONG", "longvalue_");
        supportedDataTypes.put("FLOAT", "doublevalue_");
        supportedDataTypes.put("DOUBLE", "doublevalue_");
        supportedDataTypes.put("DATE", "datevalue_");

        StringBuffer buffer = new StringBuffer();
        final Properties businessColumns = (Properties)pageContext.getAttribute(TagUtils.BUSINESS_COLUMNS_TYPES, PageContext.REQUEST_SCOPE);
        if(businessColumns != null) {
            for(Iterator iterator = businessColumns.keySet().iterator(); iterator.hasNext();) {
                String businessColumn = (String) iterator.next();
                if(!tableColumnsMap.containsKey(businessColumn)) {
                    final String columnType = String.valueOf(businessColumns.get(businessColumn));
                    StringBuffer sb = new StringBuffer();
                    sb.append(businessColumn).append("_.");

                    //Si la columna NO es de alguno de los tipos permitidos se asigna el default 'string'
                    if(supportedDataTypes.containsKey(columnType.toUpperCase())) {
                        sb.append(String.valueOf(supportedDataTypes.get(columnType.toUpperCase())));
                    } else {
                        sb.append(defaultType);
                    }

                    businessColumns.put(businessColumn, sb.toString());
                    buffer.append(sb.toString()).append(",");
                }
            }
        }

        if (buffer.length() > 0)  {
            parentValues = buffer.deleteCharAt(buffer.lastIndexOf(",")).toString();
        }

        FilterDTO filterDTO = (FilterDTO)request.getAttribute(DynaContentService.PAGED_LIST_FILTER);
        if(filterDTO != null){
        List<Object[]> filters = filterDTO.get();
            if (filters != null && !filters.isEmpty()) {
                for (Object[] filter : filters) {
                    if (businessColumns.containsKey(String.valueOf(filter[0]))) {
                        filter[0]=businessColumns.get(filter[0]);
                    }
                }        	
            }                
        }

        tableHeaders = columns.split(",");
    }

    if(headers != null) {
        tableHeaders = headers.split(",");
    }

    url = (url != null && !"".equals(url.trim())) ? url : "/fsnjbpm/utilBpm/batchDispatchTasks.do";
    dateFormat = (dateFormat!=null && !"".equals(dateFormat)) ? dateFormat : "dd/MM/yyyy HH:mm";
    width = width != null ? width + "px" : "1000px";
    height = height != null ? height + "px" : "auto";
    maxLength = maxLength != null ? maxLength : "50";
    boolean isActionFirst = Boolean.valueOf(showActionFirst);
    Integer taskUniqueSearchID = TagUtils.getHtmlUniqueId(pageContext);

    boolean showImageLink = imageUrl != null ? true : false;
    String detailLink = null;
    if(showImageLink) {
        detailLink = TagUtils.formatUrl(imageUrl);
%>
        <c:url value="<%=detailLink%>" var="_hrefDetail" scope="page"/>        
<%
        detailLink = (String)pageContext.getAttribute("_hrefDetail", PageContext.PAGE_SCOPE);
    }

    Integer taskDispatchMultipleID = 0;
    pagedUrl = TagUtils.formatUrl(pagedUrl);

    List<String> dateKeys = new ArrayList<String>();
    dateKeys.add("taskCreate");
    dateKeys.add("taskStart");
    dateKeys.add("taskDueDate");
    dateKeys.add("processStart");
    
    SortCriteriaDTO sortCriteriaDTO = new SortCriteriaDTO("taskCreate", SortCriteriaDTO.Mode.DESC);
    pageContext.setAttribute(TagUtils.SORT_CRITERIA_FIELDS , sortCriteriaDTO, PageContext.REQUEST_SCOPE );
    boolean results = TagUtils.createPagedList(pageContext,"gob.shcp.bpm.service.TaskInstanceService","service","", parentValues);
    data = (List)pageContext.getRequest().getAttribute(pageContext.getAttribute("displaySource").toString());
    if (results && data != null && !data.isEmpty())  {        
        TaskListItemDTO firstTask = (TaskListItemDTO)data.get(0);
        String controller = TagUtils.formatUrl(firstTask.getTaskController());
        List transitions = ((TaskInstanceService)TagUtils.getService(pageContext, (Class)ClassUtils.forName("gob.shcp.bpm.service.TaskInstanceService"))).getTaskAvailableTransitions(firstTask.getIdTaskInstance());
        boolean isUppercased = Boolean.valueOf(uppercase);
        String commentCssClass = isUppercased ? "uppercase" : "";
        if(addComment && isUppercased) {
%>
            <input type="hidden" name="<%=ControllerWebBindingInitializer.UPPER_CASE_PREFIX%>taskComment" value="true"/>
<%
        }
%>
        <table align="center">
            <tr>
<%
            //Transition buttons
            for (final Iterator iter = transitions.iterator(); iter.hasNext();) {
                String transition = (String)iter.next();
                String action = url + "?transitionName="+transition+"&taskController="+pagedUrl;
%>
                <c:url value="<%=action%>" var="_action" scope="page"/>
<%
                action = (String)pageContext.getAttribute("_action", PageContext.PAGE_SCOPE);

                Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);
                String onclick = "return doSubmit("+ htmlElementUniqueID +");";
                String progressType = "bar";
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
                        <spring:message code="<%=alertsMap.get(transition)%>" text="<%=alertsMap.get(transition)%>" var="_alertCode" arguments="${value}" scope="page"/>
<%
                        alertTransitionMsg = (String)pageContext.getAttribute("_alertCode", PageContext.PAGE_SCOPE);
                    }
                }
                alertTransitionMsg = alertTransitionMsg != null ? alertTransitionMsg : "";
%>               
                <td align="center">
                    <input id="<%=htmlElementUniqueID%>" type="submit" value="<c:out value='${value}'/>" class="<%=cssClass%>" onclick="<%=onclick%>" progressType="<%=progressType%>" action="<%=action%>" path="" alertCode="<%=alertTransitionMsg%>"/>
                </td>
<%
            }
%>            
            </tr>
        </table>
<%            
        if (addComment)  {
%>
        <table align="center">
            <tr>
                <td valign="bottom" align="right"><spring:message code="<%=commentLabel%>" text="<%=commentLabel%>"/></td>
                <td rowspan="2"><textarea name="taskComment" cols="60" rows="5" onkeyup="validateTextAreaLength(this, 4000);" class="<%=commentCssClass%>"></textarea></td>
            </tr>
            <tr>
                <td valign="top" align="right"><spring:message code="<%=maxSizeLabel%>" text="<%=maxSizeLabel%>"/></td>                
            </tr>
        </table>
<%                
        }        
    }   
%>
    <!--  Urls de las acciones del tag -->
    <c:url value="<%=pagedUrl%>" var="_pagedUrl" scope="page"/>
<%
    pagedUrl = (String)pageContext.getAttribute("_pagedUrl", PageContext.PAGE_SCOPE);
%>

<!-- Componentes de captura para el encabezado -->
<c:set var="ACTIONS_BUTTONS">
    <td nowrap="nowrap">
        <input id="<%=taskUniqueSearchID%>" title="Buscar" type="image" alt="buscar" path="" action="<%=pagedUrl%>" src="<spring:theme code="help.gif"/>"  onclick="return doSubmit(<%=taskUniqueSearchID%>);"/>
        &nbsp;
        <input type="image" title="Limpiar" alt="limpiar" src="<spring:theme code="clear.gif"/>" onclick="clearTaskFields(); return false;"/>
    </td>
</c:set>

<c:set var="START_ROW_CONTENT">
  <tr>
<%
    if(isActionFirst) {
%>
        <c:out value="${ACTIONS_BUTTONS}" escapeXml="false"/>
<%
    }
    
    if(isMultiple) {
%>
    <td nowrap="nowrap">&nbsp;</td>
<%
    }
    
    for(String atrName: tableColumns) {
        String businessfield = (String)pageContext.getAttribute("BUSINESS_FIELD_" + atrName, PageContext.REQUEST_SCOPE);
%>
        <c:set var="bField" value="<%=businessfield%>"/>
<%
        if(atrName != null && !"".equals(atrName.trim()) && dateKeys.contains(atrName.trim())) {
%>
            <td nowrap="nowrap">
                <input type="text" maxlength="10" name="<%=atrName%>" id="<%=atrName%>" size="11"/>
                <span class="calendar">
                    <a href="javascript:void(0)" id="button<%=atrName%>">
                        <img src="<spring:theme code="background.gif"/>" alt="calendar" width="20" height="20"/>
                    </a>
                </span>
                a
                <input type="text" maxlength="10" name="<%=atrName%>End" id="<%=atrName%>End" size="11"/>
                <span class="calendar">
                    <a href="javascript:void(0)" id="button<%=atrName%>End">
                        <img src="<spring:theme code="background.gif"/>" alt="calendar" width="20" height="20"/>
                    </a>
                </span>
            </td>
            <script type="text/javascript">
                Calendar.setup({
                    inputField     :    "<%=atrName%>",
                    ifFormat       :    "%d/%m/%Y",
                    showsTime      :    false,
                    button         :    "button<%=atrName%>",
                    step           :    1
                });
                Calendar.setup({
                    inputField     :    "<%=atrName%>End",
                    ifFormat       :    "%d/%m/%Y",
                    showsTime      :    false,
                    button         :    "button<%=atrName%>End",
                    step           :    1
                });
            </script>
<%
        } else {
%>
            <c:choose>
                <c:when test="${bField != null && bField != ''}">
                    <c:out value="${bField}" escapeXml="false"/>
                </c:when>
                <c:otherwise>
                    <td nowrap="nowrap">
                        <input type="text" id="<%=atrName%>" name="<%=atrName%>"/>
                    </td>
                </c:otherwise>
            </c:choose>
<%
        }
    }
    if(isActionFirst == false) {
%>
        <c:out value="${ACTIONS_BUTTONS}" escapeXml="false"/>
<%
    }
%>
  </tr>
</c:set>

<c:set var="EMPTY_TASK_LIST">
    <!-- Creacion de tabla vacia solo con campos de captura cuando no se encuentran tareas -->
    <div id="taskListDiv" align="center" style="height:<%=height%>;width:<%=width%>;overflow:auto;">
        <table align="center" class="displaytag">
            <tr>
<%
                if(isActionFirst) {
%>
                   <th align="center"></th>
<%
                }
                if(isMultiple) {
%>
                   <th align="center"></th>
<%
                }
                String propertyHeader = null;
                for(int i=0; i<tableColumns.length; i++) {
                    propertyHeader = getTitle(pageContext, tableHeaders, tableColumns, i);
%>
                   <th><c:out value="<%=propertyHeader%>"/></th>
<%
                }
                if(isActionFirst == false) {
%>
                   <th align="center"></th>
<%
                }
%>
            </tr>
            <c:out value="${START_ROW_CONTENT}" escapeXml="false"/>
        </table>
    </div>
</c:set>

<!-- Llamado al servicio para la creacion de la lista de tareas -->
<c:set var="applyFilters" value="true"/>
<c:set var="applyEqualFilter" value="true"/>
<c:set var="parentValues" value="<%=parentValues%>"/>
<c:choose>
    <c:when test="<%=results%>">
<%
        //data = (List)pageContext.getRequest().getAttribute(pageContext.getAttribute("displaySource").toString());
        if(data != null && !data.isEmpty()) {
            TaskListItemDTO currentRow = null;
            String format = null;
            String propertyHeader = null;
            String propertyName = null;
            String processLink = null;
%>
          <!-- Creacion de la lista de tareas asignadas -->
          <div id="taskListDiv" align="center" style="height:<%=height%>px;width:<%=width%>px;overflow:auto;">
            <display:table name="${displaySource}" class="displaytag" pagesize="<%=gridSize%>" id="row" requestURI="<%=pagedUrl%>" sort="list" decorator="gob.shcp.fsn.control.view.decorator.PagedListTableDecorator">
<%
                for(int i=0; i<tableColumns.length; i++) {
                    propertyName = tableColumns[i];
                    if(propertyName!=null && !"".equals(propertyName.trim())) {
                        currentRow = (TaskListItemDTO)pageContext.getAttribute("row");

                        if(i==0 && isActionFirst) {
%>
                            <display:column>
<%
                                processLink = TagUtils.formatUrl(currentRow.getActionUrl());
%>
                                <c:url value="<%=processLink%>" var="_hrefProcess" scope="page"/>
<%
                                processLink = (String)pageContext.getAttribute("_hrefProcess", PageContext.PAGE_SCOPE);
                                processLink = TagUtils.appendUrlParam(processLink, "idTaskInstance", currentRow.getIdTaskInstance()+"");
                                processLink = TagUtils.appendUrlParam(processLink, "idProcessInstance", currentRow.getIdProcessInstance()+"");
                                processLink = TagUtils.appendUrlParam(processLink, "taskController", currentRow.getTaskController());
%>
                                <a href="<%=processLink%>"><img  title="Ver Detalle" alt="procesar" src="<spring:theme code="auth.gif"/>" height="20" width="20" /></a>
                            </display:column>
<%
                        }

                        propertyHeader = getTitle(pageContext, tableHeaders, tableColumns, i);
                        format = "";
                        if(dateKeys.contains(propertyName.trim())) {
                            format = "{0,date," + dateFormat + "}";
                        }
                        if(i==0) {
                            if(isMultiple) {
                                String idValue = String.valueOf(currentRow.getIdTaskInstance());
%>
                                <display:column>
                                    <input type="checkbox" name="<%=checkProperty%>" value="<%=idValue%>"/>
                                </display:column>
<%
                            }
                            if(showImageLink) {
%>
                            <display:column sortable="true" title="<%=propertyHeader%>" property="<%=propertyName%>" format="<%=format%>" href="<%=detailLink%>" paramId="idProcessInstance" paramProperty="idProcessInstance" maxLength="<%=maxLength%>"/>
<%
                            } else {
%>
                            <display:column sortable="true" title="<%=propertyHeader%>" property="<%=propertyName%>" format="<%=format%>" paramId="idProcessInstance" paramProperty="idProcessInstance" maxLength="<%=maxLength%>"/>
<%
                            }
                        } else {
%>
                            <display:column sortable="true" title="<%=propertyHeader%>" property="<%=propertyName%>" format="<%=format%>" maxLength="<%=maxLength%>"/>
<%
                        }
                    }
                }
                if(isActionFirst == false) {
%>
                    <display:column title="">
<%
                                processLink = TagUtils.formatUrl(currentRow.getActionUrl());
%>
                                <c:url value="<%=processLink%>" var="_hrefProcess" scope="page"/>
<%
                                processLink = (String)pageContext.getAttribute("_hrefProcess", PageContext.PAGE_SCOPE);
                                processLink = TagUtils.appendUrlParam(processLink, "idTaskInstance", currentRow.getIdTaskInstance()+"");
                                processLink = TagUtils.appendUrlParam(processLink, "idProcessInstance", currentRow.getIdProcessInstance()+"");
                                processLink = TagUtils.appendUrlParam(processLink, "taskController", currentRow.getTaskController());
%>
                                <a href="<%=processLink%>"><img title="Ver Detalle" alt="procesar" src="<spring:theme code="auth.gif"/>" height="20" width="20" /></a>
                            </display:column>
<%
                }
%>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="basic.msg.empty_list">
                    <br><span class="pagebanner">&nbsp;</span><span class="norecords"><spring:message text="Lista Vacia"/><br><br></span>
                </display:setProperty>
            </display:table>
          </div>
<%
        } else {
%>
            <c:out value="${EMPTY_TASK_LIST}" escapeXml="false"/>
<%
        }
%>
    </c:when>
    <c:otherwise>
        <table width="100%">
            <tr align="center">
              <td>
                <table class="message">
                  <tr>
                    <td class="error"><img src="<spring:theme code="error.gif"/>" alt="error" width="30" height="30"></td>
                    <td>
                     <table border="0" cellpadding="0" cellspacing="0">
                      <c:forEach items="${errors}" var="errorItem">
                        <tr><td>
                        <c:out value="${errorItem}"/></br>
                        </td></tr>
                      </c:forEach>
                     </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>

          <c:out value="${EMPTY_TASK_LIST}" escapeXml="false"/>
    </c:otherwise>
</c:choose>

<script type="text/javascript">
    function clearTaskFields() {
        var elements = document.getElementsByTagName("input");
        var i;
        var element;
        for(i=0;i<elements.length;i++) {
            element = elements[i];
            if(element.type=="text") {
                element.value="";
            }
        }
    }
</script>

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
%>

<%
} catch(Exception e) {
    e.printStackTrace();
}
%>