<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>

<fsn:filter property="tipoConsulta" condition="=" path="tipoConsulta" value="SERVICIOS"/>
<fsn:pagedList service="gob.shcp.sipa.service.DashBoardService" baseUrl="invocaServiciosModal" />

<div style="width: 100%;">
  <button style="width: 100%; height: 20px;" onclick="javascript:parent.redirigir('/sipa/servicios/initHistServicios.do')">Servicios</button>
</div>

<display:table name="DashBoardService" class="displaytag" pagesize="20" id="pe" requestURI="${requestURI}" sort="list" style="text-align:center" export="false">	
	    <display:column titleKey="sipa.consulta.dashboard.servicios.columna0" property="nombre" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.dashboard.servicios.columna1" property="preventivos" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.dashboard.servicios.columna2" property="correctivos" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.dashboard.servicios.columna3" property="ambos" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.dashboard.servicios.columna4" property="kmDesdeUltimoPreventivo" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.dashboard.servicios.columna5" property="mesesDesdeUltimoPreventivo" maxLength="50" style="text-align:center"/>
    
    <display:setProperty name="paging.banner.placement" value="bottom"/> 
    <display:setProperty name="export.excel" value="true"/>
    <display:setProperty name="export.pdf" value="true"/>
    <display:setProperty name="export.excel.filename" value="MisSolicitudes.xls"/>
    <display:setProperty name="export.pdf.filename" value="MisSolicitudes.pdf"/> 
    <display:setProperty name="basic.msg.empty_list">
    	<br><span class="pagebanner">&nbsp;</span><span class="norecords"><spring:message code="pagedList.empty.content"/><br><br></span>
    </display:setProperty>
</display:table>
