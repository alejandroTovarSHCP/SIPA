<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<body>
<html:form modelAttribute="solicitudDTO" id="solicitudAltaBienes" action="" method="post" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
	<input type="hidden" value="${solicitudDTO.idTipo}" 		id="tipoSolicitud"/>
	<input type="hidden" value="${solicitudDTO.chofer}" 		id="requiereChofer"/>
	<input type="hidden" value="${solicitudDTO.idSolicitud}" 	id="idSolicitud"/>
	<input type="hidden" value="${solicitudDTO.rutaRegreso}" 	id="rutaRegreso"/>
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h2><b>Información de la Solicitud</b></h2>
			<hr class="red">
		</div>
		<div class="panel-body">
			<table width="100%" cellpadding="5">
				<c:if test="${solicitudDTO.idEstado == 2}">
					<tr>
			            <td width="20%" class="label">Validada Por:</td>
			            <td>
			            	<fsn:input path="rfcValidador" uppercase="false" maxlength="24" size="30" readonly="true"/>
			            </td>
			        </tr>
				</c:if>
			
				<tr>
		            <td width="20%" class="label">Folio:</td>
		            <td>
		            	<fsn:input path="folio" uppercase="false" maxlength="24" size="30" readonly="true"/>
		            </td>
		        </tr>
			
				<tr>
		            <td width="20%" class="label">Fechas del servicio:</td>
		            <td>
		            	del:&nbsp; <fsn:input path="fecha" uppercase="false" maxlength="24" size="30" readonly="true"/> al:&nbsp;
		            	<fsn:input path="fechaFin" uppercase="false" maxlength="24" size="30" readonly="true"/>
		            </td>
		        </tr>
				
				<tr>
					<td width="20%" class="label">No de Pasajeros:</td>
					<td>
						<fsn:input path="pasajeros" uppercase="false" maxlength="24" size="30" readonly="true"/>
			    	</td>
				</tr>
				
				<tr>
					<td width="100%" class="label">Justificación de solicitud:</td>
					<td><fsn:textarea path="justificacion" uppercase="false" cols="75" rows="5" readonly="true"/></td>
				</tr>
				
				<tr>
					<td width="40%" class="label">*Vehículo:</td>
					<td>
						<fsn:filter property="INMUEBLE_FK" condition="=" path="idInmueble"/>
			         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
				        <fsn:selectList beanName="selectVehiculos" path="idVehiculo" appendFilters="false" progress="true" style="width:80%"/>
			         </td>
				</tr>
				
				<c:if test="${solicitudDTO.idTipo == 2}">					
					<tr>
						<td width="40%" class="label">*Requiere chofer:</td>
						<td>
				         	<input type="radio" name="chofer" value="1" disabled>Sí
				         	<input type="radio" name="chofer" value="0" disabled>No
				         </td>
					</tr>
				</c:if>
				
				<tr id="muestraOperador">
					<td width="40%" class="label">*Operador:</td>
					<td>
						<fsn:filter property="INMUEBLE_FK" condition="=" path="idInmueble"/>
			         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
				        <fsn:selectList beanName="selectOperadores" path="idOperador" appendFilters="false" progress="true" style="width:80%"/>
			         </td>
				</tr>
				
			</table>
	    </div>
	</div>				
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h2><b>Trayectos</b></h2>
			<hr class="red">
		</div>
			<div class="panel-body">
				<table width="100%">
					<tr style="background-color:#B5B0B0">
						<td align="center"><b>No</b></td>
						<td align="center"><b>Lugar de Origen</b></td>
						<td align="center"><b>Hora de salida</b></td>
						<td align="center"><b>Lugar de Destino</b></td>
						<td align="center"><b>Hora de llegada</b></td>
						<td align="center"><b>Justificación</b></td>
					</tr>
					
					<c:forEach var="row" items="${solicitudDTO.recorridos}">
                      	<tr style="background-color:#F0EAEA">
                      		<td align="center"> <c:out value="${row.orden}"/> </td>
							<td>
								<table border="0" width="100%">
									<c:set var="origen" value="${fn:split(row.direccionOrigenAux, '$')}" />
									 <tr> <td> <c:out value="${origen[0]}"/> </td> </tr>
								     <tr> <td> <c:out value="${origen[1]}"/> </td> </tr>
								     <tr> <td> <c:out value="${origen[2]}"/> </td> </tr>
								     <c:if test="${!empty origen[3]}">
								     	<tr> <td> <c:out value="${origen[3]}"/> </td> </tr>
								     </c:if>
								</table>
							</td>						
							<td align="center"> <c:out value="${row.salida}"/> hrs </td>
							<td>
								<table border="0" width="100%">
									<c:set var="destino" value="${fn:split(row.direccionDestinoAux, '$')}" />
									 <tr> <td> <c:out value="${destino[0]}"/> </td> </tr>
								     <tr> <td> <c:out value="${destino[1]}"/> </td> </tr>
								     <tr> <td> <c:out value="${destino[2]}"/> </td> </tr>
								     <c:if test="${!empty destino[3]}">
								     	<tr> <td> <c:out value="${destino[3]}"/> </td> </tr>
								     </c:if>
								</table>
							</td>
							<td align="center"> <c:out value="${row.llegada}"/> hrs </td>
							<td> <c:out value="${row.justRecorrido}"/> </td>
						</tr>
                   	</c:forEach>
			</table>
	    </div>
	</div>
	
	<div class="row">
		<div style="text-align: center">
			<br><br><br>
			<div id="btnEliminardd">
				<fsn:window name="eliminarSolicitud" uri="solicitudes/invocaEliminarSolicitud.do?idSolicitud=${solicitudDTO.idSolicitud}&rutaRegreso=${solicitudDTO.rutaRegreso}" image="delete.gif" width="500" height="200" title="Cancelar Solicitud" />
			</div>
			
			<input type="button" value="Cancelar" id="idBtnAux">&nbsp;&nbsp;
			<input type="button" value="Autorizar"  onclick="javascript:validaSolicitud();">&nbsp;&nbsp;
			<input type="button" value="Regresar a la consulta" onclick="javascript:regresar();">
		</div>
	</div>	
 
