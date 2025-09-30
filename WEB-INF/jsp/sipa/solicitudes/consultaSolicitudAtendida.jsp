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
	<input type="hidden" value="${solicitudDTO.idTipo}" 	 id="tipoSolicitud"/>
	<input type="hidden" id="ultimaHora"/>
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h2><b>Información de la Solicitud</b></h2>
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
				
				<c:if test="${solicitudDTO.idTipo == 2}">
					<tr>
						<td width="40%" class="label">Evidencia de Salida:</td>
						<td>
							<c:if test="${solicitudDTO.tieneEvidencia}">
								<a href="descargaEvidencia.do?folio=${solicitudDTO.folio}&tipo=ENTREGA"> Descargar Evidencia Entrega
									<img alt="Evidencia" src='<spring:theme code="download.gif"/>' height="20" width="20"/>
								</a>
							</c:if>
							
							<c:if test="${!solicitudDTO.tieneEvidencia}">
								Sin Evidencia Entrega.
							</c:if>
				         </td>
					</tr>
					
					<tr>
						<td width="40%" class="label">Evidencia de Llegada:</td>
						<td>
							<c:if test="${solicitudDTO.tieneEvidenciaRecepcion}">
								<a href="descargaEvidencia.do?folio=${solicitudDTO.folio}&tipo=RECEPCION"> Descargar Evidencia Recepción
									<img alt="Evidencia" src='<spring:theme code="download.gif"/>' height="20" width="20"/>
								</a>
							</c:if>
							
							<c:if test="${!solicitudDTO.tieneEvidenciaRecepcion}">
								Sin Evidencia Recepción.
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
				
				<tr id="muestraOperador">
					<td width="40%" class="label">Operador:</td>
					<td>
			         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
				        <fsn:selectList beanName="selectOperadores" path="idOperador" style="width:80%" disabled="true"/>
			         </td>
				</tr>
			</table>
	    </div>
	</div>				
	
	<br><br>
	<div class="panel panel-default">
		<div class="panel-heading">
			<c:if test="${solicitudDTO.idTipo == 1}">
				<h2><b>Trayectos Solicitados</b></h2>
			</c:if>
			<c:if test="${solicitudDTO.idTipo == 2}">
				<h2><b>Trayectos Solicitados de Préstamos</b></h2>
			</c:if>
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
		<c:if test="${solicitudDTO.idTipo == 1}">
			<h2><b>Trayectos Realizados</b></h2>
		</c:if>
		<c:if test="${solicitudDTO.idTipo == 2}">
			<h2><b>Información de Salida-Llegada del Vehículo</b></h2>
		</c:if>
		<hr class="red">
	</div>
	<div class="panel-body">
		<table width="100%">
			<tr style="background-color:#F0EAEA">
				<th align='center'><b>No</b></<th>
				<th align='center'><b>Lugar de Origen</b></<th>
				<th align='center'><b>Hora de salida</b></<th>
				<th align='center'><b>Km inicial</b></<th>
				<th align='center'><b>Combustible Inicial<br>(Octavos)</b></<th>
				<th align='center'><b>Lugar de Destino</b></<th>
				<th align='center'><b>Hora de llegada</b></<th>
				<th class="ocultaOperador" align='center'><b>Operador</b></<th>
				<th align='center'><b>Vehiculo</b></<th>
				<th align='center'><b>Km Final</b></<th>
				<th align='center'><b>Combustible Final<br>(Octavos)</b></<th>
				<th align='center'><b>solicitud Asociada</b></<th>
			</tr>
			
			<c:forEach var="row" items="${solicitudDTO.realizados}">
            	<tr style="background-color:#F0EAEA">
                    <td align='center'><c:out value="${row.orden}"/></td>
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
					
					
					
					<td class="ocultaOperador" align='center'> <c:out value="${row.operadorTxt}"/> </td>
					<td align='center'> <c:out value="${row.vehiculoTxt}"/> </td>
					<td align='center'> <c:out value="${row.kmFin}"/> </td>
					<td align='center'> <c:out value="${row.nivelCombustible}"/> </td>
					
					<c:if test="${row.idSolCompartida == 0}">
						<td align='center'> N/A </td>
					</c:if>
					<c:if test="${row.idSolCompartida != 0}">
						<td align='center'> ${row.folio} </td>
					</c:if>
					
				</tr>
			</c:forEach>
		</table>
   	</div>
</div>
	
<div class="row">
	<div style="text-align: center">
		<br><br><br>
		<input type="button" value="Regresar a la consulta" onclick="javascript:regresar();">
	</div>
</div>	
 
</html:form>
   	
</body>   	


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer type="text/javascript">
	var $j = jQuery.noConflict();

	$j(document).ready(function() {
		$j("input[name=chofer][value='0']").prop("checked",true);
		
		if($j('#requiereChofer').val() == 'true'){
			$j("input[name=chofer][value='1']").prop("checked",true);
		}
		
		
		if($j('#requiereChofer').val() != 'true'){
			$j(".ocultaOperador").hide();
		}
		
		if($j("#tipoSolicitud").val() == 2 && $j('#requiereChofer').val() == 'false'){
			$j("#muestraOperador").hide();
		}
		
	});
	
	function regresar() {
      window.location.href = $j("#rutaRegreso").val();
    }
	
</script>	








