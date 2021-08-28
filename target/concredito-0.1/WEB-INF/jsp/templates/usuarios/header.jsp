<%-- 
    Document   : header
    Created on : 15-jul-2021, 13:47:06
    Author     : ISC_G
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>concreditos</title>

    <!--Estilos de CSS-->
    <link rel="stylesheet" href="resources/css/minGeneral.css">
    <link rel="stylesheet" href="resources/css/header.css">
    <link rel="stylesheet" href="resources/css/sidebar.css">
    <link rel="stylesheet" href="resources/css/usuarios.css">
    <link rel="stylesheet" href="resources/css/monitoreo.css">

    <body onload="renderUsuarios()">
        <%@include file="/WEB-INF/jsp/templates/navegadorGeneral.jsp" %>
        <%@include file="/WEB-INF/jsp/templates/notificaciones.jsp" %>
        <%@include file="/WEB-INF/jsp/templates/sidebar.jsp" %>