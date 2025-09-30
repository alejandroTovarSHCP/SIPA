<%@ tag import="gob.shcp.fsn.model.support.SortCriteriaDTO"%>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils"%>

<%@ attribute name="fieldName" required="true" %>
<%@ attribute name="order" required="true"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    try{
        /* Se genera la instancia del contenedor de criterios de ordenamiento y se coloca en el pageContext*/
        if (pageContext.getAttribute(TagUtils.SORT_CRITERIA_FIELDS, PageContext.REQUEST_SCOPE )==null ){
            pageContext.setAttribute(TagUtils.SORT_CRITERIA_FIELDS , new SortCriteriaDTO(), PageContext.REQUEST_SCOPE );
        } 
               
        if (fieldName!=null && !fieldName.equals("") && order!=null && !order.equals("")){
            if (order.toUpperCase().equals("DESC"))  {
                ((SortCriteriaDTO)pageContext.getAttribute(TagUtils.SORT_CRITERIA_FIELDS, PageContext.REQUEST_SCOPE )).addCriteria(fieldName, SortCriteriaDTO.Mode.DESC);
            } else {
                ((SortCriteriaDTO)pageContext.getAttribute(TagUtils.SORT_CRITERIA_FIELDS, PageContext.REQUEST_SCOPE )).addCriteria(fieldName, SortCriteriaDTO.Mode.ASC);
            }
        }
    }catch(Exception e){
        e.printStackTrace();
    }
%>