<%@ tag import="java.util.List" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.Iterator" %>
<%@ tag import="java.util.Collection" %>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>
<%@ tag import="gob.shcp.fsn.model.support.FilterDTO"%>
<%@ tag import="gob.shcp.fsn.model.support.SelectListDTO" %>
<%@ tag import="gob.shcp.fsn.control.binder.ControllerWebBindingInitializer" %> 
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ attribute name="beanName"%>
<%@ attribute name="items" type="java.util.List"%>
<%@ attribute name="path"%>
<%@ attribute name="parentPath" %>
<%@ attribute name="filterPaths" %>
<%@ attribute name="progress" %>
<%@ attribute name="name"%>
<%@ attribute name="size"%>
<%@ attribute name="uppercase" %>
<%@ attribute name="appendFilters" %>
<%@ attribute name="titleOrgn" %>
<%@ attribute name="titleDest" %>
<%@ attribute name="disabled" %>
<%@ attribute name="width" %>
<%@ attribute name="filterId" %>

<%
    try{
        if((beanName == null || "".equals(beanName)) && (items == null)){
            return;
        }
        
        boolean isReadonly = Boolean.valueOf(disabled);
        
        boolean dynaQuery = true;
        
        if (filterId==null || "".equals(filterId) ){
            filterId = DynaContentService.PAGED_LIST_FILTER;
        }
        if(appendFilters != null && !"".equals(appendFilters)) {
            dynaQuery = Boolean.valueOf(appendFilters);
        }
        
        String[] additionalPaths = null;
        if(filterPaths != null && !"".equals(filterPaths)) {
            filterPaths = filterPaths.trim();
            additionalPaths = filterPaths.split(",");
        }
        
        boolean upperCased = true;
        if(uppercase != null && !"".equals(uppercase)) {
            upperCased = Boolean.valueOf(uppercase);
        }
        String cssClass = upperCased ? "uppercase" : "";
    
        if (path==null && name==null){
            return;
        }
        if (path==null || path.equals("")){
            path=name;    
        }else{
%>
            <spring:bind path="${path}">
                <c:set var="requestValue" value="${status.actualValue}"/>
            </spring:bind>   
<%
        }
        final String sourceName = path + "_source";
        final String targetName = path + "_target";
    
        List data = new ArrayList();
        final FilterDTO filters = (FilterDTO)pageContext.getAttribute(filterId, PageContext.REQUEST_SCOPE);
        if((parentPath==null || "".equals(parentPath)) && (beanName != null && !"".equals(beanName))) {
            if(dynaQuery){
                data = TagUtils.getService(pageContext, DynaContentService.class).getListElements(beanName, TagUtils.getConditions(filters), null, null, null);
            }else{
                data = TagUtils.getService(pageContext, DynaContentService.class).getListElements(beanName, TagUtils.getConditions(filters), null, null);
            }
        }
        if(items != null){
            data = items;            
        }
        StringBuffer options = new StringBuffer();
%>      
    <div id="divDoubleSelect" onmouseout="if (isMouseOut(event, this)) selectAllOptions('<%=targetName%>');">
    <table id="tableDoubleSelect" >
        <tr valign="middle">
            <td>                
                <spring:message code="${titleOrgn}" text="${titleOrgn}"/>
            </td>
            <td align="center" >
<%
                if(progress!=null && progress.equals("true")) {
%>
                    <span id="progressMsg<%=sourceName%>" style="filter:alpha(opacity=100);display:none;"><img alt="indicator" src="<spring:theme code="indicator.gif"/>" /></span>
<%
                }
%>
            </td>
            <td>                
                <spring:message code="${titleDest}" text="${titleDest}"/>
            </td>
        </tr>
        <tr valign="middle">
            <td >
<%
                if(upperCased) {
%>
                    <input  type="hidden" name="<%=ControllerWebBindingInitializer.UPPER_CASE_PREFIX%><%=path%>" value="true"  />
<%
                }
                
                if(isReadonly) {
%>
                <c:choose>
                    <c:when test="${width != null}">
                        <select name="<%=sourceName%>" id="<%=sourceName%>" cssClass="<%=cssClass%>" multiple="true" size="<%=size%>" style="width: <%=width%>px">
                    </c:when>                        
                    <c:otherwise>
                        <select name="<%=sourceName%>" id="<%=sourceName%>" cssClass="<%=cssClass%>" multiple="true" size="<%=size%>">
                    </c:otherwise>
                </c:choose>
<%
                }else{
%>                
                <c:choose>
                    <c:when test="${width != null}">
                        <select name="<%=sourceName%>" id="<%=sourceName%>" cssClass="<%=cssClass%>" multiple="true" size="<%=size%>" ondblclick="moveOptions<%=sourceName%>('<%=sourceName%>','<%=targetName%>');" style="width: <%=width%>px">
                    </c:when>                        
                    <c:otherwise>
                        <select name="<%=sourceName%>" id="<%=sourceName%>" cssClass="<%=cssClass%>" multiple="true" size="<%=size%>" ondblclick="moveOptions<%=sourceName%>('<%=sourceName%>','<%=targetName%>');">
                    </c:otherwise>
                </c:choose>
<%
                }
                    for (final Iterator iter = data.iterator(); iter.hasNext();){
                        SelectListDTO selectList = (SelectListDTO)iter.next();
                        Object values =  pageContext.getAttribute("requestValue");
                        String selected = "";
                        if (values instanceof Collection){
                            for(final Iterator itValues = ((Collection) values).iterator(); itValues.hasNext();){
                                if (selectList.getKey().equals(itValues.next())){
                                    selected="selected=\"selected\"";
                                }
                                options.append(selectList.getKey()).append("::").append(selectList.getValue()).append(";");
                            }
                        }
%>
                        <option value="<%=selectList.getKey()%>" <%=selected%> ><%=selectList.getValue()%></option>
<%
                    }
%>
                </select>        
            </td>
            <td class="buttons">
                <table id="tbBotones" width="100%" >
<%
                if(isReadonly) {
%>
                    <tr>
                        <td align="center" >
                            <img alt="Agregar Todos" src="<spring:theme code="last.gif"/>" width="20" height="20"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" >
                            <img alt="Agregar" src="<spring:theme code="next.gif"/>" width="20" height="20" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" >
                            <img alt="Eliminar" src="<spring:theme code="prev.gif"/>" width="20" height="20"/>
                        </td>
                    </tr>
                    <tr >
                        <td align="center" >
                            <img alt="Eliminar Todos" src="<spring:theme code="first.gif"/>" width="20" height="20"/>
                        </td>
                    </tr>
<%
                }else{
%>                
                    <tr>
                        <td align="center" >
                            <a href="javascript:moveAllOptions<%=sourceName%>('<%=sourceName%>','<%=targetName%>');">
                                <img alt="Agregar Todos" src="<spring:theme code="last.gif"/>" width="20" height="20"/>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" >
                            <a href="javascript:moveOptions<%=sourceName%>('<%=sourceName%>','<%=targetName%>');">
                                <img alt="Agregar" src="<spring:theme code="next.gif"/>" width="20" height="20" />
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" >
                            <a href="javascript:moveOptions<%=sourceName%>('<%=targetName%>','<%=sourceName%>');">
                                <img alt="Eliminar" src="<spring:theme code="prev.gif"/>" width="20" height="20"/>
                            </a>
                        </td>
                    </tr>
                    <tr >
                        <td align="center" >
                            <a href="javascript:moveAllOptions<%=sourceName%>('<%=targetName%>','<%=sourceName%>');">
                                <img alt="Eliminar Todos" src="<spring:theme code="first.gif"/>" width="20" height="20"/>
                            </a>
                        </td>
                    </tr>
<%
                }
%>     
                </table>
            </td>
            <td>
<%
                if(upperCased) {
%>
                    <input type="hidden" name="<%=ControllerWebBindingInitializer.UPPER_CASE_PREFIX%><%=path%>" value="true"/>
<%
                }
                
                if(isReadonly){
%>
                <c:choose>
                    <c:when test="${width != null}">
                        <select name="<%=path%>" id="<%=targetName%>" cssClass="<%=cssClass%>" multiple="true" size="<%=size%>" style="width: <%=width%>px">
                    </c:when>                        
                    <c:otherwise>
                        <select name="<%=path%>" id="<%=targetName%>" cssClass="<%=cssClass%>" multiple="true" size="<%=size%>">
                    </c:otherwise>
                </c:choose>
<%
                }else{
%>
                <c:choose>
                    <c:when test="${width != null}">
                        <select name="<%=path%>" id="<%=targetName%>" cssClass="<%=cssClass%>" multiple="true" size="<%=size%>" ondblclick="moveOptions<%=sourceName%>('<%=targetName%>','<%=sourceName%>');" style="width: <%=width%>px">
                    </c:when>                        
                    <c:otherwise>
                        <select name="<%=path%>" id="<%=targetName%>" cssClass="<%=cssClass%>" multiple="true" size="<%=size%>" ondblclick="moveOptions<%=sourceName%>('<%=targetName%>','<%=sourceName%>');" >
                    </c:otherwise>
                </c:choose>
<%
                }
%>
                </select>
                <input id="_<%=path%>" type="hidden" name="_<%=path%>" value="1"/>
            </td>
        </tr>
    </table>
</div>
<script language="javascript" type="text/javascript">
    var orderOptions<%=sourceName%> = new Array();
    var orderOptionsIds<%=sourceName%> = new Array();
    setOptionsOrder<%=sourceName%>('<%=sourceName%>');
    initDoubleSelect('<%=sourceName%>','<%=targetName%>',orderOptionsIds<%=sourceName%>);        
    
    
    //Guarda el orden original de las opciones del selectSource dentro de la variable orderOptions[].
    function setOptionsOrder<%=sourceName%>(_selectId){
        var _selSource = document.getElementById(_selectId);
        var options = _selSource.options;        
        for (i=0;i<options.length;i++){
            orderOptions<%=sourceName%>[i] = new Array();            
            orderOptions<%=sourceName%>[i][0] = options[i].text;
            orderOptions<%=sourceName%>[i][1] = options[i].value;
            orderOptionsIds<%=sourceName%>[i] = options[i].value;
        }        
    }
    
    function moveOptions<%=sourceName%>(source, target){
        moveOptions(source, target, orderOptionsIds<%=sourceName%>);        
    }
    
    function moveAllOptions<%=sourceName%>(source, target){
        moveAllOptions(source, target, orderOptions<%=sourceName%>);        
    }

</script>

<%
    if((parentPath!=null && !parentPath.equals("")) && (beanName != null && !"".equals(beanName))) {
        StringBuffer filterStr = new StringBuffer();     
        Object params[] = new Object[]{};
        if(filters!=null && filters.get() != null) {
            for(final Iterator iter = filters.get().iterator(); iter.hasNext();) {
                params = (Object[]) iter.next();            
                filterStr.append("filter_value_").append(params[0]).append("=").append(params[2]).append(", ");
                filterStr.append("filter_condition_").append(params[0]).append("=").append(params[1]).append(", ");                
            }
        }
        String addPathParams = "";
        if(additionalPaths != null) {            
            for(String addPath : additionalPaths) {
                addPathParams += "padre={" + addPath.trim() + "}, ";
            }
        }
        String parameters   = "padre={"+parentPath+"}, " + addPathParams + "beanName="+beanName+", "+filterStr.toString()+", options="+options.toString()+", dynaQuery="+dynaQuery ;
        String preFunction  = "initProgress"+sourceName;
        String postFunction = "resetProgress"+sourceName;
        String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/util/getListElements.do";

        Object values = pageContext.getAttribute("requestValue");
        StringBuffer arrValue = new StringBuffer(",");
        if(values instanceof Collection) {
            arrValue.append(",");
            for(final Iterator itValues = ((Collection) values).iterator(); itValues.hasNext();) {
                arrValue.append( itValues.next() ).append(",");            
            }
        } else if(values instanceof Object[]) {
            Object[] arrayValue = (Object[])values;
            for(int idxValue =0; idxValue < arrayValue.length; idxValue++) {
                arrValue.append( arrayValue[idxValue] ).append(",");
            }
        } else {
            arrValue.append(values).append(",");
        }
        
        String stringArrValue = arrValue.toString();
%>  
        <script type="text/javascript">
            function initProgress<%=sourceName%>() {
                document.getElementById('<%=sourceName%>').options.length = 0;
                document.getElementById('<%=targetName%>').options.length = 0;
                Element.show('progressMsg<%=sourceName%>');
            }
            
            function resetProgress<%=sourceName%>() {                
                setTimeout("delayResetProgress<%=sourceName%>()", 500);                                
            }
    
            function delayResetProgress<%=sourceName%>() {
                if(document.getElementById('<%=sourceName%>').options.length > 0){
                    setOptionsOrder<%=sourceName%>('<%=sourceName%>');
                    updateOptions('<%=sourceName%>','<%=targetName%>','<%=stringArrValue%>', orderOptionsIds<%=sourceName%>);
                    selectAllOptions('<%=targetName%>')
                }
                Effect.Fade('progressMsg<%=sourceName%>');
            }
        </script> 
    
        <ajax:select
          baseUrl="<%=baseUrl%>"
          source="<%=parentPath%>"
          target="<%=sourceName%>"
          parameters="<%=parameters%>"
          preFunction="<%=preFunction%>"
          postFunction="<%=postFunction%>"
          executeOnLoad="true" /> 
<%
        if(additionalPaths != null && additionalPaths.length > 0){
%>
            <c:forEach items="<%=additionalPaths%>" var="adittionalSource">                        
                <ajax:select
                  baseUrl="<%=baseUrl%>"
                  source="${adittionalSource}"
                  target="<%=sourceName%>"
                  parameters="<%=parameters%>"
                  preFunction="<%=preFunction%>"
                  postFunction="<%=postFunction%>"
                  />
            </c:forEach>
<%          
        }

    }
    
    }catch(Exception e){
        e.printStackTrace();
    }
%>