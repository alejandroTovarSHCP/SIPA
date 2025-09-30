<%@ page isErrorPage="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">    
    function testIframe(){
        if(self.location!=top.location) 
            top.location.replace(self.location);
    }
    
    testIframe();
</script>        
<br/>
<br/>
<h1 align="center">
  <spring:message code="error.500"/>
</h1>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>