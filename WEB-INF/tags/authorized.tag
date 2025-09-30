<%@ tag import="java.util.StringTokenizer" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %> 
<%@ tag import="org.springframework.web.util.TagUtils"%>
<%@ tag import="org.springframework.web.util.ExpressionEvaluationUtils" %>
<%@ tag import="gob.shcp.fsn.service.security.SecurityService" %>

<%@ attribute name="roles" required="true"%>
<%@ attribute name="var"%> 
<%@ attribute name="scope"%>

<%
    try{
        scope = (scope!=null && !"".equals(scope)) ? scope : "request";
        String resolvedVar = ExpressionEvaluationUtils.evaluateString("var", this.var, pageContext);
        String resolvedScope = ExpressionEvaluationUtils.evaluateString("scope", this.scope, pageContext);
        
        final StringTokenizer tokens = new StringTokenizer(roles, ",");
        final List<String> tokenList = new ArrayList<String>();
        while(tokens.hasMoreTokens()) {
            tokenList.add(tokens.nextToken().trim());
        }
    
        final SecurityService securityService = gob.shcp.fsn.control.view.util.TagUtils.security(pageContext);
    
        boolean isAuthorized = false;
        for(String role : tokenList) {
            if(securityService.isUserAuthorized(role)) {
                isAuthorized = true;
                break;
            }
        }
    
        if(isAuthorized) {
            if(var != null && !var.equals("")) {
                // Expose as variable, if demanded.
                if (resolvedVar != null) {        
                    pageContext.setAttribute(resolvedVar, "true", TagUtils.getScope(resolvedScope));
                }
            }
%>
            <jsp:doBody />
<%    
        } else {
            if(var != null && !var.equals("")) {
                // Expose as variable, if demanded.
                if (resolvedVar != null) {        
                    pageContext.setAttribute(resolvedVar, "false", TagUtils.getScope(resolvedScope));
                }
            }
        }
    
    }catch(Exception e){
        e.printStackTrace();
    }
%>
