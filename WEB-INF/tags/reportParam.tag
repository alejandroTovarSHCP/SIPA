<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils"%>
<%@ tag import="java.util.Properties"%>
<%@ attribute name="name" required="true"%>
<%@ attribute name="value" required="true"%>

<%
    try{
        /* Se genera la instancia del contenedor de parametros y se coloca en el pageContext */
        if (pageContext.getAttribute(TagUtils.REPORT_PARAMS, PageContext.REQUEST_SCOPE )==null ){
            pageContext.setAttribute(TagUtils.REPORT_PARAMS , new Properties(), PageContext.REQUEST_SCOPE );
        }    

        if (value!=null && !value.equals("")){
            ((Properties)pageContext.getAttribute(TagUtils.REPORT_PARAMS, PageContext.REQUEST_SCOPE )).put(name, value);
        }
    
    }catch(Exception e){
        e.printStackTrace();
    }
%>
