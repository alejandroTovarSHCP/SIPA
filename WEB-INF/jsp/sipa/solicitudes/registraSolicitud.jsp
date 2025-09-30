<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<body>
<html:form modelAttribute="solicitudDTO" id="solicitudAltaBienes" action="" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
<input type="hidden" id="tipoSolicitud" value="${solicitudDTO.idTipo}" />
<input type="hidden" id="ultimaHora"/>
<input type="hidden" id="fechaActual" value="${solicitudDTO.fechaActual}" />
	
<div class="panel panel-default">
	<div class="panel-heading">
		<h2><b>
			<c:if test="${solicitudDTO.idTipo == 1}">
				Alta de Solicitud de Pool de Auto
			</c:if>
			<c:if test="${solicitudDTO.idTipo == 2}">
				Alta de Préstamo de Auto
			</c:if>
			<hr class="red">
		</b></h2>
	</div>
	
	<div class="panel-body">
		<table width="100%" cellpadding="5">
			<tr>
				<td width="20%" class="label">Nombre de usuario:</td>
				<td>
					<span>${solicitudDTO.nombreUsuario}</span>
		    	</td>
			</tr>
			<tr>
	            <td width="20%" class="label">Fecha actual:</td>
	            <td>
	           		<span>${solicitudDTO.fechaActual}</span>
	            </td>
	        </tr>
			<tr>
	            <td width="20%" class="label">*Fecha del servicio:</td>
	            <td>
	            	<fsn:calendar path="fecha" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" readonly="true" />
	            </td>
	        </tr>
	        
	        <c:if test="${solicitudDTO.idTipo == 2}">
		        <tr>
		            <td width="20%" class="label">*Fecha de entrega:</td>
		            <td>
		            	<fsn:calendar path="fechaFin" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" readonly="true" />
		            </td>
		        </tr>
	        </c:if>
		  	
			<tr>
				<td width="20%" class="label">*No de Pasajeros:</td>
				<td>
					<fsn:input path="pasajeros" uppercase="false" maxlength="24" size="20" onkeyup="javascript:fValidaEntero(this,10);"/>
		    	</td>
			</tr>
			
			<c:if test="${solicitudDTO.idTipo == 2}">
				<tr>
					<td width="40%" class="label">*Requiere chofer:</td>
					<td>
			         	<input type="radio" name="chofer" value="1">Si
			         	<input type="radio" name="chofer" value="0">No
			         </td>
				</tr>
			</c:if>
			
			<tr>
				<td width="100%" class="label">*Justificación de solicitud:</td>
				<td><fsn:textarea path="justificacion" uppercase="false" cols="75" rows="5" /></td>
			</tr>
			<tr>
				<td width="100%" class="label">*Agregar trayecto:</td>
				<td>
					<fsn:window name="agregaRecorrido" uri="solicitudes/invocaAltaRecorrido.do" image="add.gif" width="900" height="219" title="Agregar Trayecto" params="recorrido="/>
				</td>
			</tr>
		</table>
    </div>
</div>

