<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${!empty param.refresh}">
    <c:set var="refreshValue" scope="page"><c:out value="${param['refresh']}" escapeXml="true"/></c:set>
</c:if>
<c:if test="${!empty refresh}">
    <c:set var="refreshValue" scope="page" value="${refresh}"/>
</c:if>

<script type="text/javascript">
    //Obtiene el objeto td "breadCrumb" definido en este frame para reemplazar su contenido con la ruta del nodo seleccionado en el frame del arbol usando la funcion js "getBreadCrumb"
    var breadCrumb = document.getElementById("breadCrumb");
    if(breadCrumb!=null) {
        breadCrumb.innerHTML = parent.treeFrame.getBreadCrumb();//Se obtiene a traves del nombre del frame para poder ejecutar las funciones js, de lo contrario no funciona
    }

    //Si se configura el parametro "refresh" en la definicion de la vista a desplegar (archivo appname-servlet.xml) con valor "true", ejecuta el metodo "reload" del frame del arbol para recargar el contenido
    var refresh = "<c:out value="${refreshValue}" escapeXml="true"/>";
    if(refresh=="true") {
        window.top.document.getElementById("treeFrame").contentWindow.location.reload();
    }    
</script>
