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
	<input type="hidden" id="ultimaHora"/>
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h2><b>Información de la Solicitud de Pool</b></h2>
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
				
				<c:if test="${solicitudDTO.idTipo == 2 && solicitudDTO.idEstado != 1}">
					<tr>
						<td width="40%" class="label">Evidencia visual:</td>
						<td>
							<c:if test="${solicitudDTO.tieneEvidencia}">
								<a href="descargaEvidencia.do?folio=${solicitudDTO.folio}"> Descargar Evidencia
									<img alt="Evidencia" src="/resources/images/icons/descargar.gif" height="20" width="20"/>
								</a>
							</c:if>
							
							<c:if test="${!solicitudDTO.tieneEvidencia}">
								Sin Evidencia.
							</c:if>
				         </td>
					</tr>
				</c:if>
				
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
			<h2><b>Trayectos Solicitados</b></h2>
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
	
	
<br><br>
<div class="panel panel-default">
	<div class="panel-heading">
		<h2><b>Trayectos Realizados</b><i> (No se permiten trayectos traslapados.) </i></h2>
		<hr class="red">
		<h2>Agregar el trayecto o los trayectos realizados</h2>
		<fsn:window name="agregaRealizado" uri="solicitudes/invocaAltaRealizado.do" image="add.gif" width="1200" height="230" title="Registra Trayecto Realizado" params="recorrido="/>
	</div>
		<div class="panel-body">
			<table>
				<tr class="realizadoEjemplo">
					<td name="contador" align='center'> </td>
					
					<td>
						<table border="0" width="100%">
							 <tr>
								<td><select name="idEntidadOrigen" readonly></select></td>
							</tr>
						     <tr>
								<td><select name="idMunicipioOrigen" readonly></select></td>
							</tr>
						     <tr>
								<td><select name="idOrigen" readonly></select></td>
							</tr>
							<tr>
								<td><span><textarea id="dirOrigenTxt" cols="24" rows="3" readonly> </textarea></span></td>
							</tr>
						</table>
					</td>
										
					<td align='center'> <input type="time" name="salida" readonly> </td>
					
					<td>
						<table border="0" width="100%">
							 <tr>
								<td><select name="idEntidadDestino" readonly></select></td>
							</tr>
						     <tr>
								<td><select name="idMunicipioDestino" readonly></select></td>
							</tr>
						     <tr>
								<td><select name="idDestino" readonly></select></td>
							</tr>
							<tr>
								<td><span><textarea id="dirDestinoTxt" cols="24" rows="3" readonly> </textarea></span></td>
							</tr>
						</table>
					</td>
					
					<td align='center'><input type="time" name="llegada" readonly></td>
					
					<td>
					    <fsn:option key="-1" value="selectList.nonValue" />		      	  
				        <fsn:selectList beanName="selectOperadores" path="idOperador" appendFilters="false" uppercase="false" progress="true" style="width:100%"/>
				        <span style="display: block; text-align: center;">
				        	<input type="text" id="operadorTxt" size="30" maxlength="40" readonly/>
				        </span>     
					</td>
					<td>
					    <fsn:option key="-1" value="selectList.nonValue" />		      	  
				        <fsn:selectList beanName="selectVehiculos" path="idVehiculo" appendFilters="false" uppercase="false" progress="true" style="width:100%"/>     
					</td>
					
					<td align='center'> <input type="text" name="kmIni" size="10" onkeyup="javascript:fValidaEntero(this,6);"> </td>
					<td align='center'> <input type="text" name="combustibleEntrega" size="3"> </td>
					<td align='center'> <input type="text" name="kmFin" size="10" onkeyup="javascript:fValidaEntero(this,6);"> </td>
					<td align='center'> <input type="text" name="nivelCombustible" size="3"> </td>
					
					<td>
						<span>
						    <fsn:option key="-1" value="selectList.nonValue" />		      	  
					        <fsn:selectList beanName="selectSolicitudesAsoc" path="idSolicitudComp" appendFilters="false" uppercase="false" progress="true" style="width:100%"/>     
						</span>
					</td>
					
					<td align='center'><br><input class="btnEliminar" type="button" value="Eliminar" onclick="javascript:eliminaRealizado(this);"></td>
				</tr>
		</table>
		
		<table id="realizados" width="100%">
			<thead>
				<tr>
					<th align='center'><b>No</b></<th>
					<th align='center'><b>Lugar de Origen:</b></<th>
					<th align='center'><b>Hora de salida:</b></<th>
					<th align='center'><b>Lugar de Destino:</b></<th>
					<th align='center'><b>Hora de llegada:</b></<th>
					<th align='center'><b>Operador:</b></<th>
					<th align='center'><b>Vehiculo:</b></<th>
					<th align='center'><b>Km Inicial:</b></<th>
					<th align='center'><b>Combustible Inicial:</b></<th>
					<th align='center'><b>Km Final:</b></<th>
					<th align='center'><b>Combustible Final:</b></<th>
					<th align='center'><b>Solicitud Compartida:</b></<th>
					<th align='center'><b>Acción</b></<th>
				</tr>
			</thead>
			<tbody class="contenido"></tbody>
		</table>
    </div>
