function agregarFila(){
    var x = document.querySelectorAll('[id^="nombreDocumento"]');
    var lastID =x.length;
    var currentId =  parseInt(lastID)+1;
    var id2= 'documento-'+currentId;
    var id1= 'nombreDocumento-'+currentId;
    var currentOnchange= 'addFile('+currentId+');';

    var tabla=document.getElementById("tbodyDocuments");
    var tr=document.createElement("tr");
    var td1=document.createElement("td"); 
    var td2=document.createElement("td"); 

    //creamos componentes para el td
    var input1 =document.createElement("input");
    var input2 =document.createElement("input");
    //Agregamos los atributos correspondientes a cada input
    input1.setAttribute("class","form-control");
    input1.setAttribute("type","text");
    input1.setAttribute("name",id1);
    input1.setAttribute("id",id1);
    input2.setAttribute("type","file");
    input2.setAttribute("name",id2);
    input2.setAttribute("id",id2);
    input2.setAttribute("onchange",currentOnchange);

    td1.appendChild(input1);
    td2.appendChild(input2);
    tr.appendChild(td1);
    tr.appendChild(td2);
    tabla.appendChild(tr);
}
function addFile (id){
    var id2= 'documento-'+id;
    var id1= 'nombreDocumento-'+id;
    console.log(id2);
    console.log(id2.value);
    $.ajax({
        url: "singleFileUpload.htm",
        method: "post",
        enctype:"multipart/form-data",
        data: {
                nombre: document.getElementById(id1).value,
                file:   document.getElementById(id2).value
              }
    }).done((res) => {
        if (res == "505") {
            console.log("error al cargar archivo")
        } else if (res == "200") {
            console.log("archivo cargado con exito")
        } 
    }).fail((jqXHR, textStatus) => {
                console.log(textStatus, jqXHR);
    });
}
window.addEventListener("load", function() {
    prospecto.cp.addEventListener("keypress", soloNumeros, false);
  });
window.addEventListener("load", function() {
    prospecto.tel.addEventListener("keypress", soloNumeros, false);
  });

