<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Debe ir antes de cargar el xtree.js y el progess.js para obtener el contexto de la aplicacion web de recursos estaticos -->
<script type="text/javascript">
  function getThemeBaseUrl() {
     return ('<spring:theme code="themeBaseUrl" text="../../resources" />');
  }
</script>

<script type="text/javascript" src="<spring:theme code="xtree.js"/>"></script>
<script type="text/javascript" src="<spring:theme code="rightcontext.js"/>"></script>

<link type="text/css" rel="stylesheet" href="<spring:theme code="screen.css"/>"/>
<link type="text/css" rel="stylesheet" href="<spring:theme code="xtree.css"/>"/>
<link type="text/css" rel="stylesheet" href="<spring:theme code="rightcontext.css"/>"/>

<!-- Tag que incluye las funciones js para manejo de GUI de navegador protegida, 
    se agrega explicitamente ya que este jsp se depliega como jstl: y no incluye la pagina javaScript.jsp -->
<fsn:browserCtrl />

<fsn:tree name="${param['name']}" parentValues="${param['parentValues']}" appendFilters="${param['appendFilters']}" pattern="${param['pattern']}" titleArgs="${param['titleArgs']}" width="${param['width']}" height="${param['height']}" frameParams="${param['frameParams']}"/>
