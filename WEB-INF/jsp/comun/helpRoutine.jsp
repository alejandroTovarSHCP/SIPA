<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Paso de parametros para la clase HelpTableDecorator a traves del pageContext -->
<c:set var="helpAllBox"><!-- Define el checkbox del encabezado que permite seleccionar todos los registros de la helpRoutine -->
    <input type="checkbox" id="helpallbox" name="helpallbox" value="*" onclick="javascript:selectDeselectAll();"/>Todos
</c:set>
<c:set var="fieldMapping" scope="page"><c:out value="${param['fieldMapping']}" escapeXml="true"/></c:set><!-- Nombre de las columnas de la helpRoutine cuyos valores se pasaran a los campos (del mismo nombre) en la pagina principal -->
<c:set var="multipleSelection" scope="page"><c:out value="${param['multipleSelection']}" escapeXml="true"/></c:set><!-- Determina si la helpRoutine es de seleccion multiple (checkbox) -->
<c:set var="closeFunction" scope="page"><c:out value="${param['closeFunction']}" escapeXml="true"/></c:set>
<c:set var="orderedColumns" scope="page"><c:out value="${param['orderedColumns']}" escapeXml="true"/></c:set><!-- Nombre de las columnas de la helpRoutine que se mostraran y en que orden -->
<c:set var="requestURI" value="displayHelp.do" scope="request"/>
<c:url var="contextPath" value="/"/>

<!-- COMUNES -->
<script type="text/javascript" src="<spring:theme code="functions.js"/>"> </script>

<link type="text/css" rel="stylesheet" href="<spring:theme code="common.css"/>"/>
<link type="text/css" rel="stylesheet" href="<spring:theme code="screen.css"/>"/>

<!-- AJAX -->
<link type="text/css" rel="stylesheet" href="<spring:theme code="ajaxtags.css"/>"/>
<link type="text/css" rel="stylesheet" href="<spring:theme code="styledisplaytag.css"/>"/>   

<html:form>
    <table align="center">
        <tr>
            <td>
                <c:set var="applyFilters" value="true"/><!-- Habilita la creacion de filtros para todas las columnas de la helpRoutine -->
                <c:if test="${tagutils:createPagedList(pageContext,param['dataSourceName'],param['dataSourceType'],param['multipleSelection'],param['parentValues'])}" >
                    <!-- Incluye la vista para mostrar los mensajes generados al crear la lista paginada -->
                    <jsp:include page="/WEB-INF/jsp/layout/message.jsp" />
                    <c:if test="${filtersAdded}"><!-- Si se crearon los filtros desde tagutils:createPagedList(...) entonces prepara la imagen con el codigo que ejecutara los filtros -->
                        <c:set var="pathImageFind">
                            <a href="javascript:executeFilter();">
                                <img alt="help" src="<spring:theme code="help.gif"/>" height="20" width="20" style="vertical-align:middle;"/>
                            </a>
                        </c:set>
                    </c:if>
                    <!-- Realiza el render de la helpRoutine. El "decorator" se encarga de mostrar en cada registro de la helpRoutine:
                         el checkbox para seleccion multiple si aplica solo si se trata del primer registro, 
                         los campos de texto para los filtros con la imagen y codigo de busqueda si se trata del primer registro 
                         y un campo hidden para cada columna en "fieldMapping" (concatenando el nombre con el indice del registro) 
                              con valor igual al de la columna correspondiente de cada registro de la helpRoutine -->
                    <!-- displaySource: Variable que contiene el nombre de la llave del request donde estan los datos del servicio -->
                    <display:table name="${displaySource}" class="displaytag" pagesize="10" id="row" requestURI="${requestURI}" sort="list" decorator="${param['decorator']}">
                            <c:set var="propertyNames" value="${tagutils:getOrderedPropertyNames(row, param['orderedColumns'])}"/>
                            <c:choose>
                                <c:when test="${param['multipleSelection']}"><!-- Si la helpRoutine es de seleccion multiple agrega una columna al inicio con un checkbox asociado al valor de la primera columna de la consulta de la helpRoutine -->
                                    <c:forEach items="${propertyNames}" var="property" varStatus="status" >
                                        <c:if test="${status.index == 0}" >
                                            <display:column sortable="true" title="">
                                            <input type="checkbox" id="helpCheck<c:out value="${displaySource}"/><c:out value="${row_rowNum}"/>" name="helpCheck<c:out value="${displaySource}"/><c:out value="${row_rowNum}"/>" value="<c:out value="${row[property]}"/>"
                                                onclick="javascript:concatValue(this.value)"/>
                                            </display:column>
                                            <display:column sortable="true" title="${property}" property="${property}"/>
                                        </c:if>
                                        <c:if test="${status.index != 0}" >            
                                            <display:column sortable="true" title="${property}" property="${property}"/>
                                        </c:if>                               
                                    </c:forEach>
                                </c:when>
                                <c:otherwise><!-- Si la helpRoutine no es de seleccion multiple entonces en la primera columna muestra un link con la funcion para seleccionar dicho registro -->
                                    <c:forEach items="${propertyNames}" var="property" varStatus="status" >
                                        <c:if test="${status.index == 0}" >            
                                            <display:column sortable="true" title="${property}" property="${property}" href="javascript:\" onclick=\"selectItem(this)" />
                                        </c:if>
                                        <c:if test="${status.index != 0}" >            
                                            <display:column sortable="true" title="${property}" property="${property}"/>
                                        </c:if>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            <display:setProperty name="paging.banner.placement" value="bottom"/>
                            <display:setProperty name="basic.msg.empty_list">
                                <br><span class="pagebanner"></span><span class="norecords">No se encontraron elementos<br><br></span>
                                <span style="padding: 2px 4px 2px 4px;width: 90%;display: block;border-top: none;margin-bottom: 10px;margin-left: 30px;text-align: left;">
                                    <input type="button" value="Aceptar" name="btnAceptar" class="uppercase" onclick="javascript:executeFilter();">
                                </span>
                            </display:setProperty>
                    </display:table>
                </c:if>
            </td>
        </tr>
    </table>
