<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>

<div class="panel panel-default">
	<div class="panel-heading">
		<h1>
			<b>Vehículos No Asignados Para Hoy</b>
			<hr class="red">
		</h1>
	</div>
</div>

<html:form modelAttribute="solicitudDTO" id="invocaRegistradasApp" action="vehiculoNoAsignado.do" acceptCharset="ISO_8859-1">
<fsn:filter property="v.inmueble_fk" condition="=" value="${solicitudDTO.idInmueble}"/>
<fsn:filter property="s.inmueble_fk" condition="=" value="${solicitudDTO.idInmueble}"/>
<fsn:pagedList beanName="BuscarVehiculoSinAsignar" baseUrl="vehiculoNoAsignado"  appendFilters="false"/>
<display:table name="BuscarVehiculoSinAsignar" class="displaytag" pagesize="20" id="pe" requestURI="${requestURI}" sort="list" style="text-align:center" export="false">	
	    <display:column titleKey="sipa.consulta.vehiculos.columna0" property="placas" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna1" property="marca" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna2" property="modelo" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna3" property="anio" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna4" property="combustible" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna5" property="kilometraje" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna6" property="nivel_combustible" maxLength="50" style="text-align:center"/>
    <display:setProperty name="paging.banner.placement" value="bottom"/> 
    <display:setProperty name="export.excel" value="true"/>
    <display:setProperty name="export.pdf" value="true"/>
    <display:setProperty name="export.excel.filename" value="vehiculoSinAsignar.xls"/>
    <display:setProperty name="export.pdf.filename" value="vehiculoSinAsignar.pdf"/> 
    <display:setProperty name="basic.msg.empty_list">
    	<br><span class="pagebanner">&nbsp;</span><span class="norecords"><spring:message code="pagedList.empty.content"/><br><br></span>
    </display:setProperty>
</display:table>
</html:form>

