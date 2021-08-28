let map, directionsService, directionsRenderer, changeControlPoint = false,
    arrayPointers = [];
let myStyles = [{ featureType: "poi", elementType: "labels", stylers: [{ visibility: "on" }] }];
var concredito_div = document.getElementsByClassName('concredito-info');
const initMap = () => {
    /* INFORMACIÓN DE LOS MARCADORES DE concreditoS */
    var markers = [];
    var concredito_lat = [];
    var concredito_lon = [];
    var marker_concredito = [];
    var contentString = [];

    var concredito_info = [];

    for (var concredito_counter = 0; concredito_counter < concredito_div.length; ++concredito_counter) {
        markers[concredito_counter] = JSON.parse(concredito_div[concredito_counter].getAttribute('data-concredito-coords'));
        concredito_lat[concredito_counter] = parseFloat(markers[concredito_counter].lat);
        concredito_lon[concredito_counter] = parseFloat(markers[concredito_counter].lng);

        concredito_info[concredito_counter] = {
            coords: JSON.parse(concredito_div[concredito_counter].getAttribute('data-concredito-coords')),
            nombre: concredito_div[concredito_counter].getAttribute('data-concredito-nombre'),
            tipo: concredito_div[concredito_counter].getAttribute('data-concredito-tipo'),
            descripcion: concredito_div[concredito_counter].getAttribute('data-concredito-descripcion'),
            frecuencia: concredito_div[concredito_counter].getAttribute('data-concredito-frecuencia'),
            direccion: concredito_div[concredito_counter].getAttribute('data-concredito-direccion'),
            estado: concredito_div[concredito_counter].getAttribute('data-concredito-estado'),
        };

        if (concredito_info[concredito_counter].estado === 'Activo') {
            var concredito_estado = 'green'
        } else {
            concredito_estado = 'red'
        }

        contentString[concredito_counter] =
            '<div class="mapconcreditoInfo">' +
            '<div class="concreditoUp d-flex fd-column">' +
            '<div class="concredito-text d-flex ai-center">' +
            '<div class="base d-flex ai-center" style="padding: 0;">' +
            `<div class="base-state state-${concredito_estado}"></div>` +
            '<div class="caso-text d-flex fd-column">' +
            `<p class="caso-name" style="font-weight: 500;">${concredito_info[concredito_counter].nombre}</p>` +
            '<div class="caso-info d-flex">' +
            `<p class="desc-concredito">${concredito_info[concredito_counter].descripcion}</p>` +
            '</div>' +
            '</div>' +
            '</div>' +
            '<img src="resources/images/icons/edit-concredito.svg" alt="">' +
            '</div>' +
            `<p class="tipo-concredito">concredito ${concredito_info[concredito_counter].tipo} ⋅ <span class="tipo-concredito-lec"> ${concredito_info[concredito_counter].frecuencia} lecturas</span><span class="por-min"> por min</span></p>` +
            '</div>' +
            '<div class="concreditoDatos d-flex">' +
            `<p class="mapconcreditoCoords">${concredito_info[concredito_counter].coords.lat}, ${concredito_info[concredito_counter].coords.lng}</p>` +
            '<p class="mapconcreditoCarril">4 carriles</p>' +
            '</div>' +
            '</div>';
    }

    /* INFORMACIÓN DE LOS MARCADORES DE CASOS CRÍTICOS */
    var caso_critico_coords = []
    var caso_critico_info = []
    var criticoString = []
    var casos_criticos = document.getElementsByClassName('Critico');
    for (let i = 0; i < casos_criticos.length; i++) {
        caso_critico_coords[i] = JSON.parse(casos_criticos[i].getAttribute('data-caso-coords'));
        // console.log(markers[i]);

        caso_critico_info[i] = {
            concredito_estado: casos_criticos[i].getAttribute('data-caso-concredito-estado'),
            nombre_concredito: casos_criticos[i].getAttribute('data-caso-concredito'),
            tipo_concredito: casos_criticos[i].getAttribute('data-caso-tipo-concredito'),
            coords: JSON.parse(casos_criticos[i].getAttribute('data-caso-coords')),
            carril: casos_criticos[i].getAttribute('data-caso-carril'),
            orientacion: casos_criticos[i].getAttribute('data-caso-orientacion'),
            nombre_alerta: casos_criticos[i].getAttribute('data-caso-nombre-alerta'),
            nombre_reporte: casos_criticos[i].getAttribute('data-caso-nombre-reporte')
        }
        console.log(caso_critico_info[i]);
        if (caso_critico_info[i].nombre_concredito === "") {
            criticoString[i] = `
                        <div class="mapconcreditoInfo">
                            <div class="concreditoUp d-flex fd-column">
                                <div class="concredito-text d-flex ai-center">
                                    <div class="base d-flex ai-center" style="padding: 0;">
                                        <div style="flex-basis: unset!important" class="base-state state-red"></div>
                                        <div class="caso-text d-flex fd-column">
                                            <p class="caso-name" style="font-weight: 500;">${caso_critico_info[i].nombre_alerta}</p>
                                            <div class="caso-info d-flex">
                                                <p class="desc-concredito">Caso ${caso_critico_info[i].nombre_reporte}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <img style="opacity: 0" src="resources/images/icons/edit-concredito.svg" alt="">
                                </div>
                            </div>
                            <div class="concreditoDatos d-flex">
                                <p class="mapconcreditoCoords">${caso_critico_info[i].coords.lat}, ${caso_critico_info[i].coords.lng}</p>
                                <p class="mapconcreditoCarril"></p>
                            </div>
                        </div>
            `;
        } else {
            criticoString[i] = `
                        <div class="mapconcreditoInfo">
                            <div class="concreditoUp d-flex fd-column">
                                <div class="concredito-text d-flex ai-center">
                                    <div class="base d-flex ai-center" style="padding: 0;">
                                        <div style="flex-basis: unset!important" class="base-state state-red"></div>
                                        <div class="caso-text d-flex fd-column">
                                            <p class="caso-name" style="font-weight: 500;">${caso_critico_info[i].nombre_concredito}</p>
                                            <div class="caso-info d-flex">
                                                <p class="desc-concredito">${caso_critico_info[i].tipo_concredito}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <img style="opacity: 0" src="resources/images/icons/edit-concredito.svg" alt="">
                                </div>
                            </div>
                            <div class="concreditoDatos d-flex">
                                <p class="mapconcreditoCoords">${caso_critico_info[i].coords.lat}, ${caso_critico_info[i].coords.lng}</p>
                                <p class="mapconcreditoCarril">${caso_critico_info[i].carril} ⋅ ${caso_critico_info[i].orientacion}</p>
                            </div>
                        </div>
            `;
        }

    }

    /* INFORMACIÓN DE LOS MARCADORES DE CASOS ADVERTENCIA */
    var caso_advertencia_coords = []
    var caso_advertencia_info = []
    var advertenciaString = []
    var casos_advertencias = document.getElementsByClassName('Advertencia');
    for (let i = 0; i < casos_advertencias.length; i++) {
        caso_advertencia_coords[i] = JSON.parse(casos_advertencias[i].getAttribute('data-caso-coords'));
        // console.log(markers[i]);

        caso_advertencia_info[i] = {
            concredito_estado: casos_advertencias[i].getAttribute('data-caso-concredito-estado'),
            nombre_concredito: casos_advertencias[i].getAttribute('data-caso-concredito'),
            tipo_concredito: casos_advertencias[i].getAttribute('data-caso-tipo-concredito'),
            coords: JSON.parse(casos_advertencias[i].getAttribute('data-caso-coords')),
            carril: casos_advertencias[i].getAttribute('data-caso-carril'),
            orientacion: casos_advertencias[i].getAttribute('data-caso-orientacion'),
            nombre_alerta: casos_advertencias[i].getAttribute('data-caso-nombre-alerta'),
            nombre_reporte: casos_advertencias[i].getAttribute('data-caso-nombre-reporte')
        }
        if (caso_advertencia_info[i].nombre_concredito === "") {
            advertenciaString[i] = `
                        <div class="mapconcreditoInfo">
                            <div class="concreditoUp d-flex fd-column">
                                <div class="concredito-text d-flex ai-center">
                                    <div class="base d-flex ai-center" style="padding: 0;">
                                        <div style="width: 1.2rem!important" class="base-state state-red"></div>
                                        <div class="caso-text d-flex fd-column">
                                            <p class="caso-name" style="font-weight: 500;">${caso_advertencia_info[i].nombre_alerta}</p>
                                            <div class="caso-info d-flex">
                                                <p class="desc-concredito">${caso_advertencia_info[i].nombre_reporte}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <img style="opacity: 0" src="resources/images/icons/edit-concredito.svg" alt="">
                                </div>
                            </div>
                            <div class="concreditoDatos d-flex">
                                <p class="mapconcreditoCoords">${caso_advertencia_info[i].coords.lat}, ${caso_advertencia_info[i].coords.lng}</p>
                                <p class="mapconcreditoCarril"></p>
                            </div>
                        </div>
                        `
        } else {
            advertenciaString[i] = `
            <div class="mapconcreditoInfo">
                <div class="concreditoUp d-flex fd-column">
                    <div class="concredito-text d-flex ai-center">
                        <div class="base d-flex ai-center" style="padding: 0;">
                            <div style="width: 1.2rem!important" class="base-state state-red"></div>
                            <div class="caso-text d-flex fd-column">
                                <p class="caso-name" style="font-weight: 500;">${caso_advertencia_info[i].nombre_concredito}</p>
                                <div class="caso-info d-flex">
                                    <p class="desc-concredito">${caso_advertencia_info[i].tipo_concredito}</p>
                                </div>
                            </div>
                        </div>
                        <img style="opacity: 0" src="resources/images/icons/edit-concredito.svg" alt="">
                    </div>
                </div>
                <div class="concreditoDatos d-flex">
                    <p class="mapconcreditoCoords">${caso_advertencia_info[i].coords.lat}, ${caso_advertencia_info[i].coords.lng}</p>
                    <p class="mapconcreditoCarril">${caso_advertencia_info[i].carril} ⋅ ${caso_advertencia_info[i].orientacion}</p>
                </div>
            </div>
            `
        }
        
    }

    /* INFORMACIÓN DE LOS MARCADORES DE CASOS ADVERTENCIA */
    var caso_info_coords = []
    var caso_info_info = []
    var infoString = []
    var casos_infos = document.getElementsByClassName('Informativo');
    for (let i = 0; i < casos_infos.length; i++) {
        caso_info_coords[i] = JSON.parse(casos_infos[i].getAttribute('data-caso-coords'));
        // console.log(markers[i]);
        
        caso_info_info[i] = {
            concredito_estado: casos_infos[i].getAttribute('data-caso-concredito-estado'),
            nombre_concredito: casos_infos[i].getAttribute('data-caso-concredito'),
            tipo_concredito: casos_infos[i].getAttribute('data-caso-tipo-concredito'),
            coords: JSON.parse(casos_infos[i].getAttribute('data-caso-coords')),
            carril: casos_infos[i].getAttribute('data-caso-carril'),
            orientacion: casos_infos[i].getAttribute('data-caso-orientacion'),
            nombre_alerta: casos_infos[i].getAttribute('data-caso-nombre-alerta'),
            nombre_reporte: casos_infos[i].getAttribute('data-caso-nombre-reporte')
        }
        if (caso_info_info[i].nombre_concredito === "") {
            infoString[i] = `
                        <div class="mapconcreditoInfo">
                            <div class="concreditoUp d-flex fd-column">
                                <div class="concredito-text d-flex ai-center">
                                    <div class="base d-flex ai-center" style="padding: 0;">
                                        <div style="width: 1.2rem!important" class="base-state state-red"></div>
                                        <div class="caso-text d-flex fd-column">
                                            <p class="caso-name" style="font-weight: 500;">${caso_info_info[i].nombre_alerta}</p>
                                            <div class="caso-info d-flex">
                                                <p class="desc-concredito">${caso_info_info[i].nombre_reporte}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <img style="opacity: 0" src="resources/images/icons/edit-concredito.svg" alt="">
                                </div>
                            </div>
                            <div class="concreditoDatos d-flex">
                                <p class="mapconcreditoCoords">${caso_info_info[i].coords.lat}, ${caso_info_info[i].coords.lng}</p>
                                <p class="mapconcreditoCarril"></p>
                            </div>
                        </div>
                        `
        } else {
            infoString[i] = `
            <div class="mapconcreditoInfo">
                <div class="concreditoUp d-flex fd-column">
                    <div class="concredito-text d-flex ai-center">
                        <div class="base d-flex ai-center" style="padding: 0;">
                            <div style="width: 1.2rem!important" class="base-state state-red"></div>
                            <div class="caso-text d-flex fd-column">
                                <p class="caso-name" style="font-weight: 500;">${caso_info_info[i].nombre_concredito}</p>
                                <div class="caso-info d-flex">
                                    <p class="desc-concredito">${caso_info_info[i].tipo_concredito}</p>
                                </div>
                            </div>
                        </div>
                        <img style="opacity: 0" src="resources/images/icons/edit-concredito.svg" alt="">
                    </div>
                </div>
                <div class="concreditoDatos d-flex">
                    <p class="mapconcreditoCoords">${caso_info_info[i].coords.lat}, ${caso_info_info[i].coords.lng}</p>
                    <p class="mapconcreditoCarril">${caso_advertencia_info[i].carril} ⋅ ${caso_info_info[i].orientacion}</p>
                </div>
            </div>
            `
        }
    }

    /* COORDENADAS INICIALES DEL MAPA */
    let lat = concredito_lat[0];
    let lng = concredito_lon[0];

    /* DECLARACIÓN DEL MAPA */
    map = new google.maps.Map(document.getElementById("mapCanvas"), { zoom: 11, center: { lat, lng }, styles: myStyles });

    /* GENERACIÓN DE LOS MARCADORES E INFOWINDOWS DE LOS concreditoS */
    var marker = [];
    var lastInfoOpen;
    for (let marker_count = 0; marker_count < concredito_div.length; marker_count++) {
        marker_concredito[marker_count] = { lat: concredito_lat[marker_count], lng: concredito_lon[marker_count] };
        marker[marker_count] = new google.maps.Marker({
            position: marker_concredito[marker_count],
            icon: "resources/images/icons/mapicon-concredito.svg",
            map: map,
            title: 'concredito 1',
        });

        const infowindow = new google.maps.InfoWindow({
            content: contentString[marker_count],
        });

        marker[marker_count].addListener("click", () => {
            if (lastInfoOpen != undefined) {
                lastInfoOpen.close();
            }
            infowindow.open({
                anchor: marker[marker_count],
                map,
                shouldFocus: false,
            });
            lastInfoOpen = infowindow;
        });
    }

    /* GENERACIÓN DE LOS MARCADORES DE CASOS CRÍTICOS */
    var marker_critico = [];
    var lastCriticoOpen;
    for (let i = 0; i < casos_criticos.length; i++) {
        caso_critico_coords[i] = { lat: parseFloat(caso_critico_coords[i].lat), lng: parseFloat(caso_critico_coords[i].lng) };
        marker_critico[i] = new google.maps.Marker({
            position: caso_critico_coords[i],
            icon: "resources/images/icons/marker_caso_critico.svg",
            map: map,
        });

        // console.log(marker_critico[i]);

        const infowindow = new google.maps.InfoWindow({
            content: criticoString[i],
        });

        marker_critico[i].addListener("click", () => {
            if (lastCriticoOpen != undefined) {
                lastCriticoOpen.close();
            }
            infowindow.open({
                anchor: marker_critico[i],
                map,
                shouldFocus: false,
            });
            lastCriticoOpen = infowindow;
        });
    }

    /* GENERACIÓN DE LOS MARCADORES DE CASOS ADVERTENCIA */
    var marker_advertencia = [];
    var lastAdvertenciaOpen;
    for (let i = 0; i < casos_advertencias.length; i++) {
        caso_advertencia_coords[i] = { lat: parseFloat(caso_advertencia_coords[i].lat), lng: parseFloat(caso_advertencia_coords[i].lng) };
        marker_advertencia[i] = new google.maps.Marker({
            position: caso_advertencia_coords[i],
            icon: "resources/images/icons/marker_caso_advertencia.svg",
            map: map,
        });

        // console.log(marker_advertencia[i]);

        const infowindow = new google.maps.InfoWindow({
            content: advertenciaString[i],
        });

        marker_advertencia[i].addListener("click", () => {
            if (lastAdvertenciaOpen != undefined) {
                lastAdvertenciaOpen.close();
            }
            infowindow.open({
                anchor: marker_advertencia[i],
                map,
                shouldFocus: false,
            });
            lastAdvertenciaOpen = infowindow;
        });
    }

    /* GENERACIÓN DE LOS MARCADORES DE CASOS ADVERTENCIA */
    var marker_info = [];
    var lastInforOpen;
    for (let i = 0; i < casos_infos.length; i++) {
        caso_info_coords[i] = { lat: parseFloat(caso_info_coords[i].lat), lng: parseFloat(caso_info_coords[i].lng) };
        marker_info[i] = new google.maps.Marker({
            position: caso_info_coords[i],
            icon: "resources/images/icons/marker_caso_info.svg",
            map: map,
        });

        // console.log(marker_critico[i]);

        const infowindow = new google.maps.InfoWindow({
            content: infoString[i],
        });

        marker_info[i].addListener("click", () => {
            if (lastInforOpen != undefined) {
                lastInforOpen.close();
            }
            infowindow.open({
                anchor: marker_info[i],
                map,
                shouldFocus: false,
            });
            lastInforOpen = infowindow;
        });
    }
}

