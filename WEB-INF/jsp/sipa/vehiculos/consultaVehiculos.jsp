<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>


<table width="60%" align="center">
<tr><td><fieldset>
 <legend style="font-size:1.3em"><strong>&nbsp;&nbsp;Nuevo Vehiculo&nbsp;&nbsp; </strong></legend>
	<table align="center" width="100%">
		<tr align="center">
			<td>
				<fsn:window  
           		name="agregaVehiculo" 
           		uri="vehiculos/invocaAltaVehiculo.do" 
               	image="add.gif" 
               	width="700"  
               	height="500" 
               	title="Agregar Vehiculo" 
               	params=""
               />
			</td>
		</tr>
		<td></td><td></td>
	</table>
</fieldset></td></tr>
</table>

<html:form modelAttribute="vehiculoDTO" id="invocaAutosApp" action="invocaAutosApp.do" acceptCharset="ISO_8859-1">


<table width="60%" align="center">
		<tr><td><fieldset>
		 <legend style="font-size:1.3em"><strong>&nbsp;&nbsp;Datos del Vehiculo&nbsp;&nbsp; </strong></legend>
			<table align="center" width="100%">
				<tr>
				   <td align="right" class="label">Placas</td>
				   <td align="left">
						<fsn:input path="placas" uppercase="true" maxlength="24" size="30"/>
				   </td>
				</tr>
				
			</table>
		</fieldset></td></tr>
		<tr><td>
			<table width="100%" align="center">
				<tr align="center">
					<td><fsn:submit value="submit.search" path="consulta" action="vehiculos/invocaAutosApp.do"/></td>
				</tr>
			</table>
		</td></tr>
    </table>
	<p>&nbsp;</p>


	
<input type="hidden" value="${accion}" id="accion"/>
<input type="hidden" value="${resultado}" id="resultado"/>
	


<c:if test="true">

<fsn:filter property="placas" condition="=" path="placas"/>

<fsn:pagedList service="gob.shcp.sipa.service.VehiculosService" baseUrl="invocaAutosApp"/>

<display:table name="VehiculosService" class="displaytag" pagesize="20" id="pe" requestURI="${requestURI}" sort="list" style="text-align:center" export="false">	
	    
	    <display:column titleKey="sipa.consulta.vehiculos.columna1" property="placas" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna2" property="marca" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna3" property="modelo" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna4" property="color" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna5" property="anio" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.vehiculos.columna6" property="descEstado" maxLength="50" style="text-align:center"/>
	    
	    <display:column titleKey="sipa.consulta.vehiculos.columna0" style="text-align:center" media="html">
	    	<fsn:window name="editarVehiculo${pe.idVehiculo}" uri="vehiculos/invocaEditarVehiculo.do?idVehiculo=${pe.idVehiculo}" image="edit.gif" width="700" height="500" title="Editar Vehiculo" />
	    
			<fsn:window name="eliminarVehiculo${pe.idVehiculo}" uri="vehiculos/invocaEliminarVehiculo.do?idVehiculo=${pe.idVehiculo}" image="delete.gif" width="500" height="200" title="Eliminar Vehiculo" />
		</display:column>
    
    <display:setProperty name="paging.banner.placement" value="bottom"/> 
    <display:setProperty name="export.excel" value="true"/>
    <display:setProperty name="export.pdf" value="true"/>
    <display:setProperty name="export.excel.filename" value="MisSolicitudes.xls"/>
    <display:setProperty name="export.pdf.filename" value="MisSolicitudes.pdf"/> 
    <display:setProperty name="basic.msg.empty_list">
    	<br><span class="pagebanner">&nbsp;</span><span class="norecords"><spring:message code="pagedList.empty.content"/><br><br></span>
    </display:setProperty>
</display:table>
</c:if>	

</html:form>


<script type="text/javascript" defer src="../js/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/toastr.min.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	var $j = jQuery.noConflict();
	
	$j( document ).ready(function() {
		
		if($j('#accion').val().length > 0){
			Command: toastr[$j('#resultado').val()]($j('#accion').val());
			$j('#accion').val('');
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

</script>






