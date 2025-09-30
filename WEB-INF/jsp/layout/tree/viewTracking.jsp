<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>

<c:set var="inputViewName" scope="page" value="${tagutils:getInputViewParamName()}"/>
<c:set var="inputViewValue" scope="page" value="${tagutils:getInputViewParamValue(pageContext)}"/>

<script type="text/javascript">
    var formElement = document.forms[0];
    if(formElement && formElement != null) {
        var hiddenField = document.createElement("input");
        hiddenField.type = "hidden";
        hiddenField.id = "<c:out value="${inputViewName}"/>";
        hiddenField.name = "<c:out value="${inputViewName}"/>";
        hiddenField.value = "<c:out value="${inputViewValue}"/>";
        formElement.appendChild(hiddenField);
    }        
    
    var anchorFields = document.getElementsByTagName("a");
    if(anchorFields != null && anchorFields.length > 0) {
        var anchorField;
        var anchorHref;    
        var i=0;
        for (i=0; i<anchorFields.length; i++) {
            anchorField = anchorFields[i];            
            anchorHref = anchorField.href;

            if(anchorHref != null && anchorHref.length > 0) {
                if(anchorHref.indexOf("(") < 0) {
                    if(anchorHref.indexOf("?") >= 0) {
                        anchorHref = anchorHref + "&" + "<c:out value="${inputViewName}"/>" + "=" + "<c:out value="${inputViewValue}"/>";
                    } else {
                        anchorHref = anchorHref + "?" + "<c:out value="${inputViewName}"/>" + "=" + "<c:out value="${inputViewValue}"/>";
                    }                
                    anchorField.href = anchorHref;
                }
            }
        }
    }
</script>