function closeInfo() {
    if (infoObj.length > 0) {
        infoObj[0].set("marker", null);
        infoObj[0].close();
        infoObj[0].length = 0;
    }

}

function showFilters() {
    if (document.getElementById('filterModal').style.display === 'flex') {
        $('#filterModal').fadeOut();
        $('#filter-blur').fadeOut();
    } else {
        $('#filterModal')
            .css("display", "flex")
            .hide()
            .fadeIn();
        $('#filter-blur').fadeIn();
    }
}

function createEntrada() {
    if (document.getElementById('createEntrada').style.display === 'flex') {
        $('#createEntrada').fadeOut();
        $('#entradaBlur').fadeOut();
    } else {
        $('#createEntrada')
            .css("display", "flex")
            .hide()
            .fadeIn();
        $('#entradaBlur').fadeIn();
    }
}

$('#uploadFile').change(function() {
    var file = $('#uploadFile')[0].files[0].name;
    document.getElementById('filesCont').innerHTML += `
    <div class="file">
        <p>${file}</p>
        <img onclick="removeFile(this)" src="resources/images/icons/deleteFile.svg" alt="">
    </div>
    `
});

function removeFile(img) {
    img.parentElement.remove();
}

function showImgModal() {
    if (document.getElementById('imgModal').style.display === 'flex') {
        $('#imgModal').fadeOut();
        $('#imgModalBlur').fadeOut();
    } else {
        $('#imgModal')
            .css("display", "flex")
            .hide()
            .fadeIn();
        $('#imgModalBlur').fadeIn();
    }
}

