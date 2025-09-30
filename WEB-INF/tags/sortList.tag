<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.Iterator" %>
<%@ tag import="gob.shcp.fsn.model.support.FilterDTO" %>
<%@ tag import="gob.shcp.fsn.model.support.SelectListDTO" %>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ attribute name="beanName"%>
<%@ attribute name="items" type="java.util.List"%>
<%@ attribute name="path"%>
<%@ attribute name="patternValue"%>
<%@ attribute name="appendFilters"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
    <meta charset="utf-8">
<!-- JQUERY -->
    <script type="text/javascript" src="<spring:theme code="jquery.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.ui.js"/>"></script>
    <style type="text/css">
    #sortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
    #sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; text-align: left; }
    #sortable li span { position: absolute; margin-left: -1.3em; }
    </style>
    <script type="text/javascript">
     var $j = jQuery.noConflict();
    $j(function() {
        $j( "#sortable" ).sortable({
                    placeholder: "ui-state-highlight"
            });
        $j( "#sortable" ).disableSelection();
    });
    $j(document).ready(function(){
            $j('#sortable').sortable({
                update: function(event, ui) {
                   orderGroups();
                }
            });           
    });
    function orderGroups(){
        var values = $j('#sortable li').map(function() {return this.value});
        for (var i=0; i < values.length; i++) {
            document.forms[0].gruposApp[i].value = values[i];
        }    
    }
</script>
</head>
<body>
<%
try{
    if((beanName == null || "".equals(beanName)) && (items == null)) {
        return;
    }
    
    boolean dynaQuery = true;
    if(appendFilters != null && !"".equals(appendFilters)) {
        dynaQuery = Boolean.valueOf(appendFilters);
    }
    
    if(patternValue!=null) {
%>
        <spring:message code="<%=patternValue%>" var="pattern"/>
<%
    }
    String pattern = (String)pageContext.getAttribute("pattern");
    pattern = pattern == null ? "" : pattern;

    final FilterDTO filters = (FilterDTO)pageContext.getAttribute(DynaContentService.PAGED_LIST_FILTER, PageContext.REQUEST_SCOPE);
    List data = new ArrayList();
    if(beanName != null && !"".equals(beanName)) {
        if(dynaQuery) {
            data = TagUtils.getService(pageContext, DynaContentService.class).getListElements(beanName, TagUtils.getConditions(filters), null, null, pattern);
        } else {
            data = TagUtils.getService(pageContext, DynaContentService.class).getListElements(beanName, TagUtils.getConditions(filters), null, pattern);
        }    
    }
    if(items != null) {
        data = items;
    }
    if(path != null) {    
%>
        <div class="demo" align="center">
            <ul id="sortable">
<%
        for(final Iterator iter = data.iterator(); iter.hasNext();) {
                SelectListDTO selectList = (SelectListDTO)iter.next();
%>
                <input type="hidden" name="<%=path%>" id="<%=path%>" value="<%=selectList.getKey()%>"/>
                <li class="ui-state-default" value="<%=selectList.getKey()%>"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span><%=selectList.getValue()%></li>
<%
        }
    }
%>
        </ul>
    </div>
<%
} catch(Exception e) {
    e.printStackTrace();
}
%>
</body>