</div>
	
<div class="row">
	<div style="text-align: center">
		<div role="group">
			<br><br><br><br>
			<input type="button" value="Finalizar la Solicitud con los Trayectos indicados" onclick="javascript:atenderSolicitud();">&nbsp;
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
	
	$j(document).ready(function() {
		$j(".realizadoEjemplo").hide();
		
		$j(".realizadoEjemplo > td > [name='idVehiculo']").removeAttr('id');
		$j(".realizadoEjemplo > td > [name='idOperador']").removeAttr('id');
		$j(".realizadoEjemplo > td > [name='idSolCompartida']").removeAttr('id');

		$j("input[name=chofer][value='0']").prop("checked",true);
		
		if($j('#requiereChofer').val() == 'true'){
			$j("input[name=chofer][value='1']").prop("checked",true);
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
	
	var recorridos 		= [];
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
   	var operadorTxt		= [];
   	var idVehiculo		= [];
   	var nivelCombustible= [];
   	var combustibleEntrega= [];
   	var idSolCompartida	= [];
   	var horas 			= [];
	
	
	function atenderSolicitud(){
		origen  	= [];
	   	salida 		= [];
	   	destino 	= [];
	   	llegada 	= [];
	   	justifi 	= [];
	   	recorridos  = [];
	   	horas 		= [];
	   	
		if(confirm("Esta seguro que quiere cambiar la solicitud a 'Atendida' ") == true){
			if(validaRecorridos()){
   				if(validarHoras()){
   					generaSolicitud();
   				}
   			}else{
   				Command: toastr["warning"]("No existen Recorridos o tienen datos nulos.", "Recorrido");
   			}
		}
	}
	
	
	function validaRecorridos() {
		origen  		= [];
	   	salida 			= [];
	   	destino 		= [];
	   	llegada 		= [];
	   	recorridos  	= [];
	   	horas 			= [];
	   	kmIni			= [];
	   	kmFin			= [];
	   	idOperador		= [];
	   	idVehiculo		= [];
	   	nivelCombustible= [];
	   	combustibleEntrega= [];
	   	idSolCompartida	= [];
	
   		return validaNulos("idEntidadOrigen", -1) & validaNulos("idMunicipioOrigen", -1) & validaNulos("idOrigen", -1) & validaNulos("salida", "")
   				& validaNulos("idEntidadDestino", -1), validaNulos("idMunicipioDestino", -1), validaNulos("idDestino", -1) & validaNulos("llegada", "") 
   				& validaNulos("dirOrigenTxt", "") & validaNulos("dirDestinoTxt", "") & validaNulos("operadorTxt", "")
   				& validaNulos("kmIni", "") & validaNulos("kmFin", "") & validaNulos("idOperador", -1) & validaNulos("idVehiculo", -1)
   				& validaNulos("idSolicitudComp", -1) & validaNulos("nivelCombustible", "") & validaNulos("combustibleEntrega", "");
	}
	
	
	function validaNulos(name, criterio){
		var res = true;
		var InputAux = ".realizado > td > ";
		var InputAuxSol = ".realizado > td > span >";
		var selectorAux = ".realizado > td > table > tbody > tr > td > ";
		var selectorTxt = ".realizado > td > table > tbody > tr > td > span ";
		var selOperTxt  = ".realizado > td > span ";
		
		$j(InputAux + "[name='" + name + "']").each(function() {
		    if($j(this).val() == criterio){
		    	res = res && false;
		    }
		    		    
		    if(name == "salida")
		    	salida.push($j(this).val());
		    
		    if(name == "llegada")
		    	llegada.push($j(this).val());		    	
		    	
		    if(name == "kmIni")
		    	kmIni.push($j(this).val());
		    
		    if(name == "kmFin")
		    	kmFin.push($j(this).val());
		    
		    if(name == "nivelCombustible")
		    	nivelCombustible.push($j(this).val());
		    
		    if(name == "combustibleEntrega")
		    	combustibleEntrega.push($j(this).val());
		    	
		    if(name == "idOperador")
		    	idOperador.push($j(this).val());
		    
		    if(name == "idVehiculo")
		    	idVehiculo.push($j(this).val());
		});
		
		
		$j(selectorAux + "[name='" + name + "']").each(function() {
		    if($j(this).val() == criterio){
		    	res = res && false;
		    }
		    
		    if(name == "idEntidadOrigen")
		    	entidadOrigen.push($j(this).val());
		    	
		    if(name == "idMunicipioOrigen")
		    	municipioOrigen.push($j(this).val());
		    
		    if(name == "idOrigen")
		    	origen.push($j(this).val());
		    
		    if(name == "idEntidadDestino")
		    	entidadDestino.push($j(this).val());
		    
		    if(name == "idMunicipioDestino")
		    	municipioDestino.push($j(this).val());
		    
		    if(name == "idDestino")
		    	destino.push($j(this).val());
		});
		
		
		$j(selectorTxt + "#" + name).each(function() {					
		    if(name == "dirOrigenTxt")
		    	origenTxt.push($j(this).val());
		    
		    if(name == "dirDestinoTxt")
		    	destinoTxt.push($j(this).val());
		});
		
		
		$j(selOperTxt + "#" + name).each(function() {
		    if(name == "operadorTxt"){
		    	operadorTxt.push($j(this).val());
		    }
		});
		
		
		$j(InputAuxSol + "[name='" + name + "']").each(function() {
			if(name == "idSolicitudComp")
		    	idSolCompartida.push($j(this).val());
		});
		
		
		if(origen.length == 0){
			return false;
		}
		
		return res;
	}
	
	
	function generaSolicitud(){
   		
   		for(var i = 0; i < origen.length; i++){   		
   			recorridos.push({
   				"orden"				: ""+(i + 1),
   				"idEntidadOrigen"	: entidadOrigen[i],
   				"idMunicipioOrigen"	: municipioOrigen[i],
		        "idOrigen"    		: origen[i],
		        "dirOrigenTxt"    	: (origenTxt[i] == "" ? null : origenTxt[i]),
		        "salida"  			: salida[i],
		        "idEntidadDestino"	: entidadDestino[i],
		        "idMunicipioDestino": municipioDestino[i],
		        "idDestino"    		: destino[i],
		        "dirDestinoTxt"    	: (destinoTxt[i] == "" ? null : destinoTxt[i]),
		        "operadorTxt"    	: (operadorTxt[i] == "" ? null : operadorTxt[i]),
		        "llegada"    		: llegada[i],
		        "kmIni"    			: kmIni[i],
		        "kmFin"    			: kmFin[i],
		        "idOperador"    	: idOperador[i],
		        "idVehiculo"    	: idVehiculo[i],
		        "idSolCompartida"   : idSolCompartida[i],
		        "nivelCombustible"	: nivelCombustible[i],
		        "combustibleEntrega": combustibleEntrega[i]
		    });
		}		
		
		var solicitud = {idSolicitud: $j("#idSolicitud").val(), realizados: recorridos};
		
		$j.ajax({
			url: 'atenderSolicitud.do',
			type: 'POST',
			data: { solicitud: JSON.stringify(solicitud) },
			success : function(data) {
				Command: toastr[data[0]](data[1], "Trayecto");
				
				if(data[0] == "success"){
					setTimeout(function() {
						window.location.href = $j("#rutaRegreso").val();
					}, 3000);
				}
			}
		});
   	}
	
	
	function eliminaRealizado(elemento){
   		$j(elemento).closest("tr").remove();
   		
   		$j('#realizados .contenido .realizado').each(function(index) {
            $j(this).find("td:first").text(index + 1);
        });
        
        var horaActualizada = $j('#realizados .contenido .realizado').last().children().eq(-3).find('input').val();
        $j("#ultimaHora").val(horaActualizada);
   	}
	
	
	function validaComentarios(campo) {
	  const regex = /(\b(SELECT|UPDATE|DELETE|INSERT|DROP|UNION|--|;|EXEC|OR)\b|\b(ALTER|TRUNCATE|REPLACE|JOIN)\b|--|;|\/\*|\*\/|\bEXEC\b|\bUNION\b)/i;
	  return !regex.test(campo);
	}
	
	
	function agregaRecorridoRealizado(rec){
   		var selectoraux = ".realizadoEjemplo > td > table > tbody > tr > td > ";
   		
   		$j(selectoraux + "[name='idEntidadOrigen']").empty();
   		$j(selectoraux + "[name='idMunicipioOrigen']").empty();
   		$j(selectoraux + "[name='idOrigen']").empty();
   		$j(selectoraux + "span > #dirOrigenTxt").empty();
   		
   		$j(selectoraux + "[name='idEntidadDestino']").empty();
   		$j(selectoraux + "[name='idMunicipioDestino']").empty();
   		$j(selectoraux + "[name='idDestino']").empty();
   		$j(selectoraux + "span > #dirDestinoTxt").empty();
   		
		$j(selectoraux + "[name='idEntidadOrigen']").append("<option value=" + rec[0].entidadOrigen + ">" + rec[0].txtentidadOrigen + "</option>");
		$j(selectoraux + "[name='idMunicipioOrigen']").append("<option value=" + rec[0].municipioOrigen + ">" + rec[0].txtmunicipioOrigen + "</option>");
		$j(selectoraux + "[name='idOrigen']").append("<option value=" + rec[0].direccionOrigen + ">" + rec[0].txtdireccionOrigen + "</option>");
		$j(selectoraux + "span > #dirOrigenTxt").val(rec[0].dirOrigenTxt);
		$j(selectoraux + "[name='idEntidadDestino']").append("<option value=" + rec[0].entidadDestino + ">" + rec[0].txtentidadDestino + "</option>");
		$j(selectoraux + "[name='idMunicipioDestino']").append("<option value=" + rec[0].municipioDestino + ">" + rec[0].txtmunicipioDestino + "</option>");
		$j(selectoraux + "[name='idDestino']").append("<option value=" + rec[0].direccionDestino + ">" + rec[0].txtdireccionDestino + "</option>");
		$j(selectoraux + "span > #dirDestinoTxt").val(rec[0].dirDestinoTxt);
		
		$j(".realizadoEjemplo > td[name='contador']").text($j(".realizado").length + 1);
		$j(".realizadoEjemplo > td > [name='salida']").val(rec[0].salida);
		$j(".realizadoEjemplo > td > [name='llegada']").val(rec[0].llegada);
		
		$j(".realizadoEjemplo > td > [name='kmIni']").val(rec[0].kmIni);
		$j(".realizadoEjemplo > td > [name='combustibleEntrega']").val(rec[0].combustibleEntrega);
		$j(".realizadoEjemplo > td > [name='kmFin']").val(rec[0].kmFin);
		$j(".realizadoEjemplo > td > [name='nivelCombustible']").val(rec[0].nivelCombustible);
		
		$j("#ultimaHora").val(rec[0].llegada);
		
		var nuevo = $j(".realizadoEjemplo").clone();
		
		if(nuevo.find("#dirOrigenTxt").val() == ""){
			nuevo.find("#dirOrigenTxt").hide();
		}
		
		if(nuevo.find("#dirDestinoTxt").val() == ""){
			nuevo.find("#dirDestinoTxt").hide();
		}
		
		nuevo.removeClass("realizadoEjemplo").addClass("realizado").appendTo("#realizados > tbody").removeAttr('style').attr('style', 'background-color:#F0EAEA');
		
		$j('#realizados select').eq(-1).val(rec[0].solicAsociada);
		$j('#realizados select').eq(-2).val(rec[0].vehiculo);
		$j('#realizados select').eq(-3).val(rec[0].operador);
		
		if (rec[0].operadorTxt.length === 0 || rec[0].operadorTxt === "") {
		    $j('.realizado #operadorTxt').hide();
		}
		
		$j('#realizados #operadorTxt').empty();
		$j('#realizados #operadorTxt').val(rec[0].operadorTxt);
   	}
   	
   	
   	function validarHoras() {
   		for(var i=0; i < salida.length; i++){
   			horas.push(salida[i]);
   			horas.push(llegada[i]);
		}
   	
		const convertirAHorasEnMinutos = (hora) => {
			const [horas, minutos] = hora.split(':').map(Number);
			return horas * 60 + minutos;
		};
	
		for (let i = 1; i < horas.length; i++) {
			const horaAnterior = convertirAHorasEnMinutos(horas[i - 1]);
			const horaActual = convertirAHorasEnMinutos(horas[i]);
		
			if (horaActual < horaAnterior) {
				Command: toastr["warning"]("Revise los horarios de salidas y llegadas.", "Recorridos");
				return false;
			}
		}
	
		return true;
	}
	
	
	function muestraMensaje(mensaje){
   		Command: toastr["warning"](mensaje, "Recorrido Realizado.");
   	}
   	
   	
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
	
</script>


