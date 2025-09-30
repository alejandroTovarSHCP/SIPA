<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="fsn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<body> 
<div style="text-align: center;">
	<h1>Dashboard de Pool Vehicular</h1>
</div><br>

<h1>Solicitudes<hr class="red"></h1>
<div class="dashboard">
	
<c:if test="${rol == 'FUNCIONARIO'}">
		<c:forEach var="item" items="${conteos}" varStatus="i">
			<c:if test='${fn:startsWith(item.nombre, "Sol")}'>
				<div class="card <c:out value="${item.color}"/>"  onclick="redirigir('/sipa/solicitudes/invocaSolicitudesApp.do')">
					<div class="title"><c:out value="${item.nombre}"/></div>
					<div class="number"><c:out value="${item.conteo}"/></div>
				</div>
			</c:if>
		</c:forEach>
	</div><br>
</c:if>

<c:if test="${rol == 'COORDINADOR'}">
		<c:forEach var="item" items="${conteos}" varStatus="i">
		<c:if test='${fn:startsWith(item.nombre, "Sol")}'>
			<div class="card <c:out value="${item.color}"/>"  onclick="redirigir('<c:out value="${item.rutaRedireccion}"/>')">
				<div class="title"><c:out value="${item.nombre}"/></div>
				<div class="number"><c:out value="${item.conteo}"/></div>
			</div>
		</c:if>
	</c:forEach>
	</div><br>

	<h1>Vehículos<hr class="red"></h1>
	<div class="dashboard">
		
		<c:forEach var="item" items="${conteos}" varStatus="i">
			<c:if test='${fn:startsWith(item.nombre, "Veh")}'>
				<div class="card <c:out value="${item.color}"/>"  onclick="redirigir('<c:out value="${item.rutaRedireccion}"/>')">
					<div class="title"><c:out value="${item.nombre}"/></div>
					<div class="number"><c:out value="${item.conteo}"/></div>
				</div>
			</c:if>
		</c:forEach>
	</div><br>
		
	<h1>Servicios<hr class="red"></h1>
	<div class="dashboard">
		
		<c:forEach var="item" items="${conteos}" varStatus="i">
			<c:if test='${fn:startsWith(item.nombre, "Serv")}'>
				<div class="card <c:out value="${item.color}"/>"  onclick="redirigir('<c:out value="${item.rutaRedireccion}"/>')">
					<div class="title"><c:out value="${item.nombre}"/></div>
					<div class="number"><c:out value="${item.conteo}"/></div>
				</div>
			</c:if>
		</c:forEach>
	</div>
	
	<br><br>
	
	<h1>Estadísticas<hr class="red"></h1>
	
	<div class="contenedor"> 
		<div class="card colorConductor" onclick="abreModalConductores()">
			<div class="title">Conductores</div>
			<div class="icono">
		  		<img src='../images/consuctor_sipa.jpg' width="40" height="40" />
		  	</div>
		</div>
		<div class="card colorVehiculo" onclick="abreModalVehiculos()">
		  	<div class="title">Vehículo</div>
	  		<div class="icono">
	  			<img src='../images/vehiculo_sipa.jpg' width="40" height="40" />
	  		</div>
		</div>
		<div class="card colorServicio" onclick="abreModalServicios()">
		  	<div class="title">Servicios de Mantenimiento a los Vehículos</div>
		  	<div class="icono">
		  		<img src='../images/servicio_sipa.jpg' width="40" height="40" />
		  	</div>
		</div>
	</div>

	<div id="modalesEstadistica">
		<fsn:window name="conductoresModal" uri="solicitudes/invocaConductoresModal.do" image="delete.gif" width="800" height="450" title="Conductores" />
		<fsn:window name="vehiculosModal" 	uri="solicitudes/invocaVehiculosModal.do" 	image="delete.gif" width="800" height="450" title="Vehículos" />
		<fsn:window name="serviciosModal" 	uri="solicitudes/invocaServiciosModal.do" 	image="delete.gif" width="800" height="450" title="Servicios de Mantenimiento a los Vehículos" />
	</div>
</c:if>

<style>
	.contenedor {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  gap: 20px;
	}

    .dashboard {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      max-width: 1000px;
      margin: 0 auto;
    }

    .card {
      padding: 15px;
      color: white;
      border-radius: 10px;
      font-weight: bold;
      cursor: pointer;
	  transition: all 0.3s ease;
	  text-align: center;
    }

	.card:hover {
	  background-color: coral;
	  transform: scale(1.05);
	  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
	}

    .title {
      font-size: 16px;
      margin-bottom: 10px;
    }

    .number {
      font-size: 36px;
      text-align: center;
    }

    .azul-oscuro { background-color: #001f5b; }
    .rojo { background-color: #b30000; }
    .oro { background-color: #b38f00; }
    .azul { background-color: #408ca5; }
    .verde { background-color: #00b36b; }
    .morado { background-color: #9856c0; }
    .rojo-brillante { background-color: #ff1a1a; }
    .naranja { background-color: #e67e22; }
    .verde-oscuro { background-color: #007b33; }
    .marron { background-color: #823f2f; }
    .azul-claro { background-color: #7fb3d5; }
    .amarillo-oscuro { background-color: #806000; }
    .navy {background-color: #000080}
    .deepskyblue{background-color: #00BFFF}
    .slateblue{background-color: #6A5ACD}
    .silver{background-color: #C0C0C0}
    .colorConductor{background-color: #3843d1}
    .colorVehiculo{background-color: #007345}
    .colorServicio{background-color: #efb525}
  </style>
   	
</body>   	


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer type="text/javascript">
	var $j = jQuery.noConflict();
	
	$j(document).ready(function() {
		$j("#modalesEstadistica > span > a").hide();
    });
   	
   	
   	function redirigir(ruta) {
		if(ruta.length > 0){
			window.location.href = ruta;
		}
    }
    
    
    function abreModalConductores(){
    	$j("#modalesEstadistica > span > a")[0].click();
    }
    
    
    function abreModalVehiculos(){
    	$j("#modalesEstadistica > span > a")[1].click();
    }
    
    
    function abreModalServicios(){
    	$j("#modalesEstadistica > span > a")[2].click();
    }
	
</script>



