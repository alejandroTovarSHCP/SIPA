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
	<input type="hidden" value="${solicitudDTO.chofer}" 	 id="requiereChofer"/>
	<input type="hidden" value="${solicitudDTO.idSolicitud}" id="idSolicitud"/>
	<input type="hidden" value="${solicitudDTO.rutaRegreso}" id="rutaRegreso"/>
	<input type="hidden" value="${solicitudDTO.idEstado}" 	 id="idEstado"/>
	<input type="hidden" value="${solicitudDTO.folio}" 	 	 id="folioSolicitud"/>
	
	
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h2><b>Información de la Solicitud de préstamo</b></h2>
			<hr class="red">
		</div>
		<div class="panel-body">
			<table width="100%" cellpadding="5">
				<tr>
		            <td width="20%" class="label">Estatus:</td>
		            <td>
		            	<fsn:input path="descEstado" uppercase="false" maxlength="24" size="30" readonly="true"/>
		            </td>
		        </tr>
		        <tr>
		            <td width="20%" class="label">Solicitante:</td>
		            <td>
		            	<fsn:input path="nombreSolicitante" uppercase="false" maxlength="24" size="30" readonly="true"/>
		            </td>
		        </tr>
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
					<td> <fsn:input path="pasajeros" uppercase="false" maxlength="24" size="30" readonly="true"/> </td>
				</tr>
				
				<tr>
					<td width="100%" class="label">Justificación de solicitud:</td>
					<td> <fsn:textarea path="justificacion" uppercase="false" cols="75" rows="5" readonly="true"/> </td>
				</tr>
				
				<c:if test="${solicitudDTO.idEstado != 1}">
					<tr>
						<td width="40%" class="label">Vehículo:</td>
						<td>
				         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
					        <fsn:selectList beanName="selectVehiculos" path="idVehiculo" style="width:80%" disabled="true"/>
				         </td>
					</tr>
				</c:if>
				<c:if test="${solicitudDTO.idEstado == 2}">
					<tr>
						<td width="40%" class="label">Evidencia de Salida:</td>
						<td>
				         	<input type="file" id="evidencia" accept=".pdf" size="50"/>
				         </td>
					</tr>
				</c:if>
				
				<c:if test="${solicitudDTO.idEstado >= 3}">
					<tr>
						<td width="40%" class="label">Evidencia de Llegada:</td>
						<td>
							<c:if test="${solicitudDTO.tieneEvidencia}">
								<a href="descargaEvidencia.do?folio=${solicitudDTO.folio}&tipo=ENTREGA"> Descargar Evidencia
									<img alt="Evidencia" src="<spring:theme code="download.gif"/>" height="20" width="20"/>
								</a>
							</c:if>
							
							<c:if test="${!solicitudDTO.tieneEvidencia}">
								Sin Evidencia de Llegada.
							</c:if>
				         </td>
					</tr>
				</c:if>
				
				<tr>
					<td width="40%" class="label">Evidencia de Llegada:</td>
					<td>
			         	<input type="file" id="evidenciaRecepcion" accept=".pdf" size="50"/>
			         </td>
				</tr>
				
				<c:if test="${solicitudDTO.idTipo == 2}">
					<tr>
						<td width="40%" class="label">Requiere chofer:</td>
						<td>
				         	<input type="radio" name="chofer" value="1" disabled>Sí
				         	<input type="radio" name="chofer" value="0" disabled>No
				         </td>
					</tr>
				</c:if>
				
				<c:if test="${solicitudDTO.idEstado != 1}">
					<tr id="muestraOperador">
						<td width="40%" class="label">Operador:</td>
						<td>
				         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
					        <fsn:selectList beanName="selectOperadores" path="idOperador" style="width:80%" disabled="true"/>
				         </td>
					</tr>
				</c:if>
				
			</table>
	    </div>
	</div>				
	
	<br><br>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h2><b>Trayectos Solicitados de Préstamo</b></h2>
			<hr class="red">
		</div>
		<div class="panel-body">
			<table width="100%">
				<tr style="background-color:#F0EAEA">
					<th align='center'><b>No</b></<th>
					<th align='center'><b>Lugar de Origen</b></<th>
					<th align='center'><b>Hora de salida</b></<th>
					<th align='center'><b>Lugar de Destino</b></<th>
					<th align='center'><b>Hora de llegada</b></<th>
					<th align='center'><b>Justificación</b></<th>
				</tr>
				
				<c:forEach var="row" items="${solicitudDTO.recorridos}">
                     	<tr style="background-color:#F0EAEA">
                     		<td align='center'>
							<c:out value="${row.orden}"/>
						</td>
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
									
						<td align='center'> <c:out value="${row.salida}"/> hrs. </td>
						
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
						<td align='center'> <c:out value="${row.llegada}"/> hrs. </td>
						<td> <c:out value="${row.justRecorrido}"/> </td>
					</tr>
				</c:forEach>
			</table>
    	</div>
	</div>

