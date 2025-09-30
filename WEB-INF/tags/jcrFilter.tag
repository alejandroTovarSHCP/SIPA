<%@ tag import="gob.shcp.jcr.query.JcrCondition"%>
<%@ tag import="gob.shcp.fsn.service.ServiceException"%>
<%@ tag import="java.util.ArrayList"%>

<%@ attribute name="propertyName" %>
<%@ attribute name="value" type="java.lang.Object"%>
<%@ attribute name="propertyPath"%>
<%@ attribute name="valuePath" %>
<%@ attribute name="operator"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%

    try{
        operator = operator.toUpperCase();
            if("=".equals(operator)){
                operator= JcrCondition.OPERATOR_EQUALS;
            }else if( "!=".equals(operator)){
                operator= JcrCondition.OPERATOR_NOT_EQUALS;
            }else if( "<".equals(operator)){
                operator= JcrCondition.OPERATOR_LESS_THAN;
            }else if( "<=".equals(operator)){
                operator= JcrCondition.OPERATOR_LESS_THAN_OR_EQUALS;
            }else if( ">".equals(operator)){
                operator= JcrCondition.OPERATOR_GREATER_THAN;
            }else if( ">=".equals(operator)){
                operator= JcrCondition.OPERATOR_GREATER_THAN_OR_EQUALS;
            }else if( "LIKE".equalsIgnoreCase(operator)){
                operator= JcrCondition.OPERATOR_LIKE;
            }else{
                throw new ServiceException("Unsupported operator "+operator);
            }
        if (pageContext.getAttribute("jcr-conditions", PageContext.REQUEST_SCOPE )==null ){
            pageContext.setAttribute("jcr-conditions" , new ArrayList(), PageContext.REQUEST_SCOPE );
        }
        
        if(propertyName==null){
            pageContext.setAttribute("propertyPath", propertyPath, PageContext.PAGE_SCOPE);
%>
            <spring:bind path="${propertyPath}">
                <c:set var="requestValue" value="${status.value}"/>
            </spring:bind>
<%
            String obj =(String)pageContext.getAttribute("requestValue");
            if (obj!=null){
                propertyName = obj;
            }
        }

        
        
        if(value==null){
            pageContext.setAttribute("valuePath", valuePath, PageContext.PAGE_SCOPE);
%>
            <spring:bind path="${valuePath}">
                <c:set var="requestValue" value="${status.value}"/>
            </spring:bind>
<%
            Object obj =pageContext.getAttribute("requestValue");
            if (obj!=null){
                value = obj;
            }
        }
        if (value!=null && !value.equals("")){
            JcrCondition condition = new JcrCondition();
            condition.field(propertyName).value(value).setOperator(operator);
            ((ArrayList)pageContext.getAttribute("jcr-conditions", PageContext.REQUEST_SCOPE )).add(condition);
        }
    }catch(Exception e){
        e.printStackTrace();
    }
%>
