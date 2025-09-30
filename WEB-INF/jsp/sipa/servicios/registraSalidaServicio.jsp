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
<html:form modelAttribute="servicioDTO" id="registraSalida" action="" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
<html:hidden path="costoServicio"/>
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
	
<input type="hidden" id="consecutivo"/>	
<div class="panel panel-default">
	<div class="panel-heading">
		<h2><b>Registro Salida Servicio<hr class="red"></b></h2>
	</div>


	<div class="panel-body">
		<table width="100%" cellpadding="5">
			<tr>
				<td width="20%" class="label">Folio del servicio:</td>
				<td>      	  
					<fsn:input path="idBitacora"  readonly="true" maxlength="10" size="15"/>
				</td>
			</tr>
			<tr>
				<td width="20%" class="label">Vehículo:</td>
				<td>      	  
					<fsn:selectList beanName="selectVehiculosServFin" path="vehiculoFk" disabled="true" appendFilters="false" progress="true" style="width:80%"/>
				</td>
			</tr>
			<tr>
				<td width="20%" class="label">Tipo servicio:</td>
				<td>	      	  
					<fsn:selectList beanName="selectTipoServicio" path="tipoServicioFk" disabled="true" appendFilters="false" progress="true" style="width:80%"/>
				</td>
			</tr>
			<tr>
			   <td align="right" class="label">Fecha Inicio del servicio:</td>
			   <td align="left">
					<fsn:input path="fechaInicio"  readonly="true" maxlength="10" size="15"/>
			   </td>
			</tr>
			<tr>
				<td width="100%" class="label">Descripción del servicio:</td>
				<td><fsn:textarea path="descripcionIni" uppercase="false" disabled="true" cols="75" rows="5" /></td>
			</tr>
			<tr>
				<td width="100%" class="label">Justificación del servicio:</td>
				<td><fsn:textarea path="justificacion" uppercase="false" disabled="true" cols="75" rows="5" /></td>
			</tr>
			<tr>
				<td width="100%" class="label">Aseguradora:</td>
				<td>	      	  
					<fsn:selectList beanName="selectAseguradora" disabled="true" path="aseguradoraFk" appendFilters="false" progress="true" style="width:80%"/>
				</td>
			</tr>
			<tr>
				<td width="100%" class="label">Orden del servicio:</td>
				<td>
					<fsn:input path="ordenServicio" uppercase="false" readonly="true" maxlength="24" size="28"/>
				</td>
			</tr>
			<tr>
				<td width="100%" class="label">Kilometraje inicial del servicio:</td>
				<td>
					<fsn:input path="kmInicio" uppercase="false" readonly="true" maxlength="6" size="6"/>km
				</td>
			</tr>
			<tr>
				<td width="100%" class="label">Nivel de combustible inicial:</td>
				<td>
					<fsn:input path="combustibleInicio"  readonly="true" uppercase="false" maxlength="1" size="1"/>octavo(s)
				</td>
			</tr>
			<tr>
				<td width="100%" class="label">Evidencia visual inicial:</td>
				<td>
					<a href="descargaEvidencia.do?idBitacora=${servicioDTO.idBitacora}&tipo=1" target="_blank" rel="noopener noreferrer"> Descargar Evidencia Inicial
						<img alt="EvidenciaIni" src='<spring:theme code="download.gif"/>' height="20" width="20"/>
					</a>		
				 </td>
			</tr>
			<tr>
			   <td align="right" class="label">*Fecha Fin del servicio:</td>
			   <td align="left">
					<fsn:calendar path="fechaFin" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" />
			   </td>
			</tr>
			<tr>
				<td width="100%" class="label">*Descripción final del servicio:</td>
				<td><fsn:textarea path="descripcionFinal" uppercase="false" cols="75" rows="5" /></td>
			</tr>
			<tr>
				<td width="100%" class="label">*Costo del servicio:</td>
				<td>
					<input type="text" name="costoServicioS" id="costoServicioS" onkeyup="formatCurrency($j(this))" onblur="formatCurrency($j(this), 'blur')" style="text-align:right" data-type="currency" placeholder="0.00">
				</td>

			</tr>
			<tr>
				<td width="100%" class="label">*Kilometraje final del servicio:</td>
				<td>
					<fsn:input path="kmFin" onkeyup="soloNumeros($(this))" uppercase="false" maxlength="6" size="6"/>km
				</td>
			</tr>
			<tr>
				<td width="100%" class="label">*Nivel de combustible final:</td>
				<td>
					<fsn:input path="combustibleFin" onkeyup="soloOctavos($(this))"  uppercase="false" maxlength="1" size="1"/>octavo(s)
				</td>
			</tr>
			<tr>
				<td width="40%" class="label">*Evidencia visual final:</td>
				<td>
					<input type="file" name="evidenciaFin" id="evidenciaFin" accept="*.pdf" size="50"/>
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
			path="guardaFin" action="servicios/guardaSalidaServicio" 
			onclick="return guardaSalida(event)"  progressBar="true"/> 
			&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;
			<fsn:submit value="submit.back" 
			path="regresar" action="servicios/initBandejaServicios" progressBar="true"/> 
		</div>
	</div>
</div>	
 
</html:form>
   	
</body>   	

<script type="text/javascript" defer src="../js/servicios.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" defer src="../js/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/toastr.min.css"/>




