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
                        <title>Concredito</title>

                        <!--Estilos de CSS-->
                            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
                            <link rel="stylesheet" href="resources/css/minGeneral.css">
                            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
                        <!--Estilos de CSS-->

                    </head>

                    <body>
                        <header>
                            <div class="px-3 py-2 bg-dark text-white">
                              <div class="container">
                                <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                                  <a href="/" class="d-flex align-items-center my-2 my-lg-0 me-lg-auto text-white text-decoration-none">
                                    <img class="header-logo" src="resources/images/concredito-logo.png" alt="concredito">
                                  </a>
                        
                                  <ul class="nav col-12 col-lg-auto my-2 justify-content-center my-md-0 text-small">
                                    <li>
                                      <a   href="prospectos.htm" id="prospectos"  class="nav-link text-secondary text-center">
                                        <i class="bi bi-people-fill d-block mx-auto mb-1" width="24" height="24"></i>
                                        Prospectos
                                      </a>
                                    </li>
                                    <li>
                                      <a href="agregar_prospectos.htm" id="agregar_prospectos"  class="nav-link text-white text-center">
                                        <i class="bi bi-person-plus-fill d-block mx-auto mb-1" width="24" height="24"></i>
                                        Agregar 
                                      </a>
                                    </li>
                                    <li>
                                      <a href="#"  id="evaluar"  class="nav-link text-white text-center">
                                        <i class="bi bi-speedometer d-block mx-auto mb-1" width="24" height="24"></i>
                                        Evaluar 
                                      </a>
                                    </li>
                                    <li>
                                        <a href="#" class="nav-link text-white text-center">
                                            <i class="bi bi-door-closed-fill d-block mx-auto mb-1" width="24" height="24"></i>
                                            Salir 
                                        </a>
                                    </li>
                                  </ul>
                                </div>
                              </div>
                            </div>
                          
                        </header>
                          
