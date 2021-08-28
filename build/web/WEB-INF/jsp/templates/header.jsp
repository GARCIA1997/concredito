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


                        <!--Estilos de CSS-->

                        <head>
                            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                            <title>concreditos</title>

                            <!--Estilos de CSS-->
                            <link rel="stylesheet" href="resources/css/minGeneral.css">
                            <link rel="stylesheet" href="resources/css/header.css">
                            <link rel="stylesheet" href="resources/css/sidebar.css">
                            <link rel="stylesheet" href="resources/css/monitoreo.css">

                            <!--Estilos de CSS-->

                        </head>

                        <body onload="initMap()">
                            <nav>
                                <div class="nav-left">
                                    <button onclick="openNav()"><img class="si" src="resources/images/icons/hamburger.svg" alt="barras"></button>
                                    <h2>Unidades</h2>
                                </div>
                                <div class="nav-center">
                                    <img src="resources/images/icons/logo.png" alt="logo">
                                </div>
                                <div class="nav-right">
                                    <button class="nav-button noti">
                                        <img src="resources/images/icons/search.svg" alt="">
                                        <div class="state-dot state-green"></div>
                                        <div class="header-modal d-flex fd-column">
                                        <div class="head-title">Conexión a bases de datos</div>
                                        <div class="d-flex fd-column">
                                            <c:forEach items="${user_dataBase}" var="base">
                                                <div class="base">
                                                    <div class="base-state state-red"></div>
                                                    <div class="caso-text d-flex fd-column">
                                                        <p class="caso-name">${base.nombre}</p>
                                                        <div class="caso-info d-flex">
                                                            <p class="caso-state">Última conexión</p>
                                                            <p class="caso-fecha">Hace 5 min</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </button>
                                    <button class="nav-button noti" onclick="openNoti()">
                                        <img src="resources/images/icons/notificaciones-.svg" alt="">
                                        <div class="state-dot state-red"></div>
                                    </button>
                                    <button class="prof nav-button">
                                        <h2>${user_session.nombre}</h2>
                                        <div class="profile">
                                            <div style="cursor: auto;">
                                                <p>${user_session.perfil}   ${user_session.entidad}</p>
                                            </div>
                                            <div onclick="alert('Configuración')">
                                                <p>Configuración</p>
                                            </div>
                                            <div onclick="alert('¿Está seguro de que desea cerrar la sesión?')">
                                                <p>Cerrar sesión</p>
                                            </div>
                                        </div>
                                    </button>
                                </div>
                            </nav>
                            <section class="notificaciones d-flex fd-column" id="notificaciones">
                                <div class="d-flex fd-column">
                                    <div class="noti-header d-flex ai-center">
                                        <img src="resources/images/icons/Cerrar.svg" style="cursor: pointer;" alt="" onclick="closeNoti()">
                                        <p>Notificaciones</p>
                                        <img src="resources/images/icons/Cerrar.svg" style="opacity: 0;" alt="">
                                    </div>
                                    <input class="noti-search" type="text" placeholder="Búsqueda...">
                                    <div id="NotiContainer" class="d-flex fd-column">
                                        <div class="caso d-flex ai-center">
                                            <div class="d-flex ai-center">
                                                <img src="resources/images/icons/critica.svg" alt="">
                                                <div class="caso-text d-flex fd-column">
                                                    <p class="caso-name">Desconexión de concredito</p>
                                                    <div class="caso-info d-flex">
                                                        <p class="caso-state">En búsqueda</p>
                                                        <p class="caso-fecha">12 Jun 2021</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="caso d-flex ai-center">
                                            <div class="d-flex ai-center">
                                                <img src="resources/images/icons/critica.svg" alt="">
                                                <div class="caso-text d-flex fd-column">
                                                    <p class="caso-name">Desconexión de concredito</p>
                                                    <div class="caso-info d-flex">
                                                        <p class="caso-state">En búsqueda</p>
                                                        <p class="caso-fecha">12 Jun 2021</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <button class="caso-detalles">Atender</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex fd-column">
                                    <div class="caso d-flex ai-center">
                                        <div class="d-flex ai-center">
                                            <div id="noti_critica" class="casos-counter state-red">3</div>
                                            <div class="caso-text d-flex fd-column">
                                                <p class="caso-name">Casos críticos</p>
                                            </div>
                                        </div>
                                        <button class="caso-detalles">Ver casos</button>
                                    </div>
                                    <div class="caso d-flex ai-center">
                                        <div class="d-flex ai-center">
                                            <div id="noti_advertencia" class="casos-counter state-orange">160</div>
                                            <div class="caso-text d-flex fd-column">
                                                <p class="caso-name">Casos de advertencia</p>
                                            </div>
                                        </div>
                                        <button class="caso-detalles">Ver casos</button>
                                    </div>
                                    <div class="caso d-flex ai-center">
                                        <div class="d-flex ai-center">
                                            <div id="noti_informativa" class="casos-counter" style="background-color: #1A75CF;">20</div>
                                            <div class="caso-text d-flex fd-column">
                                                <p class="caso-name">Casos informativos</p>
                                            </div>
                                        </div>
                                        <button class="caso-detalles">Ver casos</button>
                                    </div>
                                </div>
                            </section>
                            <div id="noti-container" style="display: none!important; opacity: 0!important; visibility: hidden"></div>
                            <div id="notiBlur" onclick="closeNoti()"></div>
                            <%@include file="/WEB-INF/jsp/templates/sidebar.jsp" %>