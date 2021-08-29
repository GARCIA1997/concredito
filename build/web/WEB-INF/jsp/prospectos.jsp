<%-- 
    Document   : prospectos
    Created on : 28/08/2021, 12:12:23 AM
    Author     : ISC_G
--%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
            <%@taglib  prefix="form" uri="http://www.springframework.org/tags/form" %>
                <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="/WEB-INF/jsp/templates/header.jsp" %>
<div class="container">
    <br><br>
    <h1 class="text-center">Prospectos</h1>
    <h2>${holamundo}</h2>
    <br><br>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Primer Apellido</th>
                <th>Segundo Apellido</th>
                <th>Estatus</th>
                <th class="text-center">...</th>
            </tr>
            <tbody>
                <c:forEach items="${listProspectos}" var="p">
                    <tr>
                        <td>${p.nombre}</td>
                        <td>${p.apellido_paterno}</td>
                        <td>${p.apellido_materno}</td>
                        <td>${p.status}</td>                
                        <td class="text-center"> <button type="button" onclick="getDetalleProspecto(${prospecto.id});" class="btn btn-primary"><i class="bi bi-eye-fill"></i>Ver</button></td>                
                    </tr>
                </c:forEach>
            </tbody>
        </thead>
    </table>
</div>
    
<!--Modal para mostra el detalle del prospecto-->
<!-- Full screen modal -->
<div class="modal-dialog modal-fullscreen-sm-down">
  
</div>

<%@include file="/WEB-INF/jsp/templates/footer.jsp" %>
