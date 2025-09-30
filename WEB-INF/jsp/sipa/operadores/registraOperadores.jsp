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
			<div class="panel-heading"><h2><b>AGREGAR OPERADOR</b></h2></div>
		</div>
	</div>
</div>
   	
<html:form modelAttribute="operadorDTO" id="registraOperador" name="registraOperador" action="" method="post" enctype="multipart/form-data" acceptCharset="ISO_8859-1">
	<table border="0" width="100%">
		<tr>
			<td width="40%" class="label">Nombre:</td>
			<td><fsn:input  path="nombre" uppercase="false" maxlength="40" size="45" />   </td>
		</tr>
	
		<tr>
			<td width="40%" class="label">RFC:</td>
			<td><fsn:input  path="rfc" uppercase="false" maxlength="13" size="45" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Correo:</td>
			<td><fsn:input  path="correo" uppercase="false" maxlength="40" size="45" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Telefono:</td>
			<td><fsn:input  path="telefono" uppercase="false" maxlength="15" size="45" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Extension:</td>
			<td><fsn:input  path="extension" uppercase="false" maxlength="5" size="45" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Unidad Admin.:</td>
			<td><fsn:input  path="uniadAdmin" uppercase="false" maxlength="40" size="45" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Entrada:</td>
			<td><fsn:input  path="entrada" uppercase="false" maxlength="8" size="45" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Salida:</td>
			<td><fsn:input  path="salida" uppercase="false" maxlength="8" size="45" /></td>
		</tr>
		
		<tr>
			<td width="40%" class="label">Estatus:</td>
			<td>
	         	<fsn:option key="-1" value="selectList.nonValue" />		      	  
		        <fsn:selectList beanName="selectEstatusCatalogos" path="idEstado" appendFilters="false" progress="true" style="width:80%"/>
	         </td>
		</tr>
		
		<tr>			
			<td colspan=2 align="center">
				
				<fsn:submit value="Guardar" path="guardar" action="operadores/registraNuevoOperador.do"/>
													
			</td>
		</tr>
			
		   				
	</table>
     
</html:form>

