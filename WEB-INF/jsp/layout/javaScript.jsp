<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Debe ir antes de cargar el xtree.js y el progess.js para obtener el contexto de la aplicacion web de recursos estaticos -->
<script type="text/javascript">
  function getThemeBaseUrl() {
     return ('<spring:theme code="themeBaseUrl" text="../../resources" />');
  }
</script>

<!-- GENERAL -->
    <script type="text/javascript" src="<spring:theme code="functions.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="dragndrop.js"/>"> </script>
    <script type="text/javascript" src="<spring:theme code="doubleSelect.js"/>"></script>

<!-- MENU -->
    <script type="text/javascript" src="<spring:theme code="navmenu.js"/>"></script>

<!-- CALENDAR -->
    <script type="text/javascript" src="<spring:theme code="calendar.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="callang.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="calsetup.js"/>"></script>
    
<!-- CONTAINER -->    
    <script type="text/javascript" src="<spring:theme code="container.js"/>"></script>    
    
<!-- PROGRESS -->
    <script type="text/javascript" src="<spring:theme code="progress.js"/>"></script>

<!-- XTREE -->
    <script type="text/javascript" src="<spring:theme code="xtree.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="rightcontext.js"/>"></script>

<!-- AJAX TAGS -->
    <script type="text/javascript" src="<spring:theme code="ajxproto.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="ajxscript.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="ajxovlib.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="ajaxtags.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="ajaxtagsctl.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="ajaxtagspsr.js"/>"></script>

<!-- JQUERY -->
    <script type="text/javascript" src="<spring:theme code="jquery.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.ui.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.cycle.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.inputmask.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.inputmask.extensions.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.inputmask.date.extensions.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.inputmask.numeric.extensions.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.inputmask.phone.extensions.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.inputmask.regex.extensions.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.textarea.limiter.js"/>"></script>
    <script type="text/javascript" src="<spring:theme code="jquery.modal.js"/>"></script>