<br>
<div class="panel panel-default">
	<div class="panel-heading">
		<h2><b>Trayectos</b><i> (No se permiten trayectos traslapados.)</i></h2>
		<hr class="red">
	</div>
		<div class="panel-body">
			<table>
				<tr class="recorridoEjemplo">
					<td name="contador" align='center'> </td>
					
					<td>
						<table border="0" width="100%">
							 <tr>
								<td>
								    <select name="idEntidadOrigen" readonly></select>      
								</td>
							</tr>
						     <tr>
								<td>
								    <select name="idMunicipioOrigen" readonly></select>     
								</td>
							</tr>
						     <tr>
								<td>
								    <select name="idOrigen" readonly></select>
								</td>
							</tr>
							<tr>
								<td>
									<span><textarea id="dirOrigenTxt" cols="24" rows="3" readonly> </textarea></span>
								</td>
							</tr>
						</table>
					</td>
										
					<td align='center'> <input type="time" name="salida" readonly> </td>
					
					<td>
						<table border="0" width="100%">
							 <tr>
								<td>
								    <select name="idEntidadDestino" readonly></select>      
								</td>
							</tr>
						     <tr>
								<td>
								    <select name="idMunicipioDestino" readonly></select>     
								</td>
							</tr>
						     <tr>
								<td>
								    <select name="idDestino" readonly></select>
								</td>
							</tr>
							<tr>
								<td>
									<span><textarea id="dirDestinoTxt" cols="24" rows="3" readonly> </textarea></span>
								</td>
							</tr>
						</table>
					</td>
					
					<td align='center'><input type="time" name="llegada" readonly></td>
					
					<td align='center'> 
						<textarea name="justRecorrido" cols="40" rows="5"> </textarea> 
					</td>
					
					<td align='center'><br><input class="btnEliminar" type="button" value="Eliminar" onclick="javascript:eliminaRecorrido(this);"></td>
				</tr>
		</table>
		
		<table id="recorridos" width="100%">
			<thead>
				<tr>
					<th align='center'><b>No</b></<th>
					<th align='center'><b>Lugar de Origen:</b></<th>
					<th align='center'><b>Hora de salida:</b></<th>
					<th align='center'><b>Lugar de Destino:</b></<th>
					<th align='center'><b>Hora de llegada:</b></<th>
					<th align='center'><b>Justificación:</b></<th>
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
			<br><br><br><br><br>
			<input id="btnGuardar" type="button" value="Guardar"  onclick="javascript:guardaSolicitud();">
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
	var recorridoEdicion = [];

	$j(document).ready(function() {
		$j(".recorridoEjemplo").hide();
		$j("input[name=chofer][value='1']").prop("checked",true);
		
		toastr.options = {
		  "closeButton": true,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": false,
		  "positionClass": "toast-top-right",
		  "preventDuplicates": false,
		  "onclick": null,
		  "showDuration": "300",
		  "hideDuration": "1000",
		  "timeOut": 0,
		  "extendedTimeOut": 0,
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut",
		  "tapToDismiss": true
		}
	});
   	
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
   	var justifi 		= [];
   	var recorridos  	= [];
   	var horas 			= [];
   	
   	
   	function guardaSolicitud(){
   		var idTipo			= $j("#tipoSolicitud").val();
   		var fecha 			= $j("[name='text_fecha']").val();
   		var fechaFin		= (idTipo == 1) ? fecha : $j("[name='text_fechaFin']").val();
   		var pasajeros 		= $j("[name='pasajeros']").val();
   		var justificacion 	= $j("[name='justificacion']").val().trim();
   		var chofer 			= $j("input[name='chofer']:checked").val() == 1 ? true : false;
   		origen  			= [];
	   	salida 				= [];
	   	destino 			= [];
	   	llegada 			= [];
	   	justifi 			= [];
	   	recorridos  		= [];
	   	horas 				= [];
	   	
	   	if(!comparaFechas(fecha)){
	   		Command: toastr["warning"]("La fecha de servicio debe ser mayor a la Fecha Actual.", "Solicitud");
	   		return;
	   	}
	   	
	   	if(justificacion.trim().length > 1080){
	   		Command: toastr["warning"]("La justificación no puede exceder los 1080 carácteres.", "Solicitud");
	   		return;
	   	}
	   	
	   	if(confirm("La información registrada no se podrá modificar") == true){
		   	if(validaFecha(fecha) && validarSoloNumeros(pasajeros) && validaComentarios(justificacion)){
	   			if(validaRecorridos()){
	   				if(validarHoras()){
	   					generaSolicitud(fecha, fechaFin, pasajeros, justificacion, chofer);
	   				}
	   			}else{
	   				Command: toastr["warning"]("No existen Recorridos o tienen datos nulos.", "Recorrido");
	   			}
	   		}else{
	   			Command: toastr["warning"]("Contiene datos invalidos o faltantes.", "Solicitud");
	   		}
   		}
   	}
   	
   	
   	function validaComentarios(campo) {
	  const regex = /(\b(SELECT|UPDATE|DELETE|INSERT|DROP|UNION|--|;|EXEC|OR)\b|\b(ALTER|TRUNCATE|REPLACE|JOIN)\b|--|;|\/\*|\*\/|\bEXEC\b|\bUNION\b)/i;
	  return !regex.test(campo);
	}
	
   	
   	function validaFecha(campo) {
	  const regex = /^\d{2}-\d{2}-\d{4}$/;
	  return regex.test(campo);
	}
	
   	
   	function validarSoloNumeros(campo) {
	  const regex = /^[0-9]+$/;
	  return regex.test(campo);
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
   	
   	
   	function generaSolicitud(fecha, fechaFin, pasajeros, justificacion, chofer){
   		$j("#btnGuardar").hide();
   		
   		for(var i = 0; i < origen.length; i++){
   			recorridos.push({
   				"orden"				: ""+(i + 1),
   				"idEntidadOrigen"	: entidadOrigen[i],
   				"idMunicipioOrigen"	: municipioOrigen[i],
		        "idOrigen"    		: origen[i],
		        "dirOrigenTxt"    	: origenTxt[i],
		        "salida"  			: salida[i],
		        "idEntidadDestino"	: entidadDestino[i],
		        "idMunicipioDestino": municipioDestino[i],
		        "idDestino"    		: destino[i],
		        "dirDestinoTxt"    	: destinoTxt[i],
		        "llegada"    		: llegada[i],
		        "justRecorrido"		: justifi[i]
		    });
		}
		
		var solicitud = {fecha: fecha, fechaFin: fechaFin, pasajeros: pasajeros, justificacion: justificacion, chofer: chofer, idTipo: $j("#tipoSolicitud").val(), recorridos: recorridos};
		
		$j.ajax({
			url: 'guardaSolicitud.do',
			type: 'POST',
			data: { solicitud: JSON.stringify(solicitud) },
			success : function(data) {
							
				toastr.success(data[0] + "<br /><br /><button type='button' class='btn clear' onclick='redirigeAlta();'>Cerrar</button>", 'Solicitud', {
					"closeButton": false,
					"debug": false,
					"newestOnTop": false,
					"progressBar": false,
					"positionClass": "toast-top-right",
					"preventDuplicates": false,
					"onclick": null,
					"showDuration": "300",
					"hideDuration": "1000",
					"timeOut": 0,
					"extendedTimeOut": 0,
					"showEasing": "swing",
					"hideEasing": "linear",
					"showMethod": "fadeIn",
					"hideMethod": "fadeOut",
					"tapToDismiss": false
				});
			}
		});
   	}
   	
   	
   	function validaRecorridos() {
   		return validaNulos("idEntidadOrigen", -1) & validaNulos("idMunicipioOrigen", -1) & validaNulos("idOrigen", -1) & validaNulos("salida", "")
   				& validaNulos("idEntidadDestino", -1), validaNulos("idMunicipioDestino", -1), validaNulos("idDestino", -1) & validaNulos("llegada", "") 
   				& validaNulos("justRecorrido", "") & validaNulos("dirOrigenTxt", "") & validaNulos("dirDestinoTxt", "");
	}
	
	
	function validaNulos(name, criterio){
		var res = true;
		var InputAux = ".recorrido > td > ";
		var selectorAux = ".recorrido > td > table > tbody > tr > td > ";
		var selectorTxt = ".recorrido > td > table > tbody > tr > td > span ";
		
		$j(InputAux + "[name='" + name + "']").each(function() {
		    if($j(this).val() == criterio){
		    	res = res && false;
		    }
		    		    
		    if(name == "salida")
		    	salida.push($j(this).val());
		    
		    if(name == "llegada")
		    	llegada.push($j(this).val());
		    
		    if(name == "justRecorrido")
		    	justifi.push($j(this).val());
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
		
		if(origen.length == 0){
			return false;
		}
		
		return res;
	}
	
	
   	function agregaRecorrido(rec){
   		var selectoraux = ".recorridoEjemplo > td > table > tbody > tr > td > ";
   		
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
		
		$j(".recorridoEjemplo > td[name='contador']").text($j(".recorrido").length + 1);
		$j(".recorridoEjemplo > td > [name='salida']").val(rec[0].salida);
		$j(".recorridoEjemplo > td > [name='llegada']").val(rec[0].llegada);
		$j(".recorridoEjemplo > td > [name='justRecorrido']").val(rec[0].justRecorrido);
		$j("#ultimaHora").val(rec[0].llegada);
		
		var nuevo = $j(".recorridoEjemplo").clone();
		
		if(nuevo.find("#dirOrigenTxt").val() == ""){
			nuevo.find("#dirOrigenTxt").hide();
		}
		
		if(nuevo.find("#dirDestinoTxt").val() == ""){
			nuevo.find("#dirDestinoTxt").hide();
		}
		
		nuevo.removeClass("recorridoEjemplo").addClass("recorrido").appendTo("#recorridos > tbody").removeAttr('style').attr('style', 'background-color:#F0EAEA');
   	}
   	
   	
   	function eliminaRecorrido(elemento){
   		$j(elemento).closest("tr").remove();
   		
   		$j('#recorridos .contenido .recorrido').each(function(index) {
            $j(this).find("td:first").text(index + 1);
        });
        
        var horaActualizada = $j('#recorridos .contenido .recorrido').last().children().eq(-3).find('input').val();
        $j("#ultimaHora").val(horaActualizada);
   	}
   	
   	
   	function muestraMensaje(mensaje){
   		Command: toastr["warning"](mensaje, "Trayecto");
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
    
    
    function redirigeAlta() {
   		if($j("#tipoSolicitud").val() == 2){
   			location.href = '/sipa/solicitudes/registraPrestamo.do';
   		}else{
   			location.href = '/sipa/solicitudes/registroSolicitud.do';
   		}
	}
	
	
	function comparaFechas(fecha) {
		
		var fechaActual = $j("#fechaActual").val();
	
		function parsearFecha(fechaStr) {
		  const [dia, mes, anio] = fechaStr.split('-').map(Number);
		  return new Date(anio, mes - 1, dia);
		}
	
		const f1 = parsearFecha(fechaActual);
		const f2 = parsearFecha(fecha);
		
		return f2 >= f1;
	}
  
   	
</script>



