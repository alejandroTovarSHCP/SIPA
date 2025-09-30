<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<html:form modelAttribute="recorridoDTO" id="registraRecorrido" name="registraRecorrido" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
	<div class="panel panel-default">
			<div class="panel-body">
				<table width="100%">
					<tr style="background-color:#F0EAEA">
						<th align='center'><b>Lugar de Origen</b></<th>
						<th align='center'><b>Hora de salida</b></<th>
						<th align='center'><b>Lugar de Destino</b></<th>
						<th align='center'><b>Hora de llegada</b></<th>
						<th align='center'><b>Justificación</b></<th>
					</tr>
				
					<tr class="recorrido">
						<td>
							<table border="0" width="100%">
								 <tr>
									<td>
									    <fsn:option key="-1" value="sipa.selectEntidad" />		      	  
								        <fsn:selectList beanName="BuscaEntidad" path="idEntidadOrigen" appendFilters="false" uppercase="false" progress="true" style="width:80%"/>     
									</td>
								</tr>
							     <tr>
									<td>
									    <fsn:option key="-1" value="sipa.selectMunicipio" />		      	  
								        <fsn:selectList beanName="BuscaMunicipio" path="idMunicipioOrigen" parentPath="idEntidadOrigen" uppercase="false" appendFilters="false" progress="true" style="width:80%"/>     
									</td>
								</tr>
							     <tr>
									<td>
									    <fsn:option key="-1" value="sipa.selectInmueble" />		      	  
								        <fsn:selectList beanName="BuscaDomicilio" path="idOrigen" parentPath="idMunicipioOrigen" uppercase="false" appendFilters="false" progress="true" style="width:80%"/>     
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
								        <fsn:selectList beanName="BuscaEntidad" path="idEntidadDestino" uppercase="false" appendFilters="false" progress="true" style="width:80%"/>     
									</td>
								</tr>
							     <tr>
									<td>
									    <fsn:option key="-1" value="sipa.selectMunicipio" />		      	  
								        <fsn:selectList beanName="BuscaMunicipio" path="idMunicipioDestino" parentPath="idEntidadDestino" uppercase="false" appendFilters="false" progress="true" style="width:80%"/>     
									</td>
								</tr>
							     <tr>
									<td>
									    <fsn:option key="-1" value="sipa.selectInmueble" />		      	  
								        <fsn:selectList beanName="BuscaDomicilio" path="idDestino" parentPath="idMunicipioDestino" uppercase="false" appendFilters="false" progress="true" style="width:80%"/>     
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
							<fsn:textarea path="justRecorrido" uppercase="false" cols="38" rows="5"/></td>
						</td>
					</tr>
					<tr>			
					<td colspan=6 align="center">
						<br><br>
						<input type="button" value="Agregar" onclick="javascript:agregaR();">			
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
	
	$j(document).ready(function() {
		$j("#dirOrigenTxt").hide();
		$j("#dirDestinoTxt").hide();
	});
	
	
   	function agregaR(){
   		var recorrido  		= [];
   		var justRecorrido 	= $j("[name='justRecorrido']").val();
   		var dirOrigenTxt 	= $j("#dirOrigenTxt").val();
   		var dirDestinoTxt	= $j("#dirDestinoTxt").val();
   		
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
	        "justRecorrido"			: justRecorrido
	    });
	    
	    
	    if(!parent.validaComentarios(justRecorrido) || justRecorrido.length > 250){
	    	parent.muestraMensaje("La justificación del recorrido es invalidas.");
	    	return;
	    }
	    
	    if(!parent.validaComentarios(dirOrigenTxt) || !parent.validaComentarios(dirDestinoTxt) || dirOrigenTxt.length > 200 || dirDestinoTxt.length > 200){
	    	parent.muestraMensaje("La dirección proporcionada es invalida o demasiado larga.");
	    	return;
	    }
	    
   		
   		ultimaHora = parent.document.getElementById('ultimaHora').value;
   		var salidaActual = $j("[name='salida']").val();
   		
   		if(compararHoras(ultimaHora, salidaActual)){
	   		if(validaNulos("idOrigen", -1) & validaNulos("salida", "") & validaNulos("idDestino", -1) & validaNulos("llegada", "") & validaNulos("justRecorrido", "")){
	   			parent.closeDivagregaRecorrido();
	   			parent.agregaRecorrido(recorrido);
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


