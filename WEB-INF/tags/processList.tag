<%@ tag import="java.util.List"%>
<%@ tag import="java.util.ArrayList"%>
<%@ tag import="java.util.Map"%>
<%@ tag import="java.util.HashMap"%>
<%@ tag import="gob.shcp.fsn.model.support.DynaDTO" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils"%>
<%@ tag import="org.springframework.web.servlet.support.RequestContext"%>
<%@ tag import="gob.shcp.fsn.control.binder.ControllerWebBindingInitializer"%>

<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>

<%@ attribute name="pagedUrl" required="true"%>
<%@ attribute name="detailUrl" required="true"%>
<%@ attribute name="headers"%>
<%@ attribute name="columns"%>
<%@ attribute name="dateFormat"%>
<%@ attribute name="height"%>
<%@ attribute name="width"%>
<%@ attribute name="showErrors"%>
<%@ attribute name="useModel"%>
<%@ attribute name="service"%>
<%@ attribute name="maxLength"%>

<%
try{     
    /*  
    *  Posibles valores para las propiedades a mostrar:
    *        "processKey", "processName", "processStart", "processEnd"   
    */
    String[] tableColumns = {"processKey", "folio", "processName", "processStart", "processEnd"};
    String[] tableHeaders = tableColumns;
    
    if(columns != null){
        tableColumns = columns.split(",");
        tableHeaders = columns.split(",");
    }
    
    if(headers != null){
        tableHeaders = headers.split(",");
    }
    
    String processService = null;
    if (service != null && !"".equals(service)) {
        processService = service;
    } else{
        processService = "gob.shcp.bpm.service.ProcessInstanceService";
        if(Boolean.valueOf(showErrors)){
            processService = "gob.shcp.bpm.service.SuspendedErrorProcessInstanceService";
        }
    }
    
    dateFormat = (dateFormat!=null && !"".equals(dateFormat)) ? dateFormat : "dd/MM/yyyy HH:mm";
    width = width != null ? width : "1000";
    height = height != null ? height : "500";
    maxLength = maxLength != null ? maxLength : "50";
    
    Integer taskUniqueSearchID = TagUtils.getHtmlUniqueId(pageContext);
    detailUrl = TagUtils.formatUrl(detailUrl);
    pagedUrl = TagUtils.formatUrl(pagedUrl);
    
    String maxlenght = "10";
    String maxsize = "11";
    
    List<String> dateKeys = new ArrayList<String>();    
    dateKeys.add("processEnd");
    dateKeys.add("processStart");
%>    
    <!--  Urls de las acciones del tag -->
    <c:url value="<%=pagedUrl%>" var="_pagedUrl" scope="page"/>
    <c:url value="<%=detailUrl%>" var="_hrefDetail" scope="page"/>
    <c:set value="<%=processService%>" var="processService" scope="page"/>
<%
    pagedUrl = (String)pageContext.getAttribute("_pagedUrl", PageContext.PAGE_SCOPE);
    detailUrl = (String)pageContext.getAttribute("_hrefDetail", PageContext.PAGE_SCOPE);
%>

<!-- Componentes de captura para el encabezado -->
<c:set var="START_ROW_CONTENT">
  <tr>
<%
    for(String atrName: tableColumns) {
        if(atrName != null && !"".equals(atrName.trim()) && dateKeys.contains(atrName.trim())) { %>
            <td nowrap="nowrap">
                <%
                if (Boolean.valueOf(useModel))  {
                %>
                    <html:input maxlength="<%=maxlenght%>" path="<%=atrName%>" size="<%=maxsize%>"/>                        
                <%
                } else {
                %>
                    <input type="text" maxlength="<%=maxlenght%>" name="<%=atrName%>" id="<%=atrName%>" size="<%=maxsize%>"/>                        
                <%    
                }
                %>
                <span class="calendar">
                    <a href="javascript:void(0)" id="button<%=atrName%>" >
                        <img src="<spring:theme code="background.gif"/>" alt="calendar" width="20" height="20"/>
                    </a>
                </span>
                a         
                <%
                if (Boolean.valueOf(useModel))  {
                    String fieldName = atrName + "End";
                %>
                    <html:input maxlength="<%=maxlenght%>" path="<%=fieldName%>" size="<%=maxsize%>"/>                        
                <%
                } else {
                %>
                    <input type="text" maxlength="<%=maxlenght%>" name="<%=atrName%>End" id="<%=atrName%>End" size="<%=maxsize%>"/>                        
                <%    
                }
                %>
                <span class="calendar">
                    <a href="javascript:void(0)" id="button<%=atrName%>End" >
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
            <td nowrap="nowrap">
                <%
                if (Boolean.valueOf(useModel))  {
                %>
                    <html:input path="<%=atrName%>"/>    
                <%
                }else {
                %>
                    <input type="text" id="<%=atrName%>" name="<%=atrName%>"/>
                <%
                }
                %>
            </td>    
<%
        }
    }
%>
    <td nowrap="nowrap">
        <input id="<%=taskUniqueSearchID%>" type="image" alt="buscar" path="" action="<%=pagedUrl%>" src="<spring:theme code="help.gif"/>"  onclick="return doSubmit(<%=taskUniqueSearchID%>);"/>
        &nbsp;
        <input type="image" alt="limpiar" src="<spring:theme code="clear.gif"/>" onclick="clearTaskFields(); return false;"/>
    </td>
  </tr>
</c:set>

<c:set var="EMPTY_TASK_LIST">
<!-- Creacion de tabla vacia solo con campos de captura cuando no se encuentran tareas -->
    <div id="taskListDiv" align="center" style="height:<%=height%>px;width:<%=width%>px;overflow:auto;">
        <table align="center" class="displaytag">
            <tr>
<% 
                String propertyHeader = null;
                for(int i=0; i<tableColumns.length; i++) {
                    propertyHeader = getTitle(pageContext, tableHeaders, tableColumns, i);                    
%>
                   <th><c:out value="<%=propertyHeader%>"/></th>
<%
                }                
%>                                
                <th align="center"></th>        
            </tr>
            <c:out value="${START_ROW_CONTENT}" escapeXml="false"/>
        </table>    
    </div>
</c:set>

<!-- Llamado al servicio para la creacion de la lista de tareas -->
<c:set var="applyFilters" value="true"/>
<c:set var="applyEqualFilter" value="true"/>
<c:choose>
    <c:when test="${tagutils:createPagedList(pageContext,processService,'service','','')}">
<%
        List data = (List)pageContext.getRequest().getAttribute(pageContext.getAttribute("displaySource").toString());    
        if(!data.isEmpty()) {            
            String format = null;
            String propertyHeader = null;
            String propertyName = null;
            String processLink = null;
%>    
          <!-- Creacion de la lista de tareas asignadas -->
          <div id="taskListDiv" align="center" style="height:<%=height%>px;width:<%=width%>px;overflow:auto;">
            <display:table name="${displaySource}" class="displaytag" pagesize="10" id="row" requestURI="<%=pagedUrl%>" sort="list" decorator="gob.shcp.fsn.control.view.decorator.PagedListTableDecorator">
<%        
                for(int i=0; i<tableColumns.length; i++) {
                    propertyName = tableColumns[i];
                    if(propertyName!=null && !"".equals(propertyName.trim())) {                        
                        propertyHeader = getTitle(pageContext, tableHeaders, tableColumns, i);
                        format = "";
                        if(dateKeys.contains(propertyName.trim())) {
                            format = "{0,date," + dateFormat + "}";
                        }
                        if(i==0) {
%>
                            <display:column sortable="true" title="<%=propertyHeader%>" property="<%=propertyName%>" format="<%=format%>"  href="<%=detailUrl%>" paramId="idProcessInstance" paramProperty="idProcessInstance" maxLength="<%=Integer.valueOf(maxLength)%>"/>
<%
                        } else {
%>
                            <display:column sortable="true" title="<%=propertyHeader%>" property="<%=propertyName%>" format="<%=format%>" maxLength="<%=Integer.valueOf(maxLength)%>"/>
<%
                        }
                    }
                }        
%>
                <display:column/>
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
    function clearTaskFields(){
        var elements = document.getElementsByTagName("input");
        var i;
        var element;
        for(i=0;i<elements.length;i++){
            element = elements[i];
            if(element.type=="text"){
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