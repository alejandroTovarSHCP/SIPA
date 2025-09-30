<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>



<fsn:filter property="tipoConsulta" condition="=" path="tipoConsulta" value="OPERADORES"/>
<fsn:pagedList service="gob.shcp.sipa.service.DashBoardService" baseUrl="invocaConductoresModal" />

<div style="width: 100%;">
  <button style="width: 100%; height: 20px;" onclick="javascript:parent.redirigir('')">Conductores</button>
</div>

<display:table name="DashBoardService" class="displaytag" pagesize="20" id="pe" requestURI="${requestURI}" sort="list" style="text-align:center" export="false">	
	    <display:column titleKey="sipa.consulta.dashboard.columna0" property="nombre" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.dashboard.columna1" property="trayectosRealizados" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.dashboard.columna2" property="kmPromTrayecto" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.dashboard.columna3" property="kmTotal" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.dashboard.columna4" property="combustibleConsumido" maxLength="50" style="text-align:center"/>
    
    <display:setProperty name="paging.banner.placement" value="bottom"/> 
    <display:setProperty name="export.excel" value="true"/>
    <display:setProperty name="export.pdf" value="true"/>
    <display:setProperty name="export.excel.filename" value="MisSolicitudes.xls"/>
    <display:setProperty name="export.pdf.filename" value="MisSolicitudes.pdf"/> 
    <display:setProperty name="basic.msg.empty_list">
    	<br><span class="pagebanner">&nbsp;</span><span class="norecords"><spring:message code="pagedList.empty.content"/><br><br></span>
    </display:setProperty>
</display:table>
