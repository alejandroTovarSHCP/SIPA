<%@ tag import="java.util.List" %>
<%@ tag import="gob.shcp.bpm.model.DiagramInfoDTO" %>
<%@ tag import="gob.shcp.bpm.model.DiagramNodeInfoDTO" %>
<%@ tag import="gob.shcp.bpm.model.TokenDTO" %>
<%@ tag import="gob.shcp.fsn.control.view.util.TagUtils" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- BPM -->       
<link type="text/css" rel="stylesheet" href="<spring:theme code="bpm.css"/>"/>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@ attribute name="url"%>
<%@ attribute name="parentWidth"%>
<%@ attribute name="parentHeight"%>
<%@ attribute name="leftPosition"%>
<%@ attribute name="topPosition"%>

<%
try {
    String action = (url != null && !"".equals(url.trim())) ? url : "/fsnjbpm/service/bpmImage";
    final String reloadController = (String)request.getAttribute("reloadController");
    String uri = "/fsnjbpm/" + reloadController.substring(0, reloadController.lastIndexOf("/")) + "/showParentProcessImage.do";
    String params = null;
    parentWidth = parentWidth == null ? "800" : parentWidth;
    parentHeight = parentHeight == null ? "600" : parentHeight;
    leftPosition  = leftPosition == null  ? "15" : leftPosition;
    topPosition = topPosition == null ? "15" : topPosition;
    Integer htmlElementUniqueID = TagUtils.getHtmlUniqueId(pageContext);
%>
    <c:url value="<%=action%>" var="_action" scope="page"/>
    <c:url value="<%=uri%>" var="_uri" scope="page"/>
    <c:set var="idProcessInstance" scope="page" value="${param['idProcessInstance']}"/>
<%    
    action = (String)pageContext.getAttribute("_action", PageContext.PAGE_SCOPE);
    uri = (String)pageContext.getAttribute("_uri", PageContext.PAGE_SCOPE);
    final String idProcessInstance = (String)pageContext.getAttribute("idProcessInstance", PageContext.PAGE_SCOPE);
    final long processInstanceId = idProcessInstance != null ? Long.valueOf(idProcessInstance) : 0;
    final DiagramInfoDTO diagramInfo = (DiagramInfoDTO)request.getAttribute("processDiagramInfoDTO");
    if(diagramInfo != null) {
	String style="position:relative;height:"+diagramInfo.getHeight()+"px;width:"+diagramInfo.getWidth()+"px;";
        if (diagramInfo.getIdParentProcessInstance() > 0)  {
%>
        <input id="<%=htmlElementUniqueID%>" type="button" value="Ver proceso padre" class="uppercase" path="" onclick="javascript:showDiv<%=htmlElementUniqueID%>();"/>
        <br><br/>
<%
        }
%>
        
	<div style="<%=style%>">
	    <img alt="Process Diagram" src="<%=action%>?idProcessInstance=<%=processInstanceId%>" style="position:absolute;top:0;left:0"/>
<%
            TokenDTO token = null;
            DiagramNodeInfoDTO node = null;
            final List tokenList = diagramInfo.getTokens();
	    for(int x = 0; x < tokenList.size(); x++) {
	        token = (TokenDTO)tokenList.get(x);
     		node = (DiagramNodeInfoDTO)diagramInfo.getNodeMap().get(token.getNode().getName());
     		style="top:"+(node.getY()-12)+"px;left:"+(node.getX()+2)+"px;width:"+(node.getWidth()-3)+"px;height:"+(node.getHeight()+11)+"px";
                String styleClass = "pboxs";
                if(token.getEnd() != null) {
                    styleClass = "pboxs_e";
                }
                if(token.isSuspended()) {
                    styleClass = "pboxs_s";
                }
%>
                <div style="<%=style%>" class="<%=styleClass%>">
                </div>
<%
                style = "top:"+node.getY()+"px;left:"+node.getX()+"px;width:"+(node.getWidth()-3)+"px;height:"+(node.getHeight()-3)+"px";
                styleClass = "pbox";
                if(token.getEnd() != null) {
                    styleClass = "pbox_e";
                }
                if(token.isSuspended()) {
                    styleClass = "pbox_s";
                }
%>
                <div style="<%=style%>" class="<%=styleClass%>">
                </div>
<%
                style = "top:"+(node.getY()-14)+"px;left:"+node.getX()+"px;width:"+(node.getWidth()-1)+"px";
         	styleClass = "pboxc";
         	if(token.getEnd() != null) {
    		    styleClass = "pboxc_e";
                }
    		if (token.isSuspended()) {
                    styleClass = "pboxc_s";
                }
%>
                <div style="<%=style%>" class="pboxce">
                    <div class="<%=styleClass%>">
<%
                        String status = "";
                        if(token.getEnd() == null && !token.isSuspended()) {
                            status = "En Ejecucion";
                        }
                        if(token.getEnd() == null && token.isSuspended()) {
                            status = "Suspendido";
                        }
                        if(token.getEnd() != null) {
                            status = "Terminado";
                        }
                        if(token.getName() != null) {
                            status += " \""+token.getName()+"\"" ;
                        }
%>
                        <a href="#?id=<%=(token.getId()+"")%>">
                            <%=status%>
                        </a>
                    </div>
                </div>
<%
            }
%>
        </div>
<%

        if (diagramInfo.getIdParentProcessInstance() > 0)  {
            params = "?idProcessInstance=" + diagramInfo.getIdParentProcessInstance();
%>
            <br/>
            <input id="<%=htmlElementUniqueID%>" type="button" value="Ver proceso padre" class="uppercase" path="" onclick="javascript:showDiv<%=htmlElementUniqueID%>();"/>
            <div id="div<%=htmlElementUniqueID%>" class="popup">
                <table border="0" width="250" bgcolor="#3C3C3C" cellspacing="0" cellpadding="5">
                    <tr>
                        <td width="100%">
                            <table border="0" width="100%" cellspacing="0" cellpadding="0" height="36">
                                <tr>
                                    <td style="cursor:move" width="100%" onmousedown="javascript:comienzoMovimiento(event, 'div<%=htmlElementUniqueID%>');">
                                        <font color=#ffffff size=2 face=Montserrat-Regular  style="text-decoration:none" ><spring:message code="Imagen del proceso" text="Imagen del proceso" /></font>
                                    </td>
                                    <td style="cursor:hand" valign="top" align="right">
                                        <a href="#" onClick="closeDiv<%=htmlElementUniqueID%>();return false"><font color=#ffffff size=2 face=Montserrat-Regular  style="text-decoration:none">X</font></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%" bgcolor="#FFFFFF" style="padding:4px" colspan="2">
                                        <iframe style="height:<%=parentHeight%>px;width:<%=parentWidth%>px;border-style:none;" src="" name="frame<%=htmlElementUniqueID%>" id="frame<%=htmlElementUniqueID%>">
                                        </iframe>
                                    </td>
                                </tr>
                            </table> 
                        </td>
                    </tr>
                </table>
            </div>
<%
        }
        
    } else {
%>
        No diagram info has been found. Please ensure you call proper bpm service method from controller that dispatched this page.
<%
    }
%>
<script type="text/javascript" >
    function showDiv<%=htmlElementUniqueID%>() {
        if (document.getElementById("div<%=htmlElementUniqueID%>").style.visibility == "visible"){
            document.getElementById('div<%=htmlElementUniqueID%>').style.visibility="hidden";
        } else {
            centerInScreen(document.getElementById("div<%=htmlElementUniqueID%>"), '<%=leftPosition%>', '<%=topPosition%>');
            var frame = document.getElementById("frame<%=htmlElementUniqueID%>");
            
            frame.src="<%=uri+params%>";
            document.getElementById('div<%=htmlElementUniqueID%>').style.visibility = "visible";
        }
    }
    
    function closeDiv<%=htmlElementUniqueID%>() {                                
        var onCloseFunction = "";
        if(onCloseFunction.length>0) {            
            window.parent.eval(onCloseFunction);            
        }
        document.getElementById('div<%=htmlElementUniqueID%>').style.visibility="hidden";
        document.getElementById('frame<%=htmlElementUniqueID%>').src="";
    }
    carga();
</script>
<%
} catch(Exception e) {
    e.printStackTrace();
}
%>