</html:form>

<html:form modelAttribute="realizadoDTO" action="" method="post" enctype="multipart/form-data" acceptCharset="ISO_8859-1">

<br><br>
<div class="panel panel-default">
	<div class="panel-heading">
		<h2><b>Registro de la Información de salida del préstamo del vehículo y llegada de entrega del vehículo.</b></h2>
		<hr class="red">
	</div>
	<div class="panel-body">
		<div style="text-align: center;">
			<img id="indicadorNivel" style="width: 140px; height: auto;" src='../images/nivelCombustible.jpg' alt="Nivel Combustible"><br>
		</div>
		<table width="100%">
			<tr style="background-color:#F0EAEA">
				<th align='center' colspan="6" class="entregaTh"><h3><b><i>Información de salida de préstamo del vehículo</i></b></h3></th>
				<th align='center' colspan="4"><h3><b><i>Información de llegada de entrega del vehículo</i></b></h3></th>
			</tr>
			<tr style="background-color:#F0EAEA">
				<th class='ocultaOperador' align='center'><b>Operador</b></<th>
				<th align='center'><b>Vehiculo</b></<th>
				<th align='center'><b>Lugar de salida</b></<th>
				<th align='center'><b>Hora de salida</b></<th>
				<th align='center'><b>Km Inicial</b></<th>
				<th align='center'><b>Combustible (Octavos)</b></<th>
				<th align='center'><b>Lugar de llegada</b></<th>
				<th align='center'><b>Hora de llegada</b></<th>
				<th align='center'><b>Km Final</b></<th>
				<th align='center'><b>Combustible (Octavos)</b></<th>
			</tr>
		
			<tr class="realizado">
				<c:if test="${solicitudDTO.idEstado == 3}">
					<div class="consultado">
						<c:forEach var="row" items="${solicitudDTO.realizados}">
	                      		<td class="ocultaOperador" align='center'>
									<c:out value="${row.operadorTxt}"/>
								</td>
								<td align='center'>
									<input type="hidden" value="${row.idVehiculo}" id="vehiculoPrestado"/>
									<c:out value="${row.vehiculoTxt}"/>
								</td>
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
								<td align='center'> <c:out value="${row.salida}"/> hrs. </td>
								<td align='center'> <c:out value="${row.kmIni}"/> </td>
								<td align='center'> <c:out value="${row.combustibleEntrega}"/> </td>
	                   	</c:forEach>
					</div>
				</c:if>
			
			
				<td class='ocultaOperador registrar'>
				    <fsn:option key="-1" value="selectList.nonValue" />		      	  
			        <fsn:selectList beanName="selectOperadores" path="idOperador" appendFilters="false" uppercase="false" progress="true" style="width:100%"/>     
				</td>
				<td class="registrar">
				    <fsn:option key="-1" value="selectList.nonValue" />		      	  
			        <fsn:selectList beanName="selectVehiculos" path="idVehiculo" appendFilters="false" uppercase="false" progress="true" style="width:100%"/>     
				</td>
				<td class="registrar">
					<table border="0" width="100%">
						 <tr>
							<td>
							    <fsn:option key="-1" value="sipa.selectEntidad" />		      	  
						        <fsn:selectList beanName="BuscaEntidad" path="idEntidadOrigen" appendFilters="false" uppercase="false" progress="true" style="width:100%"/>     
							</td>
						</tr>
					     <tr>
							<td>
							    <fsn:option key="-1" value="sipa.selectMunicipio" />		      	  
						        <fsn:selectList beanName="BuscaMunicipio" path="idMunicipioOrigen" parentPath="idEntidadOrigen" uppercase="false" appendFilters="false" progress="true" style="width:100%"/>     
							</td>
						</tr>
					     <tr>
							<td>
							    <fsn:option key="-1" value="sipa.selectInmueble" />		      	  
						        <fsn:selectList beanName="BuscaDomicilio" path="idOrigen" parentPath="idMunicipioOrigen" uppercase="false" appendFilters="false" progress="true" style="width:100%"/>     
							</td>
						</tr>
						<tr>
							<td>
								<fsn:textarea path="dirOrigenTxt" uppercase="false" cols="24" rows="3"/></td>
							</td>
						</tr>
					</table>
				</td>						
				<td class="registrar" align='center'>
					<input type="time" name="salida">
				</td>
				<td class="registrar">
					<fsn:input path="kmIni" uppercase="false" maxlength="6" size="8" onkeyup="javascript:fValidaEntero(this,6);"/>
		    	</td>
		    	<td class="registrar" align='center'>
					<fsn:input path="combustibleEntrega" uppercase="false" maxlength="3" size="3" onkeyup="javascript:fValidaEntero(this,1);"/>
		    	</td>
		    	
				<td>
					<table border="0" width="100%">
						 <tr>
							<td>
							    <fsn:option key="-1" value="sipa.selectEntidad" />		      	  
						        <fsn:selectList beanName="BuscaEntidad" path="idEntidadDestino" uppercase="false" appendFilters="false" progress="true" style="width:100%"/>     
							</td>
						</tr>
					     <tr>
							<td>
							    <fsn:option key="-1" value="sipa.selectMunicipio" />		      	  
						        <fsn:selectList beanName="BuscaMunicipio" path="idMunicipioDestino" parentPath="idEntidadDestino" uppercase="false" appendFilters="false" progress="true" style="width:100%"/>     
							</td>
						</tr>
					     <tr>
							<td>
							    <fsn:option key="-1" value="sipa.selectInmueble" />		      	  
						        <fsn:selectList beanName="BuscaDomicilio" path="idDestino" parentPath="idMunicipioDestino" uppercase="false" appendFilters="false" progress="true" style="width:100%"/>     
							</td>
						</tr>
						<tr>
							<td>
								<fsn:textarea path="dirDestinoTxt" uppercase="false" cols="24" rows="3"/></td>
							</td>
						</tr>
					</table>
				</td>
				<td align='center'>
					<input type="time" name="llegada">
				</td>
		    	<td align='center'>
					<fsn:input path="kmFin" uppercase="false" maxlength="6" size="8" onkeyup="javascript:fValidaEntero(this,10);"/>
		    	</td>
				<td align='center'>
					<fsn:input path="nivelCombustible" uppercase="false" maxlength="6" size="3" onkeyup="javascript:fValidaEntero(this,1);"/>
		    	</td>
			</tr>
	</table>
   </div>
