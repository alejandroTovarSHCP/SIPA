<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>
<%@ tag import="gob.shcp.fsn.service.security.SecurityService" %>


<%
    try{
%>
    <script type="text/javascript">
<%
       final SecurityService securityService = TagUtils.security(pageContext);
       if(securityService.isInterfaceProtected()) {
%>
          // Bloqueo del boton derecho y central del mouse
          function mouseDown(e) {
             if (parseInt(navigator.appVersion)>3) {
                var clickType=1;
                if (navigator.appName=="Netscape") clickType=e.which;
                else clickType=event.button;
                if (clickType!=1) {               
                   alert ('Funcionalidad no permitida!');
                   return false;
                }
             }
             return true;
          }
          
          // asociacion del evento "mousedown" con la funcion mouseDown(e)
          function disableMouse(){
             if (parseInt(navigator.appVersion)>3) {
                document.onmousedown = mouseDown;
                
                if (navigator.appName=="Netscape") 
                   document.captureEvents(Event.MOUSEDOWN);         
             }
          }
          
          // liberacion del evento "mousedown"
          function releaseMouse(){
             if (parseInt(navigator.appVersion)>3) {
                document.onmousedown = null;
                
                if (navigator.appName=="Netscape") 
                   document.releaseEvents(Event.MOUSEDOWN);         
             }
          }
<%
       } else {
%>
          function disableMouse(){}      
          function releaseMouse(){}
<%
       }
%>
    
          //Inicializacion del manejo del evento mousedown
          disableMouse();   
    </script>

<%
    }catch(Exception e){
        e.printStackTrace();
    }
%>