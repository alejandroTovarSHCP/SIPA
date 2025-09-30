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
			<b>Bandeja de Servicios de Mantenimiento</b>
			<hr class="red">
		</h1>
	</div>
</div>

<html:form modelAttribute="servicioDTO" id="initBandejaServicios" action="initBandejaServicios.do" method="post" acceptCharset="ISO_8859-1">
<input type="hidden" id="inmuebleFk" name="inmuebleFk" value="${servicioDTO.inmuebleFk}"/>
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
				<td width="20%" class="label">Estado del servicio:</td>
				<td>
					<fsn:option key="-1" value="selectList.nonValue" />		      	  
					<fsn:selectList beanName="selectBandejaEstadoServicio" path="estadoServicioFk" appendFilters="false" progress="true" style="width:80%"/>
				</td>
			</tr>
		</table>
	</fieldset></td></tr>
	<tr><td>
		<table width="100%" align="center">
			<tr align="center">
				<td><fsn:submit value="submit.search" path="consulta" action="servicios/initBandejaServicios.do"/></td>
			</tr>
		</table>
	</td></tr>
</table>
	<fsn:filter property="INMUEBLE_FK" condition="=" path="inmuebleFk"/>
    <c:if test="${servicioDTO.tipoServicioFk != -1}"> 
			<fsn:filter property="TIPO_SERVICIO_FK" condition="=" path="tipoServicioFk"/>
    </c:if>
    <c:if test="${servicioDTO.estadoServicioFk != -1}"> 
			<fsn:filter property="ESTADO_SERVICIO_FK" condition="=" path="estadoServicioFk"/>
    </c:if>
	<fsn:pagedList  beanName="bandejaMantenimientoServicio" baseUrl="servicios/initBandejaServicios.do" appendFilters="false">
	<div id="displayTagDiv" style="text-align:center;width:1000px;height:300px;overflow:auto;"> 		 		 
		<display:table name="bandejaMantenimientoServicio" style="text-align:center" class="displaytag" pagesize="10" export="false" id="s" requestURI="${requestURI}" sort="list">     				
			<display:column titleKey="sipa.bandeja.servicios.columna0" property="placas" sortable="false"/>
			<display:column titleKey="sipa.bandeja.servicios.columna1" property="tipoServicio" sortable="false"/>
			<display:column  titleKey="sipa.bandeja.servicios.columna2" media="html" sortable="false">				
				<span style="<c:if test="${s.fechaInicio eq 'Por registrar a servicio'}">color:red;</c:if>">
					<c:out value = "${s.fechaInicio}" />
				</span>
			</display:column>				
			<display:column titleKey="sipa.bandeja.servicios.columna3" property="fechaUltimo" sortable="false" />
			<display:column  titleKey="sipa.bandeja.servicios.columna4" media="html" sortable="false">				
				<span style="<c:if test="${s.mesesSin >= 6 }">color:red;</c:if>">
					<c:out value = "${s.mesesSin}" />
				</span>
			</display:column>
			<display:column  titleKey="sipa.bandeja.servicios.columna5" media="html" sortable="false">
				<fmt:formatNumber type = "number" pattern = "###,##0" value = "${s.kmUltimo}" />
			</display:column>
			<display:column  titleKey="sipa.bandeja.servicios.columna6" media="html" sortable="false">
				<fmt:formatNumber type = "number" pattern = "###,##0" value = "${s.kmInicio}" />
			</display:column>
			<display:column  titleKey="sipa.bandeja.servicios.columna7" media="html" sortable="false">				
				<span style="<c:if test="${s.kmActual > 5000 }">color:red;</c:if>">
					<fmt:formatNumber type = "number" pattern = "###,##0" value = "${s.kmActual}" />
				</span>
			</display:column>

			<display:column titleKey="sipa.bandeja.servicios.columna8"  media="html">
				<c:if test="${s.idBitacora == '0'}"> 
					<a href="/sipa/servicios/registraIngServPrev.do?vehiculoFk=${s.vehiculoFk}&pv=true">
						<img alt="Detalle" src='<spring:theme code="detail.gif"/>' height="20" width="20">
					</a>
				</c:if>	
				<c:if test="${s.idBitacora != '0'}"> 
					<a href="/sipa/servicios/registroSalidaServicio.do?idBitacora=${s.idBitacora}&pb=true">
						<img alt="Detalle" src='<spring:theme code="detail.gif"/>' height="20" width="20">
					</a>
				</c:if>	
			</display:column>
			<display:setProperty name="paging.banner.placement" value="bottom"/>
			<display:setProperty name="basic.msg.empty_list">
				<br><span class="pagebanner">&nbsp;</span><span class="norecords"><spring:message code="pagedList.empty.content"/><br><br></span>
			</display:setProperty>      
		 </display:table>   
	</div>
	</fsn:pagedList> 



</html:form>
