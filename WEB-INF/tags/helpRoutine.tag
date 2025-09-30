<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ attribute name="beanName" %>
<%@ attribute name="service" %>
<%@ attribute name="path" required="true" %>            <!-- Propiedad del objeto de modelo que mantiene el identificador del registro seleccionado de la helpRoutine -->
<%@ attribute name="fieldMapping" required="true" %>    <!-- Nombre de las columnas de la helpRoutine cuyos valores se pasaran a los campos (del mismo nombre) en la pagina principal -->
<%@ attribute name="width" %>                           <%--parametros asociados a la ventana emergente--%>
<%@ attribute name="leftPosition"%>                     <%--parametro que determina la posicion de la ventana emergente en porcentajes.--%>
<%@ attribute name="height"%>                           <%--parametros asociados a la ventana emergente--%>
<%@ attribute name="topPosition"%>                      <%--parametro que determina la posicion de la ventana emergente en porcentajes.--%>
<%@ attribute name="maxlength" %>
<%@ attribute name="disabled" %>                        <!-- Muestra el campo de texto de solo lectura y la imagen del componente de helpRoutine con la opcion de modificar su valor -->
<%@ attribute name="readonly" %>                        <!-- Muestra el campo de texto de solo lectura y la imagen del componente de helpRoutine sin la opcion de modificar su valor -->
<%@ attribute name="size" %>
<%@ attribute name="title" %>
<%@ attribute name="uppercase" %>
<%@ attribute name="multiple" %>
<%@ attribute name="parentValues"%>
<%@ attribute name="onClose"%>
<%@ attribute name="decorator" %>
<%@ attribute name="maxRows" %><!-- Limita el numero de registros de la consulta, con -1 obtiene todos los registros encontrados -->
<%@ attribute name="orderedColumns" %>                  <!-- Nombre de las columnas de la helpRoutine que se mostraran y en que orden -->

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%
try {
    if((beanName == null || "".equals(beanName)) && (service == null || "".equals(service))) {
        return;
    }
    
    boolean upperCased = true;
    if(uppercase != null && !"".equals(uppercase)) {
        upperCased = Boolean.valueOf(uppercase);
    }
    boolean multipleSelection = false;
    if(multiple != null && !"".equals(multiple)) {
        multipleSelection = Boolean.valueOf(multiple);
    }
    maxlength = maxlength==null ? "" : maxlength;
    readonly = Boolean.valueOf(readonly).toString();
    String inputReadonly = String.valueOf(Boolean.valueOf(readonly) || Boolean.valueOf(disabled));
    size = size==null ? "" : size;
    String cssClass = upperCased ? "uppercase" : "";
    title = title==null ? "helpRoutine.title" : title;
    width = width==null ? "450" : width;
    height = height==null ? "320" : height;
    leftPosition  = leftPosition==null  ? "30" : leftPosition;
    topPosition = topPosition==null ? "25" : topPosition;
    String dataSourceName = "";
    String dataSourceType = "";
    if(beanName!= null && !"".equals(beanName)) {
        dataSourceName = beanName;
        dataSourceType = "beanName";
    } else if(service!= null && !"".equals(service)) {
        dataSourceName = service;
        dataSourceType = "service";
    }
    decorator = decorator==null ? "gob.shcp.fsn.control.view.decorator.HelpTableDecorator" : decorator;
    maxRows = maxRows==null ? "-1" : maxRows;

    String pathName = path.replace("[", "").replace("]", "");
    String closeFunction = "closeDiv" + pathName + "()";
%>

<c:url var="contextPath" value="/"/>
<!-- Muestra el campo (texto o hidden) donde se recibe uno de los valores de la columna de la helpRoutine para el registro seleccionado -->
<c:choose>
    <c:when test="${multiple == true}">
        <html:hidden path="<%=path%>"/>
    </c:when>
    <c:otherwise>
        <html:input path="<%=path%>" maxlength="<%=maxlength%>" size="<%=size%>" title="<%=title%>" readonly="<%=inputReadonly%>" cssClass="<%=cssClass%>"/>
    </c:otherwise>
</c:choose>

<!-- Muestra la imagen con la accion que despliega la helpRoutine -->
<span class="helproutine">
<%
    if(Boolean.valueOf(readonly)) {
%>
      <a href="javascript://nop/">
        <img alt="help" src="<spring:theme code="help_disabled.gif"/>" height="20" width="20"/>
      </a>
<%
    } else {
%>
      <a href="javascript:showDiv<%=pathName%>();">
        <img alt="help" src="<spring:theme code="background.gif"/>" height="20" width="20"/>
      </a>
<%
    }
%>
</span>

<!-- Contiene el area en donde se muestra la helpRoutine -->
<div id="div<%=pathName%>" class="popup">
    <table border="0" width="250" bgcolor="#3C3C3C" cellspacing="0" cellpadding="5">
        <tr>
            <td width="100%">
                <table border="0" width="100%" cellspacing="0" cellpadding="0" height="36">
                    <tr>
                        <td style="cursor:move" width="100%" onmousedown="javascript:comienzoMovimiento(event, 'div<%=pathName%>');">
                            <font color=#ffffff size=2 face=Montserrat-Regular  style="text-decoration:none"><spring:message code="<%=title%>" text="<%=title%>" /></font>
                        </td>
                        <td style="cursor:hand" valign="top" align="right">
                            <a href="#" onClick="closeDiv<%=pathName%>();return false"><font color=#ffffff size=2 face=Montserrat-Regular  style="text-decoration:none">X</font></a>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%" bgcolor="#FFFFFF" style="padding:4px" colspan="2">
                            <iframe style="height:<%=height%>px;width:<%=width%>px;border-style:none;" src="" name="fra<%=pathName%>" id="fra<%=pathName%>">
                            </iframe>
                        </td>
                    </tr>
                </table> 
            </td>
        </tr>
    </table>
</div>


<script type="text/javascript" >
    function showDiv<%=pathName%>() {
        if (document.getElementById("div<%=pathName%>").style.visibility == "visible"){
            document.getElementById('div<%=pathName%>').style.visibility="hidden";
        } else {
            centerInScreen(document.getElementById("div<%=pathName%>"), '<%=leftPosition%>', '<%=topPosition%>');
            var frame = document.getElementById("fra<%=pathName%>");
            <c:url var="contextPath" value="/util/displayHelp.do" >
                <c:param name="dataSourceName" value="<%=dataSourceName%>" />
                <c:param name="dataSourceType" value="<%=dataSourceType%>" />
                <c:param name="path" value="<%=path%>" />
                <c:param name="parentValues" value="<%=parentValues%>" />
                <c:param name="fieldMapping" value="<%=fieldMapping%>" />
                <c:param name="multipleSelection" value="<%=String.valueOf(multipleSelection)%>" />
                <c:param name="closeFunction" value="<%=closeFunction%>" />
                <c:param name="decorator" value="<%=decorator%>" />
                <c:param name="maxRows" value="<%=maxRows%>" />
                <c:param name="orderedColumns" value="<%=orderedColumns%>" />
            </c:url>
            frame.src="<c:out value='${contextPath}' escapeXml="false"/>";
            document.getElementById('div<%=pathName%>').style.visibility = "visible";
        }
    }
    
    function closeDiv<%=pathName%>() {                                
        var onCloseFunction = "<%=onClose%>";
        if(onCloseFunction!= "null" && onCloseFunction.length>0) {            
            window.parent.eval(onCloseFunction);            
        }
        document.getElementById('div<%=pathName%>').style.visibility="hidden";
        document.getElementById('fra<%=pathName%>').src="";
    }
    carga();
</script>
<%
} catch(gob.shcp.fsn.service.ServiceException se) {
    TagUtils.saveError(pageContext, se);
%>
    <jsp:include page="/WEB-INF/jsp/layout/message.jsp" />
<%
} catch(Exception e) {
    e.printStackTrace();
}
%>