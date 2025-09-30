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
			<b>Vehículos Asignados Para Hoy</b>
			<hr class="red">
		</h1>
	</div>
</div>

<html:form modelAttribute="solicitudDTO" id="invocaRegistradasApp" action="vehiculoAsignado.do" acceptCharset="ISO_8859-1">
<input type="hidden" value="${accion}" 		id="accion"/>
<input type="hidden" value="${resultado}" 	id="resultado"/>

<c:if test="false">
	<table width="60%" align="center">
		<tr><td><fieldset>
		 <legend style="font-size:1.3em"><strong>&nbsp;&nbsp;Búsqueda de Solicitudes&nbsp;&nbsp; </strong></legend>
			<table align="center" width="100%">
				<tr>
				   <td align="right" class="label">Folio</td>
				   <td align="left">
						<fsn:input path="folio" uppercase="true" maxlength="10" size="30"/>
				   </td>
				</tr>
				<tr>
				   <td align="right" class="label">Fecha del servicio:</td>
				   <td align="left">
						<fsn:calendar path="fecha" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" />
				   </td>
				</tr>
				<tr>
					<td width="40%" class="label">Estatus:</td>
					<td>
			         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
				        <fsn:selectList beanName="selectEstadosSol" path="idEstado" appendFilters="false" progress="true" style="width:80%"/>
			         </td>
				</tr>
				<tr>
					<td width="40%" class="label">Punto Origen:</td>
					<td>
			         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
				        <fsn:selectList beanName="selectPunto" path="puntoSalida" appendFilters="false" progress="true" style="width:80%"/>
			         </td>
				</tr>
				<tr>
					<td width="40%" class="label">Punto Destino:</td>
					<td>
			         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
				        <fsn:selectList beanName="selectPunto" path="puntoLlegada" appendFilters="false" progress="true" style="width:80%"/>
			         </td>
				</tr>
				<tr>
					<td width="40%" class="label">Tipo Solicitud:</td>
					<td>
			         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
				        <fsn:selectList beanName="selectTipoSolicitud" path="idTipo" appendFilters="false" progress="true" style="width:80%"/>
			         </td>
				</tr>
			</table>
		</fieldset></td></tr>
		<tr><td>
			<table width="100%" align="center">
				<tr align="center">
					<td><fsn:submit value="submit.search" path="consulta" action="solicitudes/vehiculoAsignado.do"/></td>
				</tr>
			</table>
		</td></tr>
	</table>
</c:if>

<fsn:filter property="s.inmueble_fk" condition="=" value="${solicitudDTO.idInmueble}"/>
<fsn:pagedList beanName="BuscarVehiculoAsignar" baseUrl="vehiculoAsignado"  appendFilters="false"/>
<display:table name="BuscarVehiculoAsignar" class="displaytag" pagesize="20" id="pe" requestURI="${requestURI}" sort="list" style="text-align:center" export="false">	
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

