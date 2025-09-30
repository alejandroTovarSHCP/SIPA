<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<!-- Viene de la vista y controller editaLocalizacionEmergente -->
<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
			<div class="panel-heading"><h2><b>EDITAR VEHICULO</b></h2></div>
		</div>
	</div>
</div>
   	
<html:form modelAttribute="vehiculoDTO" id="editaVehiculo" name="editaVehiculo" action="" method="post" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
	<input type="hidden" value="${vehiculoDTO.idVehiculo}" id="idVehiculo" name="idVehiculo"/>
	<input type="hidden" value="${vehiculoDTO.blindado}" id="checkBlindado"/>
	<input type="hidden" value="${vehiculoDTO.taller}" id="checkTaller"/>
	
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
				
				<fsn:submit value="Editar" path="guardar" action="vehiculos/editarVehiculo.do"/>
													
			</td>
		</tr>	
	</table>
     
</html:form>
   	
   	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	var $j = jQuery.noConflict();
	
	$j( document ).ready(function() {
		
		$j("input[name=blindado][value='0']").prop("checked",true);
		$j("input[name=taller][value='0']").prop("checked",true);
		//$j("input[name=activo][value='0']").prop("checked",true);
		
		if($j('#checkBlindado').val() == 'true'){
			$j("input[name=blindado][value='1']").prop("checked",true);
			console.log("Entro blindado");
		}
		
		if($j('#checkTaller').val() == 'true'){
			$j("input[name=taller][value='1']").prop("checked",true);
			console.log("Entro taller");
		}
	
	});

</script>