function changeImgSelected(img) {
    $('.img-gallery').css('border-color', '#A9B1BE');
    img.style.borderColor = 'white';
    document.getElementById('selectedImg').src = img.src;
}

function showSelecStateModal() {
    if (document.getElementById('selectStateModal').style.display === 'flex') {
        $('#selectStateModal').fadeOut();
        $('#selectCaseBlur').fadeOut();
    } else {
        $('#selectStateModal')
            .css("display", "flex")
            .hide()
            .fadeIn();
        $('#selectCaseBlur').fadeIn();
    }
}

function changeCaseState(selection) {

    var selectChild = selection.children[0];
    var childClass = selectChild.className;
    var childText = selectChild.innerHTML;

    var selectedOption = $('#selectedCaseState')[0];
    var selOptionClass = selectedOption.className;
    var selOptionText = selectedOption.innerHTML;

    selectChild.className = selOptionClass;
    selectChild.innerHTML = selOptionText;

    selectedOption.className = childClass;
    selectedOption.innerHTML = childText;

    $('#selectStateModal').fadeOut();
    $('#selectCaseBlur').fadeOut();

    $('#caseStateArrow').attr('class', 'img-' + childClass)
}

function closeCase() {
    $('#selectStateModal').fadeOut();
    $('#selectCaseBlur').fadeOut();
    $('.nueva-entrada').css('display', 'none');
    $('.case-state-drop').css('display', 'none');
    $('.caso-cerrado').fadeIn();
    $('.case-input').css('justify-content', 'center');
}

