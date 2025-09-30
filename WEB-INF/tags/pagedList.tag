<%--@Descripcion:Tag para realizar la paginación de una colección de datos obtenidos desde la capa de persistencia
     mediante la definición de un query o un servicio.
--%>
<%--@Autor: Erwin Martinez--%>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="gob.shcp.fsn.model.support.FilterDTO"%>
<%@ tag import="gob.shcp.fsn.service.support.DynaContentService" %>
<%@ tag import="gob.shcp.fsn.service.support.PagedListService" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>
<%@ tag import="gob.shcp.fsn.control.view.decorator.CheckboxTableDecorator" %>
<%@ tag import="org.springframework.util.ClassUtils" %>

<%@ attribute name="beanName" %><%--Nombre de la consulta definida en el archivo view-sql-defs.xml --%>
<%@ attribute name="service" %> <%--Nombre del servicio que realizara la consulta ---%>
<%@ attribute name="baseUrl" %> <%--Url que se usa para la paginacion --%>
<%@ attribute name="name" %>    <%--Nombre del atributo en el request donde se sube la lista de datos si no es por beanName o service, por default es igual a "items" --%>
<%@ attribute name="items" type="java.util.List" %> <%--Lista de datos a paginar --%>
<%@ attribute name="parentValues" %> <%--Valores separados por coma que se especifican como filtros de la consulta (t.campo = ?) --%>
<%@ attribute name="appendFilters" %> <%--Indica si los filtros sobre la consulta se agregan dinamicamente si el valor es "true" o se especifican en la consulta en notacion de filtros delimitados (##t.campo##) --%>
<%@ attribute name="checkbox" %> <%--Indica si se agrega una columna al inicio de cada fila de la lista con un checkbox si el valor es "true", se utiliza para listas paginadas de seleccion multiple --%>
<%@ attribute name="chkProperty" %> <%--Nombre de la propiedad de los objetos de la lista paginada cuyo valor se tomara para determinar que registros han sido seleccionados --%>
<%@ attribute name="maxRows" %> <%--Indica el numero maximo de registros a consultar, por defecto es -1 que devuelve todos los registros --%>
<%@ attribute name="filterId" %> <%--Nombre del atributo en el contexto "page" de donde se obtienen los filtros (de tipo FilterDTO), por defecto es el nombre de la constante DynaContentService.PAGED_LIST_FILTER --%>
<%@ attribute name="showErrors" %> <%--Indica si se muestran los errores que hubiera en la ejecucion como parte del tag si el valor es "true", por defecto es "true" --%>

<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
try {
    if((beanName == null || "".equals(beanName)) && (service == null || "".equals(service)) && (items == null)) {
        return;
    }

    if(filterId==null || "".equals(filterId) ) {
            filterId = DynaContentService.PAGED_LIST_FILTER;
    }

    maxRows = maxRows==null ? "-1" : maxRows;
    final int intMaxRows = Integer.parseInt(maxRows);

    boolean dynaQuery = true;
    if(appendFilters != null && !"".equals(appendFilters)) {
        dynaQuery = Boolean.valueOf(appendFilters);
    }
    boolean useCheckbox = false;
    if(checkbox != null && !"".equals(checkbox)) {
        useCheckbox = Boolean.valueOf(checkbox);
    }

    boolean isShowErrors = true;
    if(showErrors != null && !"".equals(showErrors)) {
        isShowErrors = Boolean.valueOf(showErrors);
    }

    if(!useCheckbox && (baseUrl == null || "".equals(baseUrl))) {
        baseUrl = "/home";
    }

    final FilterDTO pgf = (FilterDTO)pageContext.getAttribute(filterId, PageContext.REQUEST_SCOPE);

    String pagedListID = "";
    final List<String> parentVals = new ArrayList<String>();
    if(parentValues != null && !"".equals(parentValues)) {
        String[] array =  parentValues.split(",");
        for(String value: array) {
            parentVals.add(value.trim());
        }
        //parentValues.add(parentValue);
    }
    int totalRows = 0;
    if(service != null && !"".equals(service)) {
        List data = ((PagedListService)TagUtils.getService(pageContext, (Class)ClassUtils.forName(service))).getDataGrid(TagUtils.getConditions(pgf), parentVals, intMaxRows);
        if(intMaxRows > -1) {
            totalRows = ((PagedListService)TagUtils.getService(pageContext, (Class)ClassUtils.forName(service))).getDataGridSize(TagUtils.getConditions(pgf), parentVals);
        }
        if(data == null) {
            data = new ArrayList();
        }
        pagedListID = service;
        request.setAttribute(service.substring(service.lastIndexOf(".")+1), data); 
    }
    if(beanName != null && !"".equals(beanName)) {
//        if(sessionAttributeStore.retrieveAttribute(webRequest, beanName)==null) {
            List<String> initParams = new ArrayList<String>();
            if(parentVals.size()>0) {
                initParams.addAll(parentVals);
            }
            List data = null;
            if(dynaQuery) {
                data = TagUtils.getService(pageContext, DynaContentService.class).getDataGrid(beanName, TagUtils.getConditions(pgf), null, initParams, intMaxRows);
                if(intMaxRows > -1) {
                    totalRows = TagUtils.getService(pageContext, DynaContentService.class).getDataGridSize(beanName, TagUtils.getConditions(pgf), null, initParams);
                }
            } else {
                data = TagUtils.getService(pageContext, DynaContentService.class).getDataGrid(beanName, TagUtils.getConditions(pgf), initParams, intMaxRows);
                if(intMaxRows > -1) {
                    totalRows = TagUtils.getService(pageContext, DynaContentService.class).getDataGridSize(beanName, TagUtils.getConditions(pgf), initParams);
                }
            }
            if(data == null) {
                data = new ArrayList();
            }
        pagedListID = beanName;
        request.setAttribute(beanName, data);
    }

    if(totalRows > 0 && intMaxRows > -1 && totalRows > intMaxRows) {
        TagUtils.saveWarning(pageContext, "warn.maxRows.exceeded", null);
    }

    if(items != null) {
        if(name == null || "".equals(name)) {
            name = "items";
        }
        pagedListID = name;
        request.setAttribute(name, items);
    }
    pageContext.removeAttribute(filterId, PageContext.REQUEST_SCOPE);

    if(useCheckbox) {
        CheckboxTableDecorator chkTableDecorator = new CheckboxTableDecorator();
        if(chkProperty != null && !"".equals(chkProperty)) {
            chkTableDecorator.setFieldName(chkProperty);
            chkTableDecorator.setFieldValueProperty(chkProperty);
        }
        request.setAttribute("checkboxTableDecorator", chkTableDecorator);
%>
        <script type="text/javascript">
            function displaytagform(formname, fields) {
                var objfrm = document.forms[formname];
                objfrm.method = "get";
                for(j=fields.length-1; j>=0 ;j--) {
                    var f = objfrm.elements[fields[j].f];
                    if(f) {
                        f.value = fields[j].v;
                    }
                }
                objfrm.submit();
            }
        </script>
        <input type="hidden" name="d-16544-p" value="1"/>
        <input type="hidden" name="d-16544-s" value=""/>
        <input type="hidden" name="d-16544-o" value=""/>
        <div id="contentPag">
<%
            if(isShowErrors) {
%>
            <jsp:include page="/WEB-INF/jsp/layout/message.jsp" />
<%
            }
%>
            <br/>
            <jsp:doBody/>
        </div>
<%
    } else {
%>
        <c:set var="requestURI" value='<%=baseUrl+".do"%>' scope="request"/>
        <div id="contentPag">
<%
            if(isShowErrors) {
%>
            <jsp:include page="/WEB-INF/jsp/layout/message.jsp" />
<%
            }
%>
            <br/>
            <ajax:displayTag id="<%=pagedListID%>" ajaxFlag="displayAjax" baseUrl="${requestURI}" >
                <jsp:doBody/>
            </ajax:displayTag>
        </div>
<%
    }
} catch(javax.servlet.jsp.SkipPageException ignore) {
    //Throws ignore exception to avoid duplicated content in jsp, due "displayAjax" request parameter equals true when this tag includes body (AjaxDisplayTag.java)
    throw ignore;
} catch(gob.shcp.fsn.service.ServiceException se) {
    TagUtils.saveError(pageContext, se);
%>
    <jsp:include page="/WEB-INF/jsp/layout/message.jsp" />
<%
} catch(Exception e) {
    e.printStackTrace();
} finally {
    pageContext.removeAttribute(filterId, PageContext.REQUEST_SCOPE);
}
%>
