<%@ tag import="org.apache.commons.logging.Log" %>
<%@ tag import="org.apache.commons.logging.LogFactory" %>
<%@ tag import="javax.servlet.jsp.JspException" %>
<% 
    
    final Log jspLog = LogFactory.getLog(this.getClass().getName());
    try {
%>
                <jsp:doBody />
<%               
    } catch(Exception e) {
        if(e instanceof JspException) {
            jspLog.error("Catching JspException: " + e.getMessage());
            JspException nestedEx = (JspException)e;
            while(nestedEx.getRootCause() != null && nestedEx.getRootCause() instanceof javax.servlet.jsp.JspException) {
                nestedEx = (JspException)nestedEx.getRootCause();
            }
            if(nestedEx.getRootCause() != null && nestedEx.getRootCause() instanceof java.io.IOException){
                jspLog.error("Skip JspException due IO Error: " + nestedEx.getRootCause().getMessage());
            } else {
                throw e;
            }
        } else {
            throw e;
        }
    }
%>