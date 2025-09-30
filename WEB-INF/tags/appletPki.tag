
<%@ attribute name="opcType"%>
<%@ attribute name="isFile"%>
<%@ attribute name="showRfc"%>
<%@ attribute name="showCurp"%>
<%@ attribute name="skipAlert"%>
<%@ attribute name="forSubjectRcpt"%>
<%@ attribute name="saveToFile"%>
<%@ attribute name="appletUrl" required="true"%>
<%@ attribute name="isMultipleContent"%>
<%@ attribute name="javaArgs"%>
<%@ attribute name="width"%>
<%@ attribute name="height"%>

<%
    width = width != null ? width : "620";
    height = height != null ? height : "500";
    opcType = opcType != null ? opcType : "0";
    isFile = isFile != null ? isFile : "false";
    showRfc = showRfc != null ? showRfc : "false";
    showCurp = showCurp != null ? showCurp : "false";
    skipAlert = skipAlert != null ? skipAlert : "false";
    forSubjectRcpt = forSubjectRcpt != null ? forSubjectRcpt : "false";
    saveToFile = saveToFile != null ? saveToFile : "false";
    isMultipleContent = isMultipleContent != null ? isMultipleContent : "false";
%>
<script type="text/javascript" src="<%=appletUrl%>/js/pki/pki-applet.js"></script>

<table align="center">
    <tr>
        <td>
<script type="text/javascript"> 

    var params = new Array(8);
            params[0] = "opcType";
            params[1] = "isFile";
            params[2] = "showRfc";
            params[3] = "skipAlert";
            params[4] = "forSubjectRcpt";
            params[5] = "saveToFile";
            params[6] = "showCurp";
            params[7] = "isMultipleContent";
    var values = new Array(8);
            values[0] = "<%=opcType%>";
            values[1] = "<%=isFile%>";
            values[2] = "<%=showRfc%>";
            values[3] = "<%=skipAlert%>";
            values[4] = "<%=forSubjectRcpt%>";
            values[5] = "<%=saveToFile%>";
            values[6] = "<%=showCurp%>";
            values[7] = "<%=isMultipleContent%>";

    var appletTags = getDefaultAppletTag("PKI", "<%=appletUrl%>", "<%=width%>", "<%=height%>", params, values, "<%=javaArgs%>");
    document.writeln("<br/>" + appletTags);    
    
</script>
        </td>
    </tr>
</table>
