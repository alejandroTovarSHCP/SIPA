<%--@Descripcion:Tag para desplegar una ventana emergente. Util para deplegar detalle de algun campo
                adicional al tag, se debe construir el jsp que contendrá el detalle que se mostrará.--%>
<%--@Autor: Erwin Martinez--%>
<%--@Ejemplo:
    <fsn:window name="${row.usuario}" uri="roleMto/detalleUsuario" params="commonName=${row.usuario}"  image="detail.gif" width="300"  height="250" title="${row.usuario}"/>
--%>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>

<%@ attribute name="name" required="true" %> <%--nombre asociado al div y a las funciones js debe ser dinamico si hay mas de una--%>
<%@ attribute name="uri"  required="true" %> <%--uri donde se obtendra la informacion a presentar --%>
<%@ attribute name="params"               %> <%--parametros de entrada que se deben enviar a la petición--%>
<%@ attribute name="linkValue"            %> <%--valor que se mostrará en el link. si se especifica se ignora el atributo image--%>
<%@ attribute name="spanClass"            %> <%--hoja de estilos para el link  --%>
<%@ attribute name="width"                %> <%--parametros asociados a la ventana emergente--%>
<%@ attribute name="leftPosition"         %> <%--parametro que determina la posicion de la ventana emergente en porcentajes.--%>
<%@ attribute name="height"               %> <%--parametros asociados a la ventana emergente--%>
<%@ attribute name="topPosition"          %> <%--parametro que determina la posicion de la ventana emergente en porcentajes.--%>
<%@ attribute name="title"                %> <%--llave de titulo de la ventana definido en aplication.properties  --%>
<%@ attribute name="image"                %> <%--llave de imagen en el link de la ventana definido en spring theme--%>
<%@ attribute name="onClose"              %> <%--funcion javascript que se ejecuta al cerrarse la ventana --%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%
try {
    String viewTracking = TagUtils.getInputViewParamName()+"=iframe:/layout/empty";
    spanClass     = spanClass==null     ? "" : spanClass;
    params        = params==null        ? "?"+viewTracking : "?"+viewTracking+"&"+params.replace(",","&"); 
    title         = title==null         ? "window.title" : title;
    width         = width==null         ? "450" : width;
    height        = height==null        ? "320" : height;    
    leftPosition  = leftPosition==null  ? "30" : leftPosition;
    topPosition   = topPosition==null   ? "25" : topPosition;
    image         = image==null         ? "background.gif" : image;
    linkValue     = linkValue==null     ? "" : linkValue;
    onClose       = onClose==null       ? "" : onClose;
    uri = uri.endsWith(".do") ? uri : uri+".do";
    uri = uri.startsWith("/") ? uri : "/"+uri;
%>
<span class="<%=spanClass%>">
<%
    if(linkValue.length()>0) {
%>
      <a href="javascript:showDiv<%=name%>();">
        <%=linkValue%>
      </a>
<%
    } else {
%>
      <a href="javascript:showDiv<%=name%>();">
        <img alt="help" src="<spring:theme code="${image}"/>" height="20" width="20"/>
      </a>
<%
    }
%>
</span>
<div id="div<%=name%>" class="popup">
    <table border="0" width="250" bgcolor="#3C3C3C" cellspacing="0" cellpadding="5">
        <tr>
            <td width="100%">
                <table border="0" width="100%" cellspacing="0" cellpadding="0" height="36">
                    <tr>
                        <td style="cursor:move" width="100%" onmousedown="javascript:comienzoMovimiento(event, 'div<%=name%>');">
                            <font color=#ffffff size=2 face=arial  style="text-decoration:none" ><spring:message code="<%=title%>" text="<%=title%>" /></font>
                        </td>
                        <td style="cursor:hand" valign="top" align="right">
                            <a href="#" onClick="closeDiv<%=name%>();return false"><font color=#ffffff size=2 face=Montserrat-Regular  style="text-decoration:none">X</font></a>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%" bgcolor="#FFFFFF" style="padding:4px" colspan="2">
                            <iframe style="height:<%=height%>px;width:<%=width%>px;border-style:none;" src="" name="frame<%=name%>" id="frame<%=name%>">
                            </iframe>
                        </td>
                    </tr>
                </table> 
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript" >
    function showDiv<%=name%>() {
        if (document.getElementById("div<%=name%>").style.visibility == "visible"){
            document.getElementById('div<%=name%>').style.visibility="hidden";
        } else {
            centerInScreen(document.getElementById("div<%=name%>"), '<%=leftPosition%>', '<%=topPosition%>');
            var frame = document.getElementById("frame<%=name%>");
            
            frame.src="<%=request.getContextPath()+uri+params%>";
            document.getElementById('div<%=name%>').style.visibility = "visible";
        }
    }
    
    function closeDiv<%=name%>() {                                
        var onCloseFunction = "<%=onClose%>";
        if(onCloseFunction.length>0) {            
            window.parent.eval(onCloseFunction);            
        }
        document.getElementById('div<%=name%>').style.visibility="hidden";
        document.getElementById('frame<%=name%>').src="";
    }
    carga();
</script>
<%
} catch(gob.shcp.fsn.service.ServiceException se) {
    TagUtils.saveError(pageContext, se);
%>
    <jsp:include page="../layout/message.jsp" />
<%
} catch(Exception e) {
    e.printStackTrace();
}
%>