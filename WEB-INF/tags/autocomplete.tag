<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.Iterator" %>
<%@ tag import="gob.shcp.fsn.model.support.FilterDTO"%>
<%@ tag import="gob.shcp.fsn.model.support.SelectListDTO" %>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="beanName" required="true" %>
<%@ attribute name="name"%>
<%@ attribute name="path"%>
<%@ attribute name="parentPath" %>
<%@ attribute name="valuePath" %>
<%@ attribute name="size" %>
<%@ attribute name="minChars" %>
<%@ attribute name="uppercase" %>
<%@ attribute name="appendFilters" %>
<%@ attribute name="filterId" %>

<%
    try{
        boolean dynaQuery = true;
        if (filterId==null || "".equals(filterId) ){
            filterId = DynaContentService.PAGED_LIST_FILTER;
        }
        if(appendFilters != null && !"".equals(appendFilters)) {
            dynaQuery = Boolean.valueOf(appendFilters);
        }
    
        boolean upperCased = true;
        if(uppercase != null && !"".equals(uppercase)) {
            upperCased = Boolean.valueOf(uppercase);
        }
        String cssClass = upperCased ? "uppercase" : "";
        size = size==null ? "" : size;
        minChars = minChars==null ? "2" : minChars;
    
        String source = valuePath==null ? "" : valuePath;
        if("".equals(source) && path!=null && !"".equals(path)) {
            source = path+"_";
        }
        if("".equals(source) && name!=null && !"".equals(name)) {
            source = name+"_";
        }
        if("".equals(source)) {
            return;
        }
%>    
        <input id="<%=source%>" name="<%=source%>" type="text" size="<%=size%>" class="<%=cssClass%>" />
<%
        if(path!=null) {
%>        
            <html:hidden path="<%=path%>"/>
            <spring:bind path="${path}">
                <c:set var="requestValue" value="${status.value}"/>
            </spring:bind>    
<%
        } else if(name!=null) {
%>
            <input id="<%=name%>" name="<%=name%>" type="hidden"/>
<%    
            path = name;
        } else {
            return;
        }
        FilterDTO filters = (FilterDTO) pageContext.getAttribute(filterId, PageContext.REQUEST_SCOPE);    
        StringBuffer filterStr = new StringBuffer() ;
        Object[] params = new Object[]{};
        if(filters!=null && filters.get()!=null) {
            for(final Iterator iter = filters.get().iterator(); iter.hasNext();) {
                params = (Object[]) iter.next();            
                filterStr.append("filter_value_").append(params[0]).append("=").append(params[2]).append(", ");
                filterStr.append("filter_condition_").append(params[0]).append("=").append(params[1]).append(", ");
            }    
        }
        String indicator = "indicator"+path;
        String parameters = new String();
        if(parentPath!=null) {
            parameters = "padre={"+parentPath+"},";
        }
        if(upperCased) {
            parameters += "uppercase=true,";
        }
        if(dynaQuery) {
            parameters += "dynaQuery=true,";
        }
        
        parameters += "sourceName="+source+", beanName="+beanName+", "+filterStr.toString();
%>    
        <c:url var="contextPath" value="/"/>
        <span id="indicator<%=path%>" style="filter:alpha(opacity=100);display:none;"><img alt="indicator" src="<spring:theme code="indicator.gif"/>" /></span>
        <ajax:autocomplete
          source="<%=source%>"
          target="<%=path%>"
          baseUrl="${contextPath}util/getAutoCompleteElements.do"
          parameters="<%=parameters%>"
          className="autocomplete"
          indicator="<%=indicator%>"
          minimumCharacters="<%=minChars%>"
        />
<%    
        Object obj = pageContext.getAttribute("requestValue");
        if(obj!=null && !obj.equals("")) {
            String key = obj.toString();
            if (filters==null){
                filters = new FilterDTO();
            }
            filters.addFilter(path, "=", key);
            String parent = null;
            if(parentPath!=null) {
%>
                <spring:bind path="${parentPath}">
                    <c:set var="parentValue" value="${status.value}"/>
                </spring:bind>    
<%
                Object parentObj =pageContext.getAttribute("parentValue");
                if(parentObj!=null) {
                    parent = parentObj.toString();
                }
            }
            
            String valor = null;
            if(dynaQuery) {
                valor = TagUtils.getService(pageContext, DynaContentService.class).getAutoCompleteValue(beanName, TagUtils.getConditions(filters), null, parent);
            } else {
                valor = TagUtils.getService(pageContext, DynaContentService.class).getAutoCompleteValue(beanName, TagUtils.getConditions(filters), parent);
            }
            if(valor==null || valor.equals("")) {
                key = "";
            }
%>
            <script type="text/javascript">
                document.forms[0].<%=source%>.value = "<%=valor%>";
                document.forms[0].<%=path%>.value = "<%=key%>";
            </script>
<%
        }
    }catch(Exception e){
        e.printStackTrace();
    }finally{
        pageContext.removeAttribute(filterId, PageContext.REQUEST_SCOPE);
    }
%>