function showRepCar(caseDiv, marca, modelo, niv, color, placa) {

    $('.case-active').removeClass('case-active');

    caseDiv.classList.toggle('case-active');

    $('#vehicleData').css('right', '-40%');

    if (marca === '') {
        $('#reporteMarca').html('- - - - -');
    } else {
        $('#reporteMarca').html(marca);
    }

    if (modelo === '') {
        $('#reporteModelo').html('- - - - -');
    } else {
        $('#reporteModelo').html(modelo);
    }

    if (niv === '') {
        $('#reporteNiv').html('- - - - -');
    } else {
        $('#reporteNiv').html(niv);
    }

    if (color === '') {
        $('#reporteColor').html('- - - - -');
    } else {
        $('#reporteColor').html(color);
    }

    if (placa === '') {
        $('#reportePlaca').html('- - - - -');
    } else {
        $('#reportePlaca').html(placa);
    }

    setTimeout(() => {
        $('#vehicleData').css('right', '0');
    }, 500);
}

function showCaseDetails(marca, modelo, niv, color, placa, nombre_alerta, nivel_alerta, tipo_alerta, id_reporte) {
    // console.log(marca, modelo, niv, color, placa, nombre_alerta, nivel_alerta, tipo_alerta);

    $.ajax({
        type: 'POST',
        url: 'detalleReporte.htm',
        data: {
            id_reporte: id_reporte
        },
        success: function(result) {
            document.getElementById('casoEntradas').innerHTML = '';
            console.log(JSON.parse(result))
            var entradas  = JSON.parse(result)
            var entry= []
            for (let i = 0; i < entradas.length; i++) {
                console.log(entradas[i])
                // var images = JSON.parse(entradas[i].images);
                document.getElementById('casoEntradas').innerHTML += 
                `
                <div class="caso-update d-flex ai-center">
                    <div class="d-flex ai-center">
                        <img src="resources/images/icons/update-icon.svg" alt="">
                        <div class="d-flex ai-center">
                            <p class="update-type">${entradas[i].etiqueta}</p>
                            <p class="update-description">${entradas[i].comentario}</p>
                            <!--<button data-img="" class="update-files d-flex ai-center">
                                <img src="resources/images/icons/update-img.svg" alt="">
                                <p>Imágenes</p>
                            </button>
                            <button class="update-files d-flex ai-center">
                                <img src="resources/images/icons/update-docs.svg" alt="">
                                <p>Documento</p>
                            </button>-->
                        </div>
                    </div>
                    <p class="update-time">${entradas[i].fecha}</p>
                </div>
                `;
            }
            
        } 
    });
   
    if (marca === '') {
        $('#repMarca').html('- - - - -');
    } else {
        $('#repMarca').html(marca);
    }

    if (modelo === '') {
        $('#repModelo').html('- - - - -');
    } else {
        $('#repModelo').html(modelo);
    }

    if (niv === '') {
        $('#repNiv').html('- - - - -');
    } else {
        $('#repNiv').html(niv);
    }

    if (color === '') {
        $('#repColor').html('- - - - -');
    } else {
        $('#repColor').html(color);
    }

    if (placa === '') {
        $('#repPlaca').html('- - - - -');
    } else {
        $('#repPlaca').html(placa);
    }

    if (nombre_alerta === '') {
        $('#nombreAlerta').html('- - - - -');
    } else {
        $('#nombreAlerta').html(nombre_alerta);
    }

    $('#masterModal').css('left', '-35%');
    $('#vehicleData').fadeOut();
    $('#lecPerSec').css('right', '-20rem');

    setTimeout(() => {
        $('#caseModal').css('left', '0');
        $('.case-active').removeClass('case-active');
        $('#caseHistorial').css('right', '0');
    }, 500);
}

