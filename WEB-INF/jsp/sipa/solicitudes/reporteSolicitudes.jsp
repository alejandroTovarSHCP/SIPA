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
			<b>Reporte de Solicitudes</b>
			<hr class="red">
		</h1>
	</div>
</div>

<html:form modelAttribute="solicitudDTO" id="invocaRegistradasApp" action="invocaSolicitudesApp.do" acceptCharset="ISO_8859-1">

<table width="60%" align="center">
	<tr><td><fieldset>
	 <legend style="font-size:1.3em"><strong>&nbsp;&nbsp;Búsqueda de Solicitudes&nbsp;&nbsp; </strong></legend>
		<table align="center" width="100%">
			<tr>
			   <td align="right" class="label">Folio</td>
			   <td align="left">
					<fsn:input path="folio" uppercase="true" maxlength="10" size="60"/>
			   </td>
			</tr>
			<tr>
			   <td align="right" class="label">Fecha Inicial:</td>
			   <td align="left">
					<fsn:calendar path="fecha" size="40" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" />
			   </td>
			</tr>
			<tr>
			   <td align="right" class="label">Fecha Final:</td>
			   <td align="left">
					<fsn:calendar path="fechaFin" size="40" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" />
			   </td>
			</tr>
			<tr>
				<td width="40%" class="label">Estatus:</td>
				<td>
		         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
			        <fsn:selectList beanName="selectEstadosSol" path="idEstado" appendFilters="false" progress="true" style="width:80%"/>
		         </td>
			</tr>
			<!-- <tr>
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
			</tr> -->
			<tr>
				<td width="40%" class="label">Unidad Administrativa:</td>
				<td>
					<fsn:option key="" value="selectList.nonValue" />
					<fsn:selectList beanName="catUnidadAdmin" uppercase="false" path="cveUnidad" progress="true" style="width:80%"/>  
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
</table>

		<table width="60%" align="center">
			<tr><td><fieldset>
				 <legend style="font-size:1.3em"><strong>&nbsp;&nbsp;Reporte de Solicitudes&nbsp;&nbsp; </strong></legend>
					<table  class="table table-dark table-striped" align="center">
				        <tr>
							<td width="20%" class="label">*<spring:message code="sigma.alta.reporte.imprimeReporte"/>:</td>
				        	<td style="background-color:rgb(158, 0, 22);">
				    			<fsn:submit cssClass="btn btn-secondary" value="IMPRIMIR" path="buscarResgu" action="solicitudes/generarReporteSolicitud"  progressIcon="false" />
				    		</td>
				    	</tr>
				    </table>
			</fieldset></td></tr>
		</table> 	

</html:form>




