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
			<div class="panel-heading"><h2><b>DESEA ELIMINAR EL SIGUIENTE VEHICULO:</b></h2></div>
		</div>
	</div>
</div>
   	
<html:form modelAttribute="vehiculoDTO" id="eliminaVehiculo" name="eliminaVehiculo" action="" method="post" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
	<input type="hidden" value="${vehiculoDTO.idVehiculo}" id="idVehiculo" name="idVehiculo"/>
	
	<table border="0" width="100%">
		<tr>
			<td>
			Placas: ${vehiculoDTO.placas}<br>
			Marca: ${vehiculoDTO.marca}<br>
			Modelo: ${vehiculoDTO.modelo}<br>
			Color: ${vehiculoDTO.color}<br>
			</td>
		</tr>
		
		<tr>			
			<td colspan=2 align="center">
				<fsn:submit value="Eliminar" action="vehiculos/eliminarVehiculo.do"/>							
			</td>
		</tr>	
		
	</table>
     
</html:form>