function setProspecto (){
    var ban = true;
    var message = "";
    var rfc         = document.getElementById("rfc").value.trim().toUpperCase();
    if(document.getElementById("nombre").value.length<2){
        message +=" *Este no es un nombre valido";
        ban = false;
    }
    if(document.getElementById("apellido_paterno").value.length<2){
        message +=" *Este no es un apellido valido";
        ban = false;
    }
    if(document.getElementById("calle").value.length<2){
        message +=" *Este no es un nombre valido";
        ban = false;
    }
    if(document.getElementById("numero").value.length>5 || document.getElementById("calle").value.length<1 ){
        message +=" *Este no es un numero valido";
        ban = false;
    }
    if(document.getElementById("colonia").value.length<2){
        message +=" *Este no es un nombre valido";
        ban = false;
    }
    if(document.getElementById("cp").value.length!=5){
        message +=" *Este no es un Codigo  valido";
        ban = false;
    }
    if(document.getElementById("tel").value.length!=10){
        message +=" *Este no es un telefono  valido";
        ban = false;
    }
    if(!rfcValido(rfc)){
        message +="*Este no es un Rfc  valido";
        ban = false;
    }
    

    

    if (ban){
        console.log("hola mal")

        $.ajax({
            url: "set_prospecto.htm",
            method: "post",
            data: {
                    nombre:             document.getElementById("nombre").value,
                    apellido_paterno:   document.getElementById("apellido_paterno").value,
                    apellido_materno:   document.getElementById("apellido_materno").value,
                    calle:              document.getElementById("calle").value,
                    numero:             document.getElementById("numero").value,
                    colonia:            document.getElementById("colonia").value,
                    codigo_postal:      document.getElementById("cp").value,
                    telefono:           document.getElementById("tel").value,
                    rfc:                document.getElementById("rfc").value.trim().toUpperCase(),
                    documentos:         document.getElementById("documento-1").value
            }
        }).done((res) => {
            if (res === "500") {
                window.location = "inicioSesion.htm";
            } else if (res === "0005") {
                console.log("error al insertar")
            } else{
                    window.location = "prospectos.htm";
            }
        }).fail((jqXHR, textStatus) => {
                    console.log(textStatus, jqXHR);
        });
    }else{
		alert(message);
    }   
}
function getDetalleProspecto(id){
    $.ajax({
        url: "getDetalleProspecto.htm",
        method: "post",
        data: {
            id: id,
        }
    }).done((res) => {

        if (res === null) {
            alert("ha Ocurrido un error");
        } else  {
            var data = JSON.parse(res); 
            document.getElementById("name").innerHTML = data.nombre;
            document.getElementById("apellido_paterno").innerHTML = data.apellido_paterno;
            document.getElementById("apellido_materno").innerHTML = data.apellido_materno;
            document.getElementById("status").innerHTML = data.status;
            document.getElementById("calle").innerHTML = data.calle;
            document.getElementById("numero").innerHTML = data.numero;
            document.getElementById("colonia").innerHTML = data.colonia;
            document.getElementById("cp").innerHTML = data.codigo_postal;
            document.getElementById("tel").innerHTML = data.telefono;
            document.getElementById("rfc").innerHTML = data.rfc;
            document.getElementById("comentario").innerHTML = data.comentario;

            //document.getElementById("documentos").innerHTML = data.documentos;

            if(data.status==='Rechazado'){
                $("#divRechazado").css("display", "block");
            }else{
                $("#divRechazado").css("display", "none");
            }

        } 
    }).fail((jqXHR, textStatus) => {
        console.log(textStatus, jqXHR);
    });
}
function soloNumeros(e){
    var key = window.event ? e.which : e.keyCode;
    if (key < 48 || key > 57) {
      e.preventDefault();
    }
}
function rfcValido(rfc, aceptarGenerico = true) {
    const re       = /^([A-ZÑ&]{3,4}) ?(?:- ?)?(\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])) ?(?:- ?)?([A-Z\d]{2})([A\d])$/;
    var   validado = rfc.match(re);

    if (!validado)  //Coincide con el formato general del regex?
        return false;

    //Separar el dígito verificador del resto del RFC
    const digitoVerificador = validado.pop(),
          rfcSinDigito      = validado.slice(1).join(''),
          len               = rfcSinDigito.length,

    //Obtener el digito esperado
          diccionario       = "0123456789ABCDEFGHIJKLMN&OPQRSTUVWXYZ Ñ",
          indice            = len + 1;
    var   suma,
          digitoEsperado;

    if (len == 12) suma = 0
    else suma = 481; //Ajuste para persona moral

    for(var i=0; i<len; i++)
        suma += diccionario.indexOf(rfcSinDigito.charAt(i)) * (indice - i);
    digitoEsperado = 11 - suma % 11;
    if (digitoEsperado == 11) digitoEsperado = 0;
    else if (digitoEsperado == 10) digitoEsperado = "A";

    //El dígito verificador coincide con el esperado?
    // o es un RFC Genérico (ventas a público general)?
    if ((digitoVerificador != digitoEsperado)
     && (!aceptarGenerico || rfcSinDigito + digitoVerificador != "XAXX010101000"))
        return false;
    else if (!aceptarGenerico && rfcSinDigito + digitoVerificador == "XEXX010101000")
        return false;
    return true;
}
function validarRechazo(){
    if(document.getElementById('RE').checked){
        $("#divComentario").css("display", "block");
    }else{
        $("#divComentario").css("display", "none");
    }
}
function updateProspecto(){
     var ban = true;
    var message = "";
    var status = "";
    var comentario = "";


    if(document.getElementById('RE').checked){
        if(document.getElementById('Inputcomentario').value.length<5){
            message +=" *Este no es un comentario valido";
            ban = false;
        }
        status = document.getElementById('RE').value;
        comentario=  document.getElementById("Inputcomentario").value;
    }else{
        status = document.getElementById('AU').value;
        comentario = "NULL"
    }
    if (ban){
        $.ajax({
            url: "update_prospecto.htm",
            method: "post",
            data: {
                    id:             document.getElementById("idProspecto").value,
                    comentario:     comentario,
                    estado:         status          
            }
        }).done((res) => {
            if (res === "500") {
                window.location = "inicioSesion.htm";
            } else if (res === "0005") {
                console.log("error al insertar")
            } else{
                    window.location = "evaluar.htm";
            }
        }).fail((jqXHR, textStatus) => {
                    console.log(textStatus, jqXHR);
        });
    }else{
		alert(message);
    }   
}
function getDetalleProspectoEvaluar(id){
    $.ajax({
        url: "getDetalleProspecto.htm",
        method: "post",
        data: {
            id: id,
        }
    }).done((res) => {

        if (res === null) {
            alert("ha Ocurrido un error");
        } else  {
            var data = JSON.parse(res); 
            document.getElementById("name").innerHTML = data.nombre;
            document.getElementById("apellido_paterno").innerHTML = data.apellido_paterno;
            document.getElementById("apellido_materno").innerHTML = data.apellido_materno;
            document.getElementById("status").innerHTML = data.status;
            document.getElementById("calle").innerHTML = data.calle;
            document.getElementById("numero").innerHTML = data.numero;
            document.getElementById("colonia").innerHTML = data.colonia;
            document.getElementById("cp").innerHTML = data.codigo_postal;
            document.getElementById("tel").innerHTML = data.telefono;
            document.getElementById("rfc").innerHTML = data.rfc;
            document.getElementById("comentario").innerHTML = data.comentario;
            document.getElementById("idProspecto").value = data.id;

            //document.getElementById("documentos").innerHTML = data.documentos;

            if(data.status==='Rechazado'){
                $("#divRechazado").css("display", "block");
            }else{
                $("#divRechazado").css("display", "none");
            }

        } 
    }).fail((jqXHR, textStatus) => {
        console.log(textStatus, jqXHR);
    });
}