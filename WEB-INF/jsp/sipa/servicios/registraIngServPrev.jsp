<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="html"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tld/fsn/tagutils.tld" prefix="tagutils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<style type="text/css">
textarea {resize:none;}
</style>
<body>
<html:form modelAttribute="servicioDTO" id="registraIngreso" action="" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
<input type="hidden" id="inmuebleFk" name="inmuebleFk" value="${servicioDTO.inmuebleFk}"/>
	<table class="message" id="tbErrores" style='display:none'>
	  <tbody>
		<tr>
		  <td class="error"><img src="<spring:theme code='mensajesErr.gif'/>" alt="error" width="30" height="30"></td>
		  <td>
			<table border="0" cellpadding="0" cellspacing="0" id="tbMensajes">                    
			  <tbody>
								   
			  </tbody>
			</table>
			</td>
		</tr>
	  </tbody>
	</table>
	
	
<div class="panel panel-default">
	<div class="panel-heading">
		<h2><b>Registro Ingreso Servicio<hr class="red"></b></h2>
	</div>


	<div class="panel-body">
		<table width="100%" cellpadding="5">
			<tr>
				<td width="20%" class="label">*Vehículo:</td>
				<td>      	  
					<fsn:selectList beanName="selectVehiculos" path="vehiculoFk" disabled="true" appendFilters="false" progress="true" style="width:80%"/>
				</td>
			</tr>
			<tr>
				<td width="20%" class="label">*Tipo servicio:</td>
				<td>
					<fsn:option key="-1" value="selectList.nonValue" />		      	  
					<fsn:selectList beanName="selectTipoServPrev" path="tipoServicioFk" appendFilters="false" progress="true" style="width:80%"/>
				</td>
			</tr>
			<tr>
			   <td align="right" class="label">*Fecha Inicio del servicio:</td>
			   <td align="left">
					<fsn:calendar path="fechaInicio" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" />
			   </td>
			</tr>
			<tr>
				<td width="100%" class="label">*Descripción del servicio:</td>
				<td><fsn:textarea path="descripcionIni" uppercase="false" cols="75" rows="5" /></td>
			</tr>
			<tr>
				<td width="100%" class="label">*Justificación del servicio:</td>
				<td><fsn:textarea path="justificacion" uppercase="false" cols="75" rows="5" /></td>
			</tr>
			<tr>
				<td width="100%" class="label">*Aseguradora:</td>
				<td>
					<fsn:option key="-1" value="selectList.nonValue" />		      	  
					<fsn:selectList beanName="selectAseguradora" path="aseguradoraFk" appendFilters="false" progress="true" style="width:80%"/>
				</td>
			</tr>
			<tr>
				<td width="100%" class="label">*Orden del servicio:</td>
				<td>
					<fsn:input path="ordenServicio" uppercase="false" maxlength="24" size="28"/>
				</td>
			</tr>
			<tr>
				<td width="100%" class="label">*Kilometraje inicial del servicio:</td>
				<td>
					<fsn:input path="kmInicio" onkeyup="soloNumeros($(this))" uppercase="false" maxlength="6" size="6"/>km
				</td>
			</tr>
			<tr>
				<td width="100%" class="label">*Nivel de combustible inicial:</td>
				<td>
					<fsn:input path="combustibleInicio" onkeyup="soloOctavos($(this))"  uppercase="false" maxlength="1" size="1"/>octavo(s)
				</td>
			</tr>
			<tr>
				<td width="40%" class="label">*Evidencia visual inicial:</td>
				<td>
					<input type="file"  name="evidenciaIni" id="evidenciaIni" accept="*.pdf" size="50"/>
				 </td>
			</tr>
		</table>
    </div>
</div>

	
<div class="row">
	<div style="text-align: center">
		<div role="group">
			<br><br><br><br><br>
            <fsn:submit value="submit.save" 
			path="guardaIni" action="servicios/guardaIngresoServicio" 
			onclick="return guardaIngreso(event)"  progressBar="true"/> 
			&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;
			<fsn:submit value="submit.back" 
			path="regresar" action="servicios/initBandejaServicios" progressBar="true"/> 
		</div>
	</div>
</div>	
 
</html:form>
   	
</body>   	


<script type="text/javascript" defer src="../js/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/toastr.min.css"/>
<script type="text/javascript" defer src="../js/servicios.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>




