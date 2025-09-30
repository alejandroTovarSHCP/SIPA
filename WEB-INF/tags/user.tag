<%@ tag import="org.springframework.web.util.TagUtils"%>
<%@ tag import="org.springframework.web.util.ExpressionEvaluationUtils" %>
<%@ tag import="gob.shcp.fsn.service.security.SecurityService" %>
<%@ tag import="gob.shcp.fsn.service.security.auth.BasicUserData" %>

<%@ attribute name="var" required="true"%>
<%@ attribute name="scope"%>

<%    
    try{
    scope = (scope!=null && !"".equals(scope)) ? scope : "request";

    // Expose as variable, if demanded.
    String resolvedVar = ExpressionEvaluationUtils.evaluateString("var", this.var, pageContext);
    String resolvedScope = null;
    if (resolvedVar != null) {        
        resolvedScope = ExpressionEvaluationUtils.evaluateString("scope", this.scope, pageContext);
        pageContext.setAttribute(resolvedVar,  new BasicUserData(), TagUtils.getScope(resolvedScope));
    }

    final BasicUserData user = (BasicUserData)pageContext.getAttribute(resolvedVar, TagUtils.getScope(resolvedScope) );
    SecurityService securityService = gob.shcp.fsn.control.view.util.TagUtils.security(pageContext);
    user.setUserName(securityService.getUserName());
    user.setApplicationName(securityService.getApplicationName());
    user.setOperationYear(securityService.getOperationYear());
    
    }catch(Exception e){
        e.printStackTrace();
    }
%>