<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<div style="text-align: center;">
	<img id="indicadorNivel" style="width: 140px; height: auto;" src='../images/nivelCombustible.jpg' alt="Nivel Combustible"><br>
</div>

<html:form modelAttribute="RealizadoDTO" id="registraRealizado" name="registraRealizado" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
	<div class="panel panel-default">
			<div class="panel-body">
				<table width="100%">
					<tr style="background-color:#F0EAEA">
						<th align='center'><b>Lugar de Origen</b></<th>
						<th align='center'><b>Hora de salida</b></<th>
						<th align='center'><b>Lugar de Destino</b></<th>
						<th align='center'><b>Hora de llegada</b></<th>
						<th align='center'><b>Operador</b></<th>
						<th align='center'><b>Vehículo</b></<th>
						<th align='center'><b>Km Inicial</b></<th>
						<th align='center'><b>Combustible Inicial (Octavos)</b></<th>
						<th align='center'><b>Km Final</b></<th>
						<th align='center'><b>Combustible Final (Octavos)</b></<th>
						<th align='center'><b>Solicitud Compartida</b></<th>
					</tr>
				
					<tr class="recorrido">
						<td>
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
						<td align='center'>
							<input type="time" name="salida">
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
						<td align='center'> <input type="time" name="llegada"> </td>
						<td>
							<fsn:filter property="INMUEBLE_FK" condition="=" path="idInmueble"/>
						    <fsn:option key="-1" value="selectList.nonValue" />		      	  
					        <fsn:selectList beanName="selectOperadores" path="idOperador" appendFilters="false" uppercase="false" progress="true" style="width:100%"/>
					        
					        <span style="display: block; text-align: center;">
					        	<br>
					        	<fsn:input path="operadorTxt" uppercase="false" size="30" maxlength="40" placeholder="Nombre del operador"/>
					        </span>     
						</td>
						<td>
						    <fsn:option key="-1" value="selectList.nonValue" />		      	  
					        <fsn:selectList beanName="selectVehiculos" path="idVehiculo" appendFilters="false" uppercase="false" progress="true" style="width:100%"/>     
						</td>
						<td>
							<fsn:input path="kmIni" uppercase="false" maxlength="6" size="8" onkeyup="javascript:fValidaEntero(this,10);"/>
				    	</td>
				    	<td align='center'>
							<fsn:input path="combustibleEntrega" uppercase="false" maxlength="6" size="3" onkeyup="javascript:fValidaOctavos(this,1);"/>
				    	</td>
				    	<td>
							<fsn:input path="kmFin" uppercase="false" maxlength="6" size="8" onkeyup="javascript:fValidaEntero(this,10);"/>
				    	</td>
						<td align='center'>
							<fsn:input path="nivelCombustible" uppercase="false" maxlength="6" size="3" onkeyup="javascript:fValidaOctavos(this,1);"/>
				    	</td>
						<td>
						    <fsn:option key="-1" value="selectList.nonValue" />		      	  
					        <fsn:selectList beanName="selectSolicitudesAsoc" path="idSolCompartida" appendFilters="false" uppercase="false" progress="true" style="width:100%"/>     
						</td>
					</tr>
					<tr>			
					<td colspan="10" align="center">
						<br><br>
						<input type="button" value="Agregar" onclick="javascript:agregaRealizado();">			
					</td>
				</tr>
			</table>
	    </div>
	</div>
