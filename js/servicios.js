/**
 *SIPA - Módulo de Servicios 
 */
var $j = jQuery.noConflict();

/**Pantalla Registro Ingreso*/
$j(document ).ready(function() {
	var formid = $j('form').attr('id');
	if(formid != 'registraSalida'){
		$j('#vehiculoFk').trigger("change");
	}
});
$j('#vehiculoFk').on('change', function() {
	var idVehiculo = this.value;
 	var datosFormulario = new FormData(); 
	datosFormulario.append('idVehiculo', idVehiculo);
	$j('#kmInicio').val('');
	if(idVehiculo != -1){	
		$j.ajax({
			url: 'getKilometrajeBase.do',
			type: 'POST',
			data:datosFormulario ,	
			processData: false,
			contentType: false,
			async: false,
			cache:false, 
			success : function(data) {
			  console.log(data);
			  if(data != null){
				var kmI = data.kilometraje;
				var nComb = data.nivelCombustible;
				$j('#kmInicio').val(kmI);
				$j('#combustibleInicio').val(nComb);
				$j('#kmInicialAux').val(kmI);
			  }
			}
		})
	}
});
function guardaIngreso(event){
	console.log('Validaciones....');
	const MAXIMO_TAMANIO_BYTES = 5242880; // 5MB
	$j("table#tbMensajes tbody").empty();
	$j("#tbErrores").attr('style','display:none');

	var error = false;
	var row = '';

	var vehiculoFk     = $j('#vehiculoFk').val();
	var tipoServicioFk = $j('#tipoServicioFk').val();
	var fechaInicio    = $j('#fechaInicio').val();
	var descripcionIni = $j('#descripcionIni').val();
	var justificacion  = $j('#justificacion').val();
	var aseguradoraFk  = $j('#aseguradoraFk').val();
	var ordenServicio  = $j('#ordenServicio').val();
	
	var kmInicio  = $j('#kmInicio').val();
	var kmInicialAux  = $j('#kmInicialAux').val();
	var combustibleInicio  = $j('#combustibleInicio').val();

	var evidenciaIni  = document.getElementById('evidenciaIni');


	if(vehiculoFk == -1){
		error = true;
		row = '<tr><td>El campo veh&iacute;culo es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}
	if(tipoServicioFk == -1){
		error = true;
		row = '<tr><td>El campo tipo de servicio es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}
	if(fechaInicio == null || fechaInicio == ""){
		error = true;
		row = '<tr><td>El campo fecha de inicio es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}
	if(descripcionIni.trim().length == 0){
		error = true;
		row = '<tr><td>El campo descripci&oacute;n es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}else if(descripcionIni.trim().length > 300){
		error = true;
		row = '<tr><td>La longitud permitida para el campo descripci&oacute;n es de 300 caracteres...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}
	if(justificacion.trim().length == 0){
		error = true;
		row = '<tr><td>El campo justificaci&oacute;n es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}else if(justificacion.trim().length > 300){
		error = true;
		row = '<tr><td>La longitud permitida para el campo justificaci&oacute;n es de 300 caracteres...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}
	if(aseguradoraFk == -1){
		error = true;
		row = '<tr><td>El campo aseguradora es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}	
	if(ordenServicio.trim().length == 0){
		error = true;
		row = '<tr><td>El campo orden del servicio es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}
	if(kmInicio.trim().length == 0){
		error = true;
		row = '<tr><td>El campo kilometraje inicial es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}else if(kmInicio < kmInicialAux){
		error = true;
		row = '<tr><td>El campo kilometraje inicial no puede ser menor a '+kmInicialAux+' km...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 	
	}
	if(combustibleInicio.trim().length == 0){
		error = true;
		row = '<tr><td>El campo nivel de combustible inicial es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}

	if(evidenciaIni.files.length  <= 0){
		error = true;
		row = '<tr><td>El campo evidencia inicial es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}else{
		//Valida la extención del archivo
		var nombre = evidenciaIni.files[0].name;
		var extension = nombre.split('.').reverse()[0];
		const regex = /^[^.]+\.[^.]+$/;
	    // 2. Validar el tipo MIME
	    const tipoMIME = evidenciaIni.files[0].type;
	    if (tipoMIME !== 'application/pdf') {
		  error = true;
		  row = '<tr><td>El campo evidencia inicial contiene un formato de archivo NO permitido. Solo son permitidos archivos pdf...<br></td></tr>';
		  $j("#tbMensajes tbody").append(row); 
		  HuboError = true;
	    }else if  (extension !== 'pdf') {
			error = true;
			row = '<tr><td>El campo evidencia inicial contiene un formato de archivo NO permitido. Solo son permitidos archivos pdf...<br></td></tr>';
			$j("#tbMensajes tbody").append(row); 
			HuboError = true;
		}else if(!regex.test(nombre) || nombre.includes("%00")){
			error = true;
			row = '<tr><td>El nombre del archivo contiene extensiones dobles o inv&aacute;lidas....<br></td></tr>';
			$j("#tbMensajes tbody").append(row); 
			HuboError = true;
		}else{
			isPDF(evidenciaIni.files[0], function(esValido) {
				if (!esValido) {
					error = true;
					row = '<tr><td>El campo evidencia inicial contiene un formato de archivo NO permitido. Solo son permitidos archivos pdf...<br></td></tr>';
					$j("#tbMensajes tbody").append(row); 
					HuboError = true;
				}else{
					if (evidenciaIni.files[0].size > MAXIMO_TAMANIO_BYTES)
					{
						error = true;
						row = '<tr><td>El campo evidencia inicial excedi&oacute; el tamaño de archivo permitido de 5 MB...<br></td></tr>';
						$j("#tbMensajes tbody").append(row); 
					}
				}
			});
		}
	}


	if(error){
		$j("#tbErrores").attr('style','display:');
		return false;
	}else{
		document.charset = 'ISO-8859-1';
		return doSubmit(event.currentTarget.id);
	}
}

/**Funciones generales*/
function soloNumeros(input) {
  var regex = new RegExp("^[0-9]+$");
  var input_val = input.value;
  if (!regex.test(input_val)) {
	input.value='';
  }
}

function formatNumber(n) {
	  // format number 1000000 to 1,234,567
	  return n.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",")
}

function formatCurrency(input, blur) {
	  // appends $ to value, validates decimal side
	  // and puts cursor back in right position.
	  
	  // get input value
	  var input_val = input.val();
	  
	  // don't validate empty input
	  if (input_val === "") { return; }
	  
	  // original length
	  var original_len = input_val.length;

	  // initial caret position 
	  var caret_pos = input.prop("selectionStart");
	    
	  // check for decimal
	  if (input_val.indexOf(".") >= 0) {

	    // get position of first decimal
	    // this prevents multiple decimals from
	    // being entered
	    var decimal_pos = input_val.indexOf(".");

	    // split number by decimal point
	    var left_side = input_val.substring(0, decimal_pos);
	    var right_side = input_val.substring(decimal_pos);

	    // add commas to left side of number
	    left_side = formatNumber(left_side);

	    // validate right side
	    right_side = formatNumber(right_side);
	    
	    // On blur make sure 2 numbers after decimal
	    if (blur === "blur") {
	      right_side += "00";
	    }
	    
	    // Limit decimal to only 2 digits
	    right_side = right_side.substring(0, 2);

	    // join number by .
	    input_val =  left_side + "." + right_side;

	  } else {
	    // no decimal entered
	    // add commas to number
	    // remove all non-digits
	    input_val = formatNumber(input_val);
	    input_val =  input_val;
	    
	    // final formatting
	    if (blur === "blur") {
	      input_val += ".00";
	    }
	  }
	  
	  // send updated string to input
	  input.val(input_val);

	  // put caret back in the right position
	  var updated_len = input_val.length;
	  caret_pos = updated_len - original_len + caret_pos;
	  input[0].setSelectionRange(caret_pos, caret_pos);
	}

function soloOctavos(input) {
  var regex = new RegExp("^[0-8]+$");
  var input_val = input.value;
  if (!regex.test(input_val)) {
	input.value='';
  }
}

function isPDF(file, callback) {
	const reader = new FileReader();
	reader.onloadend = function(e) {
	  const arr = new Uint8Array(e.target.result).subarray(0, 4);
	  let header = "";
	  for (var i = 0; i < arr.length; i++) {
	    header += String.fromCharCode(arr[i]);
	  }
	  if (header === "%PDF") {
	    callback(true);
	  } else {
	    callback(false);
	  }
	};
	reader.readAsArrayBuffer(file.slice(0, 4));
}

/**Funciones Pantalla Registro Salida Servicio*/
function guardaSalida(event){
	const MAXIMO_TAMANIO_BYTES = 5242880; // 5MB
	console.log('Validaciones....');
	$j("table#tbMensajes tbody").empty();
	$j("#tbErrores").attr('style','display:none');

	var error = false;
	var row = '';

    var idBitacora       = $j('#idBitacora').val();
	var fechaFin         = $j('#fechaFin').val();
	var fechaInicio      = $j('#fechaInicio').val();
	var descripcionFinal = $j('#descripcionFinal').val();
	var costoServicio    = $j('#costoServicioS').val();
	var kmFin            = $j('#kmFin').val();
    var combustibleFin   = $j('#combustibleFin').val();
	var kmInicio         = $j('#kmInicio').val();

	var evidenciaFin = document.getElementById('evidenciaFin');
	
	if(fechaFin == null || fechaFin == ""){
		error = true;
		row = '<tr><td>El campo fecha fin es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}
	if(descripcionFinal.trim().length == 0){
		error = true;
		row = '<tr><td>El campo descripci&oacute;n final es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}else if(descripcionFinal.trim().length > 300){
		error = true;
		row = '<tr><td>La longitud permitida para el campo descripci&oacute;n final es de 300 caracteres...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}	
	if(costoServicio.trim() == '0.00' || costoServicio.trim() == '' || costoServicio.trim() == '0'){
		error = true;
		row = '<tr><td>El campo costo del servicio es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}	
	if(kmFin == null || kmFin.trim() == ""){
		error = true;
		row = '<tr><td>El campo kilometraje final es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}else if(kmFin < kmInicio){
		error = true;
		row = '<tr><td>El campo kilometraje final no puede ser menor al kilometraje inicial...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}
	if(combustibleFin == null || combustibleFin.trim() == ""){
		error = true;
		row = '<tr><td>El campo combustible final es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}
	if(fechaFin != null && fechaFin != "" && fechaInicio != null && fechaInicio != ""){
		var fecha_auxS = fechaInicio.split("-");
		var fecha_auxP = fechaFin.split("-");
	    
	    var Fecha1 = new Date(parseInt(fecha_auxS[2]),parseInt(fecha_auxS[1]-1),parseInt(fecha_auxS[0]));
	    var Fecha2 = new Date(parseInt(fecha_auxP[2]),parseInt(fecha_auxP[1]-1),parseInt(fecha_auxP[0]));
	    if(Fecha1 > Fecha2){
			error = true;
			row = '<tr><td>La fecha fin deber ser mayor a la fecha de inicio del servicio...<br></td></tr>';
			$j("#tbMensajes tbody").append(row); 
	    }
	}
	if(evidenciaFin.files.length  <= 0){
		error = true;
		row = '<tr><td>El campo evidencia final es requerido...<br></td></tr>';
		$j("#tbMensajes tbody").append(row); 
	}else{
		//Valida la extención del archivo
		//Valida la extención del archivo
		var nombre = evidenciaFin.files[0].name;
		var extension = nombre.split('.').reverse()[0];
		const regex = /^[^.]+\.[^.]+$/;
	
	    // 2. Validar el tipo MIME
	    const tipoMIME = evidenciaFin.files[0].type;
	    if (tipoMIME !== 'application/pdf') {
		  error = true;
		  row = '<tr><td>El campo evidencia final contiene un formato de archivo NO permitido. Solo son permitidos archivos pdf...<br></td></tr>';
		  $j("#tbMensajes tbody").append(row); 
		  HuboError = true;
	    }else if  (extension !== 'pdf'){
			error = true;
			row = '<tr><td>El campo evidencia final contiene un formato de archivo NO permitido. Solo son permitidos archivos pdf...<br></td></tr>';
			$j("#tbMensajes tbody").append(row); 
			HuboError = true;
		}else if(!regex.test(nombre) || nombre.includes("%00")){
			error = true;
			row = '<tr><td>El nombre del archivo contiene extensiones dobles o inv&aacute;lidas....<br></td></tr>';
			$j("#tbMensajes tbody").append(row); 
			HuboError = true;
		}else{
			isPDF(evidenciaFin.files[0], function(esValido) {
				if (!esValido) {
					error = true;
					row = '<tr><td>El campo evidencia final contiene un formato de archivo NO permitido. Solo son permitidos archivos pdf...<br></td></tr>';
					$j("#tbMensajes tbody").append(row); 
					HuboError = true;
				}else{
					if (evidenciaFin.files[0].size > MAXIMO_TAMANIO_BYTES)
					{
						error = true;
						row = '<tr><td>El campo evidencia final excedi&oacute; el tamaño de archivo permitido de 5 MB...<br></td></tr>';
						$j("#tbMensajes tbody").append(row); 
					}
				}
			});

		}
	}

	if(error){
		$j("#tbErrores").attr('style','display:');
		return false;
	}else{
		$j('#costoServicio').val(costoServicio.replace(/\,/g,""));
		document.charset = 'ISO-8859-1';
		return doSubmit(event.currentTarget.id);
	}
}