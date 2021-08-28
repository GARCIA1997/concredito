function atenderNoti(reporte_id) {
    // console.log(reporte_id);
    closeNoti();
    document.getElementById(reporte_id).children[1].click();
}

function openNoti() {
    $.ajax({

        url: "notificacion.htm", //url guarda la ruta hacia donde se hace la peticion
        success: function(result) {
            var notiJSON = JSON.parse(result);
            // console.log(notiJSON);
            document.getElementById('NotiContainer').innerHTML = '';
            document.getElementById('noti-container').innerHTML = '';
            for (let i = 0; i < notiJSON.length; i++) {
                // console.log(notiJSON[i]);
                if (notiJSON[i].nivel_alerta === 'Advertencia') {
                    var alertIcon = 'advertencia';
                } else if (notiJSON[i].nivel_alerta === 'Critico') {
                    var alertIcon = 'critica'
                } else {
                    var alertIcon = 'informativa'
                }
                document.getElementById('NotiContainer').innerHTML +=
                    `
                <div class="caso d-flex ai-center">
                    <div class="d-flex ai-center">
                        <img src="resources/images/icons/${alertIcon}.svg" alt="">
                        <div class="caso-text d-flex fd-column">
                            <p class="caso-name">${notiJSON[i].descripcion_alerta}</p>
                            <div class="caso-info d-flex">
                                <p class="caso-state">${notiJSON[i].estado_reporte}</p>
                                <p class="caso-fecha">${notiJSON[i].createdAt_notificacion}</p>
                            </div>
                        </div>
                    </div>
                    <button class="caso-detalles" onclick="atenderNoti('${notiJSON[i].id_reporte}')">Atender</button>
                </div>
                `;
                document.getElementById('noti-container').innerHTML +=
                    `<div class="${notiJSON[i].nivel_alerta}"></div>`
            };
            document.getElementById('noti_critica').innerHTML = document.getElementsByClassName('Advertencia').length;
            document.getElementById('noti_advertencia').innerHTML = document.getElementsByClassName('Critico').length;
            document.getElementById('noti_informativa').innerHTML = document.getElementsByClassName('Informativa').length;
            // getNotiJSON(notiJSON);

        }
    });



    // function getNotiJSON(noti) {
    //     var notificacion = noti;
    //     notiarray = notificacion;
    // }



    $('#notificaciones').attr('style', 'right: 0');
    $('#notiBlur').fadeIn();
    // document.getElementById('notificaciones').setAttribute('style', 'right: 0;');
    // document.getElementById('notiBlur').style.display = 'block';
}

function closeNoti() {
    $('#notificaciones').removeAttr('style');
    $('#notiBlur').fadeOut();
    // document.getElementById('notificaciones').removeAttribute('style');
    // document.getElementById('notiBlur').style.display = 'none';
}