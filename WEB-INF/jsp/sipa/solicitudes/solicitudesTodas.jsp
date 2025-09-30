<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>

<div class="panel panel-default">
	<div class="panel-heading">
		<h1>
			<b>Consulta de Solicitudes</b>
			<hr class="red">
		</h1>
	</div>
</div>

<html:form modelAttribute="solicitudDTO" id="invocaRegistradasApp" action="invocaSolicitudesApp.do" acceptCharset="ISO_8859-1">
<input type="hidden" value="${accion}" 		id="accion"/>
<input type="hidden" value="${resultado}" 	id="resultado"/>

<table width="60%" align="center">
	<tr><td><fieldset>
	 <legend style="font-size:1.3em"><strong>&nbsp;&nbsp;Búsqueda de Solicitudes&nbsp;&nbsp; </strong></legend>
		<table align="center" width="100%">
			<tr>
			   <td align="right" class="label">Folio</td>
			   <td align="left">
					<fsn:input path="folio" uppercase="true" maxlength="12" size="30"/>
			   </td>
			</tr>
			<tr>
			   <td align="right" class="label">Fecha del servicio:</td>
			   <td align="left">
					<fsn:calendar path="fecha" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" />
			   </td>
			</tr>
			<tr>
				<td width="40%" class="label">Estatus:</td>
				<td>
		         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
			        <fsn:selectList beanName="selectEstadosSol" path="idEstado" appendFilters="false" progress="true" style="width:80%"/>
		         </td>
			</tr>
			<tr>
				<td width="40%" class="label">Punto Origen:</td>
				<td>
		         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
			        <fsn:selectList beanName="selectPunto" path="puntoSalida" appendFilters="false" progress="true" style="width:80%"/>
		         </td>
			</tr>
			<tr>
				<td width="40%" class="label">Punto Destino:</td>
				<td>
		         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
			        <fsn:selectList beanName="selectPunto" path="puntoLlegada" appendFilters="false" progress="true" style="width:80%"/>
		         </td>
			</tr>
			<tr>
				<td width="40%" class="label">Tipo Solicitud:</td>
				<td>
		         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
			        <fsn:selectList beanName="selectTipoSolicitud" path="idTipo" appendFilters="false" progress="true" style="width:80%"/>
		         </td>
			</tr>
		</table>
	</fieldset></td></tr>
	<tr><td>
		<table width="100%" align="center">
			<tr align="center">
				<td><fsn:submit value="submit.search" path="consulta" action="solicitudes/invocaSolicitudesApp.do"/></td>
			</tr>
		</table>
	</td></tr>
</table>

<fsn:filter property="folio" condition="=" path="folio"/>
<fsn:filter property="fecha" condition="=" path="fecha"/>
<fsn:filter property="idEstado" condition="=" path="idEstado"/>
<fsn:filter property="idTipo" condition="=" path="idTipo"/>
<fsn:filter property="puntoSalida" condition="=" path="puntoSalida"/>
<fsn:filter property="puntoLlegada" condition="=" path="puntoLlegada"/>

<fsn:pagedList service="gob.shcp.sipa.service.SolicitudesService" baseUrl="invocaSolicitudesApp" />
<display:table name="SolicitudesService" class="displaytag" pagesize="20" id="pe" requestURI="${requestURI}" sort="list" style="text-align:center" export="false">	
	    <display:column titleKey="sipa.consulta.solicitudes.columna1" property="folio" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.solicitudes.columna2" property="fecha" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.solicitudes.columna5" property="descEstado" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.solicitudes.columna6" property="descTipo" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.solicitudes.columna3" property="puntoSalida" maxLength="50" style="text-align:center"/>
	    <display:column titleKey="sipa.consulta.solicitudes.columna4" property="puntoLlegada" maxLength="50" style="text-align:center"/>
	    <c:if test="${solicitudDTO.rolUsuario == 'COORDINADOR'}">
	    	<display:column titleKey="sipa.consulta.solicitudes.columna7" property="nombreSolicitante" maxLength="50" style="text-align:center"/>
	    </c:if>
		<display:column titleKey="sipa.consulta.operadores.columna0" style="text-align:center" media="html">
			<a href="/sipa/solicitudes/invocaSolicitud.do?idSolicitud=${pe.idSolicitud}&tipo=CONSULTA&rutaRegreso=${solicitudDTO.rutaRegreso}">
				<img alt="Detalle" src='<spring:theme code="detail.gif"/>' height="20" width="20">
			</a>
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
</html:form>


<script type="text/javascript" defer src="../js/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/toastr.min.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer type="text/javascript">
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
	
	function modalEliminacion(idSolicitud, resultado, mensaje){
		
		var cierre = "function closeDiveliminarSolicitudxxx(){var onCloseFunction = '';if(onCloseFunction.length>0){window.parent.eval(onCloseFunction);}" + 
        			 "document.getElementById('diveliminarSolicitudxxx').style.visibility='hidden';document.getElementById('frameeliminarSolicitudxxx').src=''; mensaje}";
   		cierre = cierre.replaceAll("xxx", idSolicitud);
   		cierre = cierre.replace("mensaje", "Command: toastr['" + resultado + "']('"+ mensaje +"', 'Solicitud')");
		eval(cierre);
		eval("closeDiveliminarSolicitud" + idSolicitud + "()");
		
		if(resultado == "success"){
			$j("#diveditarSolicitud" + idSolicitud).closest("tr").remove();
		}
		
	}
	
</script>





