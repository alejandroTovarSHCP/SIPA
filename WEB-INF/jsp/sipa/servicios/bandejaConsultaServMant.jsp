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
			<b>Historial de Servicios de Mantenimiento</b>
			<hr class="red">
		</h1>
	</div>
</div>

<html:form modelAttribute="servicioDTO" id="initHistServicios" action="initHistServicios.do" method="post" acceptCharset="ISO_8859-1">
<input type="hidden" id="inmuebleFk" name="inmuebleFk" value="${servicioDTO.inmuebleFk}"/>
<input type="hidden" id="estadoServicioFk" name="estadoServicioFk" value="${servicioDTO.estadoServicioFk}"/>
<table width="60%" align="center">
	<tr><td><fieldset>
	 <legend style="font-size:1.3em"><strong>&nbsp;&nbsp;Búsqueda de Solicitudes&nbsp;&nbsp; </strong></legend>
		<table align="center" width="100%">
			<tr>
				<td width="20%" class="label">Tipo servicio:</td>
				<td>
					<fsn:option key="-1" value="selectList.nonValue" />		      	  
					<fsn:selectList beanName="selectTipoServicio" path="tipoServicioFk" appendFilters="false" progress="true" style="width:80%"/>
				</td>
			</tr>
			<tr>
				<td width="20%" class="label">Placas:</td>
				<td>
					<fsn:filter property="INMUEBLE_FK" condition="=" path="inmuebleFk"/>
					<fsn:option key="-1" value="selectList.nonValue" />		      	  
					<fsn:selectList beanName="selectVehiConsultaServ" path="vehiculoFk" appendFilters="false" progress="true" style="width:80%"/>
				</td>
			</tr>
			<tr>
				<td width="20%" class="label">Folio:</td>
				<td>
					<fsn:autocomplete beanName="autoCompleteFolio" path="idBitacora"  size="20" appendFilters="false"  minChars="1" />
				</td>
				<td><a href="javascript:limpiaCampo('idBitacora_');limpiaCampo('idBitacora');"><img src="<spring:theme code="clear.gif"/>"  alt="limpiar" border=0 align="rigth" ></a></td>
			</tr>
			<tr>
				<td width="20%" class="label">Fecha Inicio del Servicio:</td>
				<td>
					<fsn:calendar path="fechaInicio" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" readonly="true"/> a <fsn:calendar path="fechaIni2" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" readonly="true"/>
				</td>
			</tr>
			<tr>
				<td width="20%" class="label">Fecha Fin del Servicio:</td>
				<td>
					<fsn:calendar path="fechaFin" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" readonly="true"/> a <fsn:calendar path="fechaFin2" size="15" maxlength="10" dateFormat="%d-%m-%Y" javaDateFormat="dd-MM-yyyy" readonly="true"/>
				</td>
			</tr>
		</table>
	</fieldset></td></tr>
	<tr><td>
		<table width="100%" align="center">
			<tr align="center">
				<td><fsn:submit value="submit.search" path="consultaH" action="servicios/initHistServicios.do"/></td>
			</tr>
		</table>
	</td></tr>
</table>
	<fsn:filter property="INMUEBLE_FK" condition="="  type="Integer" path="inmuebleFk"/>
	<fsn:filter property="ESTADO_SERVICIO_FK" condition="="  path="estadoServicioFk"/>
    <c:if test="${servicioDTO.tipoServicioFk != -1}"> 
		<fsn:filter property="TIPO_SERVICIO_FK" condition="=" path="tipoServicioFk"/>
    </c:if>
    <c:if test="${servicioDTO.vehiculoFk != -1}"> 
		<fsn:filter property="VEHICULO_FK" condition="=" path="vehiculoFk"/>
    </c:if>
	<c:if test="${servicioDTO.idBitacora != null}"> 
		<fsn:filter property="ID_BITACORA" condition="=" path="idBitacora"/>
	</c:if>
	<c:if test="${servicioDTO.fechaInicio != null && servicioDTO.fechaInicio != ''}"> 
		<fsn:filter property="FECHA_INICIO" condition="" path="fechaInicio"/>
	</c:if>
	<c:if test="${servicioDTO.fechaIni2 != null && servicioDTO.fechaIni2 != ''}"> 
		<fsn:filter property="FECHA_INICIO2" condition="" path="fechaIni2"/>
	</c:if>
	<c:if test="${servicioDTO.fechaFin!= null && servicioDTO.fechaFin != ''}"> 
		<fsn:filter property="FECHA_FIN" condition="" path="fechaFin"/>
	</c:if>
	<c:if test="${servicioDTO.fechaFin2 != null && servicioDTO.fechaFin2 != ''}"> 
		<fsn:filter property="FECHA_FIN2" condition="" path="fechaFin2"/>
	</c:if>

	<fsn:pagedList  service="gob.shcp.sipa.service.ServiciosService" baseUrl="initHistServicios" appendFilters="false">
	<div id="displayTagDiv" style="text-align:center;width:1000px;height:300px;overflow:auto;"> 		 		 
		<display:table name="ServiciosService" style="text-align:center" class="displaytag" pagesize="10" export="true" id="s" requestURI="${requestURI}" sort="list">     				
			<display:column titleKey="sipa.bandeja.servicios.columna12" property="idBitacora" sortable="false"/>
			<display:column titleKey="sipa.bandeja.servicios.columna0" property="placas" sortable="false"/>
			<display:column titleKey="sipa.bandeja.servicios.columna13" property="marca" sortable="false"/>
			<display:column titleKey="sipa.bandeja.servicios.columna14" property="modelo" sortable="false"/>
			<display:column titleKey="sipa.bandeja.servicios.columna1" property="tipoServicioDesc" sortable="false"/>
			<display:column titleKey="sipa.bandeja.servicios.columna2" property="fechaInicio" sortable="false" />
			<display:column titleKey="sipa.bandeja.servicios.columna9" property="fechaFin" sortable="false" />
			<display:column titleKey="sipa.bandeja.servicios.columna8"  media="html">
				<c:if test="${s.idBitacora != '0'}"> 
					<a href="/sipa/servicios/detalleServicio.do?idBitacora=${s.idBitacora}&pb=true">
						<img alt="Detalle" src='<spring:theme code="detail.gif"/>' height="20" width="20">
					</a>
				</c:if>	
			</display:column>
			<display:setProperty name="paging.banner.placement" value="bottom"/>
			<display:setProperty name="export.excel" value="true"/>
			<display:setProperty name="export.excel.filename" value="ConsultaServicios.xls"/>
			<display:setProperty name="basic.msg.empty_list">
				<br><span class="pagebanner">&nbsp;</span><span class="norecords"><spring:message code="pagedList.empty.content"/><br><br></span>
			</display:setProperty>      
		 </display:table>   
	</div>
	</fsn:pagedList> 



</html:form>
     <script type="text/javascript">


    document.forms[0].idBitacora_.value = document.forms[0].idBitacora.value;
 
            	
  	function limpiaCampo (fieldName) {
		 document.getElementById(fieldName).value="";
		 document.getElementById('fechaInicio').value="";
		 document.getElementById('text_fechaInicio').value="";
		 document.getElementById('fechaFin').value="";
		 document.getElementById('text_fechaFin').value="";
		 document.getElementById('fechaIni2').value="";
		 document.getElementById('text_fechaIni2').value="";
		 document.getElementById('fechaFin2').value="";
		 document.getElementById('text_fechaFin2').value="";
  	}
  	
  	
  	
  	
</script>