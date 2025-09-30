<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
			<div class="panel-heading"><h2><b>AGREGAR VEHICULO</b></h2></div>
		</div>
	</div>
</div>
   	
<html:form modelAttribute="vehiculoDTO" id="registraVehiculo" name="registraVehiculo" action="" method="post" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
	<table border="0" width="100%">
		<tr>
			<td width="40%" class="label">Placas:</td>
			<td><fsn:input  path="placas" uppercase="false" maxlength="10" size="20" />   </td>
		</tr>
	
		<tr>
			<td width="40%" class="label">Marca:</td>
			<td><fsn:input  path="marca" uppercase="false" maxlength="15" size="20" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Modelo:</td>
			<td><fsn:input  path="modelo" uppercase="false" maxlength="15" size="20" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Año:</td>
			<td><fsn:input  path="anio" uppercase="false" maxlength="4" size="20" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Color:</td>
			<td><fsn:input  path="color" uppercase="false" maxlength="15" size="20" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">No Pasajeros:</td>
			<td><fsn:input  path="pasajeros" uppercase="false" maxlength="4" size="20" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Combustible:</td>
			<td><fsn:input  path="combustible" uppercase="false" maxlength="15" size="20" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Naturaleza:</td>
			<td><fsn:input  path="naturaleza" uppercase="false" maxlength="10" size="20" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Blindado:</td>
			<td>
	         	<input type="radio" name="blindado"  value="1">Si
	         	<input type="radio" name="blindado"  value="0">No
	         </td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Taller:</td>
			<td>
	         	<input type="radio" name="taller"  value="1">Si
	         	<input type="radio" name="taller"  value="0">No
	         </td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Estatus:</td>
			<td>
	         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
		        <fsn:selectList beanName="selectEstatusCatalogos" path="idEstado" appendFilters="false" progress="true" style="width:80%"/>
	         </td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Tipo:</td>
			<td>
			    <fsn:option key="-1" value="selectList.nonValue" />		      	  
		        <fsn:selectList beanName="selectTipoVehiculo" path="idTipo" appendFilters="false" progress="true" style="width:80%"/>
			</td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Inmueble:</td>
			<td>
			    <fsn:option key="-1" value="selectList.nonValue" />		      	  
		        <fsn:selectList beanName="selectInmueble" path="idInmueble" appendFilters="false" progress="true" style="width:80%"/>
			</td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Justificación:</td>
			<td><fsn:textarea path="justificacion" uppercase="false" cols="75" rows="5"/></td>
		</tr>
		
		<tr>			
			<td colspan=2 align="center">
				
				<fsn:submit value="Guardar" path="guardar" action="vehiculos/registraNuevoVehiculo.do"/>
													
			</td>
		</tr>		
	</table>
     
</html:form>
