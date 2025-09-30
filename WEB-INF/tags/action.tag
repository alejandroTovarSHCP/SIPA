<%@ tag import="org.springframework.web.util.ExpressionEvaluationUtils" %>
<%@ tag import="org.springframework.web.util.TagUtils" %>

<%@ attribute name="url" required="true" %>
<%@ attribute name="var" %>
<%@ attribute name="scope" %>
<%@ attribute name="includeBaseURL" %>
<%@ attribute name="excludePrefix" %>
<%@ attribute name="excludeSuffix" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
try{
    boolean isBaseURL = Boolean.valueOf(includeBaseURL);
    boolean isPrefix = !Boolean.valueOf(excludePrefix);
    boolean isSuffix = !Boolean.valueOf(excludeSuffix);

    if(isPrefix && !url.startsWith("/")) {
        url = "/" + url;
    }
    if(isSuffix &&!url.endsWith(".do")) {
        url = url + ".do";
    }
%>
    <c:url value="<%=url%>" var="_url" scope="page"/>
<%
    var = (var!=null && !"".equals(var)) ? var : "action";
    scope = (scope!=null && !"".equals(scope)) ? scope : "request";
    
    url = (String)pageContext.getAttribute("_url", PageContext.PAGE_SCOPE);
    if(isBaseURL) {
        url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+url;
    }
    
    // Expose as variable, if demanded.
    String resolvedVar = ExpressionEvaluationUtils.evaluateString("var", this.var, pageContext);
    if (resolvedVar != null) {
        String resolvedScope = ExpressionEvaluationUtils.evaluateString("scope", this.scope, pageContext);
        pageContext.setAttribute(resolvedVar, url, TagUtils.getScope(resolvedScope));
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>