<!-- CUSTOM -->
    <script type="text/javascript">
      function doSubmit(submitId) {
        var anchor = document.getElementById(submitId);
        if(anchor) {
            var action = anchor.getAttribute("action");
            var path = anchor.getAttribute("path");
            var message = anchor.getAttribute("alertCode");
            return doSubmitInternal(action, path, message, submitId);
        }
        return doSubmitInternal();
      }

      function doSubmitInternal(action, path, message, submitId) {
        if(path && '' != path) {
          document.getElementsByName(path)[0].value = "true";
        }
        if(message && '' != message) {
            if(confirm(message)) {
                hideMessageDiv();
                showLightbox(submitId);
                for (var i=0; i<document.forms.length; i++ ){
                  if(document.forms[i].contains(document.getElementById(submitId))){
                     document.forms[i].action = action;
                     break;
                  }
                }
                return true;
            } else {
                return false;
            }
        }
        hideMessageDiv();
        showLightbox(submitId);
        if(action && '' != action) {
            for (var i=0; i<document.forms.length; i++ ){
               if(document.forms[i].contains(document.getElementById(submitId))){
                  document.forms[i].action = action;
                  break;
               }
            }
        }
        return true;
      }

      //Deshabilita el boton que haya sido presionado
      function disableButton() {
            var objectSrc = window.event.srcElement;
            if(objectSrc.type == 'submit' || objectSrc.type == 'reset') {
                if(document.forms[0] != null) {
                    var onSubmitFunction = document.forms[0].onsubmit;
                    document.forms[0].onsubmit = function() {
                        for(var i=0; i<document.forms[0].elements.length; i++) {
                              var object = document.forms[0].elements[i];
                              if(object.type == 'submit' || object.type == 'reset') {
//                                if( objectSrc.name == object.name && objectSrc.name == '<!--%=Constants.CANCEL_PROPERTY%-->' ){
//                                    var newHidden = document.createElement("input");
//                                    newHidden.type = "hidden";
//                                    newHidden.name="<!--%=Constants.CANCEL_PROPERTY%-->";
//                                    newHidden.value=objectSrc.value;
//                                    document.forms[0].appendChild( newHidden );
//                                }
                                  object.disabled = true;
                              }
                        }
                        if(onSubmitFunction) {
                          onSubmitFunction();
                        }
                        //return true;
                    }
                }
            }
      }

      function doOpen(htmlElementUniqueID) {
        var htmlElement = document.getElementById(htmlElementUniqueID);
        if(htmlElement) { var url = htmlElement.getAttribute("action"); return popup(url); }
      }

      //Abre una ventana que ocupa toda la pantalla, sin menus ni barra de estado
      function popup(url) {
         //Assign the same domain value in case of default port numbers (if update document.domain then port 80 will become port null),
         //this must be set in all window/frames that need interact with each other. If we set this code on top of the document, then must be set in iframes also,
         //therefore is only enabled for window open documents.
         if(document.domain) { document.domain = document.domain; }
         if(document.domain && document.domain.indexOf("hacienda") >= 0) { document.domain = document.domain.substring(document.domain.indexOf("hacienda")); }
         var newwin = window.open(url, 'Main', 'width='+screen.width+', height='+screen.height+', top=0, left=0, status=no, menubar=no, toolbar=no, directories=no, location=no, fullscreen=yes, scrollbars=yes');
         if(window.focus) { newwin.focus() }
         return false;
      }

      function delegateOpener(url) {
         if(window.opener != undefined && !window.opener.closed) {
            //Assign the same domain value in case of default port numbers (if update document.domain then port 80 will become port null),
            //this must be set in all window/frames that need interact with each other. If we set this code on top of the document, then must be set in iframes also,
            //therefore is only enabled for window open documents.
            if(document.domain) { document.domain = document.domain; }
            if(document.domain && document.domain.indexOf("hacienda") >= 0) { document.domain = document.domain.substring(document.domain.indexOf("hacienda")); }
            //Accessing "document.location" throw a SecurityError (same-origin policy) when execute from cross-origin windows using different protocols, domains or ports
            //Instead use cross-document messaging "postMessage" with an unspecific target origin URI "*", so child window doesn't need to know where parent window is located
            //In case of IE "postMessage" only works for IFRAMES/FRAMES not for WINDOWS (As of IE11, this issue has not yet been fixed), if an Error raised then fallback to
            //window.opener.document.location = url;
            try { window.opener.postMessage("[delegateOpener]:" + url, "*"); } catch(e) { window.opener.document.location = url; }
            window.opener.focus();
            window.close();
         } else { document.location = url; }
      }

      function onMessageListener(event) {
         //event.source is origin window
         //event.origin is target origin URI
         //console.log(event);
         if(!event.data) { throw new Error("No data specified in postMessage(...)"); }
         if(!(typeof(event.data) == "string")) { throw new Error("The data specified in postMessage(...) is not type of string"); }
         if(event.data.indexOf("[delegateOpener]:") == 0) { delegateOpener(event.data.split("[delegateOpener]:").join("")); }
      }

      if(window.addEventListener) { //Firefox, Chrome, Opera, Safari compatibility
         addEventListener("message", onMessageListener, false);
      } else if(window.attachEvent) { //IExplorer compatibility
         attachEvent("onmessage", onMessageListener);
      }
    </script>

    <script type="text/javascript">
      jQuery.noConflict();

      //Prevents "clickjacking" attack. Exclude internal iframes (iframe, tframe, etc.)
      function preventClickjacking() {
         if(self == top || jQuery("meta[name=use-iframe]").attr("content") == "true") { (document.getElementsByTagName('body')[0]).style.display = "block";} else { top.location = self.location; }
      }
      
      jQuery(document).ready(function($) { preventClickjacking(); });

      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      ga('create', 'UA-61915722-1', 'auto');
      ga('send', 'pageview');
    </script>

<!-- Agrega codigo js para manejo de GUI de navegador protegida -->
    <fsn:browserCtrl />
