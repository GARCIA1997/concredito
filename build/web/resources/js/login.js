const correo= document.getElementById("correo_form");
const password = document.getElementById("password_form");
const form = document.getElementById("formLogin");

form.addEventListener("submit", async (e) => {
    e.preventDefault();
    let pattern = RegExp(/^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i);
    if (pattern.test(correo.value)) {
        if (password.value.length >= 2) {
            await $.ajax({
                url: "iniciar_sesion.htm",
                method: "post",
                data: {
                    correo:correo.value,
                    password:password.value
                }
            }).done((res) => {
                if (res === "404") {
                    alert("Password o email incorrecto, no se encontro respuesta");
                } else if (res === "200") {
                    window.location = "prospectos.htm";
                } 
            }).fail((jqXHR, textStatus) => {
                console.log(textStatus, jqXHR);
            });
        } else {
            alert("contraseña invalida");
        }
    } else {
        alert("Correo invalido");
    }
});

