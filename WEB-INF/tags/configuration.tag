<%@ tag import="org.springframework.web.util.TagUtils"%>
<%@ tag import="org.springframework.web.util.ExpressionEvaluationUtils" %>
<%@ tag import="gob.shcp.fsn.service.config.ConfigurationService" %>

<%@ attribute name="var" required="true"%>
<%@ attribute name="scope"%>
<%@ attribute name="context"%>
<%@ attribute name="key"%>
<%@ attribute name="pattern"%>
<%@ attribute name="type"%>

<% 
    try{
        context = (context != null && !"".equals(context)) ? context : ConfigurationService.DEFAULT_CONFIG_CONTEXT_NAME;
        key = (key != null && !"".equals(key)) ? key : var;
        type = (type != null && !"".equals(type)) ? type : "string";
        
        Object value = null;
        ConfigurationService configurationService = gob.shcp.fsn.control.view.util.TagUtils.configuration(pageContext);
        if("string".equalsIgnoreCase(type)) {
            value = configurationService.getString(context, key);
        } else if("long".equalsIgnoreCase(type)) {
            value = new Long(configurationService.getNumber(context, key).longValue());
        } else if("int".equalsIgnoreCase(type) || "integer".equalsIgnoreCase(type)) {
            value = new Integer(configurationService.getNumber(context, key).intValue());
        } else if("double".equalsIgnoreCase(type)) {
            value = new Double(configurationService.getNumber(context, key).doubleValue());
        } else if("float".equalsIgnoreCase(type)) {
            value = new Float(configurationService.getNumber(context, key).floatValue());
        } else if("short".equalsIgnoreCase(type)) {
            value = new Short(configurationService.getNumber(context, key).shortValue());
        } else if("byte".equalsIgnoreCase(type)) {
            value = new Byte(configurationService.getNumber(context, key).byteValue());
        } else if("date".equalsIgnoreCase(type)) {
            value = configurationService.getDate(context, key, pattern);
        } else {
            value = configurationService.getString(context, key);
        }
    
        // Expose as variable, if demanded.
        scope = (scope!=null && !"".equals(scope)) ? scope : "request";
        String resolvedVar = ExpressionEvaluationUtils.evaluateString("var", this.var, pageContext);
        String resolvedScope = null;
        if (resolvedVar != null) {        
            resolvedScope = ExpressionEvaluationUtils.evaluateString("scope", this.scope, pageContext);
            pageContext.setAttribute(resolvedVar, value, TagUtils.getScope(resolvedScope));
        }
    
    }catch(Exception e){
        e.printStackTrace();
    }
%>