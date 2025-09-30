<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@ attribute name="title"%>        <!-- Titulo que aparecera en alguno de los contenedores. -->
<%@ attribute name="name"%>         <!-- Nombre que se le va a asociar a alguno de los contenedores. -->
<%@ attribute name="content"%>      <!-- Variable definida en el jsp con el contenido que se va a desplegar en alguno de los contenedores. -->
<%@ attribute name="selected"%>     <!-- Indica cual de los contenedores es el que aparecera desplegado -->
<%@ attribute name="section"%>      <!-- Atributo que indica en que momento inicia el contenedor ("init") y en donde finaliza ("final") para poder armar correctamente el contenedor. -->
<%@ attribute name="type"%>         <!-- Especifica como se mostrara el contenedor si en forma de tabs("tab") o en acordeon ("accordion") el valor por default es accordion. -->
<%@ attribute name="tabHeight"%>    <!-- La altura en pixeles de los tabs, el valor por default es 25. -->
<%@ attribute name="displayTime"%>  <!-- Especifica cuantos segundos debe tardar en abrir los contenidos, el valor por default es 3 segundos. -->

<%
try{
    
    title = title != null ? title : "<-- " + name + " -->";
    selected = selected == "true" ? "header_highlight" : "";
    tabHeight = tabHeight != null ? tabHeight : "25";
    type = type != null ? type : "accordion";
    
    if(section != null && section =="init" && type != null){
        request.setAttribute("CONTAINER_TYPE", type);
    }
%>
    
    <c:if test="${section != null && section =='init'}">
        <style type="text/css">
            .tab_container *{
                float:left;
                width:100px;
                height:<%=tabHeight%>px;
            }
        </style>
<%
        displayTime = displayTime != null ? displayTime : "3";
        request.setAttribute("CONTAINER_DISPLAY_TIME", displayTime);
%>
        <div id="fsn-container">
    </c:if>
    
    <c:if test="${section == null && name != null}" >
<%
        if(request.getAttribute("CONTAINER_TYPE") != null && request.getAttribute("CONTAINER_TYPE") == "tab"){
%>
        <c:set var="TABS_HEADER_DIV" scope="request">
            <c:out value="${TABS_HEADER_DIV}" escapeXml="false"/>
            <div id="<%=name%>-header" class="container_headings <%=selected%>" ><%=title%></div>
        </c:set>        
        <c:set var="TABS_CONTENT_DIV" scope="request">
            <c:out value="${TABS_CONTENT_DIV}" escapeXml="false"/>
            <div id="<%=name%>-content">
                <div class="container_child">
                    <c:out value="${content}" escapeXml="false"/>
                    <jsp:doBody/>
                </div>
            </div>
        </c:set>
<%
        }else if(request.getAttribute("CONTAINER_TYPE") != null && request.getAttribute("CONTAINER_TYPE") == "accordion"){
%>                
            <div id="<%=name%>-header" class="container_headings <%=selected%>" ><%=title%></div>
            <div id="<%=name%>-content">
                <div class="container_child">
                    <c:out value="${content}" escapeXml="false"/>
                    <jsp:doBody/>
                </div>
            </div>
<%
        }
%>
    </c:if>
    <c:if test="${section != null && section =='final'}">
<%
        displayTime = (String)request.getAttribute("CONTAINER_DISPLAY_TIME");
        if(request.getAttribute("CONTAINER_TYPE") != null && request.getAttribute("CONTAINER_TYPE") == "tab"){
%>        
            <div class="tab_container">
                <c:out value="${TABS_HEADER_DIV}" escapeXml="false"/>
            </div>
            <div style="float:left;width:100%">
                <c:out value="${TABS_CONTENT_DIV}" escapeXml="false"/>
            </div>      
<%
        }
        request.removeAttribute("CONTAINER_TYPE");
        request.removeAttribute("CONTAINER_DISPLAY_TIME");
%>    
        </div>
        
        <script type="text/javascript">	
            var containerDisplayTime = "<%=displayTime%>";
            
            var oldonload = window.onload;
            
            window.onload = function(){
                if(oldonload){
                    oldonload();
                }
                new Accordian('fsn-container',containerDisplayTime,'header_highlight');
            }
        </script>
    </c:if>
    
<%
} catch(Exception e) {
    e.printStackTrace();
}
%>