</html:form>
   	
</body>   	


<script type="text/javascript" defer src="../js/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/toastr.min.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer type="text/javascript">
	var $j = jQuery.noConflict();

	$j(document).ready(function() {
		$j("#btnEliminardd > span > a").hide();
	
		$j("input[name=chofer][value='0']").prop("checked",true);
		
		if($j('#requiereChofer').val() == 'true'){
			$j("input[name=chofer][value='1']").prop("checked",true);
		}
		
		if($j("#tipoSolicitud").val() == 2 && $j('#requiereChofer').val() == 'false'){
			$j("#muestraOperador").hide();
		}
		
		
		toastr.options = {
		  "closeButton": true,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": true,
		  "positionClass": "toast-top-right",
		  "preventDuplicates": false,
		  "onclick": null,
		  "showDuration": "300",
		  "hideDuration": "1000",
		  "timeOut": "5000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		}
	});
	
	function muestraAdvertenciaMotivo(){
		Command: toastr["warning"]("Debe seleccionar un motivo de cancelación.");
	}
	
	
	function modalEliminacion(idSolicitud, resultado, mensaje){
		var cierre = "function closeDiveliminarSolicitud(){var onCloseFunction = '';if(onCloseFunction.length>0){window.parent.eval(onCloseFunction);}" + 
        			 "document.getElementById('diveliminarSolicitud').style.visibility='hidden';document.getElementById('frameeliminarSolicitud').src=''; mensaje}";
   		cierre = cierre.replace("mensaje", "Command: toastr['" + resultado + "']('"+ mensaje +"', 'Solicitud')");
		eval(cierre);
		eval("closeDiveliminarSolicitud()");
		
		if(resultado == "success"){
			$j("#diveditarSolicitud" + idSolicitud).closest("tr").remove();
			
			setTimeout(function() {
				window.location.href = $j("#rutaRegreso").val();
			}, 3000);
		}
	}
	
	
	function validaSolicitud(){
   		if(confirm("¿Desea validar la solicitud?") == true){
	   		var tipoSolicitud  	= $j("#tipoSolicitud").val();
	   		var requiereChofer 	= $j("#requiereChofer").val();
	   		var idOperador 		= $j("#idOperador").val();
	   		var idVehiculo 		= $j("#idVehiculo").val();
	   		var idSolicitud	   	= $j("#idSolicitud").val();
	   		var solicitud 		= null;
	   		var form 			= new FormData();   		
	   		
	   		if(tipoSolicitud == 1){
	   			if(idOperador == -1 || idVehiculo == -1){
	   				Command: toastr["warning"]("Debe asignar un Operador y un Vehiculo", "Solicitud");
	   				return;
	   			}
	   			
	       		form.append('idSolicitud', idSolicitud);
	       		form.append('idOperador', idOperador);
	       		form.append('idVehiculo', idVehiculo);
	   			
	   		}else if(tipoSolicitud == 2){
	   			if(requiereChofer == 'true' && idOperador == -1){
					Command: toastr["warning"]("Debe asignar un Operador", "Solicitud");
	   				return;
				}
				
				if(idVehiculo == -1){
	   				Command: toastr["warning"]("Debe asignar un Vehiculo", "Solicitud");
	   				return;
	   			}
	   			
	       		form.append('idSolicitud', idSolicitud);
	       		form.append('idOperador', idOperador);
	       		form.append('idVehiculo', idVehiculo);
	   		}
	   		
			$j.ajax({
				url: 'autorizaSolicitud.do',
				type: 'POST',
				data: form,
				processData: false,
		        contentType: false,
		        cache: false, 
				success : function(data) {
					Command: toastr[data[0]](data[1], "Solicitud");
					
					if(data[0] == "success"){
						setTimeout(function() {
							window.location.href = $j("#rutaRegreso").val();
						}, 3000);
					}
				}
			});
		}
   	}
   	
   	
   	function regresar() {
      window.location.href = $j("#rutaRegreso").val();
    }
	
	
	$j('#idBtnAux').click(function(e){
    	$j("#btnEliminardd > span > a")[0].click();
    });
    
    
    $j('#idVehiculo').change(function () {
	    $j.ajax({
			url: 'verificaVehiculoAsignado.do',
			type: 'POST',
			data: {idVehiculo: $j('#idVehiculo').val()},
			success : function(data) {
				if(data.length > 0){
					Command: toastr["warning"](data, "Vehículo Asignado Hoy a las:");
				}
			}
		});
	});
	
	
	$j('#idOperador').change(function () {
	    $j.ajax({
			url: 'verificaOperadorAsignado.do',
			type: 'POST',
			data: {idOperador: $j('#idOperador').val()},
			success : function(data) {
				if(data.length > 0){
					Command: toastr["warning"](data, "Operador Asignado Hoy a las:");
				}
			}
		});
	});
    
	
</script>

