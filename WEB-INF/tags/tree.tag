<%@ tag import="gob.shcp.fsn.control.view.tree.TreeRepository" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="gob.shcp.fsn.model.support.FilterDTO"%>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>
<%@ tag import="java.util.HashSet" %>
<%@ tag import="java.util.Set" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ taglib uri="http://struts-menu.sf.net/tag-el" prefix="menu"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="name" required="true"%>
<%@ attribute name="parentValues"%>
<%@ attribute name="pattern"%>
<%@ attribute name="titleArgs"%>
<%@ attribute name="width"%>
<%@ attribute name="height"%>
<%@ attribute name="frame"%>
<%@ attribute name="frameWidth"%>
<%@ attribute name="frameParams"%>
<%@ attribute name="appendFilters" %> <%--Indica si los filtros sobre la consulta se agregan dinamicamente si el valor es "true" o se especifican en la consulta en notacion de filtros delimitados (##t.campo##) --%>
<%@ attribute name="filterId" %>

<%
try {
    width = width==null? "250" : width;
    height = height==null? "500" : height;
    frameWidth = frameWidth==null? "600" : frameWidth;
    parentValues = parentValues==null? "" : parentValues;
    pattern = pattern==null? "" : pattern;
    boolean useFrames = Boolean.valueOf(frame);
    if (filterId==null || "".equals(filterId) ){
            filterId = DynaContentService.PAGED_LIST_FILTER;
    }


    boolean dynaQuery = true;
    if(appendFilters != null && !"".equals(appendFilters)) {
        dynaQuery = Boolean.valueOf(appendFilters);
    }

    if(useFrames) {
        final FilterDTO filterDTO = (FilterDTO)pageContext.getAttribute(filterId, PageContext.REQUEST_SCOPE);  
        final List filters = filterDTO == null ? null : filterDTO.get();
        final StringBuffer filterParams = new StringBuffer();     
        if(filters!=null) {
            Object[] filter = null;
            final int size = filters.size();
            for(int i = 0; i < size; i++) {
                filter = (Object[])filters.get(i);
                filterParams.append("&").append("filter_value").append("_").append(filter[0]).append("=").append(filter[2]);
                filterParams.append("&").append("filter_condition").append("_").append(filter[0]).append("=").append(filter[1]);
            }
        }
%>
        <input type="hidden" id="treeBreadCrumb" name="treeBreadCrumb"/>
        <table align="center" width="100%" cellspacing="0px" style="padding: 0px;">
            <tr>
                <td width="<%=Integer.parseInt(width)%>px">
<%
                    if(frameParams != null){
%>        
                        <input type="hidden" id="frameParams" name="frameParams" value="<%=frameParams %>" />
<%            
                    }
%>
                    <!-- Se agrega hidden con pagina en blanco para usarla como tracking en caso de error, se obtiene en el xtree.js para enviarla como parametro -->
                    <input type="hidden" id="blankPage" name="blankPage" value="tframe:/layout/empty" />
                    <iframe src="" frameborder="0"  style="width: <%=Integer.parseInt(width)%>px; height: <%=height%>px; overflow: auto; padding: 0px;" id="treeFrame" name="treeFrame"></iframe>
                </td>
                <td>
                    <iframe src="" frameborder="0" style="width: <%=frameWidth%>px; height: <%=height%>px; overflow: auto; padding: 0px;" id="treeBody" name="treeBody"></iframe>
                </td>
            </tr>
        </table>
        <c:url var="contextPath" value="/"/>
        <script language="javascript" >
            var frame = document.getElementById("treeFrame");            
            frame.src="<c:out value="${contextPath}"/>util/displayTree.do?name=<%=name%>&parentValues=<%=parentValues%>&appendFilters=<%=dynaQuery%>&pattern=<%=pattern%>&titleArgs=<%=titleArgs%>&width=<%=Integer.parseInt(width)%>&height=<%=height%><%=filterParams%>";
        </script>
<%
    } else {
        Object[] argsTitle = null;
        if(titleArgs!=null && !"".equals(titleArgs)) {
             argsTitle = titleArgs.split(",");
        }
        pageContext.setAttribute("argsTitle", argsTitle);

        List<String> initParams = new ArrayList<String>();
        if(parentValues != null && !"".equals(parentValues)) {
            String[] array =  parentValues.split(",");
            for(String value: array) {
                initParams.add(value.trim());
            }
        }

        final String repositoryKey = TreeRepository.TREE_REPOSITORY_KEY+"."+name;
        final FilterDTO filters = (FilterDTO)pageContext.getAttribute(filterId, PageContext.REQUEST_SCOPE);

        TreeRepository treeRepository = (TreeRepository) request.getSession(false).getServletContext().getAttribute(TreeRepository.TREE_REPOSITORY_KEY);
        if(dynaQuery) {
            if(filters != null && filters.get() != null && !filters.get().isEmpty()) {
                treeRepository = treeRepository.build(name, repositoryKey, initParams, pattern, TagUtils.getConditions(filters));
            } else {
                treeRepository = treeRepository.build(name, repositoryKey, initParams, pattern, TagUtils.getConditions(request));
            }
        } else {
            if(filters != null && filters.get() != null && !filters.get().isEmpty()) {
                treeRepository = treeRepository.build(name, repositoryKey, initParams, pattern, TagUtils.getConditions(filters), dynaQuery);
            } else {
                treeRepository = treeRepository.build(name, repositoryKey, initParams, pattern, TagUtils.getConditions(request), dynaQuery);
            }             
        }
%>
        <div style="overflow: none; padding: 0px;" onmouseover="releaseMouse()" onmouseout="disableMouse()">
            <menu:useMenuDisplayer name="<%=treeRepository.TREE_DISPLAYER_KEY%>" permissions="rolesAdapter" repository="<%=repositoryKey%>">
                <menu:displayMenu name="<%=name%>"/>
            </menu:useMenuDisplayer>

            <menu:useMenuDisplayer name="<%=treeRepository.CONTEXT_DISPLAYER_KEY%>" permissions="rolesAdapter" repository="<%=repositoryKey%>">
                <c:forEach var="menu" items="<%=treeRepository.getTopMenus()%>">
                    <c:if test="${menu.name != name}">
                        <menu:displayMenu name="${menu.name}"/>
                    </c:if>            
                </c:forEach>
            </menu:useMenuDisplayer>
        </div>
<%
        pageContext.removeAttribute(filterId, PageContext.REQUEST_SCOPE);
        pageContext.removeAttribute("argsTitle");    
    }
%>

<script type="text/javascript"> 
    function getBreadCrumb() {
        var tree = eval(<%=name%>);
        var child = tree.getSelected();
        var rute = "";
        if(child!=null){            
            while(child!=null){
                if(rute.length > 0){
                   rute = child.text+"<UL>"+rute;
                }else{
                   rute = child.text
                }
                child = child.parentNode		
            }
            rute = "<UL style='padding: 0px'>"+rute;
        }else{
            rute = window.top.document.getElementById("treeBreadCrumb").value;
        }        
        window.top.document.getElementById("treeBreadCrumb").value = rute;
        return rute;
    }
</script>

<%
} catch(Exception e) {
    e.printStackTrace();
}finally {
    pageContext.removeAttribute(filterId, PageContext.REQUEST_SCOPE);
     pageContext.removeAttribute("argsTitle");
}
%>
