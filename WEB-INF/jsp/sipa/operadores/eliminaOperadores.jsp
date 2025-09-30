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
			<div class="panel-heading"><h2><b>DESEA ELIMINAR EL SIGUIENTE OPERADOR:</b></h2></div>
		</div>
	</div>
</div>
   	
<html:form modelAttribute="operadorDTO" id="eliminaOperador" name="eliminaOperador">
	<input type="hidden" value="${operadorDTO.idOperador}" id="idOperador" name="idOperador"/>
	
	<table border="0" width="100%">
		<tr>
			<td>
			Nombre: ${operadorDTO.nombre}<br>
			RFC: ${operadorDTO.rfc}<br>
			Correo: ${operadorDTO.correo}<br>
			Telefono: ${operadorDTO.telefono}<br>
			</td>
		</tr>
		
		<tr>			
			<td colspan=2 align="center">
				<input type="button" value="Eliminar"  onclick="javascript:eliminarOperador();">				
			</td>
		</tr>	
		
	</table>
     
</html:form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer type="text/javascript">
   	
   	function eliminarOperador(){
   		var idOperador = $("#idOperador").val();
   	
   		$.ajax({
			url: 'eliminarOperador.do',
			type: 'POST',
			data: {
				idOperador: idOperador
			},			        
			success : function(data) {
				parent.modalEliminacion(idOperador, data[0], data[1]);
			}
		 });
   	}
</script>   
    
  
       