</html:form>

<script type="text/javascript" >
    var field = "<c:out value="${fieldMapping}" escapeXml='true'/>".replace("[","").replace("]","");
    var fields = field.split(",");
    if(<c:out value="${multipleSelection}" escapeXml='true'/>) {
        var listOfValues = "<c:out value='${concatenatedKeys}' escapeXml="true"/>"; // concatenatedKeys: Llave bajo la cual se almacenan los ids de los datos que se obtienen del servicio
        var pathValue= window.parent.document.getElementById(trim(fields[0])).value;
        var masterCheck = (document.getElementById("helpallbox")!=null)?document.getElementById("helpallbox"):"";
        if(pathValue == "*" ) {
            var pathValuess = "";
            masterCheck.checked = (masterCheck != null)?true:"";
        } else {
            var pathValuess = pathValue.split(",");
            masterCheck.checked = (masterCheck != null)?false:"";
        }    
        var checkBoxes = document.getElementsByTagName("input");    
        for(var n=0;n<checkBoxes.length;n++) {
            if(checkBoxes[n].type=="checkbox"){            
                if(pathValue =="*" ) {
                    checkBoxes[n].checked = true;                
                } else if(pathValue.length==0) {
                    checkBoxes[n].checked = false;
                } else {
                    for(var i=0;i<pathValuess.length;i++) {
                        if(pathValuess[i] == checkBoxes[n].value) {
                            checkBoxes[n].checked = true;                    
                        }
                    }
                }            
            }
        }
    }
    
    function selectItem(link) {
        var choice = link.parentNode.parentNode.id;//Obtiene el indice del registro seleccionado
        //Para cada columna de la helpRoutine si existe como campo en la gui 
        //entonces obtiene el valor del hidden correspondiente (concatenando el nombre con el indice del registro) y se lo pasa al campo en la gui
	for (x in fields) {
            if(window.parent.document.getElementById(trim(fields[x]))!=null) {
                window.parent.document.getElementById(trim(fields[x])).value = document.getElementById(trim(fields[x])+choice).value;
            }if(window.parent.document.getElementById("text_"+trim(fields[x]))!=null) {
                window.parent.document.getElementById("text_"+trim(fields[x])).value = document.getElementById(trim(fields[x])+choice).value;
            }
        }
        var onCloseFunction = "<c:out value="${closeFunction}" escapeXml="true"/>";
        window.parent.eval(onCloseFunction);
    }
      
    function closeHelp() {
        var onCloseFunction = "<c:out value="${closeFunction}" escapeXml="true"/>";                
        window.parent.eval(onCloseFunction);        
    }
    
    function replaceValue(newValue) {
        pathValue = pathValue.replace(newValue+",","");
        pathValue = pathValue.replace(newValue,"");
    }
    
    function concatValue(newValue) {        
        if(pathValue == "*" ) {            
            pathValue = listOfValues;
            masterCheck.checked = false;
            replaceValue(newValue);
        } else if(pathValue.search(newValue)<0) {
            if(pathValue.length==0) {
                pathValue = newValue+",";
            } else {
                pathValue = newValue+","+pathValue;
            }
        } else {
            replaceValue(newValue);
        }
        
        if(pathValue.length==listOfValues.length) {
            pathValue = "*";
            masterCheck.checked = true;
        }
        
        window.parent.document.getElementById(trim(fields[0])).value = (pathValue.lastIndexOf(",")+1== pathValue.length)?pathValue.substring(0,pathValue.length-1):pathValue;
    }
    
    function executeFilter() {
        document.forms[0].action = '<c:out value="${contextPath}" escapeXml="true"/>util/<c:out value="${requestURI}" escapeXml="true"/>?dataSourceName=<c:out value="${param['dataSourceName']}" escapeXml="true"/>&dataSourceType=<c:out value="${param['dataSourceType']}" escapeXml="true"/>&path=<c:out value="${param['path']}" escapeXml="true"/>&parentValues=<c:out value="${param['parentValues']}" escapeXml="true"/>&fieldMapping=<c:out value="${param['fieldMapping']}" escapeXml="true"/>&multipleSelection=<c:out value="${param['multipleSelection']}" escapeXml="true"/>&closeFunction=<c:out value="${param['closeFunction']}" escapeXml="true"/>&decorator=<c:out value="${param['decorator']}" escapeXml="true"/>&maxRows=<c:out value="${param['maxRows']}" escapeXml="true"/>';
        document.forms[0].submit();
    }
    
    function selectDeselectAll() {
        for(var n=0;n<checkBoxes.length;n++) {
            if(checkBoxes[n].type=="checkbox" && checkBoxes[n].value != "*") {
                if(masterCheck.checked) {
                    checkBoxes[n].checked = true;
                } else {
                    checkBoxes[n].checked = false;
                }
            }
        }               
        if(masterCheck.checked) {
            pathValue = "*";
        } else {
            pathValue = "";
        }
        window.parent.document.getElementById(trim(fields[0])).value = (pathValue.lastIndexOf(",")+1== pathValue.length)?pathValue.substring(0,pathValue.length-1):pathValue;
    }
</script>
