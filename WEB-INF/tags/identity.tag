<%@ tag import="org.springframework.web.util.TagUtils"%>
<%@ tag import="org.springframework.web.util.ExpressionEvaluationUtils" %>
<%@ tag import="gob.shcp.fsn.service.identity.IdentityService" %>
<%@ tag import="gob.shcp.fsn.service.identity.User" %>

<%@ attribute name="userName" required="true"%>
<%@ attribute name="var" required="true"%>
<%@ attribute name="scope"%>

<%    
try {
    scope = (scope!=null && !"".equals(scope)) ? scope : "request"; 
    
    String resolvedVar = ExpressionEvaluationUtils.evaluateString("var", this.var, pageContext);
    if(resolvedVar != null) {        
        String resolvedScope = ExpressionEvaluationUtils.evaluateString("scope", this.scope, pageContext);

        IdentityService identityService = gob.shcp.fsn.control.view.util.TagUtils.identity(pageContext);
        User user = identityService.get(userName);
        pageContext.setAttribute(resolvedVar, user, TagUtils.getScope(resolvedScope));
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>