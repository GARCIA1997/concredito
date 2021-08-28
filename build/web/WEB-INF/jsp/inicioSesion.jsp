<%-- 
    Document   : inicioSesion
    Created on : 27/07/2021, 03:39:30 PM
    Author     : ISC_G
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bienvenido - Concredito</title>
    <link rel="stylesheet" href="resources/css/login.css">
</head>

<body>
    <div class="login-form">
        <img src="resources/images/concredito-logo.png" alt="Logo concredito" style="width: 100%;">
        <form id="formLogin">
            <input id="correo_form" type="text" placeholder="Correo electrónico"/>
            <input id="password_form" type="password" placeholder="Contraseña"/>
            <button type="submit" class="submit-btn">Iniciar sesión</button>
        </form>
    </div>

    <script src="resources/js/login.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</body>

</html>
