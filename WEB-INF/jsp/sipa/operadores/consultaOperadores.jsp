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
 <legend style="font-size:1.3em"><strong>&nbsp;&nbsp;Nuevo Operador&nbsp;&nbsp; </strong></legend>
	<table align="center" width="100%">
		<tr align="center">
			<td>
				<fsn:window  
           		name="agregaOperador" 
           		uri="operadores/invocaAltaOper.do" 
               	image="add.gif" 
               	width="700"  
               	height="400" 
               	title="Agregar Operador" 
               	params=""
               />
			</td>
		</tr>
		<td></td><td></td>
	</table>
</fieldset></td></tr>
</table>

<html:form modelAttribute="operadorDTO" id="invocaOperadoresApp" action="invocaOperadoresApp.do" acceptCharset="ISO_8859-1">


<table width="60%" align="center">
		<tr><td><fieldset>
		 <legend style="font-size:1.3em"><strong>&nbsp;&nbsp;Búsqueda de Operador&nbsp;&nbsp; </strong></legend>
			<table align="center" width="100%">
				<tr>
				   <td align="right" class="label">RFC</td>
				   <td align="left">
						<fsn:input path="rfc" uppercase="true" maxlength="24" size="30"/>
				   </td>
				</tr>
				
			</table>
		</fieldset></td></tr>
		<tr><td>
			<table width="100%" align="center">
				<tr align="center">
					<td><fsn:submit value="submit.search" path="consulta" action="operadores/invocaOperadoresApp.do"/></td>
				</tr>
			</table>
		</td></tr>
    </table>
	<p>&nbsp;</p>


	
<input type="hidden" value="${accion}" id="accion"/>
<input type="hidden" value="${resultado}" id="resultado"/>
	

<fsn:filter property="rfc" condition="=" path="rfc"/>

<fsn:pagedList service="gob.shcp.sipa.service.OperadoresService" />

<display:table name="OperadoresService" class="displaytag" pagesize="20" id="pe" sort="list" style="text-align:center" export="false">	
	    ${requestURI}
	    <display:column titleKey="sipa.consulta.operadores.columna1" property="nombre" maxLength="50" style="text-align:center"/>
		<display:column titleKey="sipa.consulta.operadores.columna2" property="rfc" maxLength="50" style="text-align:center"/>
		<display:column titleKey="sipa.consulta.operadores.columna3" property="correo" maxLength="50" style="text-align:center"/>
		<display:column titleKey="sipa.consulta.operadores.columna4" property="telefono" maxLength="50" style="text-align:center"/>
		<display:column titleKey="sipa.consulta.operadores.columna5" property="extension" maxLength="50" style="text-align:center"/>
		<display:column titleKey="sipa.consulta.operadores.columna6" property="entrada" maxLength="50" style="text-align:center"/>
		<display:column titleKey="sipa.consulta.operadores.columna7" property="salida" maxLength="50" style="text-align:center"/>
		<display:column titleKey="sipa.consulta.operadores.columna8" property="descEstado" maxLength="50" style="text-align:center"/>
	    
	    <display:column titleKey="sipa.consulta.operadores.columna0" style="text-align:center" media="html">
	    	<fsn:window name="editarOperador${pe.idOperador}" uri="operadores/invocaEditarOperador.do?idOperador=${pe.idOperador}" image="edit.gif" width="700" height="500" title="Editar Operador" />
	    
			<fsn:window name="eliminarOperador${pe.idOperador}" uri="operadores/invocaEliminarOperador.do?idOperador=${pe.idOperador}" image="delete.gif" width="500" height="200" title="Eliminar Operador" />
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
<script type="text/javascript">
	
	
	function modalEliminacion(idOperador, resultado, mensaje){
	
		var cierre = "function closeDiveliminarOperadorxxx(){var onCloseFunction = '';if(onCloseFunction.length>0){window.parent.eval(onCloseFunction);}" + 
        			 "document.getElementById('diveliminarOperadorxxx').style.visibility='hidden';document.getElementById('frameeliminarOperadorxxx').src=''; mensaje}";
   		cierre = cierre.replaceAll("xxx", idOperador);
   		cierre = cierre.replace("mensaje", "Command: toastr['" + resultado + "']('"+ mensaje +"', 'Operador')");
		eval(cierre);
		eval("closeDiveliminarOperador" + idOperador + "()");
		
		return;
	}



	var $j = jQuery.noConflict();
	
	$j( document ).ready(function() {
		
		if($j('#accion').val().length > 0){
			Command: toastr[$j('#resultado').val()]($j('#accion').val());
			$j('#accion').val('');
			return;
		}
		
		return;
		
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