</div>
	
<div class="row">
	<div style="text-align:center">
		<div role="group">
			<br><br><br>
			<c:if test="${solicitudDTO.idEstado == 2}">
				<input type="button" value="Registrar salida de préstamo del vehículo" onclick="javascript:entregaSolicitud();">&nbsp;&nbsp;
				<input type="button" value="Registrar llegada de entrega del vehículo" onclick="javascript:atiendeSolicitud();">
			</c:if>
			
			<c:if test="${solicitudDTO.idEstado == 3}">
				<input type="button" value="Finalizar la Solicitud con los Trayectos indicados" onclick="javascript:recepcionSolicitud();">&nbsp;&nbsp;
			</c:if>
			&nbsp;
			<input type="button" value="Regresar a la consulta" onclick="javascript:regresar();">
			
		</div>
	</div>
</div>	
 
</html:form>
   	
</body>   	


<script type="text/javascript" defer src="../js/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/toastr.min.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer type="text/javascript">
	var $j = jQuery.noConflict();
	const extensionesArchivo = /\.(exe|bat|sh|js|com|msi|vbs|scr)\.pdf$/i;
	
	$j("[name='combustibleEntrega'], [name='nivelCombustible']").on({
	    mousedown: function() {
	        $j("#indicadorNivel").show();
	    },
	    mouseup: function() {
	        $j("#indicadorNivel").hide();
	    }
	});
	
	$j(document).ready(function() {
		
		$j("input[name=chofer][value='0']").prop("checked",true);
		$j("#dirOrigenTxt").hide();
		$j("#dirDestinoTxt").hide();
		$j("#indicadorNivel").hide();
		
		
		if($j('#requiereChofer').val() == 'true'){
			$j("input[name=chofer][value='1']").prop("checked",true);
		}else{
			$j(".ocultaOperador").hide();
			$j('.entregaTh').attr('colspan', 5);
		}
		
		
		//Muestra apartado dependiendo si ya esta en atencion
		if($j("#idEstado").val() == 3){
			$j(".registrar").hide();
		}else{
			$j(".consultado").hide();
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
	
	var realizados 		= [];
	var entidadOrigen 	= [];
   	var municipioOrigen	= [];
   	var origen 			= [];
   	var origenTxt		= [];
   	var salida 			= [];
   	var entidadDestino 	= [];
   	var municipioDestino= [];
   	var destino 		= [];
   	var destinoTxt		= [];
   	var llegada 		= [];
   	var kmIni			= [];
   	var kmFin			= [];
   	var idOperador		= [];
   	var idVehiculo		= [];
   	var nivelCombustible= [];
   	var combustibleEntrega= [];
   	var idSolCompartida	= [];
   	var horas 			= [];
	
	
	function entregaSolicitud(){
		origen  	= [];
	   	salida 		= [];
	   	realizados  = [];
	   	horas 		= [];
	   	kmIni			= [];
	   	idOperador		= [];
	   	idVehiculo		= [];
	   	combustibleEntrega = [];
	   	var evidencia	= $j('#evidencia')[0];
   		
	   	
		if(validaEntrega()){
			if(evidencia.files[0] == undefined){
				if(confirm("Antes de registrar la salida del vehículo. ¿Desea agregar un archivo (pdf) con las imágenes de Evidencia de Salida del Vehículo?\n\n ACEPTAR para agregar el archivo.\n\n CANCELAR para continuar con el proceso de Registro de Salida del Vehículo.") == true){
		   			return;
		   		}
			}
			
			if(evidencia.files[0] != undefined){
				if (extensionesArchivo.test(evidencia.files[0].name)) {
					Command: toastr["warning"]("Documento con extensión incorrecta.", "Evidencia de Salida");
					return;
				}
				
				isPDF(evidencia.files[0], function(esValido) {
					if (!esValido) {
						Command: toastr["warning"]("Documento debe ser PDF.", "Evidencia de Salida");
						return;
					}
				});
			}
		
  			generaEntrega();
		}else{
			Command: toastr["warning"]("Favor de proporcionar toda la información requerida de Salida del Vehículo", "Préstamo");
		}
	}
	
	
	function recepcionSolicitud(){
		nivelCombustible 	= [];
		realizados  		= [];
		salida 				= [];
	   	destino 			= [];
	   	llegada 			= [];
	   	horas 				= [];
	   	kmFin				= [];
	   	
		if(confirm("Esta seguro que quiere cambiar la solicitud a 'Atendida' ") == true){
			if(validaRecepcion()){
   				generaRecepcion();
   			}else{
   				Command: toastr["warning"]("Los campos de la sección RECEPCIÓN, son obligatorios.", "Recorrido");
   			}
		}
	}
	
	function atiendeSolicitud(){
		combustibleEntrega 	= [];
		nivelCombustible	= [];
		idOperador			= [];
		idVehiculo			= [];
		recorridos  		= [];
		origen  			= [];
		salida 				= [];
		destino 			= [];
		llegada 			= [];
		horas 				= [];
		kmIni				= [];
		kmFin				= [];
	   	var evidencia		= $j('#evidenciaRecepcion')[0];
	   	var evidenciaEntrega= $j('#evidencia')[0];
	   			
		if(validaEntrega() && validaRecepcion()){
			if(evidencia.files[0] == undefined || evidenciaEntrega.files[0] == undefined){
				if(confirm("Antes de registrar la salida del vehículo. ¿Desea agregar un archivo (pdf) con las imágenes de Evidencia de Salida/Llegada del Vehículo?\n\n ACEPTAR para agregar el archivo.\n\n CANCELAR para continuar con el proceso de Registro de Salida del Vehículo.") == true){
		   			return;
		   		}
			}
			
			if(evidencia.files[0] != undefined){
				if (extensionesArchivo.test(evidencia.files[0].name)) {
					Command: toastr["warning"]("Documento con extensión incorrecta.", "Evidencia de Llegada");
					return;
				}
				
				isPDF(evidencia.files[0], function(esValido) {
					if (!esValido) {
						Command: toastr["warning"]("Documento debe ser PDF.", "Evidencia de Llegada");
					}
				});
			}
			
			if(evidenciaEntrega.files[0] != undefined){
				if (extensionesArchivo.test(evidenciaEntrega.files[0].name)) {
					Command: toastr["warning"]("Documento con extensión incorrecta.", "Evidencia de Salida");
					return;
				}
				
				isPDF(evidenciaEntrega.files[0], function(esValido) {
					if (!esValido) {
						Command: toastr["warning"]("Documento debe ser PDF.", "Evidencia de Salida");
						return;
					}
				});
			}
		
			generaSolicitud();
		}else{
			Command: toastr["warning"]("Favor de proporcionar toda la información requerida de Salida/Lleada del Vehículo", "Préstamo");
		}
	}
	
	
	function validaEntrega() {
	   	var resultado = validaNulos("idOrigen", -1) & validaNulos("idEntidadOrigen", -1) & validaNulos("idMunicipioOrigen", -1) & validaNulos("salida", "") 
   				& validaNulos("kmIni", "") & validaNulos("combustibleEntrega", "") & validaNulos("idVehiculo", -1);
   				
		var entrega = (resultado === 1) ? true : false;
		
   		if($j("#requiereChofer").val() == 'true'){
   			return entrega && validaNulos("idOperador", -1);
   		}
   		
   		validaNulos("idOperador", -1);
   		return entrega;
	}
	
	
	function validaRecepcion() {
	   	var resultado = validaNulos("idDestino", -1) & validaNulos("idEntidadDestino", -1) & validaNulos("idMunicipioDestino", -1) & validaNulos("llegada", "") 
   				& validaNulos("kmFin", "") & validaNulos("nivelCombustible", "");
   				
		var recepcion = (resultado === 1) ? true : false;
		
   		return recepcion;
	}
	
	
	function generaEntrega(){
   		for(var i = 0; i < origen.length; i++){
   			realizados.push({
   				"idEntidadOrigen"	: entidadOrigen[i],
   				"idMunicipioOrigen"	: municipioOrigen[i],
		        "idOrigen"    		: origen[i],
		        "dirOrigenTxt"    	: origenTxt[i],
		        "salida"  			: salida[i],
		        "kmIni"    			: kmIni[i],
		        "idOperador"    	: idOperador[i],
		        "idVehiculo"    	: idVehiculo[i],
		        "combustibleEntrega": combustibleEntrega[i]
		    });
		}
		
		var evidencia	= $j('#evidencia')[0];
   		var form 		= new FormData();
   		
   		if(evidencia.files[0] != undefined){
			form.append('evidenciaEntrega', evidencia.files[0]);
		}
		
		var solicitud = {idSolicitud: $j("#idSolicitud").val(), realizados: realizados, folio: $j("#folioSolicitud").val()};
		form.append("solicitud", JSON.stringify(solicitud));
		
		console.log(solicitud);
		
		/*$j.ajax({
			url: "enAtencionSolicitudPrestamo.do",
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
		});*/
   	}
   	
   	
   	function generaRecepcion(){
   		var evidencia	= $j('#evidenciaRecepcion')[0];
   		var form 		= new FormData();
   		
   		if(evidencia.files[0] != undefined){
			form.append('evidenciaRecepcion', evidencia.files[0]);
		}
   		
   		form.append("idSolicitud", $j("#idSolicitud").val());
   		form.append("idEntidadDestino",	entidadDestino[0]);
		form.append("idMunicipioDestino", municipioDestino[0]);
		form.append("idDestino", destino[0]);
		form.append("idVehiculo", $j("#vehiculoPrestado").val());
		
		if(destinoTxt[0] != undefined){
			form.append("dirDestinoTxt", destinoTxt[0]);
		}
		
		form.append("llegada", llegada[0]);
		form.append("kmFin", kmFin[0]);
		form.append("nivelCombustible", nivelCombustible[0]);
		
		sendForm(form, 'recepcionSolicitudPrestamo.do');
   	}
   	
   	
   	function generaSolicitud(){	
   		if(kmIni[0] > kmFin[0]){
			Command: toastr['warning']('El Km Final debe ser mayor al Km Inicial', "Solicitud");
			return;
		}
   		
		var evidencia			= $j('#evidenciaRecepcion')[0];
		var evidenciaEntrega	= $j('#evidencia')[0];
   		var form 				= new FormData();
   		
   		if(evidencia.files[0] != undefined){
			form.append('evidenciaRecepcion', evidencia.files[0]);
		}
		
		if(evidenciaEntrega.files[0] != undefined){
			form.append('evidenciaEntrega', evidencia.files[0]);
		}
   		
   		form.append("idSolicitud", $j("#idSolicitud").val());
   		form.append("idEntidadDestino",	entidadDestino[0]);
		form.append("idMunicipioDestino", municipioDestino[0]);
		form.append("idDestino", destino[0]);
		
		if(destinoTxt[0] != undefined){
			form.append("dirDestinoTxt", destinoTxt[0]);
		}
		
		form.append("idEntidadOrigen",	entidadOrigen[0]);
		form.append("idMunicipioOrigen", municipioOrigen[0]);
		form.append("idOrigen", origen[0]);
		
		if(origenTxt[0] != undefined){
			form.append("dirOrigenTxt", origenTxt[0]);
		}
		
		form.append("salida", salida[0]);
		form.append("llegada", llegada[0]);
		form.append("kmFin", kmFin[0]);
		form.append("kmIni", kmIni[0]);
		form.append("nivelCombustible", nivelCombustible[0]);
		form.append("combustibleEntrega", combustibleEntrega[0]);
		form.append("idVehiculo", idVehiculo[0]);
		form.append("idOperador", idOperador[0]);
		
		sendForm(form, 'atenderSolicitudPrestamo.do');
   	}
   	
   	
   	function sendForm(formulario, url){
   		$j.ajax({
			url: url,
			type: 'POST',
			data: formulario,
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
   	
	
	function validaNulos(name, criterio){
		var res = true;
		var InputAux = ".realizado > td > ";
		var InputAuxSol = ".realizado > td > span >";
		var selectorAux = ".realizado > td > table > tbody > tr > td > ";
		var selectorTxt = ".realizado > td > table > tbody > tr > td > span ";
		
		$j(InputAux + "[name='" + name + "']").each(function() {
		    if($j(this).val() == criterio){
		    	res = false;
		    }
		    		    
		    if(name == "salida"){
		    	salida.push($j(this).val());
		    }
		    
		    if(name == "llegada"){
		    	llegada.push($j(this).val());
		    }	
		    	
		    if(name == "kmIni"){
		    	kmIni.push($j(this).val());
		    }
		    
		    if(name == "kmFin"){
		    	kmFin.push($j(this).val());
		    }
		    
		    if(name == "nivelCombustible"){
		    	nivelCombustible.push($j(this).val());
		    }
		    	
		    if(name == "combustibleEntrega"){
		    	combustibleEntrega.push($j(this).val());
		    }
		    	
		    if(name == "idOperador"){
		    	idOperador.push($j(this).val());
		    }
		    
		    if(name == "idVehiculo"){
		    	idVehiculo.push($j(this).val());
		    }
		});
		
		
		$j(selectorAux + "[name='" + name + "']").each(function() {
		    if($j(this).val() == criterio){
		    	res = false;
		    }
		    
		    if(name == "idEntidadOrigen"){
		    	entidadOrigen.push($j(this).val());
		    }
		    	
		    if(name == "idMunicipioOrigen"){
		    	municipioOrigen.push($j(this).val());
		    }
		    
		    if(name == "idOrigen"){
		    	origen.push($j(this).val());
		    }
		    
		    if(name == "idEntidadDestino"){
		    	entidadDestino.push($j(this).val());
		    }
		    
		    if(name == "idMunicipioDestino"){
		    	municipioDestino.push($j(this).val());
		    }
		    
		    if(name == "idDestino"){
		    	destino.push($j(this).val());
		    }
		});
		
		
		$j(selectorTxt + "#" + name).each(function() {			
		    if(name == "dirOrigenTxt"){
		    	origenTxt.push($j(this).val());
		    }
		    
		    if(name == "dirDestinoTxt"){
		    	destinoTxt.push($j(this).val());
		    }
		});
		
		return res;
	}
	
	
	function muestraMensaje(mensaje){
   		Command: toastr["warning"](mensaje, "Recorrido Realizado.");
   	}
   	
   	$j('#idOrigen').change(function () {
	    var otros = $j("[name='idOrigen']").children("option").filter(":selected").text().toUpperCase();
	    
	    if(otros.startsWith("OTRO")){
	    	$j("#dirOrigenTxt").show();
	    }else{
	    	$j("#dirOrigenTxt").hide();
	    }
	});
	
	
	$j('#idDestino').change(function () {
	    var otros = $j("[name='idDestino']").children("option").filter(":selected").text().toUpperCase();
	    
	    if(otros.startsWith("OTRO")){
	    	$j("#dirDestinoTxt").show();
	    }else{
	    	$j("#dirDestinoTxt").hide();
	    }
	});
	
	
	function fValidaEntero (obj, posiciones){
        var cad = obj.value;
        
        if (!/^([0-9])*$/.test(cad)){
            cad = cad.replace(/[^0-9]+/g,'');
            obj.value = cad;
        }
        else {
            cad = cad.replace(/^0*/g,'');
            obj.value = cad;
        }
        
        if(cad.length > posiciones){
            obj.value = cad.substring(0,posiciones);
        }
    }
    
    function regresar() {
      window.location.href = $j("#rutaRegreso").val();
    }
    
    
    function isPDF(file, callback) {
		const reader = new FileReader();
	
		reader.onloadend = function(e) {
		  const arr = new Uint8Array(e.target.result).subarray(0, 4);
		  let header = "";
		  for (let i = 0; i < arr.length; i++) {
		    header += String.fromCharCode(arr[i]);
		  }
		
		  if (header === "%PDF") {
		    callback(true);
		  } else {
		    callback(false);
		  }
		};
		
		reader.readAsArrayBuffer(file.slice(0, 4));
	}
	
</script>


