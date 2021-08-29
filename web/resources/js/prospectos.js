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
function salirProspecto(){
    window.location = "prospectos.htm";
}
function setProspecto (){
    var id2= 'documento-'+id;
    var id1= 'nombreDocumento-'+id;
    console.log(id2);
    console.log(id2.value);
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
                rfc:                document.getElementById("rfc").value,
                documentos:         document.getElementById("documento-1").value
                
        }
    }).done((res) => {
        if (res == "500") {
            window.location = "inicioSesion.htm";
        } else if (res == "0005") {
            console.log("error al insertar")
        } else{
           window.location = "prospectos.htm";
        }
    }).fail((jqXHR, textStatus) => {
                console.log(textStatus, jqXHR);
    });
}