</html:form>
   	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer type="text/javascript">
	var $j = jQuery.noConflict();
	var ultimaHora = "";

	$j("[name='combustibleEntrega'], [name='nivelCombustible']").on({
	    mousedown: function() {
	        $j("#indicadorNivel").show();
	    },
	    mouseup: function() {
	        $j("#indicadorNivel").hide();
	    }
	});
	
	$j(document).ready(function() {
		$j("#dirOrigenTxt").hide();
		$j("#dirDestinoTxt").hide();
		$j("#operadorTxt").hide();
		$j("#indicadorNivel").hide();
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
    
    function fValidaOctavos (obj, posiciones){
        var cad = obj.value;
        
        if (!/^([0-8])*$/.test(cad)){
            cad = cad.replace(/[^0-8]+/g,'');
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
	
	
   	function agregaRealizado(){
   		var recorrido  		= [];
   		var dirOrigenTxt 	= $j("#dirOrigenTxt").val();
   		var dirDestinoTxt	= $j("#dirDestinoTxt").val();
   		var nombreOperador 	= $j("[name='idOperador']").children("option").filter(":selected").text().toUpperCase();
	    
	    
	    if(nombreOperador.includes("0TR0")){
	    	if($j("#operadorTxt").val().length == 0){
	    		parent.muestraMensaje("Debe especificar un nombre para el Operador.");
	    		return;
	    	}
	    }
   		
   		if($j("[name='kmIni']").val() > $j("[name='kmFin']").val()){
   			parent.muestraMensaje("El Km Final debe ser mayor al Km Inicial");
   			return;
   		}
   		
   		recorrido.push({ 
	        "entidadOrigen"    		: $j("[name='idEntidadOrigen']").val(),
	        "municipioOrigen"  		: $j("[name='idMunicipioOrigen']").val(),
	        "direccionOrigen"   	: $j("[name='idOrigen']").val(),
	        "txtentidadOrigen"  	: $j("[name='idEntidadOrigen']").children("option").filter(":selected").text(),
	        "txtmunicipioOrigen"	: $j("[name='idMunicipioOrigen']").children("option").filter(":selected").text(),
	        "txtdireccionOrigen"	: $j("[name='idOrigen']").children("option").filter(":selected").text(),
	        "dirOrigenTxt"			: dirOrigenTxt,
	        "salida"    			: $j("[name='salida']").val(),
	        "entidadDestino"    	: $j("[name='idEntidadDestino']").val(),
	        "municipioDestino"  	: $j("[name='idMunicipioDestino']").val(),
	        "direccionDestino"  	: $j("[name='idDestino']").val(),
	        "txtentidadDestino" 	: $j("[name='idEntidadDestino']").children("option").filter(":selected").text(),
	        "txtmunicipioDestino"	: $j("[name='idMunicipioDestino']").children("option").filter(":selected").text(),
	        "txtdireccionDestino"	: $j("[name='idDestino']").children("option").filter(":selected").text(),
	        "dirDestinoTxt"			: dirDestinoTxt,
	        "llegada"    			: $j("[name='llegada']").val(),
	        "kmIni"    				: $j("[name='kmIni']").val(),
	        "kmFin"    				: $j("[name='kmFin']").val(),
	        "operador"    			: $j("[name='idOperador']").val(),
	        "operadorTxt"    		: $j("[name='operadorTxt']").val(),
	        "vehiculo"    			: $j("[name='idVehiculo']").val(),
	        "nivelCombustible"		: $j("[name='nivelCombustible']").val(),
	        "combustibleEntrega"	: $j("[name='combustibleEntrega']").val(),
	        "solicAsociada"    		: $j("[name='idSolCompartida']").val()
	    });
	    
	    if(!parent.validaComentarios(dirOrigenTxt) || !parent.validaComentarios(dirDestinoTxt) || dirOrigenTxt.length > 200 || dirDestinoTxt.length > 200){
	    	parent.muestraMensaje("La dirección proporcionada es invalida o demasiado larga.");
	    	return;
	    }
	    
   		ultimaHora = parent.document.getElementById('ultimaHora').value;
   		var salidaActual = $j("[name='salida']").val();
   		
   		if(compararHoras(ultimaHora, salidaActual)){
	   		if(validaNulos("idOrigen", -1) & validaNulos("salida", "") & validaNulos("idDestino", -1) ){
	   			parent.closeDivagregaRealizado();
	   			parent.agregaRecorridoRealizado(recorrido);
	   		}else{
	   			parent.muestraMensaje("Todos los campos son obligatorios");
	   		}
   		}else{
   			parent.muestraMensaje("La hora de salida que intenta registrar es anterior a la hora de su ultima llegada.");
   		}
   	}
   	
   	function validaNulos(name, criterio){
		var res = true;
		var InputAux = ".recorrido > td > ";
		var selectorAux = ".recorrido > td > table > tbody > tr > td > ";
		
		$j(InputAux + "[name='" + name + "']").each(function() {
		    if($j(this).val() == criterio){
		    	res = res && false;
		    }
		});
		
		$j(selectorAux + "[name='" + name + "']").each(function() {
		    if($j(this).val() == criterio){
		    	res = res && false;
		    }
		});
		
		return res;
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
	
	
	$j('#idOperador').change(function () {
	    var otros = $j("[name='idOperador']").children("option").filter(":selected").text().toUpperCase();
	    
	    if(otros.includes("0TR0")){
	    	console.log("Entro a otros");
	    	$j("#operadorTxt").show();
	    }else{
	    	$j("#operadorTxt").hide();
	    }
	});
	
	
	function compararHoras(hora1, hora2) {
		if(ultimaHora == ""){
			return true;
		}
	
		const [hora1Horas, hora1Minutos] = hora1.split(':').map(Number);
		const [hora2Horas, hora2Minutos] = hora2.split(':').map(Number);
		
		const date1 = new Date();
		date1.setHours(hora1Horas, hora1Minutos, 0, 0);
		
		const date2 = new Date();
		date2.setHours(hora2Horas, hora2Minutos, 0, 0);
		
		if (date2 >= date1) {
			return true;
		} else {
			return false;
		}
	}
	
	
</script>  



