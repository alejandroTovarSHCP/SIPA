<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table cellspacing="0" cellpadding="0" border="0" width="100%">
  <tr>
    <td valign="middle" align="center">    
      <iframe id="fraFSNVaadin" src="../fsnjbpm/sa/<c:out value='${view}.jsf' />"
              scrolling="yes" marginwidth="0" marginheight="0" frameborder="0" 
              vspace="0" hspace="0" style="overflow:visible; width:1px; height:1px; display:block"></iframe>
    </td>
  </tr>
</table>

<script type="text/javascript" src="<spring:theme code="iframe.js"/>"></script>
<script type="text/javascript">
    window.parent.resizeIframe("650","1024");
</script>