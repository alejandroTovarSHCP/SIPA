<%@ tag import="java.util.Enumeration" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="org.springframework.validation.BindingResult" %>
<%@ tag import="org.springframework.beans.PropertyAccessor" %>

<%@ attribute name="path" required="true" %>

<%
try {
    if(path != null && path.startsWith("*")) {
        String beanName = null;
        String resolvedPath = null;
        ArrayList<String> attrs = new ArrayList<String>();
        
        for(Enumeration e = request.getAttributeNames(); e.hasMoreElements(); ) {
            attrs.add((String)e.nextElement());
        }
        for(String attrName:attrs) {
            if(attrName.startsWith(BindingResult.MODEL_KEY_PREFIX)) {
                beanName = attrName.substring(BindingResult.MODEL_KEY_PREFIX.length(), attrName.length());
                resolvedPath = path.substring("*".length());
                if(!"".equals(resolvedPath) && !resolvedPath.startsWith(PropertyAccessor.NESTED_PROPERTY_SEPARATOR)) {
                    resolvedPath = PropertyAccessor.NESTED_PROPERTY_SEPARATOR + resolvedPath;
                }
                resolvedPath = beanName + resolvedPath;
                pageContext.setAttribute("resolvedPath", resolvedPath, PageContext.REQUEST_SCOPE);
%>
                <jsp:doBody />
<%
            }
        }
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>
