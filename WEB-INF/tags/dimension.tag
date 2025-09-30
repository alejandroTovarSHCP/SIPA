<%@ tag import="org.springframework.web.util.TagUtils"%>
<%@ tag import="org.springframework.web.util.ExpressionEvaluationUtils" %>
<%@ tag import="gob.shcp.fsn.service.security.SecurityService" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>

<%@ attribute name="var" required="true"%>
<%@ attribute name="scope"%>
<%@ attribute name="code" required="true"%>
<%@ attribute name="parentValue"%>

<%
    try{
        scope = (scope!=null && !"".equals(scope)) ? scope : "request";
    
        // Expose as variable, if demanded.
        String resolvedVar = ExpressionEvaluationUtils.evaluateString("var", this.var, pageContext);
        String resolvedScope = null;
        if (resolvedVar != null) {        
            resolvedScope = ExpressionEvaluationUtils.evaluateString("scope", this.scope, pageContext);
            pageContext.setAttribute(resolvedVar,  new ArrayList(), TagUtils.getScope(resolvedScope));
        }
    
        SecurityService securityService = gob.shcp.fsn.control.view.util.TagUtils.security(pageContext);
    
        final List values = (List)pageContext.getAttribute(resolvedVar, TagUtils.getScope(resolvedScope));
        if(parentValue != null && !"".equals(parentValue)) {
            values.addAll(securityService.getDimensionSecondaryLevel(code, parentValue));
        } else {
            values.addAll(securityService.getDimensionPrimaryLevel(code));
        }
    
    }catch(Exception e){
        e.printStackTrace();
    }
%>