<%@ attribute name="id" required="true" %>
<%@ attribute name="cssOdd" required="false" %>
<%@ attribute name="cssEven" required="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    try{
        String strIndex = (String)pageContext.getAttribute("gob.shcp.fsn.control.tag." + id + "TogglerIndex", PageContext.REQUEST_SCOPE);
        int index = strIndex == null ? 1 : Integer.valueOf(strIndex);
        if(index % 2 == 0) {
            if(cssEven == null) {
                cssEven = "even";
            }
%>
            class="<c:out value="<%=cssEven%>"/>"
<%
        } else {
            if(cssOdd == null) {
                cssOdd = "odd";
            }
%>
            class="<c:out value="<%=cssOdd%>"/>"
<%
        }
        pageContext.setAttribute("gob.shcp.fsn.control.tag." + id + "TogglerIndex", Integer.toString(index + 1), PageContext.REQUEST_SCOPE);
    
    }catch(Exception e){
        e.printStackTrace();
    }
%>
