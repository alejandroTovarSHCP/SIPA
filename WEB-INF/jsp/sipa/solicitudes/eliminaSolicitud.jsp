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
			<div class="panel-heading"><h2><b>DESEA CANCELAR LA SIGUIENTE SOLICITUD:</b></h2></div>
		</div>
	</div>
</div>
   	
<html:form modelAttribute="solicitudDTO" id="eliminaSolicitud" name="eliminaSolicitud">
	<input type="hidden" value="${solicitudDTO.idSolicitud}" id="idSolicitud" name="idSolicitud"/>
	<input type="hidden" value="${solicitudDTO.rolUsuario}" id="rolUsuario" name="rolUsuario"/>
	
	<table border="0" width="100%">
		<tr>
			<td>
			Folio: ${solicitudDTO.folio}<br>
			Fecha del servicio: ${solicitudDTO.fecha}<br>
			Pasajeros: ${solicitudDTO.pasajeros}<br><br>
			</td>
		</tr>
		
		<c:if test="${solicitudDTO.rolUsuario != 'FUNCIONARIO'}">
			<tr>
				<td width="20%" class="label">*Motivo:</td>		
				<td align="center">
					<fsn:option key="-1" value="selectList.nonValue" />		      	  
					<fsn:selectList beanName="selectEstadosCancelacion" path="idEstado" appendFilters="false" progress="true" style="width:100%"/>
				</td>
			</tr>
		</c:if>
		
		<tr>			
			<td colspan=2 align="center">
				<br>
				<input type="button" value="Cancelar Solicitud" onclick="eliminarSolicitud();">				
			</td>
		</tr>
	</table>
</html:form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer type="text/javascript">
	var $j = jQuery.noConflict();
   	
   	function eliminarSolicitud(){   	
   		var idSolicitud = $j("#idSolicitud").val();
   		var rolUsuario = $j("#rolUsuario").val();
   		var idEs = 10; //cambiar id
   		
   		if(rolUsuario == "COORDINADOR"){
   			idEs = $j("[name='idEstado']").val();
   			
   			if(idEs == -1){
	   			parent.muestraAdvertenciaMotivo();
	   			return;
   			}
   		}
   	
   		$j.ajax({
			url: 'eliminarSolicitud.do',
			type: 'POST',
			data: {
				idSolicitud: idSolicitud,
				idEstado: idEs
			},			        
			success : function(data) {
				parent.modalEliminacion(idSolicitud, data[0], data[1]);
			}
		 });
   	}
</script>   
    