function closeCaseDetails() {
    $('#caseModal').css('left', '-70rem');
    $('#caseHistorial').css('right', '');
    setTimeout(() => {
        $('#masterModal').css('left', '0');
        $('#vehicleData').css('right', '-40%');
        $('#vehicleData').css('display', 'flex');
        $('#lecPerSec').css('right', '');
    }, 500);
}

function hideLilNoti() {
    $('#lilNoti').fadeOut();

    // $('#lilNoti')
    //     .css("display", "flex")
    //     .hide()
    //     .fadeIn();
}

/* FILTROS */

var criticoCheck = document.getElementById('check_critica');
var advertenciaCheck = document.getElementById('check_advertencia');
var infoCheck = document.getElementById('check_info');

criticoCheck.addEventListener('change', () => {
    if (criticoCheck.checked) {
        $('.Critico').css('display', 'flex');
    } else {
        $('.Critico').css('display', 'none');
    }
});
advertenciaCheck.addEventListener('change', () => {
    if (advertenciaCheck.checked) {
        $('.Advertencia').css('display', 'flex');
    } else {
        $('.Advertencia').css('display', 'none');
    }
});
infoCheck.addEventListener('change', () => {
    if (advertenciaCheck.checked) {
        $('.Informativo').css('display', 'flex');
    } else {
        $('.Informativo').css('display', 'none');
    }
});